#import "NSString+CMBEmoji.h"

@implementation NSString (CMBEmoji)

/*
	master list: https://unicode.org/emoji/charts/emoji-list.html

	this implementation is for v12.0

	perform the following checks:
		1. check single code points
		2. check sequences of 2 code points that weren't eliminated by 1.
		3. check sequences of 3 code points that weren't eliminated by 1.

	checking 1. eliminates many of the sequences with 2-8 code points, leaving
	just a handful of 2/3 code point emojis to check.
*/

- (BOOL)isEmojiSingleCodePoint:(UTF32Char)cp1
{
	/* single code points */

	switch (cp1)
	{
		case 0x00a9:
		case 0x00ae:
		case 0x203c:
		case 0x2049:
		case 0x2122:
		case 0x2139:
		case 0x2194:
		case 0x2195:
		case 0x2196:
		case 0x2197:
		case 0x2198:
		case 0x2199:
		case 0x21a9:
		case 0x21aa:
		case 0x231a:
		case 0x231b:
		case 0x2328:
		case 0x23cf:
		case 0x23e9:
		case 0x23ea:
		case 0x23eb:
		case 0x23ec:
		case 0x23ed:
		case 0x23ee:
		case 0x23ef:
		case 0x23f0:
		case 0x23f1:
		case 0x23f2:
		case 0x23f3:
		case 0x23f8:
		case 0x23f9:
		case 0x23fa:
		case 0x24c2:
		case 0x25aa:
		case 0x25ab:
		case 0x25b6:
		case 0x25c0:
		case 0x25fb:
		case 0x25fc:
		case 0x25fd:
		case 0x25fe:
		case 0x2600:
		case 0x2601:
		case 0x2602:
		case 0x2603:
		case 0x2604:
		case 0x260e:
		case 0x2611:
		case 0x2614:
		case 0x2615:
		case 0x2618:
		case 0x261d:
		case 0x2620:
		case 0x2622:
		case 0x2623:
		case 0x2626:
		case 0x262a:
		case 0x262e:
		case 0x262f:
		case 0x2638:
		case 0x2639:
		case 0x263a:
		case 0x2640:
		case 0x2642:
		case 0x2648:
		case 0x2649:
		case 0x264a:
		case 0x264b:
		case 0x264c:
		case 0x264d:
		case 0x264e:
		case 0x264f:
		case 0x2650:
		case 0x2651:
		case 0x2652:
		case 0x2653:
		case 0x265f:
		case 0x2660:
		case 0x2663:
		case 0x2665:
		case 0x2666:
		case 0x2668:
		case 0x267b:
		case 0x267e:
		case 0x267f:
		case 0x2692:
		case 0x2693:
		case 0x2694:
		case 0x2695:
		case 0x2696:
		case 0x2697:
		case 0x2699:
		case 0x269b:
		case 0x269c:
		case 0x26a0:
		case 0x26a1:
		case 0x26aa:
		case 0x26ab:
		case 0x26b0:
		case 0x26b1:
		case 0x26bd:
		case 0x26be:
		case 0x26c4:
		case 0x26c5:
		case 0x26c8:
		case 0x26ce:
		case 0x26cf:
		case 0x26d1:
		case 0x26d3:
		case 0x26d4:
		case 0x26e9:
		case 0x26ea:
		case 0x26f0:
		case 0x26f1:
		case 0x26f2:
		case 0x26f3:
		case 0x26f4:
		case 0x26f5:
		case 0x26f7:
		case 0x26f8:
		case 0x26f9:
		case 0x26fa:
		case 0x26fd:
		case 0x2702:
		case 0x2705:
		case 0x2708:
		case 0x2709:
		case 0x270a:
		case 0x270b:
		case 0x270c:
		case 0x270d:
		case 0x270f:
		case 0x2712:
		case 0x2714:
		case 0x2716:
		case 0x271d:
		case 0x2721:
		case 0x2728:
		case 0x2733:
		case 0x2734:
		case 0x2744:
		case 0x2747:
		case 0x274c:
		case 0x274e:
		case 0x2753:
		case 0x2754:
		case 0x2755:
		case 0x2757:
		case 0x2763:
		case 0x2764:
		case 0x2795:
		case 0x2796:
		case 0x2797:
		case 0x27a1:
		case 0x27b0:
		case 0x27bf:
		case 0x2934:
		case 0x2935:
		case 0x2b05:
		case 0x2b06:
		case 0x2b07:
		case 0x2b1b:
		case 0x2b1c:
		case 0x2b50:
		case 0x2b55:
		case 0x3030:
		case 0x303d:
		case 0x3297:
		case 0x3299:
		case 0x1f004:
		case 0x1f0cf:
		case 0x1f170:
		case 0x1f171:
		case 0x1f17e:
		case 0x1f17f:
		case 0x1f18e:
		case 0x1f191:
		case 0x1f192:
		case 0x1f193:
		case 0x1f194:
		case 0x1f195:
		case 0x1f196:
		case 0x1f197:
		case 0x1f198:
		case 0x1f199:
		case 0x1f19a:
		case 0x1f201:
		case 0x1f202:
		case 0x1f21a:
		case 0x1f22f:
		case 0x1f232:
		case 0x1f233:
		case 0x1f234:
		case 0x1f235:
		case 0x1f236:
		case 0x1f237:
		case 0x1f238:
		case 0x1f239:
		case 0x1f23a:
		case 0x1f250:
		case 0x1f251:
		case 0x1f300:
		case 0x1f301:
		case 0x1f302:
		case 0x1f303:
		case 0x1f304:
		case 0x1f305:
		case 0x1f306:
		case 0x1f307:
		case 0x1f308:
		case 0x1f309:
		case 0x1f30a:
		case 0x1f30b:
		case 0x1f30c:
		case 0x1f30d:
		case 0x1f30e:
		case 0x1f30f:
		case 0x1f310:
		case 0x1f311:
		case 0x1f312:
		case 0x1f313:
		case 0x1f314:
		case 0x1f315:
		case 0x1f316:
		case 0x1f317:
		case 0x1f318:
		case 0x1f319:
		case 0x1f31a:
		case 0x1f31b:
		case 0x1f31c:
		case 0x1f31d:
		case 0x1f31e:
		case 0x1f31f:
		case 0x1f320:
		case 0x1f321:
		case 0x1f324:
		case 0x1f325:
		case 0x1f326:
		case 0x1f327:
		case 0x1f328:
		case 0x1f329:
		case 0x1f32a:
		case 0x1f32b:
		case 0x1f32c:
		case 0x1f32d:
		case 0x1f32e:
		case 0x1f32f:
		case 0x1f330:
		case 0x1f331:
		case 0x1f332:
		case 0x1f333:
		case 0x1f334:
		case 0x1f335:
		case 0x1f336:
		case 0x1f337:
		case 0x1f338:
		case 0x1f339:
		case 0x1f33a:
		case 0x1f33b:
		case 0x1f33c:
		case 0x1f33d:
		case 0x1f33e:
		case 0x1f33f:
		case 0x1f340:
		case 0x1f341:
		case 0x1f342:
		case 0x1f343:
		case 0x1f344:
		case 0x1f345:
		case 0x1f346:
		case 0x1f347:
		case 0x1f348:
		case 0x1f349:
		case 0x1f34a:
		case 0x1f34b:
		case 0x1f34c:
		case 0x1f34d:
		case 0x1f34e:
		case 0x1f34f:
		case 0x1f350:
		case 0x1f351:
		case 0x1f352:
		case 0x1f353:
		case 0x1f354:
		case 0x1f355:
		case 0x1f356:
		case 0x1f357:
		case 0x1f358:
		case 0x1f359:
		case 0x1f35a:
		case 0x1f35b:
		case 0x1f35c:
		case 0x1f35d:
		case 0x1f35e:
		case 0x1f35f:
		case 0x1f360:
		case 0x1f361:
		case 0x1f362:
		case 0x1f363:
		case 0x1f364:
		case 0x1f365:
		case 0x1f366:
		case 0x1f367:
		case 0x1f368:
		case 0x1f369:
		case 0x1f36a:
		case 0x1f36b:
		case 0x1f36c:
		case 0x1f36d:
		case 0x1f36e:
		case 0x1f36f:
		case 0x1f370:
		case 0x1f371:
		case 0x1f372:
		case 0x1f373:
		case 0x1f374:
		case 0x1f375:
		case 0x1f376:
		case 0x1f377:
		case 0x1f378:
		case 0x1f379:
		case 0x1f37a:
		case 0x1f37b:
		case 0x1f37c:
		case 0x1f37d:
		case 0x1f37e:
		case 0x1f37f:
		case 0x1f380:
		case 0x1f381:
		case 0x1f382:
		case 0x1f383:
		case 0x1f384:
		case 0x1f385:
		case 0x1f386:
		case 0x1f387:
		case 0x1f388:
		case 0x1f389:
		case 0x1f38a:
		case 0x1f38b:
		case 0x1f38c:
		case 0x1f38d:
		case 0x1f38e:
		case 0x1f38f:
		case 0x1f390:
		case 0x1f391:
		case 0x1f392:
		case 0x1f393:
		case 0x1f396:
		case 0x1f397:
		case 0x1f399:
		case 0x1f39a:
		case 0x1f39b:
		case 0x1f39e:
		case 0x1f39f:
		case 0x1f3a0:
		case 0x1f3a1:
		case 0x1f3a2:
		case 0x1f3a3:
		case 0x1f3a4:
		case 0x1f3a5:
		case 0x1f3a6:
		case 0x1f3a7:
		case 0x1f3a8:
		case 0x1f3a9:
		case 0x1f3aa:
		case 0x1f3ab:
		case 0x1f3ac:
		case 0x1f3ad:
		case 0x1f3ae:
		case 0x1f3af:
		case 0x1f3b0:
		case 0x1f3b1:
		case 0x1f3b2:
		case 0x1f3b3:
		case 0x1f3b4:
		case 0x1f3b5:
		case 0x1f3b6:
		case 0x1f3b7:
		case 0x1f3b8:
		case 0x1f3b9:
		case 0x1f3ba:
		case 0x1f3bb:
		case 0x1f3bc:
		case 0x1f3bd:
		case 0x1f3be:
		case 0x1f3bf:
		case 0x1f3c0:
		case 0x1f3c1:
		case 0x1f3c2:
		case 0x1f3c3:
		case 0x1f3c4:
		case 0x1f3c5:
		case 0x1f3c6:
		case 0x1f3c7:
		case 0x1f3c8:
		case 0x1f3c9:
		case 0x1f3ca:
		case 0x1f3cb:
		case 0x1f3cc:
		case 0x1f3cd:
		case 0x1f3ce:
		case 0x1f3cf:
		case 0x1f3d0:
		case 0x1f3d1:
		case 0x1f3d2:
		case 0x1f3d3:
		case 0x1f3d4:
		case 0x1f3d5:
		case 0x1f3d6:
		case 0x1f3d7:
		case 0x1f3d8:
		case 0x1f3d9:
		case 0x1f3da:
		case 0x1f3db:
		case 0x1f3dc:
		case 0x1f3dd:
		case 0x1f3de:
		case 0x1f3df:
		case 0x1f3e0:
		case 0x1f3e1:
		case 0x1f3e2:
		case 0x1f3e3:
		case 0x1f3e4:
		case 0x1f3e5:
		case 0x1f3e6:
		case 0x1f3e7:
		case 0x1f3e8:
		case 0x1f3e9:
		case 0x1f3ea:
		case 0x1f3eb:
		case 0x1f3ec:
		case 0x1f3ed:
		case 0x1f3ee:
		case 0x1f3ef:
		case 0x1f3f0:
		case 0x1f3f3:
		case 0x1f3f4:
		case 0x1f3f5:
		case 0x1f3f7:
		case 0x1f3f8:
		case 0x1f3f9:
		case 0x1f3fa:
		case 0x1f400:
		case 0x1f401:
		case 0x1f402:
		case 0x1f403:
		case 0x1f404:
		case 0x1f405:
		case 0x1f406:
		case 0x1f407:
		case 0x1f408:
		case 0x1f409:
		case 0x1f40a:
		case 0x1f40b:
		case 0x1f40c:
		case 0x1f40d:
		case 0x1f40e:
		case 0x1f40f:
		case 0x1f410:
		case 0x1f411:
		case 0x1f412:
		case 0x1f413:
		case 0x1f414:
		case 0x1f415:
		case 0x1f416:
		case 0x1f417:
		case 0x1f418:
		case 0x1f419:
		case 0x1f41a:
		case 0x1f41b:
		case 0x1f41c:
		case 0x1f41d:
		case 0x1f41e:
		case 0x1f41f:
		case 0x1f420:
		case 0x1f421:
		case 0x1f422:
		case 0x1f423:
		case 0x1f424:
		case 0x1f425:
		case 0x1f426:
		case 0x1f427:
		case 0x1f428:
		case 0x1f429:
		case 0x1f42a:
		case 0x1f42b:
		case 0x1f42c:
		case 0x1f42d:
		case 0x1f42e:
		case 0x1f42f:
		case 0x1f430:
		case 0x1f431:
		case 0x1f432:
		case 0x1f433:
		case 0x1f434:
		case 0x1f435:
		case 0x1f436:
		case 0x1f437:
		case 0x1f438:
		case 0x1f439:
		case 0x1f43a:
		case 0x1f43b:
		case 0x1f43c:
		case 0x1f43d:
		case 0x1f43e:
		case 0x1f43f:
		case 0x1f440:
		case 0x1f441:
		case 0x1f442:
		case 0x1f443:
		case 0x1f444:
		case 0x1f445:
		case 0x1f446:
		case 0x1f447:
		case 0x1f448:
		case 0x1f449:
		case 0x1f44a:
		case 0x1f44b:
		case 0x1f44c:
		case 0x1f44d:
		case 0x1f44e:
		case 0x1f44f:
		case 0x1f450:
		case 0x1f451:
		case 0x1f452:
		case 0x1f453:
		case 0x1f454:
		case 0x1f455:
		case 0x1f456:
		case 0x1f457:
		case 0x1f458:
		case 0x1f459:
		case 0x1f45a:
		case 0x1f45b:
		case 0x1f45c:
		case 0x1f45d:
		case 0x1f45e:
		case 0x1f45f:
		case 0x1f460:
		case 0x1f461:
		case 0x1f462:
		case 0x1f463:
		case 0x1f464:
		case 0x1f465:
		case 0x1f466:
		case 0x1f467:
		case 0x1f468:
		case 0x1f469:
		case 0x1f46a:
		case 0x1f46b:
		case 0x1f46c:
		case 0x1f46d:
		case 0x1f46e:
		case 0x1f46f:
		case 0x1f470:
		case 0x1f471:
		case 0x1f472:
		case 0x1f473:
		case 0x1f474:
		case 0x1f475:
		case 0x1f476:
		case 0x1f477:
		case 0x1f478:
		case 0x1f479:
		case 0x1f47a:
		case 0x1f47b:
		case 0x1f47c:
		case 0x1f47d:
		case 0x1f47e:
		case 0x1f47f:
		case 0x1f480:
		case 0x1f481:
		case 0x1f482:
		case 0x1f483:
		case 0x1f484:
		case 0x1f485:
		case 0x1f486:
		case 0x1f487:
		case 0x1f488:
		case 0x1f489:
		case 0x1f48a:
		case 0x1f48b:
		case 0x1f48c:
		case 0x1f48d:
		case 0x1f48e:
		case 0x1f48f:
		case 0x1f490:
		case 0x1f491:
		case 0x1f492:
		case 0x1f493:
		case 0x1f494:
		case 0x1f495:
		case 0x1f496:
		case 0x1f497:
		case 0x1f498:
		case 0x1f499:
		case 0x1f49a:
		case 0x1f49b:
		case 0x1f49c:
		case 0x1f49d:
		case 0x1f49e:
		case 0x1f49f:
		case 0x1f4a0:
		case 0x1f4a1:
		case 0x1f4a2:
		case 0x1f4a3:
		case 0x1f4a4:
		case 0x1f4a5:
		case 0x1f4a6:
		case 0x1f4a7:
		case 0x1f4a8:
		case 0x1f4a9:
		case 0x1f4aa:
		case 0x1f4ab:
		case 0x1f4ac:
		case 0x1f4ad:
		case 0x1f4ae:
		case 0x1f4af:
		case 0x1f4b0:
		case 0x1f4b1:
		case 0x1f4b2:
		case 0x1f4b3:
		case 0x1f4b4:
		case 0x1f4b5:
		case 0x1f4b6:
		case 0x1f4b7:
		case 0x1f4b8:
		case 0x1f4b9:
		case 0x1f4ba:
		case 0x1f4bb:
		case 0x1f4bc:
		case 0x1f4bd:
		case 0x1f4be:
		case 0x1f4bf:
		case 0x1f4c0:
		case 0x1f4c1:
		case 0x1f4c2:
		case 0x1f4c3:
		case 0x1f4c4:
		case 0x1f4c5:
		case 0x1f4c6:
		case 0x1f4c7:
		case 0x1f4c8:
		case 0x1f4c9:
		case 0x1f4ca:
		case 0x1f4cb:
		case 0x1f4cc:
		case 0x1f4cd:
		case 0x1f4ce:
		case 0x1f4cf:
		case 0x1f4d0:
		case 0x1f4d1:
		case 0x1f4d2:
		case 0x1f4d3:
		case 0x1f4d4:
		case 0x1f4d5:
		case 0x1f4d6:
		case 0x1f4d7:
		case 0x1f4d8:
		case 0x1f4d9:
		case 0x1f4da:
		case 0x1f4db:
		case 0x1f4dc:
		case 0x1f4dd:
		case 0x1f4de:
		case 0x1f4df:
		case 0x1f4e0:
		case 0x1f4e1:
		case 0x1f4e2:
		case 0x1f4e3:
		case 0x1f4e4:
		case 0x1f4e5:
		case 0x1f4e6:
		case 0x1f4e7:
		case 0x1f4e8:
		case 0x1f4e9:
		case 0x1f4ea:
		case 0x1f4eb:
		case 0x1f4ec:
		case 0x1f4ed:
		case 0x1f4ee:
		case 0x1f4ef:
		case 0x1f4f0:
		case 0x1f4f1:
		case 0x1f4f2:
		case 0x1f4f3:
		case 0x1f4f4:
		case 0x1f4f5:
		case 0x1f4f6:
		case 0x1f4f7:
		case 0x1f4f8:
		case 0x1f4f9:
		case 0x1f4fa:
		case 0x1f4fb:
		case 0x1f4fc:
		case 0x1f4fd:
		case 0x1f4ff:
		case 0x1f500:
		case 0x1f501:
		case 0x1f502:
		case 0x1f503:
		case 0x1f504:
		case 0x1f505:
		case 0x1f506:
		case 0x1f507:
		case 0x1f508:
		case 0x1f509:
		case 0x1f50a:
		case 0x1f50b:
		case 0x1f50c:
		case 0x1f50d:
		case 0x1f50e:
		case 0x1f50f:
		case 0x1f510:
		case 0x1f511:
		case 0x1f512:
		case 0x1f513:
		case 0x1f514:
		case 0x1f515:
		case 0x1f516:
		case 0x1f517:
		case 0x1f518:
		case 0x1f519:
		case 0x1f51a:
		case 0x1f51b:
		case 0x1f51c:
		case 0x1f51d:
		case 0x1f51e:
		case 0x1f51f:
		case 0x1f520:
		case 0x1f521:
		case 0x1f522:
		case 0x1f523:
		case 0x1f524:
		case 0x1f525:
		case 0x1f526:
		case 0x1f527:
		case 0x1f528:
		case 0x1f529:
		case 0x1f52a:
		case 0x1f52b:
		case 0x1f52c:
		case 0x1f52d:
		case 0x1f52e:
		case 0x1f52f:
		case 0x1f530:
		case 0x1f531:
		case 0x1f532:
		case 0x1f533:
		case 0x1f534:
		case 0x1f535:
		case 0x1f536:
		case 0x1f537:
		case 0x1f538:
		case 0x1f539:
		case 0x1f53a:
		case 0x1f53b:
		case 0x1f53c:
		case 0x1f53d:
		case 0x1f549:
		case 0x1f54a:
		case 0x1f54b:
		case 0x1f54c:
		case 0x1f54d:
		case 0x1f54e:
		case 0x1f550:
		case 0x1f551:
		case 0x1f552:
		case 0x1f553:
		case 0x1f554:
		case 0x1f555:
		case 0x1f556:
		case 0x1f557:
		case 0x1f558:
		case 0x1f559:
		case 0x1f55a:
		case 0x1f55b:
		case 0x1f55c:
		case 0x1f55d:
		case 0x1f55e:
		case 0x1f55f:
		case 0x1f560:
		case 0x1f561:
		case 0x1f562:
		case 0x1f563:
		case 0x1f564:
		case 0x1f565:
		case 0x1f566:
		case 0x1f567:
		case 0x1f56f:
		case 0x1f570:
		case 0x1f573:
		case 0x1f574:
		case 0x1f575:
		case 0x1f576:
		case 0x1f577:
		case 0x1f578:
		case 0x1f579:
		case 0x1f57a:
		case 0x1f587:
		case 0x1f58a:
		case 0x1f58b:
		case 0x1f58c:
		case 0x1f58d:
		case 0x1f590:
		case 0x1f595:
		case 0x1f596:
		case 0x1f5a4:
		case 0x1f5a5:
		case 0x1f5a8:
		case 0x1f5b1:
		case 0x1f5b2:
		case 0x1f5bc:
		case 0x1f5c2:
		case 0x1f5c3:
		case 0x1f5c4:
		case 0x1f5d1:
		case 0x1f5d2:
		case 0x1f5d3:
		case 0x1f5dc:
		case 0x1f5dd:
		case 0x1f5de:
		case 0x1f5e1:
		case 0x1f5e3:
		case 0x1f5e8:
		case 0x1f5ef:
		case 0x1f5f3:
		case 0x1f5fa:
		case 0x1f5fb:
		case 0x1f5fc:
		case 0x1f5fd:
		case 0x1f5fe:
		case 0x1f5ff:
		case 0x1f600:
		case 0x1f601:
		case 0x1f602:
		case 0x1f603:
		case 0x1f604:
		case 0x1f605:
		case 0x1f606:
		case 0x1f607:
		case 0x1f608:
		case 0x1f609:
		case 0x1f60a:
		case 0x1f60b:
		case 0x1f60c:
		case 0x1f60d:
		case 0x1f60e:
		case 0x1f60f:
		case 0x1f610:
		case 0x1f611:
		case 0x1f612:
		case 0x1f613:
		case 0x1f614:
		case 0x1f615:
		case 0x1f616:
		case 0x1f617:
		case 0x1f618:
		case 0x1f619:
		case 0x1f61a:
		case 0x1f61b:
		case 0x1f61c:
		case 0x1f61d:
		case 0x1f61e:
		case 0x1f61f:
		case 0x1f620:
		case 0x1f621:
		case 0x1f622:
		case 0x1f623:
		case 0x1f624:
		case 0x1f625:
		case 0x1f626:
		case 0x1f627:
		case 0x1f628:
		case 0x1f629:
		case 0x1f62a:
		case 0x1f62b:
		case 0x1f62c:
		case 0x1f62d:
		case 0x1f62e:
		case 0x1f62f:
		case 0x1f630:
		case 0x1f631:
		case 0x1f632:
		case 0x1f633:
		case 0x1f634:
		case 0x1f635:
		case 0x1f636:
		case 0x1f637:
		case 0x1f638:
		case 0x1f639:
		case 0x1f63a:
		case 0x1f63b:
		case 0x1f63c:
		case 0x1f63d:
		case 0x1f63e:
		case 0x1f63f:
		case 0x1f640:
		case 0x1f641:
		case 0x1f642:
		case 0x1f643:
		case 0x1f644:
		case 0x1f645:
		case 0x1f646:
		case 0x1f647:
		case 0x1f648:
		case 0x1f649:
		case 0x1f64a:
		case 0x1f64b:
		case 0x1f64c:
		case 0x1f64d:
		case 0x1f64e:
		case 0x1f64f:
		case 0x1f680:
		case 0x1f681:
		case 0x1f682:
		case 0x1f683:
		case 0x1f684:
		case 0x1f685:
		case 0x1f686:
		case 0x1f687:
		case 0x1f688:
		case 0x1f689:
		case 0x1f68a:
		case 0x1f68b:
		case 0x1f68c:
		case 0x1f68d:
		case 0x1f68e:
		case 0x1f68f:
		case 0x1f690:
		case 0x1f691:
		case 0x1f692:
		case 0x1f693:
		case 0x1f694:
		case 0x1f695:
		case 0x1f696:
		case 0x1f697:
		case 0x1f698:
		case 0x1f699:
		case 0x1f69a:
		case 0x1f69b:
		case 0x1f69c:
		case 0x1f69d:
		case 0x1f69e:
		case 0x1f69f:
		case 0x1f6a0:
		case 0x1f6a1:
		case 0x1f6a2:
		case 0x1f6a3:
		case 0x1f6a4:
		case 0x1f6a5:
		case 0x1f6a6:
		case 0x1f6a7:
		case 0x1f6a8:
		case 0x1f6a9:
		case 0x1f6aa:
		case 0x1f6ab:
		case 0x1f6ac:
		case 0x1f6ad:
		case 0x1f6ae:
		case 0x1f6af:
		case 0x1f6b0:
		case 0x1f6b1:
		case 0x1f6b2:
		case 0x1f6b3:
		case 0x1f6b4:
		case 0x1f6b5:
		case 0x1f6b6:
		case 0x1f6b7:
		case 0x1f6b8:
		case 0x1f6b9:
		case 0x1f6ba:
		case 0x1f6bb:
		case 0x1f6bc:
		case 0x1f6bd:
		case 0x1f6be:
		case 0x1f6bf:
		case 0x1f6c0:
		case 0x1f6c1:
		case 0x1f6c2:
		case 0x1f6c3:
		case 0x1f6c4:
		case 0x1f6c5:
		case 0x1f6cb:
		case 0x1f6cc:
		case 0x1f6cd:
		case 0x1f6ce:
		case 0x1f6cf:
		case 0x1f6d0:
		case 0x1f6d1:
		case 0x1f6d2:
		case 0x1f6d5:
		case 0x1f6e0:
		case 0x1f6e1:
		case 0x1f6e2:
		case 0x1f6e3:
		case 0x1f6e4:
		case 0x1f6e5:
		case 0x1f6e9:
		case 0x1f6eb:
		case 0x1f6ec:
		case 0x1f6f0:
		case 0x1f6f3:
		case 0x1f6f4:
		case 0x1f6f5:
		case 0x1f6f6:
		case 0x1f6f7:
		case 0x1f6f8:
		case 0x1f6f9:
		case 0x1f6fa:
		case 0x1f7e0:
		case 0x1f7e1:
		case 0x1f7e2:
		case 0x1f7e3:
		case 0x1f7e4:
		case 0x1f7e5:
		case 0x1f7e6:
		case 0x1f7e7:
		case 0x1f7e8:
		case 0x1f7e9:
		case 0x1f7ea:
		case 0x1f7eb:
		case 0x1f90d:
		case 0x1f90e:
		case 0x1f90f:
		case 0x1f910:
		case 0x1f911:
		case 0x1f912:
		case 0x1f913:
		case 0x1f914:
		case 0x1f915:
		case 0x1f916:
		case 0x1f917:
		case 0x1f918:
		case 0x1f919:
		case 0x1f91a:
		case 0x1f91b:
		case 0x1f91c:
		case 0x1f91d:
		case 0x1f91e:
		case 0x1f91f:
		case 0x1f920:
		case 0x1f921:
		case 0x1f922:
		case 0x1f923:
		case 0x1f924:
		case 0x1f925:
		case 0x1f926:
		case 0x1f927:
		case 0x1f928:
		case 0x1f929:
		case 0x1f92a:
		case 0x1f92b:
		case 0x1f92c:
		case 0x1f92d:
		case 0x1f92e:
		case 0x1f92f:
		case 0x1f930:
		case 0x1f931:
		case 0x1f932:
		case 0x1f933:
		case 0x1f934:
		case 0x1f935:
		case 0x1f936:
		case 0x1f937:
		case 0x1f938:
		case 0x1f939:
		case 0x1f93a:
		case 0x1f93c:
		case 0x1f93d:
		case 0x1f93e:
		case 0x1f93f:
		case 0x1f940:
		case 0x1f941:
		case 0x1f942:
		case 0x1f943:
		case 0x1f944:
		case 0x1f945:
		case 0x1f947:
		case 0x1f948:
		case 0x1f949:
		case 0x1f94a:
		case 0x1f94b:
		case 0x1f94c:
		case 0x1f94d:
		case 0x1f94e:
		case 0x1f94f:
		case 0x1f950:
		case 0x1f951:
		case 0x1f952:
		case 0x1f953:
		case 0x1f954:
		case 0x1f955:
		case 0x1f956:
		case 0x1f957:
		case 0x1f958:
		case 0x1f959:
		case 0x1f95a:
		case 0x1f95b:
		case 0x1f95c:
		case 0x1f95d:
		case 0x1f95e:
		case 0x1f95f:
		case 0x1f960:
		case 0x1f961:
		case 0x1f962:
		case 0x1f963:
		case 0x1f964:
		case 0x1f965:
		case 0x1f966:
		case 0x1f967:
		case 0x1f968:
		case 0x1f969:
		case 0x1f96a:
		case 0x1f96b:
		case 0x1f96c:
		case 0x1f96d:
		case 0x1f96e:
		case 0x1f96f:
		case 0x1f970:
		case 0x1f971:
		case 0x1f973:
		case 0x1f974:
		case 0x1f975:
		case 0x1f976:
		case 0x1f97a:
		case 0x1f97b:
		case 0x1f97c:
		case 0x1f97d:
		case 0x1f97e:
		case 0x1f97f:
		case 0x1f980:
		case 0x1f981:
		case 0x1f982:
		case 0x1f983:
		case 0x1f984:
		case 0x1f985:
		case 0x1f986:
		case 0x1f987:
		case 0x1f988:
		case 0x1f989:
		case 0x1f98a:
		case 0x1f98b:
		case 0x1f98c:
		case 0x1f98d:
		case 0x1f98e:
		case 0x1f98f:
		case 0x1f990:
		case 0x1f991:
		case 0x1f992:
		case 0x1f993:
		case 0x1f994:
		case 0x1f995:
		case 0x1f996:
		case 0x1f997:
		case 0x1f998:
		case 0x1f999:
		case 0x1f99a:
		case 0x1f99b:
		case 0x1f99c:
		case 0x1f99d:
		case 0x1f99e:
		case 0x1f99f:
		case 0x1f9a0:
		case 0x1f9a1:
		case 0x1f9a2:
		case 0x1f9a5:
		case 0x1f9a6:
		case 0x1f9a7:
		case 0x1f9a8:
		case 0x1f9a9:
		case 0x1f9aa:
		case 0x1f9ae:
		case 0x1f9af:
		case 0x1f9b0:
		case 0x1f9b1:
		case 0x1f9b2:
		case 0x1f9b3:
		case 0x1f9b4:
		case 0x1f9b5:
		case 0x1f9b6:
		case 0x1f9b7:
		case 0x1f9b8:
		case 0x1f9b9:
		case 0x1f9ba:
		case 0x1f9bb:
		case 0x1f9bc:
		case 0x1f9bd:
		case 0x1f9be:
		case 0x1f9bf:
		case 0x1f9c0:
		case 0x1f9c1:
		case 0x1f9c2:
		case 0x1f9c3:
		case 0x1f9c4:
		case 0x1f9c5:
		case 0x1f9c6:
		case 0x1f9c7:
		case 0x1f9c8:
		case 0x1f9c9:
		case 0x1f9ca:
		case 0x1f9cd:
		case 0x1f9ce:
		case 0x1f9cf:
		case 0x1f9d0:
		case 0x1f9d1:
		case 0x1f9d2:
		case 0x1f9d3:
		case 0x1f9d4:
		case 0x1f9d5:
		case 0x1f9d6:
		case 0x1f9d7:
		case 0x1f9d8:
		case 0x1f9d9:
		case 0x1f9da:
		case 0x1f9db:
		case 0x1f9dc:
		case 0x1f9dd:
		case 0x1f9de:
		case 0x1f9df:
		case 0x1f9e0:
		case 0x1f9e1:
		case 0x1f9e2:
		case 0x1f9e3:
		case 0x1f9e4:
		case 0x1f9e5:
		case 0x1f9e6:
		case 0x1f9e7:
		case 0x1f9e8:
		case 0x1f9e9:
		case 0x1f9ea:
		case 0x1f9eb:
		case 0x1f9ec:
		case 0x1f9ed:
		case 0x1f9ee:
		case 0x1f9ef:
		case 0x1f9f0:
		case 0x1f9f1:
		case 0x1f9f2:
		case 0x1f9f3:
		case 0x1f9f4:
		case 0x1f9f5:
		case 0x1f9f6:
		case 0x1f9f7:
		case 0x1f9f8:
		case 0x1f9f9:
		case 0x1f9fa:
		case 0x1f9fb:
		case 0x1f9fc:
		case 0x1f9fd:
		case 0x1f9fe:
		case 0x1f9ff:
		case 0x1fa70:
		case 0x1fa71:
		case 0x1fa72:
		case 0x1fa73:
		case 0x1fa78:
		case 0x1fa79:
		case 0x1fa7a:
		case 0x1fa80:
		case 0x1fa81:
		case 0x1fa82:
		case 0x1fa90:
		case 0x1fa91:
		case 0x1fa92:
		case 0x1fa93:
		case 0x1fa94:
		case 0x1fa95:
			return YES;
			break;
	}

	return NO;
}

- (BOOL)isEmojiCodePointSequenceOf2:(UTF32Char)cp1 codePoint2:(UTF32Char)cp2
{
	/* sequences with 2 code points */

	switch (cp1)
	{
		case 0x1f1e6:
			switch (cp2)
			{
				case 0x1f1e8:
				case 0x1f1e9:
				case 0x1f1ea:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ee:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f4:
				case 0x1f1f6:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fa:
				case 0x1f1fc:
				case 0x1f1fd:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1e7:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e7:
				case 0x1f1e9:
				case 0x1f1ea:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1ee:
				case 0x1f1ef:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f4:
				case 0x1f1f6:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fb:
				case 0x1f1fc:
				case 0x1f1fe:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1e8:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e8:
				case 0x1f1e9:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1ee:
				case 0x1f1f0:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f4:
				case 0x1f1f5:
				case 0x1f1f7:
				case 0x1f1fa:
				case 0x1f1fb:
				case 0x1f1fc:
				case 0x1f1fd:
				case 0x1f1fe:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1e9:
			switch (cp2)
			{
				case 0x1f1ea:
				case 0x1f1ec:
				case 0x1f1ef:
				case 0x1f1f0:
				case 0x1f1f2:
				case 0x1f1f4:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1ea:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e8:
				case 0x1f1ea:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fa:
					return YES;
			}
			break;

		case 0x1f1eb:
			switch (cp2)
			{
				case 0x1f1ee:
				case 0x1f1ef:
				case 0x1f1f0:
				case 0x1f1f2:
				case 0x1f1f4:
				case 0x1f1f7:
					return YES;
			}
			break;

		case 0x1f1ec:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e7:
				case 0x1f1e9:
				case 0x1f1ea:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1ee:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f5:
				case 0x1f1f6:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fa:
				case 0x1f1fc:
				case 0x1f1fe:
					return YES;
			}
			break;

		case 0x1f1ed:
			switch (cp2)
			{
				case 0x1f1f0:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f7:
				case 0x1f1f9:
				case 0x1f1fa:
					return YES;
			}
			break;

		case 0x1f1ee:
			switch (cp2)
			{
				case 0x1f1e8:
				case 0x1f1e9:
				case 0x1f1ea:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f4:
				case 0x1f1f6:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
					return YES;
			}
			break;

		case 0x1f1ef:
			switch (cp2)
			{
				case 0x1f1ea:
				case 0x1f1f2:
				case 0x1f1f4:
				case 0x1f1f5:
					return YES;
			}
			break;

		case 0x1f1f0:
			switch (cp2)
			{
				case 0x1f1ea:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1ee:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f5:
				case 0x1f1f7:
				case 0x1f1fc:
				case 0x1f1fe:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1f1:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e7:
				case 0x1f1e8:
				case 0x1f1ee:
				case 0x1f1f0:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fa:
				case 0x1f1fb:
				case 0x1f1fe:
					return YES;
			}
			break;

		case 0x1f1f2:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e8:
				case 0x1f1e9:
				case 0x1f1ea:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1f0:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f4:
				case 0x1f1f5:
				case 0x1f1f6:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fa:
				case 0x1f1fb:
				case 0x1f1fc:
				case 0x1f1fd:
				case 0x1f1fe:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1f3:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e8:
				case 0x1f1ea:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ee:
				case 0x1f1f1:
				case 0x1f1f4:
				case 0x1f1f5:
				case 0x1f1f7:
				case 0x1f1fa:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1f4:
			switch (cp2)
			{
				case 0x1f1f2:
					return YES;
			}
			break;

		case 0x1f1f5:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1ea:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1f0:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fc:
				case 0x1f1fe:
					return YES;
			}
			break;

		case 0x1f1f6:
			switch (cp2)
			{
				case 0x1f1e6:
					return YES;
			}
			break;

		case 0x1f1f7:
			switch (cp2)
			{
				case 0x1f1ea:
				case 0x1f1f4:
				case 0x1f1f8:
				case 0x1f1fa:
				case 0x1f1fc:
					return YES;
			}
			break;

		case 0x1f1f8:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e7:
				case 0x1f1e8:
				case 0x1f1e9:
				case 0x1f1ea:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1ee:
				case 0x1f1ef:
				case 0x1f1f0:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f4:
				case 0x1f1f7:
				case 0x1f1f8:
				case 0x1f1f9:
				case 0x1f1fb:
				case 0x1f1fd:
				case 0x1f1fe:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1f9:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e8:
				case 0x1f1e9:
				case 0x1f1eb:
				case 0x1f1ec:
				case 0x1f1ed:
				case 0x1f1ef:
				case 0x1f1f0:
				case 0x1f1f1:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f4:
				case 0x1f1f7:
				case 0x1f1f9:
				case 0x1f1fb:
				case 0x1f1fc:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1fa:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1ec:
				case 0x1f1f2:
				case 0x1f1f3:
				case 0x1f1f8:
				case 0x1f1fe:
				case 0x1f1ff:
					return YES;
			}
			break;

		case 0x1f1fb:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1e8:
				case 0x1f1ea:
				case 0x1f1ec:
				case 0x1f1ee:
				case 0x1f1f3:
				case 0x1f1fa:
					return YES;
			}
			break;

		case 0x1f1fc:
			switch (cp2)
			{
				case 0x1f1eb:
				case 0x1f1f8:
					return YES;
			}
			break;

		case 0x1f1fd:
			switch (cp2)
			{
				case 0x1f1f0:
					return YES;
			}
			break;

		case 0x1f1fe:
			switch (cp2)
			{
				case 0x1f1ea:
				case 0x1f1f9:
					return YES;
			}
			break;

		case 0x1f1ff:
			switch (cp2)
			{
				case 0x1f1e6:
				case 0x1f1f2:
				case 0x1f1fc:
					return YES;
			}
			break;
	}

	return NO;
}

- (BOOL)isEmojiCodePointSequenceOf3:(UTF32Char)cp1 codePoint2:(UTF32Char)cp2 codePoint3:(UTF32Char)cp3
{
	/* sequences with 3 code points */

	switch (cp1)
	{
		case 0x0023:
		case 0x002a:
		case 0x0030:
		case 0x0031:
		case 0x0032:
		case 0x0033:
		case 0x0034:
		case 0x0035:
		case 0x0036:
		case 0x0037:
		case 0x0038:
		case 0x0039:
			if (cp2 == 0xfe0f && cp3 == 0x20e3)
				return YES;
			break;
	}

	return NO;
}

- (BOOL)isEmojiCodePointOrSequence:(UTF32Char)cp1 codePoint2:(UTF32Char)cp2 codePoint3:(UTF32Char)cp3
{
	// rolling sequence of up to 3 code points

	// cp1   0   0
	if (cp2 == 0)
	{
		if ([self isEmojiSingleCodePoint:cp1])
		{
			return YES;
		}

		return NO;
	}

	// cp1 cp2   0
	if (cp3 == 0)
	{
		if ([self isEmojiSingleCodePoint:cp2])
		{
			return YES;
		}

		if ([self isEmojiCodePointSequenceOf2:cp1 codePoint2:cp2])
		{
			return YES;
		}

		return NO;
	}

	// cp1 cp2 cp3
	if ([self isEmojiSingleCodePoint:cp3])
	{
		return YES;
	}

	if ([self isEmojiCodePointSequenceOf2:cp2 codePoint2:cp3])
	{
		return YES;
	}

	if ([self isEmojiCodePointSequenceOf3:cp1 codePoint2:cp2 codePoint3:cp3])
	{
		return YES;
	}

	return NO;
}

// adapted from: https://stackoverflow.com/a/41008984
- (BOOL)containsEmoji
{
	// Get the UTF-16 representation of the text.
	unsigned long length = self.length;
	unichar buffer[length];
	[self getCharacters:buffer];

	// Temporary stores for the UTF-32 and UTF-16 values.
	UTF32Char utf32 = 0, cp1 = 0, cp2 = 0, cp3 = 0;
	UTF16Char h16 = 0, l16 = 0;

	int cpcount = 0;

	for (int i = 0; i < length; i++) {
		unichar surrogate = buffer[i];

		// High surrogate.
		if (0xd800 <= surrogate && surrogate <= 0xd83f) {
			h16 = surrogate;
			continue;
		}
		// Low surrogate.
		else if (0xdc00 <= surrogate && surrogate <= 0xdfff) {
			l16 = surrogate;

			// Convert surrogate pair to UTF-32 encoding.
			utf32 = ((h16 - 0xd800) << 10) + (l16 - 0xdc00) + 0x10000;
		}
		// Normal UTF-16.
		else {
			utf32 = surrogate;
		}

		// rolling sequence of up to 3 code points
		switch (cpcount)
		{
			case 0:
				cp1 = utf32;
				break;
			case 1:
				cp2 = utf32;
				break;
			case 2:
				cp3 = utf32;
				break;
			default:
				cp1 = cp2;
				cp2 = cp3;
				cp3 = utf32;
				break;
		}

		if ([self isEmojiCodePointOrSequence:cp1 codePoint2:cp2 codePoint3:cp3])
			return YES;

		cpcount++;
	}

	return NO;
}

@end
