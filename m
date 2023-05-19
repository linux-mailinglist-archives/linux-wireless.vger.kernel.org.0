Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27D709961
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjESOT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 May 2023 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESOT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 May 2023 10:19:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2131.outbound.protection.outlook.com [40.107.92.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5311ED3
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 07:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6MxIe2KmvyFy/LUfub0BoLBSKxXVTWFnXGMAJqlf7g7KaJf964htnGjGpz3qV9J2TJRnYiqwcw9cMhyknNyj/8ricrzzIVOaWvul4Ve/OUpf+965wgkWK2YWvPFMKpnz4exj+FyvM/INz7cSZfgBwZgvSVogrDyYQf9k7RlHNSgR7lPKA+oUDfK0xhSf56NV9ZZ8Oj/nlDlAQ1xtbQD3+AxWepH/kwweihd9oTC7v7N4BGX1vPOwCBgIl/hOAb26+i9ELY45xk/EQusvDJstKXhiFwdIHk5BQSSWSLRxVLjShEqkY5wq0OQCo+052pd2INqWmOnU8kj6vueH1n0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+oPsDun6PntWdfZTqe6HVevZ4lCLAWqDNMzIT99LrE=;
 b=X3scia+tiFvf6VkUHvVXVll/oYRafdUPHYjt/2ukxdBhyc5c+iO4MEDnyq/5mby0tQ2DRSnV5pavxdxJwstVcn1gYnJ7CD4S/Jr9JF4ge6o6oQB+DDjL0/ja8lVIN3giPo2/KUu8g2K1bTpCCqJoXzqXhxf5ySSmEAZyfVi9G9i1DALlFbhPeQjlMgjlXo/lLat6qpyKf+Z0smoIaS4uODLhtiuVLmXzXJ1S0RTW7gaHSyC18S51Eju8D0O6u7ddOpYAF1BwLmz8DtFVYIFh1T2LLuhwKvKnvOX5HSpBa4DQtRnEKebFOOLk2eAOfenEfGFlRcRtuNFGUc2/FWa7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+oPsDun6PntWdfZTqe6HVevZ4lCLAWqDNMzIT99LrE=;
 b=qdrK0bSUD/GsAE0dGkaXeuTtAAV/2c6kZ/9jd4Z8Ej18A9se5X3XPstp4KwV0S7UOrh7TkO1/i5ZrYLMia3a7DuUGL51TROUbtQk8zIvQ4WKXCe2xIPialcWXrd1zCMXgxWkQqZP3yMJZ6mxwd6BXKuhxHkuBTjcCbkbbdlbGcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BLAPR13MB4739.namprd13.prod.outlook.com (2603:10b6:208:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 14:19:53 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 14:19:53 +0000
Date:   Fri, 19 May 2023 16:19:47 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921:  Support temp sensor.
Message-ID: <ZGeFgxR7OUkhPvTB@corigine.com>
References: <20230518200718.1367381-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518200718.1367381-1-greearb@candelatech.com>
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BLAPR13MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e845ee-dd18-4a2b-598f-08db58741ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLFYn88ui8A2Xe4ABbHIPSEE6ZwNdxfH5kq3oc09O5PBkjfioEyvGIgxl6zKn3THdFrfcg1eHfGbQ6N6vPiziSzL+cwA/+2NLTiHjJEMbsZZc+r26z27gvv5sfSGBB8SMpMcOXR+nZ/LYBMvWpMjFDz8UyApT/FQzv7DD+R4l7uJQ3r9jTce1OkpiYudU+RHdpuXELqBKEz+rCL38hGr6HANp6neGMk0G+kxQeLWjKsS3jmZLL4I+kK7WRe7wtgL79ttdRCf9NwylyS19QFlyrpqP09ZlPDJqxcQGA4gn28w14DquV1/+VzbXrc+bN03/u12Z1h/+ZH3XJiv2OiXdl0pGgt5aO5zKDtfEW1nX7juaptxajXZv9VT0F2oJ1bOmO2/+8TYDtIP388imf+2l1lf++PyMDcHDKx8c5qhJOO4LY06BPXi6xwAGxONPTQ65FDoRDVST13eHxoHL6xC2ZyTDJg59xgKxURQOzsM2uK0M4c1xSnu+HnRqIpgeFw3idJ384sYsj3blFG31OSbQP1+pQmLyTQOBBq8v2FpcNbwxD44wIrAUCP7wh3FBvOd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(451199021)(478600001)(316002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(4326008)(6916009)(2906002)(66476007)(66556008)(66946007)(36756003)(6486002)(6512007)(6666004)(186003)(6506007)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tSc3VnaDRJUlpqSXNHNnpkTU5hbWhINHRGUDFxMnNla2l2QjBxNWNwTThV?=
 =?utf-8?B?a1p0NmRZNHBVanZKOC9URjNBOVVzSzNhS2JJRndKREhlMGtOeWdXaXgwSmlP?=
 =?utf-8?B?b0ZtMmNCS2V6ZmJUWDZtU0tJZFhJa0ZUWGJQTk8xL05aTmU1MFpzZjVPWllk?=
 =?utf-8?B?dXcxOFFhclIyRWNrZnpseDd1UHRqSlNQeCs5eWdOY3NvMXNTUjV0YVhLRjhs?=
 =?utf-8?B?K3k5NzdIbGtYelFpOUVMT1BlSmZVSHdqZG1rV3hJMEV1a1I5a1RydENSaE0w?=
 =?utf-8?B?NFF1dHNaQXNoQ2doZjI2T1ZwbVBuR0lPV1pEdW1xWEkrMGNudGhKOU5OZ0FZ?=
 =?utf-8?B?REJSRk5vQ1lmMlg5WS8zd24zZTczTVMvWnhmNG4yRFRuWEU1M2s1RFhGVnNS?=
 =?utf-8?B?cXF0bnZaZDZVYUlZK0lqbGRpdWtqMXI3NTFuV3NZZlFTSVIycm1xTWJaNVk3?=
 =?utf-8?B?bW1rNkJuUzdwMFJFRjF3TjNudHo3M0dTWlhtOTR0TTlQc0N6S3hTNHBFWmtO?=
 =?utf-8?B?b0VYNlZVeGxWbld5cGpoRmVmVCs4MmhtQ0NsdkhJK2hDZ0JWc3VjTHhTdmg1?=
 =?utf-8?B?aHhSbWFXQjhLWWRpVUNqb05nS3VJRGh6cTZNcng4Rm5uWTJpMzJwSHdJeVAw?=
 =?utf-8?B?aWU1UGdINDU3b0swbVV0Qkt1OVozdnNaMDVjdTE1SnZ4cG16bmh4ZUFSOTlp?=
 =?utf-8?B?MkhGL1luMkZ6N1o2MHErMXJtcXZWdlZJcUtHVFhOWTJNQ3pZTFRUTWhsWWJw?=
 =?utf-8?B?dVBJVXFMTXJVc0ZMbXNjbks2RjZyNW4yQXhVUUo0eDQ4YVAvejVaYU93SWhk?=
 =?utf-8?B?a2NNYVJkUUpVKzQzL2RhMnhvWjdnREN2V090dlFYaEdSWjhIVm5ITk55cHky?=
 =?utf-8?B?UWpJTklvSDZoekJKbUdMVnhqV2t2QzVVWXZpZ21DL0tVTkZuSEpDRTl0cVlD?=
 =?utf-8?B?SGFWMERJYWFGMStWTjU0LzM0RGlIVENZaGdaR1NibmcrZHhXdk56NWU5WThz?=
 =?utf-8?B?UHU2MHg2LzBEc1ZVbHp6ZzJxcmQ0VVpaaWMzMjBqb2dVTHNIKytqb1VVS0JS?=
 =?utf-8?B?RGVVV0JxeENoVlFXWkp3dGx3L09YaGYwVDNjdGVtMDl2b2dROTluR2t2OUcy?=
 =?utf-8?B?L3NKcVEyR2ZuNlo1VkNVR2hEN0czYTZ0VmdTdG04QjBJT2dZV3JKakwrK2pv?=
 =?utf-8?B?dmVLcm9qZ3JJK25SOUJhdGZlVmtTb1dKNURRUE1QVXozMUVlNG1UQ0xxQzU4?=
 =?utf-8?B?SVJTT09lR29EWndmOEJEVkZnaDI3OXQ4UG9GVlNaOEI3dzBBVUdQTHRRTWg3?=
 =?utf-8?B?aEVtY1daWi9YRVFNS2JoZnpPaVRiOEdvWldJcEs4eWY0NjFjcmlSR2wxRUtp?=
 =?utf-8?B?bVZISEFsVmtJK2lpcDg0VENpWDVVVlRaUlMyRjJ0bUErVW5KV0xJSGRmNjVB?=
 =?utf-8?B?V1UwcW1mQ0RDOHp3bi9nVkJQUS84Sm9Md0V1TkVjU3p2K0ErT3JCcUlwd3Jo?=
 =?utf-8?B?MXBKTHo4Z2U0RmRqQi8zRGFBUEJzaytmaExSRjdqUm81Vzh1eWVBRVEvaGNL?=
 =?utf-8?B?cW1DZEUrckVhd1R3NUZrRUE0QVQyUFpZRm1Id2NqNDhZcXpMaWU0MmZ6d0dn?=
 =?utf-8?B?WlU5SWo0TnUwL1kwdm42SUIwYzR4UEtrNFBXVkFtTjdOZENpbk5mTEV5bHRE?=
 =?utf-8?B?ZGRKWU11K2RMQythRU9obFRncHRYeStQWXUxYjZNOEZEZEVwcXhjU3dUUVMx?=
 =?utf-8?B?UDRxaXQyYk1zL0hYLzZCWW1NNU1EaGkwWnVmcDB6QXRVRXJVNlpydHVBaVFL?=
 =?utf-8?B?b3YrV3ZpYksvZzEzaEVqR1FLazlCQWdUU3VXUkoyeGdkaVFweVNtUHpscC9s?=
 =?utf-8?B?M25aRVArOWc3elJLVU43QXBYUjlpMnFVTFVQZ1FTVU4wWnZNeXdxUGQ1SGVN?=
 =?utf-8?B?ZWgvSDJaRGNmZ3d1ckxweVZGdkVTMURJSFJtU3JlY2dSaGp4Q3VJbkRsRUVC?=
 =?utf-8?B?Q1dscTYwR1FUYjl3WTRBYVY4clBLTkcwOFhFUDNCTnFzczVNdUh3OFRESFM2?=
 =?utf-8?B?VGdCZ3UrbUo1UVFsSlVZbU1pNFFDOW4rUGl4ZXVsbUpTRVhHbmNPL2hDUSta?=
 =?utf-8?B?cDNPUS9XRnJ3blVpU2JzQ09XVjFoY0dYNVQxdS9qN3pqL2FhZVdxV1hkOWxq?=
 =?utf-8?B?eitNaG9LRUhqRW9yV1l0R2kzZkZmYVZ0Qi9nN0t4VlBwY1FkUnh6TXVYQnRZ?=
 =?utf-8?B?dytDMTIyWDRoZ2U5ZGloZkc1NWhRPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e845ee-dd18-4a2b-598f-08db58741ced
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:19:52.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoGkEaTv3kg4UAwEI+jCv1Us/rk1wgzcYst7vzfx9+bp0BQmw9Q4PHwUI8Wpm97hZKSq9hrzPJdVctNrJ71LuzeTt0B90x81OeKKjAvcsGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4739
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 18, 2023 at 01:07:18PM -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Allow sensors tool to read radio's temperature, example:
> 
> mt7921_phy17-pci-1800
> Adapter: PCI adapter
> temp1:        +72.0°C
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 53 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 17 ++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
>  3 files changed, 71 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> index c15ce1a19000..18f0f2dfbbcf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -2,6 +2,9 @@
>  /* Copyright (C) 2020 MediaTek Inc. */
>  
>  #include <linux/etherdevice.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/thermal.h>
>  #include <linux/firmware.h>
>  #include "mt7921.h"
>  #include "../mt76_connac2_mac.h"
> @@ -58,6 +61,50 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
>  	}
>  };
>  
> +static ssize_t mt7921_thermal_temp_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct mt7921_phy *phy = dev_get_drvdata(dev);
> +	int i = to_sensor_dev_attr(attr)->index;
> +	int temperature;
> +
> +	switch (i) {
> +	case 0:
> +		temperature = mt7921_mcu_get_temperature(phy);
> +		if (temperature < 0)
> +			return temperature;
> +		/* display in millidegree celcius */

Hi Ben,

a minor nit from my side: s/celcius/Celsius/

> +		return sprintf(buf, "%u\n", temperature * 1000);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...
