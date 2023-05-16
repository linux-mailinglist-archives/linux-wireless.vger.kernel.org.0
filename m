Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7538870517B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjEPPES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjEPPEQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 11:04:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2090.outbound.protection.outlook.com [40.107.93.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE565B85
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 08:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzoDdZi32l9XA2lCKx/lXzNaWbCKiqNDR5W89iZTa51uDHerdt10/tAp/HlS9ry8QldHU9+3daLCigms2fPzqEl7kCQyVwPkUySHFtjKo30jI1pBq9by/mLbeWUxMg3fyva8YdNpc6/YFRwDvSj6DWgZ3QXr1ZrPI0+dCRjE6QUNbYr8Dz2xXy0+RezVjwqHWuYSxVkkT3ReKexZqUV+6dJWo3oqivfEQu/0B5yMBBv1uGQYBDxNnvLvPpf+40W2Pf8yv7mhlBGpV0bMq/o0PzQ2VGc43Wh5G3VTA4LR/deYHQ9TaEzQiLlLfcTyegqGs3oRXCI4nPHUsg+2C1Rq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLmkus46LE+jjYucLlilAyTNK8+RZYyLzqokmoFw/Ao=;
 b=Y83owguab/yTU2/zIuYGah3oYwqDssabYd4UYMwfy+jDyylif5Mci+vf8BokmGRQ8F4+M+08Eo7+p8YI0su7df1GlCxD5yHppeEqWs91ioLGcJ8iy4pXNg0GfjJfHd/BP1vyeA0QVs1TjM004DEOX7RwQe1XBiDIKaZ/YBiEBPXxjQ8rF50HYDKO6hqaPn3yS5j4IOfK6dM7DsRN+BAXEy183oTKBK3InsHXS8OSQgjXHmUPkv4id+oT0E+8JQMj/SDDQDXKiOSNCe4+v6ZpjBVG00DkMbMcHk/EuCJ8cnR3reaLocr4EXoIp5v/xRzhUqyIAXVyKTNlbhux/mu8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLmkus46LE+jjYucLlilAyTNK8+RZYyLzqokmoFw/Ao=;
 b=F0cRx56VkiWV+zNuN0ysZjYEEksr2hfOYgKOkD5waosSRQkVRIudngda6kkWcp5M2was1C4lFFqSfNokbx1IcwcX4ER6XXm0cL4JbJNgRjnAaSlUIulUkLg8TOZN15o5ezaKjUaHqeNJyT6IsqqHPSVQ+hAW+Mwd/7FoqjOZXtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3851.namprd13.prod.outlook.com (2603:10b6:5:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 15:04:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:04:12 +0000
Date:   Tue, 16 May 2023 17:04:06 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: mt76: mt7921: rely on mib_stats shared
 definition
Message-ID: <ZGObZnyeGSl4Nhsr@corigine.com>
References: <cover.1683930235.git.lorenzo@kernel.org>
 <09e74469a8c47138a2c20b700f8cd1193bc0bbae.1683930236.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e74469a8c47138a2c20b700f8cd1193bc0bbae.1683930236.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM3PR05CA0121.eurprd05.prod.outlook.com
 (2603:10a6:207:2::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3851:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f1592c-e775-4f1d-efc3-08db561ecef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Js9Yjok6mLT4LyAzpBDPXpKuqD7TWE2ZFh/pO6RLqugw34JcRAevNhcF/N4uD2DZ+lbE3bi6zGmMEH88iNS3p2Skhk3Omvo4i8vya8Z2yW6EFPitrLGzs247+SpRxaBR4i5W8uMOy3P11dxsm5ce2Unr0OUJmuAYmYMh+Z8s2WjIqDeDpaaNFEsJHoG17wjT6sRSz73FnOPo5IP1vJbQi6CUmfPtoEKgiJv9aaEQG4nIDRNi5QkezuU5LQyVZk3W4hpNcaXjtjpFmWr3lmkOAL3ghN2Fibkhs2s0HgoNA4a/c6Cd8J1sZrhDtUuSm8YATtQLeXu/0HDqLtPu4ynurbDdbnguqCfDufc5kZMHuLYqsHO8fkwybli9gspUncqymjnA0mwvQVtDWGhLt8Oup/odEiRKh1Ca++k4ASAx1hiDaLfXYxksF60bFXwFedEldiJmLHH0mpbfWyb2HappOsjnL2AL5iscEfBnZ6ZdwTMCeAKHRjzcARHSswShj3Qc8qyr62uUy1iJj51+hofd01QN5IL+6jOeeJz1Kt4wSd3ZCEL4+yxbMCnLLJqXzAUKJfgRh31MZ710PdzRfhZFDz7hL86l45p03DOx8h0wE+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39840400004)(376002)(136003)(451199021)(5660300002)(8676002)(8936002)(44832011)(2616005)(6512007)(6506007)(38100700002)(186003)(478600001)(6666004)(6486002)(558084003)(41300700001)(316002)(66556008)(66946007)(66476007)(86362001)(6916009)(4326008)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YD4AnjqW5CweywuvE8ZUiyp/SuDo8EcGMpUt9Hqd2R54Tdey5tjDGin9wZQE?=
 =?us-ascii?Q?TVMWSrnqcy9KEG9F2QojA+zhgkbYxBaAwlGiGkwbvMh6hXrOyvpGpO35KGnu?=
 =?us-ascii?Q?rj11iWpwC4sAZnAAtS/QAN95QEO9bWAjjKz8d/9jy5QccOsCigseudefmMVz?=
 =?us-ascii?Q?VsNILywuJV2Wh7tX66hTPuWmo3N290LKTTZr3eGXFnRbdO9miwdCkWzr3lxU?=
 =?us-ascii?Q?DPj1Oc2i9gkPt+T53WXS6yl9Dj3es2BdO0kZqWs6yIE24zlpHBatkRckp3fo?=
 =?us-ascii?Q?EIXzbqY9qLRDfgYsiZvWZwkIz/ZrW0CJoQ4wSjzlYGb6KXZ9EPKJYMpaGsmm?=
 =?us-ascii?Q?PdweyDk8wR6SLjXasPF9rcwtQYqHjuYEvFBjk+3cRLKqasFa2qlTlouaGNox?=
 =?us-ascii?Q?azb1e3P6MWz/s2Gt+r9COi4Kq14roU7vQkZrvxcSL4CiiW9zbCKVWJMgCNES?=
 =?us-ascii?Q?Aa71N2dD2BqA5ZY/Zml/F+hzRThwAP13cvttJJqlfnHytGfs6C3HnObfXjkM?=
 =?us-ascii?Q?qcY2W+70klRwe/vpubcylCR/IVlqMlHeGXJcg/RhnoD+lqXNr0VsmAa4ZWk+?=
 =?us-ascii?Q?vqb6JOk1jPy1OjUAR1Jx4HydGuFL1RFY+k+xyosYy1pK0rQYoe7a2IsYMBfC?=
 =?us-ascii?Q?859jAJhgQShw0v8GAs4avjP+/9ix+je6GBEp2QatL47ASJbhGEXjsNKAanL1?=
 =?us-ascii?Q?YU6Bjj7h4vCf6L2VbGK4Bl6rSh2FzINO5YqUn33UEcZuefvoNz8njDpF+mAr?=
 =?us-ascii?Q?EHADZNJrGgRCoEBrEvEv60VEfqRk5zC2W/GpGGcDpNMfSJPLKIHU/SrNFObL?=
 =?us-ascii?Q?XvJMTXuj9bwH9CMXT1AHPhnB92v8MQLbsyH3rQoPltvF8kO8js3dUNjhuj+M?=
 =?us-ascii?Q?/NcuRDV0rSTDCmpVvCp6Q9y8BToeVjq0gsTnKkpFJpi4lVD6dkFApPzxSQer?=
 =?us-ascii?Q?sDYbcW777w47pmIWecMdhl8gTUDbuvIr2FHXsei/CZmm+3CGGVBl4gXgOCNW?=
 =?us-ascii?Q?XKV8l4xHm94Qn3zge/S7Bre+LZ9PHJSwIWuZ6zURvoOvV6Kc5ejhU8CR+nem?=
 =?us-ascii?Q?r9CMF4zUmx2vWsTndXVapK5F/fP9/XTBK44zi5zlxh0Xxb1u/rV2xD/lZnZz?=
 =?us-ascii?Q?Pp+MdP+6H68hfWNRoOgNyAi8gnQhvv7bKv/9gT5HTgmzXmc2Z8sfubKAwP3I?=
 =?us-ascii?Q?xdXZWMGJXI56ZDOHcUDJURzrroRMrTtyU6+myMx6pLoEJBaNOl8ubK9oLiXW?=
 =?us-ascii?Q?VyO6dZ3Vbb0vGY1hJhiHNdDrXoCJuVbECGgn0QJeRWCAl81CJ8ibg4zwAt7/?=
 =?us-ascii?Q?bcbL0N9mp1raS3c0dRILuS9lsQbzBAJEcbj8cIDfH9TXNlPJH2xS8AFxYFmO?=
 =?us-ascii?Q?78G6Z4ZdGO/kJmlzt/gGfJt6R75geUqTIXGam0tEshXLmPLGziG38bXABAxl?=
 =?us-ascii?Q?6EtQVkxt5jUuqk3jaYRGO9Him9w8bk95JmGT61skFXyM9u1ysa3LnDKC1sNp?=
 =?us-ascii?Q?AEfLuKi9ltoA4P3ezywOPnSB9dwNZfKuj+Upuq+6ySmoN59aJuntWToHCIee?=
 =?us-ascii?Q?H2NlYiMZeB+GfD+J9/x11kZbEU1FLx/Ovgi4SzOq5tr+O6nA+k0INIn41nZ4?=
 =?us-ascii?Q?rcPHQB5Xpq4ecSb2fPVmNIjGcHLbqYgvNGUGKpHIOa9f+otYIJvo8Q/AFAO5?=
 =?us-ascii?Q?vsoSvg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f1592c-e775-4f1d-efc3-08db561ecef6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:04:12.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: labu7+ZPXa34GkSGTuKRJ/NnvQR/inNMcs4o6u2v9oHYI0wkw3znwaFBe3lUNuW9VUFsKGtROkCIzEzW1sTR7JPoZXy/U3iyqlpqNj0TY3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 13, 2023 at 12:29:55AM +0200, Lorenzo Bianconi wrote:
> Get rid of private copy of mib_stats structure.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

