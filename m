Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF7721402
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 03:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFDBqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jun 2023 21:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDBql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jun 2023 21:46:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2089.outbound.protection.outlook.com [40.92.99.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF11A7
        for <linux-wireless@vger.kernel.org>; Sat,  3 Jun 2023 18:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcWAaFQjGu3tAV/bXaoO08tP8XFGBsdcaYCezl09T+ZrxUxNDRpGWJN+PAyjL0HsapXk1ybTe/xmi+fAqLsfWmES3G31Wv4wZrSQC0FV7XgFLy0HcuHPv4muxFmO9VC64C4pscut3/lwecKuDXU9172PfoFyvN6H70/GjvV3WDEu9q8ssmB9b3gy9qepIjQ9BWrQMRaO0jl/0xGiLaM1xvbYTkZeBX8Qwziihb+DIMp6hq0hAY+BYF90To3tapQOfgocNeI0VWZmpdz8+purIiHeVX+7SDbscGaW46+18IDkI4N6RaRaBadiGKfSnubRKLEe1guW5SpHfwef0qWBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zgs/lJZrn6BmcrMQzXDNapK5b1limh2xigsDYtj71o=;
 b=OrF06Y+tzE1jog90MOKzLJSqSRT/O57JP2U3CjMMlrUJAL1o+HzwdA+geVmp6Xllax/Da6Ec8nkuuB6WJHYZXoGVX2veSBP4EUGFnjvAJIQN7n86ZeYOpMbF5m6qHAelUQJdcjHjfByX7gw2VDdp4LHHNE2ByI78m5oEB4VWLvezIvOQsLRsZjq+04rAXk+8Ngt2tH3Cm73zh/h8sPoi5fUYwSqNwejanGo7+txqkEtSb5TPdqZeER1fG9xslCphUXAIxGnJD3JxkWGglOO78RXZMnwzEFVVpxevlzexVbf7/zNAvxvfmfLcALqvecbPGozPgc982h6dQ3FkA7L+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zgs/lJZrn6BmcrMQzXDNapK5b1limh2xigsDYtj71o=;
 b=fI2hpy/oJnWp4hz4m09jgCMd2uofcAQ5/LIqQZPOjr5pWSKkKui1KscTTaTC7pOEJIeLDDrc5NRkcZmh0fgpD7Lk/Ia80p0I8FpdfsM8pNZHTfjmWMRH3OP8EFb0VmcfifKqC28wK6Znlj6+/U0fnnv6v/H31ZRFWXodZXd0SrcN1F7xJqCPFHqlFCT99YZyrcFu5Esxh0faviupoxIsC8MSIbXlczBbJyXtmi+vQLN/FmY6sHQCAhd/SPhwdlMDmV4m+iEyG8RUPWKcW7ETD9MyQudd9ngzZ7x45Zbx/VZifp2+i8KW5/k3L8876RQ380ilr7da7J9myMDxZoQYPg==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB3621.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 01:46:32 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 01:46:32 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     kvalo@kernel.org
Cc:     ansuelsmth@gmail.com, chunkeey@gmail.com, jirislaby@kernel.org,
        linux-wireless@vger.kernel.org, mcgrof@kernel.org,
        mickflemm@gmail.com, robimarko@gmail.com, toke@toke.dk,
        yangshiji66@outlook.com, yangshiji66@qq.com
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
Date:   Sun,  4 Jun 2023 09:46:23 +0800
Message-ID: <TYAP286MB031549FE3088D5C895C1ED3FBC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87cz2ejva8.fsf@kernel.org>
References: <87cz2ejva8.fsf@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RzqqBzuFf5jsP8OlY3bwfQboNijcgZDMWkPfvxrC4i0=]
X-ClientProxiedBy: TY2PR0101CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::25) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230604014623.2503-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB3621:EE_
X-MS-Office365-Filtering-Correlation-Id: 567fa2c0-9306-4f47-1c56-08db649d85e5
X-MS-Exchange-SLBlob-MailProps: SoURN12IA8s/gDLIVuVs5DCM8ERYB6AyI/mAvjbJTkDTieoacimSKT1xoG9AYKy1P7lEeiM/nIlCH2o/zemg1JUD3nZUDAwdjWnqRgTodcGFLBv1wu7k7a1CtVO8saUTTaSOIdd/J5Kn5Tpe5K5vta1xEodrB/9NECe9+EB26ZJnKijucSLCmLak1IylP7En2RPfJVijQqm8MCKkeko3Fx2cIYC2pgRGR/mHryaL1nGMAkGwIRcec7kDU1a/G1t2VD27miZFo5nOoUGJF4XJl4CuRGrNVxjt6KQ01soY14E59Est/g3OMjySIwmAiVDUIcg/LUtxpXlxSOJ1Bm/DoWdXZ4agxQlpiUqsVEg4z2kcMAGN3hDHqPZlTGEd9DQrdkFKOwjyhWoISnU4Onj9ARZPS6MJlu/50hQZYeSsL1fP14RprduRgdGHV4lnhyrTOC/AWxs8crmCMgEiDnNU2001R22wxK3NFbYfnx31qPIjcJZsoeY3TqIKWHRLL+YgAfu0Wf58PJW/J8IUlHGf+xs6Sm/1SH5/KmlWADTRESSbLks3P2jP6LWkvjQCQj21DpRRcf/wWBERdF52cyoo9e3J0O0PR323YMyYx5JGtVQgfUG+kl/JP5lZjATjJGgx9ZwH2P4kzM/1k2ryuPvnnn4piY+h/1we
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cj+Ju5ksBIeiuaG0BTVMBBN/vc+eTXoNeLRz5vvva9pr6DsxE73CB4tzZjiOt24X36YV6/pJr9OxnFuR6yxfe+eN7NqOL5y4vhdS0E9Wed+Cl424BPgfX2ZXhcnzdaQC+CBmTwM9eZdhzMEhb+XvyIMDmpLrT4Xiv61L8rbW2rjH07khh0CUEMuGLiG7Yc8uPsoGQVYhphqHKkzpWAk0v09rYo/oHxkKzSztZKAu4tmmY6OD9xvp2qv8SDK7qFobq+bDQHv+p64zTeUBVx07GANQFRsIwNeaLu8djE2j9EPrrhEjpvq4I27HGu0ApqL7BNYCctbi6gk2tLTfnJ0dyLkQZL+0rx4ogYtG0Z7TMKixfE5L0ryM2QTi38N1IkzNZM/FhcSmrUSSvOm8LoB9iv0GFtd/c7ln9e9YYs91hk2MKtr0co5dzEnxDo0gR9o605IZ6lGTRAiitcY1Fmlrqo8+MnaCRMHIoVwHwaTb5pnXGiX57ljMWuE4z3zeEnyBUxE8+umMSCJzIc+3QNR7ofTjU8j8jGskBXwVeMPqVyyZK1u6lSYJuOUdVPUTeY8BaBvypAhFmGpxiWOpj/yQ5AqlNmBlhn/HQLVyL8gnUafs1kaTcFZrQ5HxsH0Rg3fBy88wHkIg9ieo41Hi9gRaNA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMaEQ9UO1XoucRQLwDobri2xwbtbIoYV3L37pPGlms5TxwRPkomwC2vwbsUH?=
 =?us-ascii?Q?swiX0q9/drwN8do9NMRHC+SJUcfvhXT1lavdyMdBXKU1bfBUtBvv9R5h27nS?=
 =?us-ascii?Q?bx+QZAYB1iAeCN6sQbJceE2J6E3A8BBIxD9oOTIBfjrAu9jdn6t2+w9Xwt1t?=
 =?us-ascii?Q?NDxPzSnjHfMU9tlNiyEA78hi0hxcfaVL9PXG0veL2nvPWj1e55HhVCWn8gkK?=
 =?us-ascii?Q?f85tTYctdf9EhAOn+t+aDbeF2Rys+8bWlLJ5XVeFdJGww5TJIvX5DSmTYEZR?=
 =?us-ascii?Q?IRrZ+1Tm007ZmKHkJalB64Rdvx/dUvZRYPpbJCOUsgTTnWdQERmYR7Qgtcp1?=
 =?us-ascii?Q?+hAjnRHIu1+AZuhGzHrDiYwiJ0NmAXZBiyKTrePLHUc4mzMZxja3COWMCNp1?=
 =?us-ascii?Q?c+KDvkadtp/WafvYHVsnpI4c59tv4gE7AFS8uGvl8cAVxlTTSZfB8RJJyOA7?=
 =?us-ascii?Q?ZzOVGCxZbFaYBswFBakruR7q12QMJe+UN+z+g43jn5hxhLJhbK732RgqDiBy?=
 =?us-ascii?Q?NjNp/vB/bwLNwP842UwV4sEE+Nlr6MiGhWX4fgwafBGC8ajATx/lwerLc6/X?=
 =?us-ascii?Q?KznruK43H7oaRBdv7P+LwkUmHxnqF1XMcjlsXJ5ZUiJVnYcg+j472mQUCqC1?=
 =?us-ascii?Q?BMkOSqaDNMxDeRxf5Ak/Rmt+gNcglGgs+aNFk53SNXTEAfcOJJsQg7lcxRgd?=
 =?us-ascii?Q?9ftGst1TezzkD93hK/MG6nWz+9MpQRtuosCID8BZc83tM6B03KYGA9LIk5jl?=
 =?us-ascii?Q?rmpvP+ZZRoeM6zlOyZXXFMylSMoznGmPiIVAzj4qso96c2K+s7tK18Ppce4o?=
 =?us-ascii?Q?gWZGWU+GSXebH4nPr2aDwcMGd9ibZsQd+s08Pv0Rk52VsWSHmQ7yA4ngWZy9?=
 =?us-ascii?Q?6TGjzc/yU9iEIkD6ExEaqzIZUqrCKduIGu6kP6Orxi8h4pHXmuJ4QGb/4Ae+?=
 =?us-ascii?Q?yNHHZeyY4tEKmIS+b28s7uy8FSZ2Lv7nvp7jr/Dve/8ctraJ3xXypSmykjI+?=
 =?us-ascii?Q?iSbPF6/p0bHwzGodYy9qcd6ZP7/0nu1Hffcg9IN5PE8SbJPYF0DcQ4jiV+2m?=
 =?us-ascii?Q?mUBw0JXE6RXZRKh7wDJ1ppD4FmJBqRNLp6Kuxf0e98JQVbVOuiEnrToazoCu?=
 =?us-ascii?Q?wPs5ni+OPER7iYkd9Qs5vK0DnGc3bhkuGsH/N877h89gd0I97WisVhhfioqE?=
 =?us-ascii?Q?RjpTF9VDzIlEadpv/ymHM1k5QtEzT/has6Vaq9MiSo/B1kX016F5qcmm9NM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567fa2c0-9306-4f47-1c56-08db649d85e5
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 01:46:32.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3621
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>Also it's better to include links like this in the actual commit log so
>it's archived to git.

Thanks for the tips. If necessary, I will update it in v2.
