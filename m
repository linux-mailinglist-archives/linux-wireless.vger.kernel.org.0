Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0F57050D7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjEPOdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjEPOdW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 10:33:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D121727;
        Tue, 16 May 2023 07:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSa1Jyh3A9GTGWxtq4CWei0UI1cSg0gNbjqdHHncMieqzTGnSzkBAYpHwr1TMa/H52GSyrSyrtrd05nwoiuhW990B+LYiEWP58FW2d0yaQ9nVhDmHQBPIwnrG51QUZ89Iu7w3q0nb7LtjOxAP8zC/Q6RbByaR/t4t3xDu79AurfaifU47jzRuEETjnukEgTO4iAl6Z301GwtHpi7OWCniDG7V3PEyLBlcrERVpCE4v8VWKztJxHYOeA+nuzQ3RTZ1yOqyDHsHp3gF1lyMZxxUHQqnB01f/d4BYzl3t6y9fwwBKYLRl9VzpW+T1jax3MmyMJ9gpdDkey7E2TSkVvVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhMm3St/RYCSo+E+uVNGcI1arHajf5p9rdBVHxKvYbk=;
 b=GwlzZ1k3Ye3fJzxD2rP2Xx9I7Bfku/vi1POBGv5GwxF0Mg9rvh+BUVlt0TVVxxknUCEWFHRaCGOI4jodQfd8Bz2+/+SvxIKQInlAZZeB9Xb7izIfPI7GxqVlEVQMamKw9fWDJoepG5ItyFpGwk8qSus/OWJi8fPFaGlcsRFBULvH0+ifHrYIym0eTEsaiMkKWEcXKJc5TY4aHNKojFctUMFFvkF+JVd+OaHDbjAscFYzy7I88S4oHg6a9kTJLzs7Lya+V6/0t/SxB6uxe7r0oh15AWz4Ckvz7UaUXVuIjRcCTpH6oGk4PuyPJVFNuXE3rBtDvKBQ5HRO2rZNAQEAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhMm3St/RYCSo+E+uVNGcI1arHajf5p9rdBVHxKvYbk=;
 b=J5lIj/i/DmkBzsywzlfeXUMbwc9bDjKg+P/HYqhpTRkowAe8rv5CxorkUoHNaUoCbsp9eP63Y1RJXfjQIaRx7AyEEdvH43Etkxu89jQzIANC70n5JAfqiJA8xkCs2L85+gaIiCGktq+ytTGqB4XieiPgVn47J4opirJ0AuAoj78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB4632.namprd13.prod.outlook.com (2603:10b6:408:116::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 14:33:16 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 14:33:16 +0000
Date:   Tue, 16 May 2023 16:33:08 +0200
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
Subject: Re: [PATCH] wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU
Message-ID: <ZGOUJJgXiZLvJ03N@corigine.com>
References: <b45ef06de62ce4f02d35ecef26ba78c7a7e75b51.1684153148.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45ef06de62ce4f02d35ecef26ba78c7a7e75b51.1684153148.git.deren.wu@mediatek.com>
X-ClientProxiedBy: AS4P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5866a266-cc88-4236-58bb-08db561a7c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgPu7IFEJTjTkEyv11thsDLTWLPrbHeuwmvW6TRYFL0wjPNczzYjzSLK7M/j03s6XPiQiwod7FOAwp5+2ehSAjPtNyx/fe0JHkg78w3bbSh+rLwj3ySxHoFqF9X6frvfxE9749/GB0LCbZSvmwJILZaa8M8mlSUi/ZQqksHD2AZ3ooU2sjVKvU+eaD6SyctEXtKzfHRj2I+PufpZmEo44WfN2VY/COEmT9NpwPBLy/JWz5g1Zx5YaMmYcpUs6fK2iA9uk+L4nVlQ2tyVEa2kFvRW2qvHaWo5kGwWjorAak/TQtAkmDs7PRbM+gWd10GildpPgXyrsqm1pDgjThLkd92/GU4TNW5tV9KRUWjanNjgRv+jHY5ucE0lD9++GRav4uVbFOgOGmFR6lgVdNiCki7uTr30D2YLZp9fsCXOGvsSItKj6S5BwercrB++GDP1+tSgBADr3ZZiQwJpbx/tx+b+9vmr52kIQ2kP0tuNeHObpetQNckmaeDAumLKoGxDLAoDn5ob16aMJCU2Xj5vx9JLklP8wMzdKscoD9e4A5I1TfpdhBRpi5B3eF+QQaaas+cE2o2bjf51qqwrJ+7o/ily999JCzjpua2REAyvbMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39840400004)(136003)(396003)(376002)(451199021)(36756003)(86362001)(54906003)(316002)(66556008)(66476007)(6916009)(4326008)(66946007)(478600001)(6666004)(5660300002)(8676002)(7416002)(8936002)(2906002)(44832011)(41300700001)(38100700002)(186003)(2616005)(6512007)(6506007)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y0g+bIKU47Fu04atQIKduw18hJ5l2K0BLlpswQKAE5CVQZU3G7s2y2KineOR?=
 =?us-ascii?Q?ZtDQDaQB2pgqbGWjKIILQZiR0UHr7SzfzBQCtqXlzuGApr/MflcRiBliGxHT?=
 =?us-ascii?Q?fYmiHgy4ss9aHT/rcRGk6lANVm0ptwasA31QvBraVD3R37DiH33dPe0b0bxf?=
 =?us-ascii?Q?SE1VkAe6RYbZ2AG/roKFMU3e+8OtK803ng/w6icNYA9Z0FbAO9p/whN3GYxi?=
 =?us-ascii?Q?StkgokxmfGt1+c9ZxpEHpPtlILDzvaxzGaLR1BiouupBrhbyV+GsrxKOQ2zP?=
 =?us-ascii?Q?WTl3QhF5bWR7oZjOE4ARLyOrWwLPkRW95s7UXWttYxFCoM1GPmLApMsex80x?=
 =?us-ascii?Q?Q8W+v23ozGpdAsIBxj2ETP0FYC7D73DhQ+fHKBbINFswRHX7oOhzMQLbfKWb?=
 =?us-ascii?Q?I5WRiJLD15h9nGUe6PLmnhOiWVeZ+p/wXl7EdWD9OCeznh6dr9M2vzE+B2t4?=
 =?us-ascii?Q?s+6RnkZg8WBUt2Cq6BjP6WXWADM8f24MSWBLBPdUxCzhgI0VARQOQra/I3HR?=
 =?us-ascii?Q?ZAimh0ZBIndgLcllJp93QAdRnBwTd/u0sjAF0pzv11HRChkIlnZ8SEdSTLEO?=
 =?us-ascii?Q?s6pz2GpgWNlFk4UW6U4N4Z3hc2GPTLHh0JSzNhQtggS34yig433Z1SPbSrDG?=
 =?us-ascii?Q?ERdhajUL5QHuvMULyKhNW7Ij8vDrjRe6/94aKge080lOZx9K0tla3WLTVz23?=
 =?us-ascii?Q?zmMzJujfZGHgvPa2/OodCZfwzGm3avPfPR7pgAtQaLKlUvlT53FF07B9MtAN?=
 =?us-ascii?Q?9kxFg2qEHWp4Wv3xXkJHsmt4Bh4BaFVkNZz2NdIWRaePJAgsEaZuUQHqByPL?=
 =?us-ascii?Q?lCJtP/rp1UyqFddy0cBOYPAVHZOMQIHH8VUQ8rexWNNIUArGoqUbSBCLjSWV?=
 =?us-ascii?Q?RWPAdYB+RBL8EuDK5bKvtwxCG3AM32jYm6DjTgmm2U2BocX8XT5dNGsMPo3W?=
 =?us-ascii?Q?jFkvVw6GzkfQzL8NToAMk/LCwM6ahA56y05GHzTaNQyIVBDC7db7f4/gh8xv?=
 =?us-ascii?Q?pLM7T5ZRoUjtBpt9It6l0BXGIRsmrROQ7GHbpEw9z7/K814c2rMpw+QkWe16?=
 =?us-ascii?Q?LMKLYjOCm6YuTFFN4HKdjWtr+iPRIfg3G4a376GK79Axr3Kaas+UW/c6QdPw?=
 =?us-ascii?Q?DFQ09ZTQ2lv0JZN9PwMnkmR46dn1FMf7mxdCI++q7ZHGzWIit+pqzVH1UNQC?=
 =?us-ascii?Q?2Ma6GuL/QPbUIR9MQ0S1qJL4wagpDnuovfGUGtu+TDccprSf9tMIRxHD6QK9?=
 =?us-ascii?Q?++lMwGMSz+1DKxjdk/XhRSGz2SPlUiCfkCZWX+U0u5If9qCaajaUoXrXue4z?=
 =?us-ascii?Q?qbFYC/DuhPgQfWlcV+Rfhdix63p9TZBn+R6J1VgygkI93W+9m8Q+zmFC6Plw?=
 =?us-ascii?Q?QCBYYCbp/UIGhTg6xsJ5E/G+IGLzXBJxsTysDHIKN9QeETFZABnifCIYOPcT?=
 =?us-ascii?Q?jJLT+QIti5UJLW+BCOXaAOHxUkaLvwXrQYJGa2el7tyALbWb8RF9yJZ/99i1?=
 =?us-ascii?Q?mZ7jC6Ji88PWW2eAQ3SOcGlOvZvRhbRMDAkBU15sD+KRamQTfn+vGnIT1Jue?=
 =?us-ascii?Q?Bty6YyoikoUL6RU5wJBbcWTlTGprrPRr/mYGasTMow/HKXjqg7gjuAai/SbE?=
 =?us-ascii?Q?xWA8HiJ85T7b1VXvHtAmVqepBPjv/0MtKMMhFeBIhWnZkWx30IiwslWssqPN?=
 =?us-ascii?Q?JRvTZA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5866a266-cc88-4236-58bb-08db561a7c9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:33:16.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D41peU9yKRMFYSDm7uIBWx8ZfOQrfKtEE3koveYW3dbJ6gqb2R7IN6zUfHR6qpS/vglbvKAMhX5G0saQTAbUWrObSGPwa9QR1cP4yrkj1R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4632
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 15, 2023 at 10:18:05PM +0800, Deren Wu wrote:
> txs may be dropped if the frame is aggregated in AMSDU. When the problem
> shows up, some SKBs would be hold in driver to cause network stopped
> temporarily. Even if the problem can be recovered by txs timeout handling,
> mt7921 still need to disable txs in AMSDU to avoid this issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 182071cdd594 ("mt76: connac: move connac2_mac_write_txwi in mt76_connac module")
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index ee0fbfcd07d6..56c42ee1178c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -495,6 +495,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
>  				    BSS_CHANGED_BEACON_ENABLED));
>  	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
>  					 BSS_CHANGED_FILS_DISCOVERY));
> +	bool amsdu_en = wcid->amsdu;
>  
>  	if (vif) {
>  		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
> @@ -554,12 +555,14 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
>  	txwi[4] = 0;
>  
>  	val = FIELD_PREP(MT_TXD5_PID, pid);
> -	if (pid >= MT_PACKET_ID_FIRST)
> +	if (pid >= MT_PACKET_ID_FIRST) {
>  		val |= MT_TXD5_TX_STATUS_HOST;
> +		amsdu_en &= !is_mt7921(dev);

These are booleans not bitfields,
so perhaps something like this is more appropriate?

		amsdu_en = amsdu_en && !is_mt7921(dev);

> +	}
>  
>  	txwi[5] = cpu_to_le32(val);
>  	txwi[6] = 0;
> -	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
> +	txwi[7] = amsdu_en ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
>  
>  	if (is_8023)
>  		mt76_connac2_mac_write_txwi_8023(txwi, skb, wcid);
> -- 
> 2.18.0
> 
