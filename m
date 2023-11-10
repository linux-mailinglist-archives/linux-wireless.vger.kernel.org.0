Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1717E75B2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjKJALK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 19:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjKJAK7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 19:10:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979E6A68
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 16:06:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9NsjP8008041;
        Fri, 10 Nov 2023 00:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DLrhEL4LxUz9Tp4lLJR+bN5nshNSVrn4xQuNT+IaCVQ=;
 b=aezcW+0W/Z6b6nvswFqSxpBav7sl8yZOWi6SNjRNI47gddQ/HLIBOn61Unl+SrbtsPJq
 NLrzcKHM+WKX0bG3LkvH+vreWFCoyHXdmVCB+4QnLCHraIGloHcIVoOt+idjA0NqS3Cs
 rrql3HxGIBbY4U25CcvgMeVtR9tbtMVUFCvPXoZF+gVXBZ4d7vj48cQSdpoRgguPazvh
 ANnY8XCr/7H3ycNG2LmN98C4Z3Nspmg0SXXWcMEdrsYObK+UXJKxL94pi1/fsjbuCktm
 VIT5BR9XSluSXAemKDWpF16Lt3LnaIZC+EbLEEN553Qk9Hjy+3HkmqRPsEg/xtc0MSg8 DA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93gtrtkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 00:06:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA06N6u010974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 00:06:23 GMT
Received: from [10.110.6.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 16:06:23 -0800
Message-ID: <ff9af6fc-22a4-4ccf-88e0-ffaa4e733ba8@quicinc.com>
Date:   Thu, 9 Nov 2023 16:06:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Handle 320Mhz in
 ieee80211_ht_cap_ie_to_sta_ht_cap
Content-Language: en-US
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
References: <20231109182201.495381-1-greearb@candelatech.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231109182201.495381-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 64umyaRMrfko77sLg4oJQzbuv6VnVGVc
X-Proofpoint-GUID: 64umyaRMrfko77sLg4oJQzbuv6VnVGVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxlogscore=691 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090178
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/9/2023 10:22 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> I saw a splat in the switch statement, I think because 320Mhz was

nit: s/Mhz/MHz/

> not specified..
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   net/mac80211/ht.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
> index 68cea2685224..749f4ecab990 100644
> --- a/net/mac80211/ht.c
> +++ b/net/mac80211/ht.c
> @@ -271,6 +271,7 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
>   	case NL80211_CHAN_WIDTH_80:
>   	case NL80211_CHAN_WIDTH_80P80:
>   	case NL80211_CHAN_WIDTH_160:
> +	case NL80211_CHAN_WIDTH_320:
>   		bw = ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
>   				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
>   		break;

