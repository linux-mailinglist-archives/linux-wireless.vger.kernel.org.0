Return-Path: <linux-wireless+bounces-3411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E6850165
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 02:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686EE1F23AAF
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 01:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5263C;
	Sat, 10 Feb 2024 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EXuVPHiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D441FB3
	for <linux-wireless@vger.kernel.org>; Sat, 10 Feb 2024 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526893; cv=none; b=JovcL1Q4O/StlSSMvRgr4aXGIEdlJ8qQSGvb36rnuON52FJzn3jC3vt0a5xh9iro/yyBbrg+SfHqOsNLjpeM84AXfWC4cmNcZ+TRGtCXn+lcM+2rqvS4X3RI/Sa7n5Rzr9ItvxT6nkFcCpgJjv9Iz7AnkFvfq7n31lMvgr6AXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526893; c=relaxed/simple;
	bh=IlYc0IcD5wmjQRsQjYZQL0f1TKp1n+c93X7O+gBoE6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HI4HNgkXQKeBUM5wmuqmCUvqc/xnaEiM3joIsV8AR5qQ0wtMSSUjzlXLf2k2ne+MCyZjUJMmM90F/PncXU/LFH/YKxRKt3VdWMRTauQZVI5ngUejIIO0TSsns3rP+GOoSHls/PxuUDevDZ55OOvkvDk2d01cnCNzf0S2M1Wd6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EXuVPHiJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41A0QueI023881;
	Sat, 10 Feb 2024 01:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5mdUMqjC5FVMd6zd90jCMJAJRBycbZ8QqkMDb5VKNFE=; b=EX
	uVPHiJzMy/pK5X0fY2tat/qk0v7pCclG0l5JJZR59K0CO32wMF1H27J2o42FLJAb
	OlNyP8fHqKKJwaVNA4jvVhLjRklF+QJQf773Z/2FE8Fim3KKlCNf7LyS/7Iq9ZMU
	bgmhNpAwyNtOrQtr2v4WEHQUJlRkdsjMDE8zBZG291Vkf0WAAI9KxFg2hZwevcEL
	JgdnivlRTMAyRBhan4ja8ZWPWupVBOhm3eVRb31CbgoWyYyVfXjnyQLVTUyOfAYe
	pHzQhye5ywDYaedwVIDK/M212KQaTHQ2GJSAwfly3lb0jbX+EFuNnDSPZ57esZEk
	qe3qRw6taYUBVJIuJHUw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4rk85dks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 01:01:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A11OMQ004009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 01:01:24 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 17:01:24 -0800
Message-ID: <ae2a91ed-841f-47a3-b0b8-1e46244721f9@quicinc.com>
Date: Fri, 9 Feb 2024 17:01:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups to
 driver
Content-Language: en-US
To: Vinayak Yadawad <vinayak.yadawad@broadcom.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <jithu.jance@broadcom.com>
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HaJUXivEO_Wx6B9baiB9zHoyh3u0kL0X
X-Proofpoint-ORIG-GUID: HaJUXivEO_Wx6B9baiB9zHoyh3u0kL0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100005

On 2/9/2024 5:50 AM, Vinayak Yadawad wrote:
> In case of SAE authentication offload, the driver would need
> the info of SAE DH groups for both STA connection and soft AP.
> In the current change we update the SAE DH group support info

who is we?

<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>
Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
do frotz", as if you are giving orders to the codebase to change its
behaviour.


> to driver in the order/priority as provided by the supplicant/
> upper layer.
> 
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> ---
>  include/net/cfg80211.h       |  6 ++++++
>  include/uapi/linux/nl80211.h |  7 +++++++
>  net/wireless/nl80211.c       | 22 ++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 5b42bfc..0b2db0d 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1194,6 +1194,7 @@ struct survey_info {
>  };
>  
>  #define CFG80211_MAX_NUM_AKM_SUITES	10
> +#define CFG80211_MAX_NUM_SAE_DH_GROUPS 10
>  
>  /**
>   * struct cfg80211_crypto_settings - Crypto settings
> @@ -1235,6 +1236,9 @@ struct survey_info {
>   *
>   *	NL80211_SAE_PWE_BOTH
>   *	  Allow either hunting-and-pecking loop or hash-to-element
> + *
> + * @sae_dh_groups: SAE DH groups in preference order.
> + * @n_sae_dhd_groups: No of SAE DH groups assigned.
>   */
>  struct cfg80211_crypto_settings {
>  	u32 wpa_versions;
> @@ -1252,6 +1256,8 @@ struct cfg80211_crypto_settings {
>  	const u8 *sae_pwd;
>  	u8 sae_pwd_len;
>  	enum nl80211_sae_pwe_mechanism sae_pwe;
> +	u32 sae_dh_groups[CFG80211_MAX_NUM_SAE_DH_GROUPS];
> +	u8 n_sae_dh_groups;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 853ac53..7c1a7b4 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2855,6 +2855,11 @@ enum nl80211_commands {
>   *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
>   *	are used on this connection
>   *
> + * @NL80211_ATTR_SAE_DH_GROUPS: Attribute to indicate the supported SAE DH

suggest you be more specific and say this is a nest attribute containing
zero or more u32 attributes containing a DH Group number

> + *	groups to driver. For STA role, the dh groups should be tried in the

s/dh/DH/

> + *	indicated order. For AP role, the order does not have any specific
> + *	significance.
> + *
>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>   * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3400,6 +3405,8 @@ enum nl80211_attrs {
>  
>  	NL80211_ATTR_ASSOC_SPP_AMSDU,
>  
> +	NL80211_ATTR_SAE_DH_GROUPS,
> +
>  	/* add attributes here, update the policy in nl80211.c */
>  
>  	__NL80211_ATTR_AFTER_LAST,
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 68c2040..555eb0f 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -826,6 +826,7 @@ static int validate_he_capa(const struct nlattr *attr,
>  	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
>  	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
>  	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
> +	[NL80211_ATTR_SAE_DH_GROUPS] = { .type = NLA_NESTED },

can/should this have a policy? not sure it can have a policy, so see
below...

>  };
>  
>  /* policy for the key attributes */
> @@ -10883,6 +10884,27 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
>  	else
>  		settings->sae_pwe = NL80211_SAE_PWE_UNSPECIFIED;
>  
> +	if (info->attrs[NL80211_ATTR_SAE_DH_GROUPS]) {
> +		struct nlattr *dh_group;
> +		int tmp, i = 0;
> +
> +		if (!wiphy_ext_feature_isset(&rdev->wiphy,
> +					     NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
> +		    !wiphy_ext_feature_isset(&rdev->wiphy,
> +					     NL80211_EXT_FEATURE_SAE_OFFLOAD_AP))
> +			return -EINVAL;
> +
> +		nla_for_each_nested(dh_group, info->attrs[NL80211_ATTR_SAE_DH_GROUPS],
> +		    tmp) {
> +			settings->sae_dh_groups[i] = nla_get_u32(dh_group);

...note that since you don't have a policy to ensure that each attribute
actually has 4 bytes of data, this can result in a buffer overread if
userspace provides less than 4 bytes of payload.

perhaps add logic like the following (borrowed from validate_scan_freqs():

		if (nla_len(dh_group) != sizeof(u32))
			return -EINVAL;

also if it passes the u32 size test, don't you also want to check each
value to make sure it is a valid DH Group #?

of course, this begs the question of whether cfg80211 or the individual
drivers should validate the DH Group values. if we don't validate in
cfg80211 then perhaps add to the documentation of @sae_dh_groups that
the values have not been validated

> +			i++;
> +
> +			if (i == CFG80211_MAX_NUM_SAE_DH_GROUPS)
> +				break;
> +		}
> +		settings->n_sae_dh_groups = i;
> +	}
> +
>  	return 0;
>  }
>  


