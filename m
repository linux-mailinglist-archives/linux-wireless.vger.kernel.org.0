Return-Path: <linux-wireless+bounces-176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E3B7FC69D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 22:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DFEB219FE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CF4438A;
	Tue, 28 Nov 2023 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UVqMdctB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993D9D
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 13:01:43 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS9xhE9014934;
	Tue, 28 Nov 2023 21:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=paDe/iNFmsZdrFr+e8yTyjXKdqvtKJ5WsVGXHBzNBaA=;
 b=UVqMdctBXsCsByODIMfUhIZhvpK1zvL41ztFv0H//3zhpFImcHc5I3bcwPAvOVS8RLCG
 qz4eUHIWxoLlQzR/wUEnyZK9u4jMnHnoSvYxO0oO5Bh/AsWDj3oWNDX5VGzUZ7U26j7h
 d/KcRN1AP04hDPizbKM0E2UOdHfHBEZFyvwp/EP4m0tMLxA8nBD9YbpXjUvfRLr7BNoG
 B63M2s4CyaLRg4lPRBB+H9HcbKOz+ACUWsYIWo0KjzNaHRfP1tHyIBF5HhG9VLOjfShY
 C7scWCnPc5dvj4yYJS7IP2g3PrNV/B0D/8NIqQNA9L/zUGzp0mj18uZtb5Adr0OZECgm aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un586u2ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 21:01:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASL1LVX009692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 21:01:21 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 13:01:21 -0800
Message-ID: <fc1dbe4a-a810-445c-9398-60a5e55990a2@quicinc.com>
Date: Tue, 28 Nov 2023 13:01:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Michael Walle
	<mwalle@kernel.org>, Kees Cook <keescook@chromium.org>
CC: <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-wireless@vger.kernel.org>, Max Schulze <max.schulze@online.de>
References: <202311090752.hWcJWAHL-lkp@intel.com>
 <202311090752.hWcJWAHL-lkp@intel.com>
 <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WaQfPiCdTt_S4kE9z9lwCkMNtcsqI8Rw
X-Proofpoint-GUID: WaQfPiCdTt_S4kE9z9lwCkMNtcsqI8Rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_23,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=520 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280167

On 11/28/2023 10:23 AM, Johannes Berg wrote:
> On Tue, 2023-11-28 at 15:44 +0100, Michael Walle wrote:
>> Hi,
>>
>>> net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
>>> net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound
>>> 18446744073709551615 exceeds maximum object size 9223372036854775807
>>> [-Wstringop-overflow=]
>>
>> FWIW, I'm getting the same error with the current next (next-20231128).
>>
> 
> I actually forgot about that, but does anyone actually know what this is
> trying to tell me?
> 
> The code seems to be
> 
>         if (n_thresholds) {
>                 cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
>                                                  n_thresholds),
>                                      GFP_KERNEL);
>                 if (!cqm_config)
>                         return -ENOMEM;
> 
>                 cqm_config->rssi_hyst = hysteresis;
>                 cqm_config->n_rssi_thresholds = n_thresholds;
>                 memcpy(cqm_config->rssi_thresholds, thresholds,
>                        flex_array_size(cqm_config, rssi_thresholds,
>                                        n_thresholds));
> 
> 
> Or does it just want to say n_thresholds shouldn't be a signed variable?

+Kees for flex array education :)

