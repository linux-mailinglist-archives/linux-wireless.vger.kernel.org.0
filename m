Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38407CF7C4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 13:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345476AbjJSL7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbjJSL7S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 07:59:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2058.outbound.protection.outlook.com [40.92.98.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B70136
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 04:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu9T/EIQwChdyGWC7rRXCk8zZQCpETJXsCXP6u+yOt+UuV5ltQv3e5I/YwIIPCr3Q81AhIb6jLEoTEWqELJQV1RyhEUNzeILQPCfaiixcVw1FVD+N1H3sYd8w45mBJpd+ZIheU0J0vjAL0PGX8V1W+itZ1N7Mj/47RwWBO1twW2EfuvwDM2M4am1YxMUFm9WW/8ZPttk5WC7AauR0zezoF9vwc14Cod2vsC1Wi/nUgAXrPW5YfEgWrNLK3hfQTgtJ6mTVaMI6Sg6JQVzeTiHA4pl5jC4h9oWvQdG/f001sNQVYnp2sGiIc0YkhRyyCCZ09k5D54GJoDpzxHAEVXVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMV+JLPG7x/BoSPym1ZmuJgc9Ws6Mca7lQyHi7/RsEM=;
 b=i5lX52R0M/U9n1trMFYpur2O/MRm7/tYeszkJnhLBAD1FqSigue1Y0rpk0CdGarroA19BKzYbgHZ5d6C6f6o91ZTPS98fd46mnSzQD9Orc15jExnYgZ/+Hbx2JVfpebNJLrYZysQcAZA/sC/X8A/sS2/k0NR7WsnHcvVBZhV7MsYgpgCfcJSSARMBSfV0h7Vnjgmct3aVfOBqM6GUerIYYfYkqJ8C0o5uvWTDGax8J1y5M906c/QKwXDUYOSvT6QhVhwZ7lCtCFpRSmQKdzgCKE4S5u1WoOH/3PoFTVL6/Vfs8s7ma8s5h2Otl6NqJreTHUMVXdTRYxk29EhMfU8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMV+JLPG7x/BoSPym1ZmuJgc9Ws6Mca7lQyHi7/RsEM=;
 b=X9oKpu0i6av/TdNxFD4fOu8CzfUILW2bjvN4d5lRcSJFxueMXRcXm8AirJQ6af3k0LUW8YUDijBCTxrLUnNkvGrJx0kqLGGEKKMPMHup88XxRLPBwbss3pliobDQRnu/JgAiyL6qoEfqxclrloBoTZwgq5LpCF80WtrMPozP2exInoEaL+OjxGJLHQZHWNEA7fUi6HsnLUp19ERh0rpT+L06WEQMC02GPgLLvZ3NzI3q/N847aF9zYodIfm4V2yfa9qYGQFTWWD5P4HSBgTTOoy9yMPTlm+n+N2PkDXARxrfa/S+GTavfEegTWNJ7fI8xvldh8Gqv4Fdi0SEBgT8Sg==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB2729.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 11:59:14 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:59:13 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH V2 0/3] wifi: rt2x00: various improvements for MT7620 initialization
Date:   Thu, 19 Oct 2023 19:58:55 +0800
Message-ID: <TYAP286MB0315FE08DF950CCA8946AC8ABCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [z6oeY1FX9GHSUlFOZa8aGcAQzap8cJYU]
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231019115859.2791-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB2729:EE_
X-MS-Office365-Filtering-Correlation-Id: e7513397-b28d-414e-82d2-08dbd09acf3a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZzclkW+BGsa9iH/NBb8ieg2rhqz4sEIXWhhR746XigiGIuek8471adsWsbpsOy43auDXhjjiKjUHOhP24RHqUtCdkczumTm0s0IH5u/bleelfIcJe1cMVuETYEVTQZRBKtz1csT94laPBLmL4RuWugoIa7hQ8+TJZaaaiebdzlSQgOfqwb4WKyPndg3aAjZQgqCz6/w8p2sHCvs+yoA0L7nuApMm9ZWApy4QDVmokEqZPmOS7+cZzzzYW9/HSGrFz2Ma5b8Su3dHlMnbdmKkVTlo2TvKjOepBatDTNGflEmt2OIvxHZg9BJVAk9OVDeA49YqGr2TNXJKUvygvCqXmIRBXKrfCJwnF4d4RPpFmQ1DHGV1FQFvgZKmgUDk+TqTfLI841yERaRg1pzxxEp/++CHx4LVj5cmH/w6zJLydkDqJh3QX8zaV119QLA/AarXTrMUZ5l8IU0pj/f6lh3l1rNHD8+r/HGhOK2ou4ghImaDItKUffCVBgr+MK9jwHJZMDPycx1tl78q4rIg+PTy1CMc3kelCHjOFNAUe71rBXUZB10/jrP2pzbeX6AilyfcvcVyxPIOebJo/LruuBoGV7GxsKAsItALFTLjqU0FaoAwYLsnFM5dBTQrjI+l7OC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWqcA1d2/gAaMIOv6Q2u2c5N1E+ipHZYaRfojCHrzhG8nFnjYXc8wV+pWGKc?=
 =?us-ascii?Q?iTrrnFOtJ/RHVGc3zQogVVtEJurwffbdwHpyUhIpRbyKnLuvbo3oX39NHklU?=
 =?us-ascii?Q?v+jZjLZpHyTbxvoFUzYKWjgqsWx2xv4AwNrZypcNiCYJoWScrbriGwKVL3Ym?=
 =?us-ascii?Q?X5ghALcmeZxbLSyoIiyOcGqf4XHGYcpPUnVRqME5B6gu6fn3bbSSsIjOl/uE?=
 =?us-ascii?Q?ylo4x9Uv7YgHJTpulapRg5eL/V9xBlMIK7od3Zs4LacuHUsDVgrpBWmxC7fZ?=
 =?us-ascii?Q?LqeHQQYE+oinTX9t3uo/gFaRkUv+ceD9yMNn/8XjFCW7NNQXTKSR/+il6k77?=
 =?us-ascii?Q?CiPPZp/6C260/+b9HMGIZQIeadZBCY5m/ClX0jmcj0jZKf+XheZ43dGz6YGu?=
 =?us-ascii?Q?k1rIHa3jeeTWwBAmq+n/HUtZLwFLhMSadQhIpoD9K0BqRAuF3gcowhK9z/Nj?=
 =?us-ascii?Q?uMT34bwBoniUipeOzs0i/QxVguF2dOi7CS5Hr+2fM4Y+mejwwUEhLgMD/zVK?=
 =?us-ascii?Q?jGcv68fIF9aoBisWXm9eunUIjB8aEivAmE2jFzlJyI3XCxaOSaMcQWG9A93F?=
 =?us-ascii?Q?BFnsnqSIIHS1OGkIvVae9FM5alMJcJHG/saA8NSe7zAM16PXSXFNoRgKfUav?=
 =?us-ascii?Q?uQaP8pWcgr8WVkVba4olHRQeTWJWoMDaA6GkbtZa/jMvP+2O7T54mQbYzBmp?=
 =?us-ascii?Q?KbdVF6frSwwXwUcw3KUyl/RfbipuSwUhm4bCA53+WOJW3USU7N/00V6B5T3u?=
 =?us-ascii?Q?Nko15LMp/UJgDcSVxPSyQq117I4IHhUFaJJf3oxRfydSUbX/Bnrrnx4uOJRp?=
 =?us-ascii?Q?SDWjv1MqKkfvSjP/WUYvtpATDow1UcbUBKAl+Vsq2aDsk3NkwKVFvUmSDk9n?=
 =?us-ascii?Q?hF8yFjYB1RuQFvCM4TpV4ebL9TweutOL/Z9e6CPN06EjMYMjWOa18rdVB+z9?=
 =?us-ascii?Q?EdlI32T9SHAQL7tx8ph2Glln+3DJRHMXCWu16Rr5rrGa4zjGmCJ4dDYmYsxL?=
 =?us-ascii?Q?J65djRNiaNhN7yGpevE0BghsoKXERNYLI9Z33LclNVjv3QjOggtXXQY3mIeq?=
 =?us-ascii?Q?OTqdsV2TaHDpf7RtPrLIS04APFisg8+zrnUzBWFNA+9uYHcaDC9UXHB5DPV/?=
 =?us-ascii?Q?3srHoS3o3rRn8iPe/y1g0p0N1gySRCoKcDnoLXLCtIEGgm2n9twngVhQRzQ+?=
 =?us-ascii?Q?mvNVVjyGQffCLHfRip6BaqfiuhyNVPOFHNyNfSC7y/YxTwaCuQumagD3wWA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7513397-b28d-414e-82d2-08dbd09acf3a
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:59:13.5989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change since V1:
* Move rt2800_calibration_rt6352() function call from
  rt2800_enable_radio() into rt2800_init_rfcsr().

Hi!
This series patches aim to improve the initialization of MT7620. All
changes and register values were ported from the Mediatek vendor
driver, and I have been testing them on OpenWrt for several weeks.
Regards,
Shiji Yang

Shiji Yang (3):
  wifi: rt2x00: improve MT7620 register initialization
  wifi: rt2x00: rework MT7620 channel config function
  wifi: rt2x00: rework MT7620 PA/LNA RF calibration

 drivers/net/wireless/ralink/rt2x00/rt2800.h   |  18 ++
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 287 +++++++++++-------
 .../net/wireless/ralink/rt2x00/rt2800mmio.c   |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |   6 +
 4 files changed, 208 insertions(+), 106 deletions(-)

-- 
2.39.2

