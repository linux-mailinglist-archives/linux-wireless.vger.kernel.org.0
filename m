Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30270E06A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjEWP0y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjEWP0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 11:26:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2111.outbound.protection.outlook.com [40.107.212.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C88518B
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 08:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je4o+53B6FIOb4W62Z9UYdceRsupJvC20DAzNukOSyyg9/SNsGSha/CESXnpZ8wvrQ+/i7YmYqVFONQh+4VsJ2uI0YpXIA2DmBEhgJBOGTHOePzqAvluISr9ogQWVPlVLN8bZsk/n6wHgbAertB920HEQ3elEBctWiQaHXv9nql/lQsMxHBjRLKSaiZ/mVlQhzM+LAah5KDdHLyIP7tQgnfV6y28KVxzuFACPFAlIDo5+Ns8bnHWh7POSWZjJMdhA4TnHZWYqXrT7YH6Ii7fPcOvTXhJzCnBSnOK8CR0X6h/YAGvzayInmghOR5+cy7jdhmkqTmgW8BgyVJgnTcPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfL0s8BIHdrnDy6gEulL6FT22jvGg9exgqWotpjfpB0=;
 b=dveAyzQlyIOv7kft+EHiIOWLaRWSqhHmC07KNxikvj4wIhoQGQ6jKAMCI6J/w2clxf/4DQxbBYZjBwnKCxGaXa2UlFybd9TDnEn7DNnLO8PvR7SZejQ12tdlFDVeTKXouVmjDZNEl5Cq7MnM9ua0NTR19Bcz7RCW4FP9u14Uh7iMwi+gJpPYqPeMyfD2y/ngksJUk/l9IEB7rVLHqpYMYOM+u/+R9wF1xMHkCcWujyGy77J/eveOpRgQvvgRNCkj/Nm34EPbUX4sv9UrkQ8Y2gZuLNVht4voCt6z11l2lfh2fI1NC3C0KxqnA3Pafuiov/MnRjZW2Q3e4kghWmwv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfL0s8BIHdrnDy6gEulL6FT22jvGg9exgqWotpjfpB0=;
 b=jesjGlGE8cjKoYIKqsJrR3O3qVSWngJ0FuTEiG/4esvbYSsiZXzhesGomTN7qTredmtpWmiApKBH9IyzEpu7Cd17nlhqr155iclfa/hDVFgLTHhAS8+5ArpYfc8+fwrhlP+RJiHsMI3DxUcGuz/VBz5m72J87+GlWnOH+lv6zA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6506.namprd13.prod.outlook.com (2603:10b6:610:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 15:26:25 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 15:26:24 +0000
Date:   Tue, 23 May 2023 17:26:18 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: iwlwifi: add ethtool tx and rx stats.
Message-ID: <ZGzbGmaJld0eA1BF@corigine.com>
References: <20230522233743.3058844-1-greearb@candelatech.com>
 <ZGyWQpFs9DDAlsx6@corigine.com>
 <adf58b64-f1dc-82a0-ae37-4dbe8b53f3bc@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf58b64-f1dc-82a0-ae37-4dbe8b53f3bc@candelatech.com>
X-ClientProxiedBy: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 33703ea8-4125-4963-6dad-08db5ba21197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZPOqIikqd/sIFATwIf0Q3w/b928agQPWW3Lg3iYKdPxfPcLL0V6SjIKr606df5ah6lgfiJCdKUoos8fLzcu73kkEv1rBUvkOe8jFqIIZO07Q8ABQ/Ir59ubmaTiIkCiuPRPQahuUTx/yOI1O448AyD/PNrCOJs9c5roCvvJ2zVhN7k02w+3inMWOougTrAkuwItsAa61HTGTz6JI2Hg+QMpwOnXi4UxifCFD83ewgiqsDPe3nnpchxjHgnRAwhIUeo4p9Lg8v5dYaWCD3JwikL9+QQ40iT3d09pdQ7L4TuYWL5nmJIAbc6rpqOKbCEGwBL0bepygLFCC7IITbScVPB7TVzBG6r79rNTv+xfjZX8TRGFj82SVxzt9FhPq4zRwJYEXdKs5kJtWgf5McjvOEAn8VhnlBt32TQdaEB4GPf/RiCSsxSgk57UcIveDm4+nZ4+S78Sdtzrh+FlvO+wxxrNEvV0+1CfgS1vbxx2J5SO0+WZMnariGL0awkrZ1e+QoCxKATRisOQLZt66e2Q9Mmj1ROnCpA8S/YyCFW48GNLxKY1TsXrD9eK5IR+Um1QV9yuK8jdBYkaje/E9uER/x+6jbfboATqQq5A4UsrW4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(451199021)(8676002)(478600001)(186003)(6506007)(6512007)(8936002)(41300700001)(5660300002)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(36756003)(44832011)(53546011)(6486002)(6666004)(38100700002)(2906002)(2616005)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+iNFj/ymn/Wh3vRbu4R7F8a4ds1tWi1BPr0JiqxIqXFccBm+5pSr1dK+7Av?=
 =?us-ascii?Q?WNkRj/RsGMtSsxVmGrr19aOxTMM95xOb9z2lNg3a9nNT0ncvzY/CLyey/NhA?=
 =?us-ascii?Q?BBdw5CbtGGiogATdNVbVOXs/+pCj3nGkhb7c2X+s/qwEo3prRstqYrj8WjMZ?=
 =?us-ascii?Q?IJMmxapEI48SatCkcz60bUMxPrctkh4EhNBYh989zzlD4yspUxRUHAxjnoUY?=
 =?us-ascii?Q?gB/M6ShWhVygHU5Weyuj60W+8rJ5OKFP+mTzf6oi8INA7Qxj5lpPY3CD/bTr?=
 =?us-ascii?Q?2QyRSlk5gYregMyRzxZqvpgyHbQK47LO/kFll4C48j0ldIiq+Hi/3oSBPCwn?=
 =?us-ascii?Q?Z3FET8uhO/jwo8dU8FXzbW5JTx4PRvZuhFsCCRwYPRsPWI1rPFUXjoMgTlX6?=
 =?us-ascii?Q?u+OG/hCYmS95V7dvLFYV3Xu6tjbqKpx6R4isNw58cesBbvf1rSGqQlHjio5+?=
 =?us-ascii?Q?5Mm+Kw61WVp+bk5Ar1OvlDpyRU3Nh/NVYMvW+ZO3m25bU+WhV8dglEAt5KJW?=
 =?us-ascii?Q?epme89n2NBBTMpYfC5p2FKrpUqZ21WEK5mTJlkI5p9/CTzl0QK3KyKW9mfig?=
 =?us-ascii?Q?eEl3TkcoFHtDfWhGNb2TJcPV31RZmmPsaSj6D5pdd7kk7NSCocVlG9Hem9nD?=
 =?us-ascii?Q?o8XAyhW2sP/AaaQfW1zDFuCA6dxuLHvc+TFRH7mNNunlaf0V0Kz2rorVjALh?=
 =?us-ascii?Q?RKC4yiqGQb7yaB7vSAWOc3KJVwX9ssqH2R+tWM8MIB47R+hUu8abE2dAvqOM?=
 =?us-ascii?Q?r4j+T+gI2DVh3byHsVSqWL/W9TE7yyX47ZH+jeBsAiEqAJtVI8s8ueb5ZIGr?=
 =?us-ascii?Q?uAjH3m3qk3DhRJLJ9u87ISHEPR2cOc/twsYy8HHQQANJOFQcEY4TvHKtIodA?=
 =?us-ascii?Q?8h8zN3k4Bphi61c+0w0RWnaloqZYTYIT/zhMRgjNhoxgbQD3qPv5s417PRM7?=
 =?us-ascii?Q?SOvCEVcRk0DK0siTXTHDPbrrpTzBYpHKri8j5X1c6HRdgEIAI3fE/sFQHlT5?=
 =?us-ascii?Q?vePSEoV1j25U5ysm7bBPDZur6vbiSajcoyoGFYif4AtfRFH78AVPjzCNRW9a?=
 =?us-ascii?Q?EvEC0WmscTWQxCcn0Z3mpwmcURIFkMgh1QUU2+eljCwn5lgj9vw0ukuWGtlm?=
 =?us-ascii?Q?+fpFh3Ouel92IG1wr3D3IxL6JTKx9Tkg/HXsYPl6EhOm6gC/rSWs1zG/wx7V?=
 =?us-ascii?Q?CeowSy23cTPe1Zvm5IRn30M2+olInpL8De48CtyNUjwB6xF2NoP6CYA9lnne?=
 =?us-ascii?Q?Mb6MsQL4x/QwxCC0w1aGchaKAMTNgZU06UTokw/czEU3FPKv5Fx/pi2Pq4D3?=
 =?us-ascii?Q?u1PhvI/APAVhD1PLjct0LdNewLhhqFlG9oWb9dmtZ2VDZPSBR5lAD50DQ9w4?=
 =?us-ascii?Q?lu09TBBhVGj3rjKaAS+2NfIQKFTs/e2itGlVOAcVi3shYL2Bg59RVpf0vQ2p?=
 =?us-ascii?Q?og9AY6EiCks1aDOxFHDH/juKel/ApIq5D38rLWWraozMU5laAq+rcM1VulxM?=
 =?us-ascii?Q?nggIIbKzAzkDowFukMvbkzUbhZqsvATyZqa0tCH8Y5e4KYcctjK5/6sT3WsC?=
 =?us-ascii?Q?idDpWnmtl/e32t+qy77Ww5E4X55X/qlx885/e5f2NRzP6fJPv/VZhu2/qeoa?=
 =?us-ascii?Q?vn3eAWcmhqWUtgTTSZkgq56r289IgD6ihaOXolcZXPjixctEfrDu7ysK3tzy?=
 =?us-ascii?Q?KuLFTg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33703ea8-4125-4963-6dad-08db5ba21197
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:26:24.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNdg5cnlAu/wS684y0bGBHRSFYK8MtP4isiUagjPPl/pp7vEVHDZpN0EtftpoIGtnOKZX304xv0dL1gAUbSIfz+fu76eUHcfYlU0kXAsJ+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6506
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 23, 2023 at 07:50:22AM -0700, Ben Greear wrote:
> On 5/23/23 3:32 AM, Simon Horman wrote:
> > On Mon, May 22, 2023 at 04:37:43PM -0700, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > > 
> > > Report tx/rx error codes, nss, mcs, bandwidth, mode, he types,
> > > tx ampdu length histogram.
> > > 
> > > To provide some clues about how transmit and receive path is
> > > actually working.
> > > 
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > > 
> > > v3:  Combine tx and rx ethtool patches into single patch.
> > > Fix some stats calculations, especially the path that consumes
> > > tx frames based on block-ack receipt.
> > > 
> > > Comparing the stats with expected values now matches better, but
> > > hard to verify everything exactly.
> > 
> > Hi Ben,
> > 
> > I am a little (lot) confused about what tree/branch this patch applies to.
> > 
> 
> It is against upstream iwlwifi-backports driver.  I need to use that to
> use latest Intel radio, and in general flow of patches seems to be
> iwlwif-backports -> kernel, so I was hoping the patch had a chance that
> way.  I'm sure it could also be patched into the kernel with a bit of
> work, and I'll be happy to do that work if that will make patch
> acceptable.

Thanks Ben,

got it.
