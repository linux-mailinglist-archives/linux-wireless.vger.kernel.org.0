Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6423A70C239
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjEVPWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVPWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 11:22:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B537C6
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 08:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWcrg7RPzvRrZbUwwsIS+irmmG1EPNDiE7yr5fwY5km5eDrW+rTRw+RaLQJ8IDdkh3rh6LdmsDh8r+9fIRE/0Nh0trI/xr6Efqn0EJs0ptT8I/7G8t7llQTKpFbcfTlwJ9ixFlDHHNB6SGoC5Wzts+mERy1O+h3qmAGDcjamb9oXLPDIuPIZJ42pg3vbmUzGW+MdSqcO0vy8jRu5WjVCjr5ZPwh2Ev0OjyflTzzQUfy/9dhEC2qp2u8kbWKFeANVHlL8DqB8cI+AvXQXLmoB8BWCM9919XgMqFXdo2Kj+4dYxwq3Vkhyx18Z+cA6aNea7JfYWWfqoPCJTbuCMSRqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW7VRvFk7z/ACjt8IGAkFf2+zSevAwzDhh1DZRIVhx4=;
 b=BDfR7WkImVLG8JgfMWGoncQl2vl5LIdMCAtQaERF7kEscnbI1lzves94l3yWYVsQzzUdESV01kAiZf/LQYMb+kxpF9AXynSbiUMI1/JPeWuY/eBYCuiD0Dn5IuvRoLi8oMWW0PGhCtkml348Vr12dqXpho6IKzWIW70+SEsufsXuYPIL3ZXyshSw7WVKHlNrm0z5IDKnzB7hXsZymbBtbZblmwxIPZ0kRiwst1XHaXsbxghow+khSazydT8v345rz8eZWfxYDQHEjJ7TdOuoqzM0dTc4gbv5dViPuPPfv0x3kSTuwNkDtGFihPZ+oap+77IU5r2IGVLVcxLyoAOJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW7VRvFk7z/ACjt8IGAkFf2+zSevAwzDhh1DZRIVhx4=;
 b=ZHhNhThhQK4DDjLTf/8d+Tk+FQ7EC2VOl8XykquPvOCIn6BlLT2yjo1g80iNKQVhpLKOAl3N/ceiGkOJm/sctYhiM9jMt40FCpbPT/QoIqKi45t9FCOyZIeuFznbItKKWkb0CtHFYUQs4Ifgv2mynVF8gSpOok2Marj9GgmUlJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB5118.namprd13.prod.outlook.com (2603:10b6:408:161::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:22:06 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:22:06 +0000
Date:   Mon, 22 May 2023 17:22:01 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7921:  Support temp sensor.
Message-ID: <ZGuImWxI9Hr8jj1/@corigine.com>
References: <20230519163611.1640585-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519163611.1640585-1-greearb@candelatech.com>
X-ClientProxiedBy: AM3PR07CA0066.eurprd07.prod.outlook.com
 (2603:10a6:207:4::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ced203-634d-43d8-6e7e-08db5ad84da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsFKtlXJRHUnhLCOrC9oZOpZfgxfytygP7HSXisr6oU3jU2yXDNB7uEvbD3wesSbDTYtRjFnczwh2NyuNg/hFJNwuyu2wwNj0OVVfQzgqZR7WjuPmpdMpi843PqKFt2TwQXfe8cT963dGiMLDntm2OYfa2m9Y7nu+urfg2gISUgFmRndYR1DuP7LrqLH8qqsszBwOBBM1ZalhjiKRlh59QU34qLqXO/tcw2Tua6OaGA/fzsatnbELz/V5Z7ARKV8xANxQel8AfsqX1mk0C74k/KtZ9rMpaey8WOWqGATRGd6hdR8UL9NC7lgRD/McMaVXFO6XInLKuuNSwaVLjo4e++qj+6QKOdSDuHnm3BlVpeM3gbvxFQa1389FeLO/5Qx9xMsxW3YMvG3GL0gc3fYKPC30O+LGsh6mEh2ydGfCk2dere30N6NCdvYvWzuv0aMkioSrB2E4sUsk2UVlUUyGWIxIEdyv1SrQcbdC0fUZNxTFs7/gAiKB/CjT2ZIaf516OlYHTR+aBnRFjtrM12XO+RSzyUqTPKTlAqlB2z/hea5CAR2JlXXCjo+uuqavkIsIMrpyfKpfx/eQFDuDQ8JuD2l7RB4T4Bk+pEjIhLu74o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39840400004)(366004)(136003)(451199021)(5660300002)(8676002)(8936002)(86362001)(6506007)(6512007)(2906002)(83380400001)(2616005)(36756003)(186003)(44832011)(6916009)(66556008)(66476007)(4326008)(66946007)(316002)(38100700002)(478600001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxKS3hob00xY0pRbm53T29XRTJlY2RIcGdZQ1h0OXRYUEw1NUpMN2N6MXhY?=
 =?utf-8?B?bDlQdTBrUThpQzM4NTdSaUtMQmowRUs5K240NVlUWTZIMnNqT0tUeGVrNmls?=
 =?utf-8?B?L3JWUWwrUTZxZWxaTWNEZHU4am9sa29RN0FnN0ZaRk9kVTd6OE1pV2w1VWcv?=
 =?utf-8?B?anFzWTJVaWl3a3c4Z25naG5yb3VxRXM3b3J2OStIUWMrdGJqRjBuUHpPQi83?=
 =?utf-8?B?LzR3RE1YWlJMMDI5eXE1WG8vK0Q1QXBKTm5qTDJXRjhUVXZuUDFTYTEvMDk2?=
 =?utf-8?B?SnVRcEM1UmZDejJwREpYcFBMR3FIMXU4K0tpK2xaTUI4WWdvSGlQTG1JT3Fa?=
 =?utf-8?B?aFhIZm8vMkJZb0U3T05tVjFQQXVxQjFsczVzRE9HSFNkQ1F2MWd1TmxMV3Rn?=
 =?utf-8?B?Q0dOMk5jSTl3QTR5N0VnRTBnRWMycnBra1RrNzJPVGxtbUEyaDBEL2hDcFVl?=
 =?utf-8?B?c3Y4VDJycjBCNDd2a2VrQnNZSmZIN3ZLNG02RTRsS3pxcXNDRWM4eFdobE9G?=
 =?utf-8?B?VDZmS1lkS1BJVEQ4RU9RakNnRjNYbjZhTHJBa0JtbktYZjdFVU53dU16bTNW?=
 =?utf-8?B?d0RYa0JjVnVrclZOcEIrelBmdlcwZTJTdVpxc1pERXBSckMyOEdMeitKeTRR?=
 =?utf-8?B?S2NDb0w0ZjU5eGRUVjFVSStWS1JUWkFWbmU0VlJVU2hGY2JnWXBFUmVJa3hZ?=
 =?utf-8?B?eWJNQ1g3SlAwRTNiR2xTQVpEZGpEdEQreWFwWVZNTTZ0Wk56a25CR1Jya2Vw?=
 =?utf-8?B?Z2tJRmN2MmJhZ0N4bWJWWTA5OTk0bmZKWW9PRXo2ZTd0MEdramRzM3psdU5u?=
 =?utf-8?B?cjJnQ2FyR2RSb09TblF4Z2FxMlZpRVluemk1Ny9iZ2pCd0VCSm4wNlFHSnpV?=
 =?utf-8?B?dnlXc0hTUC9mcXVGZU5QYzcxMEZUOUVTNWtFVmhDZ0RsY2xRYlkzZ2hreXRk?=
 =?utf-8?B?YUxlSzRrNHIrRjl6YVNBRFVPMFdHUHlqN0R5UGtraW1hTWhUcnZ4dXdVbjI3?=
 =?utf-8?B?NWRMcC92WkpZMUtHbk9pRzlrRy95dWNIK2Y1L3Z3Q3VZV3d4UGlCMmdyRWR6?=
 =?utf-8?B?ZUp1Q3Nma1RjTU14SzVzWFgxUllsOVphMDhNTUZsaVREejRBY2FrbjFGcHlx?=
 =?utf-8?B?S2ZIeTVBUkFqUks5bGJEUHRtcWtEdklkTW9DOEZXZEJPWnYzeVl2VXNnRmtZ?=
 =?utf-8?B?cTJ6TjFKYWJ1aU15OXdCekQwQnlLcnNaQWloeEp3cnV1bHRSMDJFQzNRc2lB?=
 =?utf-8?B?a3hUKy9hSHNuRVNlcFh0dHJYcVdDbHc2YzN2aEZQMFp6Y1B2dXM2TzJqM2xr?=
 =?utf-8?B?ODVJSDdjaDNKN0M3V24yeWIwcllFK1VuNjB6b21tK08vT3ZmK01xVDBrZjJw?=
 =?utf-8?B?Zk1XWnRtdWsrNUJGY2poRjB0ZmpNaGsrV1pEYmpVVm54dGlZUExLRS9tZUY1?=
 =?utf-8?B?dWFqNkZseWZSQk1GbWEzZXhIV2hyNEk2dzVVRTBmL2RNakhEa3BWOFJPTU5G?=
 =?utf-8?B?SnBJZnR0eUlMblRxM2lubmJvUWE0UEtSTi9xUEVhRmlqVFNMUWJrWFo2YUNj?=
 =?utf-8?B?THcrd3F6UHdoMmFpd29PM0J6ZmFpeVF6MGVRMVIxTSt0RW1HTUF5UWxzQVJS?=
 =?utf-8?B?RlUrVjlFSVNXY3h5R0VsaHkrQU1RbmxjcTdnSHFja1N4VkVjSGY0NWVlcUt3?=
 =?utf-8?B?MnFiQ2tXQ1E0ZFM5UUNzdmlJY04yYU5weXlYUjlVeWRGU2ozLzJOQVpTZjdL?=
 =?utf-8?B?THorb1hGem0rajB4MmI1aVBid1BHVmZSNVkvK0lhaEc1Z2ZQTTFrTkhiRXBL?=
 =?utf-8?B?OVdOaTRDUitYQVlFbXE4Znh2ZmJONHJiQzUrelpLNjhGYWJlY3h6OC93SS9R?=
 =?utf-8?B?cHREYjF1d29BVnFKaWVjZlZkSEVSQWlXUTlOeHQyTlcvVVRRd3Y4dEtSZ3Yw?=
 =?utf-8?B?VXFia3NXV0JhZ1FaUE92SlFGKzZlREhDVVVZdjdIaDRNa0VweU0veTVwZDBi?=
 =?utf-8?B?QzlkaEtobVhQWityYU10d1MxSkhwMkorNXdnVkdIOE9nL2FTZ0doaXVSTVRk?=
 =?utf-8?B?WjM0bTJKd3ArdDJMZWVDTThOZlBMYm5UQm1RZGNDeUlibE9CQ2I0b3RHbko3?=
 =?utf-8?B?c0piQ1dTNVZIZzB2cGNkcThYeG5pbDZkbENMY1hrZzdqVU05OGZnOFg3VTlL?=
 =?utf-8?B?VnFabnFuYWU2aC9Pa0JxaGhaS3djWDBnOEx5RGduZnRLNTNHd2FJREx4VWtk?=
 =?utf-8?B?cncvL3IrQWZrQjJuRHgvRDZHSzhnPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ced203-634d-43d8-6e7e-08db5ad84da6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:22:06.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFKllq6Jc/a8jYeDbCLnwunJ08GItYNxsFBgJ6XsKRnr/1rjXN9xcFdAoTSMzOgOVQ2LmzVzcHV/M6Ozyu7IKJjtCB00bFCxcR7ekRGvjDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5118
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 19, 2023 at 09:36:11AM -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Allow sensors tool to read radio's temperature, example:
> 
> mt7921_phy17-pci-1800
> Adapter: PCI adapter
> temp1:        +72.0°C
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>

Hi Ben,

me again.

...

> @@ -58,6 +61,53 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
>  	}
>  };
>  
> +static ssize_t mt7921_thermal_temp_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	switch (to_sensor_dev_attr(attr)->index) {
> +	case 0:
> +		struct mt7921_phy *phy = dev_get_drvdata(dev);
> +		struct mt7921_dev *mdev = phy->dev;
> +		int temperature;
> +
> +		mt7921_mutex_acquire(mdev);
> +		temperature = mt7921_mcu_get_temperature(phy);
> +		mt7921_mutex_release(mdev);
> +
> +		if (temperature < 0)
> +			return temperature;
> +		/* display in millidegree Celcius */

nit: s/Celcius/Celsius/
     Did I get that wrong last time?
     If so, sorry.

> +		return sprintf(buf, "%u\n", temperature * 1000);

clang-16 does not seem to like this:

drivers/net/wireless/mediatek/mt76/mt7921/init.c:63:3: error: expected expression
                struct mt7921_phy *phy = dev_get_drvdata(dev);
                ^
drivers/net/wireless/mediatek/mt76/mt7921/init.c:64:29: error: use of undeclared identifier 'phy'
                struct mt7921_dev *mdev = phy->dev;
                                          ^
drivers/net/wireless/mediatek/mt76/mt7921/init.c:68:44: error: use of undeclared identifier 'phy'
                temperature = mt7921_mcu_get_temperature(phy);
                                                         ^
drivers/net/wireless/mediatek/mt76/mt7921/init.c:64:22: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                struct mt7921_dev *mdev = phy->dev;
                                   ^
1 warning and 3 errors generated.


I think a fix is:

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index af9b1d5e520b..9655dbd5cfc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -59,7 +59,7 @@ static ssize_t mt7921_thermal_temp_show(struct device *dev,
 					char *buf)
 {
 	switch (to_sensor_dev_attr(attr)->index) {
-	case 0:
+	case 0: {
 		struct mt7921_phy *phy = dev_get_drvdata(dev);
 		struct mt7921_dev *mdev = phy->dev;
 		int temperature;
@@ -72,6 +72,7 @@ static ssize_t mt7921_thermal_temp_show(struct device *dev,
 			return temperature;
 		/* display in millidegree Celcius */
 		return sprintf(buf, "%u\n", temperature * 1000);
+	}
 	default:
 		return -EINVAL;
 	}

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7921_thermal_temp, 0);

...
