Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0F7CA874
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjJPMsR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjJPMsQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 08:48:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2079.outbound.protection.outlook.com [40.92.98.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ECBAB
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 05:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl1lMsB7IE1eWYgUzK7P25sWii6BgCXtdb0M+Vko6pApFVaCOPwDcRYG0rrr+x+YZQfjnLkmGxYGPB6jmLUcssw1WyvRH65lp9dtyt6BvaXWQPXR5x4D1Sffo0VxIKEIF08CeGNFNt4Kk4A9iKrMih1cx7B2HC+p3jNvCJKpSveO46Q8/Tj2RvgMQyP0DcXFgbPWzp6ND+5eKCG6lvkBIqsGWAHzBwME+lOU8tfrHfAIzOlke52XqnDQ4UCouY/HhQqPmmsrNX8+MmV1IopPoiGosa9uBHLaG667sVB1B0UL4SDM62Yc7CwAc53FmYqa48kngLrnRQRoj7p4e5DNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHkBw+9uwNW7EcQg88aOthHXceegOSovU3NgK0fY2UA=;
 b=byjTgGnow5qhLTMrZRm9RXCaBvBrxiumQiNx5dBc9CKVhYVlSsS1w5B/bUWyZpu8UWnyCguhdKF58IroAm0+e/OHSak/2xhON9lIT0BiOxkfgjKNdMldUUfzOWXqUsTbmzqANBkCXlgLdfvNS5bWFx3lXrp0iivszt045dl0SWjfdRiR5ZxJmILwEfiGV7YTq0yCenEkn17DEmPKqkiU87hZg36wGc1aRITDF2AcGIoWr8BXEUwfOhRDBX3vwMJDDmCLsgdNeeLG/paCRxXSUFrI6c8mCck2/8ZYFKANg7fuFxFCk2+UcKivu41VCfWgitdojO1lJiavkxfE4amYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHkBw+9uwNW7EcQg88aOthHXceegOSovU3NgK0fY2UA=;
 b=bQKicrDDTngshmH2CgimtKY6ywucKERLHraqRKdk5njnNKVvTnpByFG6zIRMav8utfK7EWd+vd6nYwLZnAgZydSGHit7iO8N9HWa/v4Tqm++rPiwjaFQiJK1LErFOQwDLk0aX+te46WzPIoXb4XMdH1I/7STzDwF1dX4SXyWiO+oxWhqL1+pHq4GETj9kwBgBzuE659sYTs0mGfHCkmz0SkZtLgA1u9tm7koiuFRSORLta8qe2PE/nYR+K892LtDPndIr4GgTQTqawTMsPgQuluqG8s+nn5cH5DOPCqHDwlNxwkbxsgx6ORYl2Eoq8K5vLAXBg2KAuOEmIAtAPzJrw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB3847.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16; Mon, 16 Oct
 2023 12:48:11 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6907.018; Mon, 16 Oct 2023
 12:48:11 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     stf_xl@wp.pl
Cc:     helmut.schaa@googlemail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name,
        ryder.lee@mediatek.com, yangshiji66@outlook.com
Subject: Re: [PATCH 0/3] wifi: rt2x00: various improvements for MT7620 initialization
Date:   Mon, 16 Oct 2023 20:45:55 +0800
Message-ID: <TYAP286MB0315F67DBCB35AB91CC5822DBCD7A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231014175428.GA477888@wp.pl>
References: <20231014175428.GA477888@wp.pl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/XcEELYteIBd9vNDfuiJGrcP7YDbBYoufJVwxJKSdpM=]
X-ClientProxiedBy: TYCPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:4::16) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231016124555.31625-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB3847:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d35630-1ed2-4103-6e0a-08dbce462500
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02AlUYZzhAXajNeLyi/foLdateGedoz3jHmFi+zia1Xr7s9fPhDRKozAvUw+EJkFAFcUeRLgZy+cFMySwEkhaxlBUXxQ0gSvOeex374FSh943dxVOD+LBn58DKi3b++pzI67VYtdtfqDzfwsfiEPwUIRXO630eshSbwSTdUy+8EimLh2jhyvtxCbJI3536GlMP1gKftk0RvIy1Grr+7cxq/8uOZl1tVejVC64IIEcLZBf+lUQv/ojhA7v3Et9dz9nt9Rs/1tzPtr2+DB/wbGdg2LNWnLE1ka1zkM4BsnR8iDDkpbYgKEdwhLVZRSyJh2ywgDmxccslO5kmOs60yy/RLYdkBdmNaQglstXMVvhSc8s2i3jnoXxx5bjuo/dLKKogl77XM5fKzj+ki807vOzMGl4Ub361uT++N2yFDT/C3KAhmCnLl+zYBAlCplnFtlwQCm9AX2XQZ8yMXBzEGoxv6KJXmlUGbcMCMeIHa7QJegd9e5TfWSaSUM3TmfL0f1JRhpQruxLAV0aUBKXHx7KrFJpQaZUvKSQWq9CLSQ+l4VSav3GddL/CNb1n4rzckuXO10URnqjuDMCF9w7aPrX0k9UyLWuqHoYvbaSToFgR9tXokAcbX9+GXKSHpTATfq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HgqH6p146YxyH9dQIVCjDXXI87Gq/XvwV/OWIHFLdEzL3kso3tSjSUJ67Arb?=
 =?us-ascii?Q?TiGjTcMbX1aleOxtaSk579N0FcLmJnKNE1z+Y0q46kz/xMSAxhKR5L7qMOv0?=
 =?us-ascii?Q?xjm9zvMoN8bZgsGn8QJKOlG/xCofHQDqGPPLNa4uLswOaNHgmN1wESazeWwz?=
 =?us-ascii?Q?XEuH7y9GR1YBwKay0BD0dbY02nqcRVZ+oYnFdwhyZSltny4MBEAEqNG7C9U1?=
 =?us-ascii?Q?iH0g7g6+ZeVjMMsXhcgTFQhr/GZFqFxNQNp8AxHzYSJA0ipC1FM4vk+rkIzK?=
 =?us-ascii?Q?3a3Kbbr5nAIs2prnk1rqWu5U5FbAOr+e3/F9mlX9WgDDoAS+Dg7X3ckuW63A?=
 =?us-ascii?Q?gI/uDLxNaJnYVcXEWHoajV0sOeNeTNR8fNLYYHs0TMDofDL5GOBrS2B5lSNf?=
 =?us-ascii?Q?4Ojz/EhAUFHSzpw4nMhUvefLTJBEeltbrGarfbpuPCmPxjwsmD7pd/OSqSN+?=
 =?us-ascii?Q?ohbePB2m7eMCUp+9S7xWMcBrbDOQFtwFu7eLQ1efc/c+/nJgHoapxKE9hwXd?=
 =?us-ascii?Q?h/QzX2d6JBwz0JTc88/fSSvTOux4LztIuHGtdpsovgFTvq3caftmRe1KoWtS?=
 =?us-ascii?Q?CuB6S3RvecdZMBoTmtNlaZhPP5jQ81wM5XWknE7d5I068VWbuL8U9kLxUQ1G?=
 =?us-ascii?Q?xZD63oGrUaRAqyE72waPAY+gswzITnnP9ORqI0+7jI8mZFEn7nypcmP4m9gU?=
 =?us-ascii?Q?EsN3IWN288guZyLJutaKt8zFLAutdNhmlJyExvXB3kZqKz081e5ta5+u/r0i?=
 =?us-ascii?Q?mgkJRBrE++nXcDKoEgH+YS4UZCE7QuBO4+bYoKIBTO65AImOw9XHk3P/4FcQ?=
 =?us-ascii?Q?KmlNqz5Qdce2EFPWIvv4UPYeTRcewNPFthpsvzCWa5seOew5EOvhye8ziDqS?=
 =?us-ascii?Q?a/LXBb3z5efBFVt6IpNUpDiPTq/3UEGxLWgQIRvgkpUyXwZVHAFGvw5UYU6l?=
 =?us-ascii?Q?semImbm2zJx2+uyNTQzpIFjYqlPsj7pes2208Dat4gauRLsfVn1ZUl9ruQdh?=
 =?us-ascii?Q?w2b24Ht/AJBXILA4FrXgBxeTmfrynzsmX3zvtIxRsHB5Fg5aSzYduoJUe2rM?=
 =?us-ascii?Q?eyeidMZRZTX5ad05dwfd+OjRcFFjG01ago0JUFOx97lc3ebihsOEcZAukGcn?=
 =?us-ascii?Q?9TbdSt1QMMba86wisQUUtho/9SHmsa2+jw8b0IKdtsng129WmrCVBzPzkPws?=
 =?us-ascii?Q?vijExC3zbGs+WS1Dbkn38/dvBPoBDttQ5Hp2wLLqq95AJTn7CwMNn1uWD/Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d35630-1ed2-4103-6e0a-08dbce462500
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 12:48:11.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3847
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 14 Oct 2023 19:54:28 +0200, Stanislaw Gruszka wrote:
>On Sat, Oct 14, 2023 at 07:21:27AM +0800, Shiji Yang wrote:
>> This series patches aim to improve the initialization of MT7620. All
>> changes and register values were ported from the Mediatek vendor
>> driver, and I have been testing them on OpenWrt for several weeks.
>
>Hi Shiji!
>
>Thank you for improving MT7620 support in rt2x00!
>Your patches generally look ok to me.
>
>I would suggest however consider to move support of MT7620 to
>mt76 driver. It's much nicer and better written driver with
>better mac80211/linux integration and support of various
>features that rt2x00 lacks. Adding mt7620 sub-driver there
>should not be that hard, and would be much "cooler" project
>for you in my opinion.
>
>This of course depend of how much time do you have to work
>on this. Tweaking/improving rt2x00 can be easier and faster
>way to achieve your goals and I don't want discourage 
>you from doing this, if that's something you prefer.
>Keep good work!
>
>Regards
>Stanislaw
>

Hi!
Thanks for your quick review.

Porting MT7620 support to mt76 is definitely a good idea, but to
be honest I don't have much interesting to do that. Overall, there
are two reasons that hinder me. First I'm not familiar with linux
net driver development. This is the main reason. And then it is
difficult to analyze the MT7620 vendor driver. There are too many
dead code and macro switches.

rt2x00 is already stable enough for me (except watchdog reset, it
still requires some work). Thank you all for your contributions
to the rt2x00. It's really a hard to job to provide an usable open
source driver ten years ago.

Regards,
Shiji Yang
