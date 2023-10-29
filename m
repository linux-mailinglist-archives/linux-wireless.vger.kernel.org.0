Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2D7DAA4E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Oct 2023 02:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjJ2AyX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Oct 2023 20:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2AyW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Oct 2023 20:54:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2066.outbound.protection.outlook.com [40.92.99.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8239E
        for <linux-wireless@vger.kernel.org>; Sat, 28 Oct 2023 17:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehY2kXN31Y7f6NDTabtPdvUa+9aUkq7kvqjk/d9VwUlOrTXm42zVJ0zYOB4BDZp4oato4HqVkxowi+zeGSgcpcj0a2c8nb0erh06bzQXEj65kIcbLATnN0hnA/kCpFmvd1QGKHnzCH1LWKkKH0pAL0ZW2MHSGbWLPKUjFBFyPHwTTvYdkhP/RqT0+RNkeubFuqwbYwEaWJiObF6b7/W/7UhOZCykLsWi/DJ2rlC4OWuQoVf4jDNJjQ1yLJpTMC1FXaO3vk2f/fsHjqEm837benKyaf8SnkrbWxxLaFXGSgSs5AdpjNd36Ba7vanz05QzHUHLJFFBMcGJqrbSviRWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbWn+lPDJPma78prKLFlZY60TAwLHBNaDrFl4DVM1Sg=;
 b=CvRid59VvRjDoQJIaEgfizh8XYlaMGFfhR+OImAwuG/BB85LT2K4fj+Aq/xhziiKnvK92Xf5uI7VJL7g5wdcn45JiVVrci7T/1Zscz1qzVaWEpd2iYMh0VBAun8sUpa/lQLCu4sbAURwzpFF+dkkVEeORxpUA9s5MvFyqsGyxEaThpH9dHZ6aGxalAmO8k3fsGX37bWLwZEAa7LS1FHilCaOIEg9d1EOjVa83D1/rl3uiyoa2R78qdr3Dq6RF24fm3SEICRRZQLNapLsyPJ/uoRWhyqQNQolpOSeGUgk/r2sD5+uwMY0tFbPAulL4s3j3tZz+H49e6lYx7e1tmzOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbWn+lPDJPma78prKLFlZY60TAwLHBNaDrFl4DVM1Sg=;
 b=vO2FKteAJpicDyX577KzSCnEBko/zBdwsbz2y7dE2nrlvJ/nlQJnF78SzLQbeo2arPD0tcXurhmau7znINcWj1GKZ1XBLgA7CBHYbseA5ccly4SKw3AH1CFNh4NNN7FQGHz5o0ca098FAAIVHCGLkIe0a1hbBgFMcF4PLKULacL+8SnrhlknAJ8ZKob/mrxLzCz9BeVm5wNnx/OMfxNRMtLYwtLoRyTxRU1YChLZ6fiYT/sN6tp10YY4+lSJ90bDmDsh5lmqsmxbirqgQMcNlQRX82YblhlH38krVEJc0UymwqdHfMjPxFAdGQJys4oQl5EuCgCsgbJm7PG6+797sw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2258.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:153::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Sun, 29 Oct
 2023 00:54:16 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6933.019; Sun, 29 Oct 2023
 00:54:16 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, stf_xl@wp.pl
Subject: Re: [PATCH 2/3] wifi: rt2x00: disable RTS threshold for rt2800 by default
Date:   Sun, 29 Oct 2023 08:54:02 +0800
Message-ID: <TYAP286MB03156AAFCED8CD8D91392FC5BCA2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87y1fmbxwc.fsf@kernel.org>
References: <87y1fmbxwc.fsf@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CODVy8XVF+HDrCLHxGz2NpUhWVHjMB6lVIFIFis2wPs=]
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231029005402.6834-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3feb9bd7-35f6-408b-38ba-08dbd819928e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDiIPYwdO6+sYufrWWgAXvJ6aQfch14Yiv7lMZvYYqrZiiPZ7Plx37SmnOFoUEJeDeda2je1e12vQ+8zYxj+4/jP0LaYjmNLe3zk94o9hQj3rdmlxHs7vfEjYqIcnNEToh3kpf7gS21bdmMVRvfHZmCQ6/IaRyl3MuZmowjlUyj6JnQ4dGu39bOO1GkTVBi8YcCwm9rjfbSUUHhq67pRpKW6QFqXM55U70rZ31vsIfUe0YcZCmUQFHEMFYona0kGQwCXpHuKEgj2lHX6JeqwVPFipWBxAhGbzrPDYUgbGM93FwNEhTYr4fN4VqjNaGC3jsNtmEOv6NpUZ2AHg6YKRsu6Jnxj8Da8GlNwrVZWu6T7sdo6fK7NaSJY8kAQDrB1J0xMWZs+Tmsgb3gAt+BVIoNXa9ZAUm/o/KdljJlk5VU7fppbQJGEjMhSQlUnn6fZVidneoMy5p+D4cepkLBQycuS0BjvUss2vHd1eGmx0gATu9Qc3PvR11u2fdilzL0bFyfO6qIxPoOYtKvs/LmS1AYzOwoa/1c+UD8az3F0ojBRCbMH1c8BjlAQK8ixAXyv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9MX/lsqg0XR3i+HOyvySLs9+BUc03mw7dwobQQyVFuWXy7az7KCNCn0oOG4d?=
 =?us-ascii?Q?7nvsm9p6WFmpJEpTPhmQTG0s6EjIKouD4+tF4n+OE/O7bjTmX8klO7um2Cww?=
 =?us-ascii?Q?jbeJ3RGAirQUAX/Z99wLjYJFO4oqpjyhRiugdQlbMBpZ+vpyCSnANl8ohDsH?=
 =?us-ascii?Q?BI3daChk1J6FZBqlFAdo64beU8I0kWdMgLV2ORgofrbGvmdbn/4JA8/WudRv?=
 =?us-ascii?Q?uk4oUaWRQxYkiN06pNZc9r1xNZ1uipWz0LDOc+thSXEaWAFdcZoZG2otrTo0?=
 =?us-ascii?Q?eZcZNUT7uR9ZZwSCuthv/bBePfogkz79AxSwo4lhkpwR4Ro4TC4M2q/LFIXL?=
 =?us-ascii?Q?8vaf3WrBYm6214i2wL4/o1vnvVZfO8rGlLztTkbP2AlM8S+3sQlkf/f8Mtwt?=
 =?us-ascii?Q?iTGpCkuSIn0VcTsaTvltpW0xp70KyNLKSt57371NryRggzrBl9W0ULqJMvW+?=
 =?us-ascii?Q?4arGdGV90rU25WNEzvXTMtoFKCFhXDLZ2/DxqKYWXTYCTnMbIknd1Jln9ioA?=
 =?us-ascii?Q?Ka1dOxYYdpmxiLqyI/IfhmYy8QIfGwlVBiU3R1cQjAFdwL18mKAaFhdZO5eF?=
 =?us-ascii?Q?sPinxIR8roDJ3T6Jpa/kQkZof/skdgT2q0qfvA6DAjiiUC+dreJTMeUkXaK7?=
 =?us-ascii?Q?U1mkg3iQTUl486iiWUEBG4KcOdBgjNllOEju7+S63XGPiVC8Gt6VL3UdsVvX?=
 =?us-ascii?Q?x3kVuVgZ2nL4F6yQyc+CNX9RM5k9FBaLqDQGX1KKJcjbcoc+03cRRNNSu4yw?=
 =?us-ascii?Q?yvrohW3dD/hu+tvD8oJsU4T65a5wm5M/IhGYSGm6Ne+iSZNamtRhslK2zqqo?=
 =?us-ascii?Q?60Q435ePuQf6N0WUE/CwZ/TXXJ+ECx8Ijku1zxlIqi0zjo81SANjHIoEvhEe?=
 =?us-ascii?Q?Zg4W96wEKB7pc5ndn1UE213K7M98M6RFRm1dbdKNJx2o6d/Se8002a7PE6lx?=
 =?us-ascii?Q?6u7nxMFNpHxQXJJ1LW8Dp8QdAMtGiWZ6YHn/Gx+udAtxpe6lejPcI+wH4y4j?=
 =?us-ascii?Q?+XhNDLgBdUsXd367vJiaJc4P+efu+iF/vb9fWD77erQh0gkJ6AkE6s5NeJpf?=
 =?us-ascii?Q?8pMh+j8rNrCHys/08FkzJMonmI5YxxAZL3bBt/IXaaMbvHV6BqbEpR7drwSy?=
 =?us-ascii?Q?78oTJjHkkXTWPZBmsLyzNneMFtIrwP+cf+OrTNv22SZKMxp6Jmp/SLZkLpgU?=
 =?us-ascii?Q?q5pGF1XyTLfoEk9YfDdz0Hdt+sR3Ypv5fvG0o/H9n1l62BqjVNUckCPmo5I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feb9bd7-35f6-408b-38ba-08dbd819928e
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 00:54:15.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2258
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 28 Oct 2023 17:54:27 +0300, Kalle Valo wrote:

>Shiji Yang <yangshiji66@outlook.com> writes:
>
>> Disable the RTS threshold for OFDM and CCK rates by default as the
>> initial RTS threshold is 'IEEE80211_MAX_RTS_THRESHOLD'. And RTS
>> thresholds for all other rates have already been disabled when init.
>>
>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>
>The commit log should always answer to the question "Why?". What problem
>does this patch fix?

Hi! Thanks for your review.

rt2800 has a lot of registers to control the RTS enable/disable
status for different rates. And the driver control them via
rt2800_set_rts_threshold(). I found that when RTS was disabled
in user interface, this function won't be called at all. This
means that the RTS is still 'on' for CCK and OFDM rates. So we'd
better to disable them by default in case they did some bad
things. The RTS for HT20 and HT40 is already default off so we
don't need to touch them. If we toggle the RTS status, these
register bits will be enabled/disabled again by
rt2800_set_rts_threshold().

If this patch is acceptable, I will add more explanations in the
v2 patch. Anyway, I don't know if it really solves some existing
problems, but I think it should be like this.

Regards,
Shiji Yang
