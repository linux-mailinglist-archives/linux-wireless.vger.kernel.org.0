Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB005706C95
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjEQPYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjEQPYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 11:24:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2136.outbound.protection.outlook.com [40.107.95.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D821B7;
        Wed, 17 May 2023 08:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvy7eDycdY/Rl8k5ccTYrLQWRQl0r9JyceQ8TmRJIGKQNGfFOBHEOyNkzNoigUo0pnS6N2FjzS3WFP6mg/5dlUylwsAWpk2fKOY21N3P+fiEIPm9fwPJnfhmmZqqP5x1p99a7juOZDz5K6tj8BVUJP+DItAqA0KpkMKuXk4/YPClfVTOJ40/CdbTXP2A5crnHx5CzCeHPSsPNQGtcMOEcZCD/SrhttWvt+Y4qE1afYTJzjRemZ5lC8/URbiCqkmh7haX3z0UpLuSEovNodifzM2eUSvFzyzfcmEL2JyvHCADbTVyyWzWLKc3MfkzGtvAn0RIyBxjqcZ60OpmHwStpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhMr9sZi4rABGR79KHcDrNxiczite7LhBujapFvUJ4M=;
 b=BGjUNelvluY/b/tQb49X4yVIzIfsz6B7e1LLflBsA7j09u4bMIzSgVMWI2KGNSw4DOun8bWYA06AHHKknc5D6xQDuib244lTV+OhLuSTvieBfMu3JHtz5WRPKe57QVSv9LL2I2kmYFoNWRsAVdOq2Tz+xbiAVSKKUTI5BNrMPE/iJ+IDNPGFToLclYS+aYH79oQObc/IsVorg7vp1S2HMmetjBQ9unh6FnQl9VVU7+DCAIB/B0spt6tqIhgqQoPcr5ZSR4bKnGTpQYvVgXuvUyCtLJUELlL5I4Q+UBcItQLXNHt6ktAsH2qYlCdN9WdWySFGkJ2RekyRAEmET3a+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhMr9sZi4rABGR79KHcDrNxiczite7LhBujapFvUJ4M=;
 b=qDhmt2Upn362MCV/yNOGZFfuCSGBMBi+6/6kuBZm6dhr4RtfR3GBH5to+Ee4XmgZmL8aMJ+TFKNIBCyAAc7l9lkwlVfrVYQLbghdJ3r6Xpobop+xDjdHno3RhkCrZrD10rJkgX0GQ4KgmKEmcH+H6G7JDthbE/ypn3ATiuTLVck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV3PR13MB6406.namprd13.prod.outlook.com (2603:10b6:408:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 15:24:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 15:24:20 +0000
Date:   Wed, 17 May 2023 17:24:11 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix skb leak by txs missing in
 AMSDU
Message-ID: <ZGTxm5o9w8c+mSmQ@corigine.com>
References: <3c9926f5492523e0128bbc4897815d75b83e324a.1684312995.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9926f5492523e0128bbc4897815d75b83e324a.1684312995.git.deren.wu@mediatek.com>
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV3PR13MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 919974f7-6e2d-4b25-2856-08db56eac903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3a6jiuzs17Vvn8dhm12g+Aea81SkBbqaSd2feyFEJSMgwBTNkAzdfTxHVagAv7TmBVzvF6khwoyjOmgETeO1rF73pEMIdn9QbtRj8YXONpQDIAn0l1/TRjQina6foUDu/x4POIXrQBHc++rEPmKPLgJEccnPF+6HhPHFZH3bQBsmKCPCqk1XCVUo+1Fo4zO9LtXPdrLVngt1b/VwRrMpda4R/Z1QfrW+s4Zse16SEikwyapmmgaObmeSQBrHnAKMoeMKA1Q17+9Dge0CsIaKe5rknrj5zp8vmp+DgFI4/1f8X3V0oN/bmdfwGKw3gFawlv8aL7JIov6SHrq8cPPWX8WJGGyO9/u6dKikcXAx3RxSUdp1V5em5Ip5v5t4uqjyKkb8zPPCKHhGCZZda6llfUAeOIK02pCv81y9xH2cAjNZ5ZTxpXWV3CpV0SDu8xItbXfsPsCziv5ICADMOorwWAYun77wGAdu1VW9kfuXgRM3T+1LdZlDvBXkZ9Zp2eh1+E219XtjBveI5xmKUPuB8tg0Cx0phz5851N93WwjW//3iiX3yp3oXdGGGEWRhaUyBTIvgFBJBPu2CV55tSy5V0dDUdcQqXdRR8kEGTbcXdn6avs6vsVopnds7yVQFKCqCDSTE1MxQvvZc18RAnXx2++ZPZvdcsDJp2UqwGtQMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(366004)(396003)(451199021)(36756003)(86362001)(54906003)(66946007)(66556008)(4326008)(66476007)(316002)(6916009)(478600001)(6666004)(8676002)(8936002)(6486002)(5660300002)(41300700001)(4744005)(2906002)(44832011)(7416002)(38100700002)(2616005)(6506007)(6512007)(186003)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tGd/oMdHJQwPu8LXBmC4bIimx/t3/nfo3tL0FCF+ybeeJwRF6Znk6NEMPVfa?=
 =?us-ascii?Q?0kJNd5vGlsAi2aKlClkaiqRrMKOxHLVTKO/0QlPm6eWymzCncFyGtKRSZfNa?=
 =?us-ascii?Q?1eZQfEv2TGe5LB7n5SrnrXo8/RCj1HYondDeGzDiRvlH6vpOscXPxrHKFoHh?=
 =?us-ascii?Q?biYeIkD/iwxxnyTdHF60uey9abGcy9QDX65Yg1il/VpTG/+IG/owrvw+XYbe?=
 =?us-ascii?Q?WOt6ZkfcAU4jUorAeZRn42Ucsre6al3nBdxktIB+56AKIlrG0GWt8am+RuX/?=
 =?us-ascii?Q?e6Lc3QGlvy+Ca+0vYWHN1qVJJxMeA30b6JYKbAfmePKkZzXzejw5LtiFqBBl?=
 =?us-ascii?Q?czcUka1Ga/PwKvPOTnpnnX2jve8nXyqA+Vvpr32Icj0OISolXiob/8FqlC1p?=
 =?us-ascii?Q?UYOkSKQ8CsJHZ2dxwoRPQxdPn58kHUBi7G3wUNBXw8AGl+XGGqvjp6QS/02M?=
 =?us-ascii?Q?JX1KpDzHb7RRKSZGQg7kDNA1NbeabZjc9kl79aJ4u9gd1Urh8KmxjdxV5MU5?=
 =?us-ascii?Q?M48LWmXE7qLJZAAIGEW0BnmVp5GVzxOTQYPI1/SfhrNoYXy+h6CIc3hpoN55?=
 =?us-ascii?Q?Hs2viBeFHvIQWjKySBYC9yyy4LBaOcHd1JogY6QCAE4yjDWR0CSN50IRgIbT?=
 =?us-ascii?Q?WDuAb5nkYkQhuHZhgrYqWG+dm8Qw0DtSrGGKRRkMqV8dsddSfMDd8tbLMu8Y?=
 =?us-ascii?Q?pfVWoG9qfiRMzf2hx9pptBBBMlBUOi2IC8EvpoSB0g9H231QwG93vuvIka2L?=
 =?us-ascii?Q?rlejEtaBfQlPZPCnAzawarr6whOlyO9Oe4Cc9SKTAk3rbPTyDOCe8rgbrWvA?=
 =?us-ascii?Q?INCt6TzcWz0vu6KqtfP36BJDdqN84hfmaC3fACeEFGkgy+kmdWNCg0Vmen9+?=
 =?us-ascii?Q?mgGGQwkz1cv/Lqw3go4UZNzH667gNGjjr3hrACjhMGple8bmVUJLnn8rMsp5?=
 =?us-ascii?Q?cETKei2s4YCkjzymqgOuGznBWeaxsZLhpa0K4Tp/9st/5EkNQ4TVo8te8hD2?=
 =?us-ascii?Q?qfSRdMKVmghGisI9eahEziBWQuc5/5wk1yhq3LrgadO/xsQwYowsi4CZmlDH?=
 =?us-ascii?Q?OAGCevQ/7ADOT2GJT7xwpqPSMbvJMrB0hevS6yPNRCaKtlGfX7KbF8Zzz7P4?=
 =?us-ascii?Q?tGdqsSVDlCUX8UuOtTGRv+gvY/YwLu/SXIMM195vWoaVFB9qlcHJhGFVy6wv?=
 =?us-ascii?Q?wj4F8qFcFTHcWiumjN+/o8IWktpS/AoCmjEhFyF+BXLdjOX8Hdy2sQdzcxHS?=
 =?us-ascii?Q?uk+yDCqbIJKyR7YyKBps48faCL7Ino1cndHk8rY6XJxMyGvMU3YO/TxD1xTe?=
 =?us-ascii?Q?6wVqRzPKHERxZe4hFrICM2zQaZpQE0xb2arFDM0H2hMR2nZX5anuZUMWYHq1?=
 =?us-ascii?Q?w3+WunD+Lj0yp8nmBQOOipnJ8ux6dlerHbNLwptppR2qVqVPtP9KaM0V1Lfr?=
 =?us-ascii?Q?qTgov+A6vLzpyvFR+WNI3jOSOaWp1z2MuKgrt2XKpoBTO1XcOjyv1k8SE4d4?=
 =?us-ascii?Q?+bvnY3xnaGJITcLStSg933QMNOREHRpG1HAZJnIlvvIH2g4VVQfgL7bgRj8c?=
 =?us-ascii?Q?HirDKUWIYTxa87UUx4Fu3+XVUiqAMgQ017VuhuAmRsg9AlrtmpPj4gI/i9qa?=
 =?us-ascii?Q?PcOzWN+8DRUrUOTiGuXIChgyXIw4QT+ykcQ9nHq1rFKVH2R+maLt7gR61bbe?=
 =?us-ascii?Q?5Mm2xQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919974f7-6e2d-4b25-2856-08db56eac903
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:24:19.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4s8gHD452RgBtK+uG0h3ov0SgwzNTlv/Jl4HCdgaqHR2dUpxCbotG6cztrnHPFHyVF7vS12icMNnFGjvMTdCgAaR5AFgbN8NVT0vBBqSv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6406
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 17, 2023 at 05:18:24PM +0800, Deren Wu wrote:
> txs may be dropped if the frame is aggregated in AMSDU. When the problem
> shows up, some SKBs would be hold in driver to cause network stopped
> temporarily. Even if the problem can be recovered by txs timeout handling,
> mt7921 still need to disable txs in AMSDU to avoid this issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
> v2: * update operation for booleans, not bitfields (suggested by Simon Horman)
>     * rectify fixes tag for downstream backport

Thanks, LGTM.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
