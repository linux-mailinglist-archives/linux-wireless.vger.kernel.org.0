Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E078296B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjHUMrw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjHUMrv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 08:47:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859BCD;
        Mon, 21 Aug 2023 05:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUmLK/nmIMWHYgvdCuAf//JphfntRaXlUEjVbnjbHt/PUruU8tFzJhjoGbf2dsqtDCyueD47QuO7dq+obzHSmFeUdCwxDNfC81lSrQ5umnO+ahr73MdgancaVvxym4vsLDzIUk1dCy3gmBDub25NPcAAQxWnCb5U1yWqRFHNc38LHcyW7dRXOqIkli45lCWgLrsyoYLen1BC5qp1x990d740tAuakyxOVZpfff6lCuKKuBXwIZOIKXNMgoSksx5I9uVV8YFqU6dWYaDuXEavasPA5jo8nCSlwFjQBVcyq5D3DNzRiBSKiMMVxpkyjStVzsUp4HG3R2dbLQUZ/uIjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5GsFyI5GJmuujrW0DUtJ8taZ70zjMgaQ0pdfSIUmQI=;
 b=MSmZsTn0suSrDgkHKmD4Nn3Vo+YNcMXsbx3uVMAOOc/dZc33r01kJO/m5WL3T1sl/ZmOjuPYoB2g6ymrhpxXlOUcn/PX5m5YfytBRCQX5ht9MKbUsZ/EyjEMikEX5QLQl516QTjefaVUbHPYmjfJtyI7gRqpTmjKqtiSvD/zV6LHIDxT+3NKxAQ28dKtgpY5270pbo9YsZMJmTJza6oHAnTZg0ZlT3DVm0DcNsH6vA23vmQ0haptQUbuozhn4xngHNmkL3hI2P4RybmtzarXKI997d3894g/zBb+sXF7lltQUuxFJbACy33FiworplFpApIa2Nt3tUQ2XbP6p6IhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5GsFyI5GJmuujrW0DUtJ8taZ70zjMgaQ0pdfSIUmQI=;
 b=dKCEZ9XMExO+U64YpfZ899mI38wOmX1KZg5I0QsUt9dDR2XIz6fljoqIozNO88agt9bmrgdbuDiCM+jYlZyawimAu6zchOlUT1v3fX5uG6gnGBLXe6tfqJzJR0cj6q/jP8j6ZPGYMd24lT1Md1yO7M6Aei5iPG3NGTgYQx2MgOX2WddCi2juZ3GJpWBACTpeJDPZWRe3NPgeBs8/wXIYiKfS7S8cDMUZ3gqpkeZe81QXX9U8i4ALow4uQut7mFgdLDyL8bPyH6wOzZ0m9BSOxfAnrhL71iEOliogbmGbdeZFHZZVnt85RlMNFk29c4Sgvu5BoOmcU7A9BfOv6MxnwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:47:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 12:47:47 +0000
Date:   Mon, 21 Aug 2023 09:47:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Andy Gross <agross@kernel.org>,
        David Airlie <airlied@gmail.com>, alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Frank Rowand <frowand.list@gmail.com>, iommu@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Sean Paul <sean@poorly.run>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] iommu: Remove the device_lock_assert() from
 __iommu_probe_device()
Message-ID: <ZONc8myQKuBceAMf@nvidia.com>
References: <0-v1-98d20e768c66+7-of_dma_lock_jgg@nvidia.com>
 <78114fd6-9b83-92ba-418f-6cc7bda9df9b@arm.com>
 <ZONYQyMSG17YMc_b@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZONYQyMSG17YMc_b@8bytes.org>
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: b5aa5770-4f00-429f-1466-08dba244d248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGF8zel1taRlADL03+zpPzjaQXOoChnNhkSfrWMPOxDtKVuRhd1RtIocUOvCPW0Gnki0Zd+tURdQvBZVGt0wNmYeANR0Dl9BsHNm0MuklqaYI7UgyWMrVuXVahDUyb/dLkHEaB3JY05fqnvntop1/MZezqfTCTXwDBn5pfHgb/BZiC0OxI52/LO1g/1m5IpHsXr+ozrH1ZVwOtApgVV7z9w/cxNhKGNjGqYU8WdcpCDOwyDLvSsvCP16l3faRlGWF2iUjE7Xy3UDkc51q7QxjszqJ/zqZ+jaQmUUWubEi4hsOzVENB/7vLRgoZdiy10wrRt+AaXjN0/6xnXCVqO/E3+3qU6wPfSNOBT2ivoJzNQaCQC6WPPdQZC8/TdfzhHpe4+eNrs4+AjZ5JAe/DPJny1rmxB4d3pM8J43srXWKTRrTTgqVf8Yn0VPzs+pMw4Nc4yfG8lD1ITlWbP36BLClxuMqJr8eKCDPJhcMFMWE1RJjM6Y3TSqMyu6qWKmeUbVEkozxUYwUOdCvg/us5AuGhGh23Hk7tCZbvTAiqOJcTrGhyArKozypA2/lbXvgSm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(7416002)(7366002)(7406005)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(6916009)(66556008)(66476007)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8ahnWSFdLqj3/2FrxKcJRUBtTV+iTAW5m9zZr18g1KUns9xgwW1e1A5VRVT?=
 =?us-ascii?Q?x5fUDGPYJGgEIfOsaVqqIr86tfLoBzzZqzGASpypPIiRzafvbnD/FEdeOeTe?=
 =?us-ascii?Q?JF+GMm9rz2elCO8lJ59TRStXeS9IPTlbGX7xVj/XfgIevhoTSYNHsM/+jUKx?=
 =?us-ascii?Q?eIVkGRnQEf4QmqbqomeTDhQswcTCM+BLyAh8NmV5E0WLQYHR7djpdesjHkAU?=
 =?us-ascii?Q?WaTNsUIM5nHZFwrF6uTBwkSHCSBRbcYmggFh7rstw6KXfpiK49VB8lNlr3TZ?=
 =?us-ascii?Q?dLUFd1SmmCDmLaGiWmwCwD2p+J43Jilg8OdczFx9q/KudByJa2Gut+6MnctP?=
 =?us-ascii?Q?T2H9epO9edOn7s9/zltqsVuT1JsxnZK24Om7nbPeHnPxdrEzWumPai/BkO/f?=
 =?us-ascii?Q?eMtjhcUs9XPznRIjl2AJzDGxm19sih5EZQ5JCmCUtoSiqaZIp5CLo7cnaUWV?=
 =?us-ascii?Q?s++B2KVmww2Bv5MOYVBg8UyajVfwEbx0/b/QZ3vwJeudZQ/fS5y1Wmov+wmN?=
 =?us-ascii?Q?9q0aABLaRFeSmeEBmR0l+KltrJOsZ/cdum8d8BOm2dOX5TZhhyqdL1lQEuRx?=
 =?us-ascii?Q?POAv1guAfwEOV+gWe4wR7MjeApPEnqKohodtHAPuzkTWm1mQXnIpvgXtNsPA?=
 =?us-ascii?Q?t2wAz9HxRbAbyXXao2GcoeNgVJK+xVvjhjity/mdyNC117ZWrSMBYaEGyePb?=
 =?us-ascii?Q?sPIybVXSTlT9iDelE07U85c7KrkOvgliv2kM77fj1hg8k3DMCVQyKmnzY/yo?=
 =?us-ascii?Q?yv8pQMoRzdU4wemAZ0i4Aw4Lrszr8aoWOMY0hG/Xf1wr5OXDITzXOmKmoWOZ?=
 =?us-ascii?Q?Od0/Y81XTXYJ7cSKedn6sUbTGz8VfX4UMNG8tlSkqgcKBkNdXbRI9rFn1g0j?=
 =?us-ascii?Q?jXx8gSpWXqNGIcvfA6SSnN7G7NOGevMxF3WD45wvzZXieW6p1y2NUCWaDixM?=
 =?us-ascii?Q?48IhP2fpqvDRUx79zZrBFchLf58wZzqZ8dm2qMdrLJczD/0RRhgs1VVvULhM?=
 =?us-ascii?Q?TUBI3CdojgxxLLfoxAyYr+ZACZtlNRRcZV/bGUdEQaTjEmmhtf4nLGhrhjEY?=
 =?us-ascii?Q?K9uue4dEJH7k5CDiSdOAFkidpTi6uRLfvdO+cTYfEf9m1IOxmPvaL993uVlb?=
 =?us-ascii?Q?QMueK6OzFgvxV2rNJe5Dsee1lXWVXMcf6/YR8wQTio+3KtAOKz7MKR0UZYXp?=
 =?us-ascii?Q?2cvrb3KJflAzdxivD470bJZg+X7UFoJttkoy5fI2SHTlovYc3uAE2skmZZ3v?=
 =?us-ascii?Q?xi4yKDuKYej1mgiS+tac97uvgpRFL6CBWcT7DYkJ9URRLiA/GZAYLB1h4BzO?=
 =?us-ascii?Q?KfBYpzgGUUSBoEDw7r6GnLnZHq1ntP8DKmEYYei3xNk120DtHRRfEqR9RsQq?=
 =?us-ascii?Q?PZIbhgG5+6m5utQBP87o6Cxdj7haMxTJ+xcdaL2C9AB4JgEAGNI6m2AveaUX?=
 =?us-ascii?Q?dKwXWOH7HG2HWgS9sIdHTgBpbH38Lh9ud21yvoyFv9jedabbDJBdHU9Ibtmp?=
 =?us-ascii?Q?bO6MPmfKFv3pnh68MlcT95ORcuJp4nhCWlDGFQL/jDmQeLdR/sVKxHq6xDP1?=
 =?us-ascii?Q?PwzaOa8VVCG2HmRQOwKw1ROZY93Duo6WOvWAtJw7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aa5770-4f00-429f-1466-08dba244d248
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:47:47.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9LDXsRLWNFEJxLIhFjHq/MXAkLThR3n/3J7GHPZ13/ftt9AIhg4pymIazkmRRfo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 21, 2023 at 02:27:47PM +0200, Joerg Roedel wrote:
> On Mon, Aug 21, 2023 at 12:06:40PM +0100, Robin Murphy wrote:
> > The solution is to drop those locking patches entirely and rethink the whole
> > thing.
> 
> Agreed, that was exactly what I thought when looking at this patch.
> 
> I dropped the original 10 patches and the 4 fixes on-top from the IOMMU
> tree. This needs more investigation and adaption of the actual API users
> before it can be reconsidered.

Why did you drop the whole series? The group changes are fine

Jason
