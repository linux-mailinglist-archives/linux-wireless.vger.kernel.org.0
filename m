Return-Path: <linux-wireless+bounces-27282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5BDB56F46
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673BE178D60
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B81E7C2E;
	Mon, 15 Sep 2025 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="funeYHYm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146FD17BEBF
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757910379; cv=none; b=LjpbSpJXq9QIxY4yKfh5jY3HKCtqGAW+ePkVaV/1r7q+YRjs1DIntuklWWkSpM2Fb9jOi9oaZ9k9LR48vk35STC/oknYNgMbflRGf07OTiBUTxhsiAVmcgiyYHhZgyFAIQg7naYhxjoaSUNK0C26ylOV8c9HAJ2IrSMD2zzPAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757910379; c=relaxed/simple;
	bh=1h9c3Eoq8jnLqYRdBZ+GlMh98AgYGnqy61CfEnesVTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0n3mQj+RAsJWSHyQBd0/AG7mDVAWJ/T0Gi3OWZWVpqn1ZaKhNUt29KbF5M6J2BS6M85MC+GP0S9TiMXYFNg0Zm4DkULLBQHCS2N6QnIL6J9HyOXYjlEDYdW1rW9hq86MJGAiqiWQp2zaGGf1cVy4zdtCJn/8k417GWsEpDf2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=funeYHYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EKZlHG031237
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 04:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W6Lq9VvRKpMqKre0etY7xuiVmSSWr6BhJdXSNSQCv/g=; b=funeYHYm/wscAL/k
	JGZYPmh+FRffAEp3Bm/aCg8Y718V0SmMSfNoc4A/C1TQ8oDCokxdIRcOTNAUd6Xi
	wzMj/E2OGYySLoFJ9cyXKO/fYcqcXpE9y4JN+zrpkW207wWyt15f49iD0jaw6kqR
	JMJoO3TsYSqSYIMenAADDXA+48+Yzsyv4WMKzVJDcxSukoPVDwlk1/bbjk/SzqEP
	97yQExv8iK2iR3HwSgxOfJ3gvacW2IfegnWHIFnReSJY4xhvqYkkBanZtufCgwrl
	Oeh0a2mcP58JB7rt3Ads8jz3vbswQInfyxX8TE0UCjtDExiogRqHBTO/I8eycHzf
	4MTc3w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv3grk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 04:26:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c72281674so2615242a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 21:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757910376; x=1758515176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Lq9VvRKpMqKre0etY7xuiVmSSWr6BhJdXSNSQCv/g=;
        b=xO5zFBcOFWB8YHVkEHZCfjZ0+Chjs3eFOZF+NN/mEZas5iLumy0Ei3mDbiZooAHsHS
         ox0JhyPwJAq7baeeWRPDq5esHQjV88Cnkbv/qm2ujpz8SYX42iej1XCSRWPEjZckxQru
         YxyuSnlLlcbiuijO/EVxVkrnprNSq88Sxg5I0HiFagbVGib0mjCR88D/4S94DtfonZaX
         /J82U6sS6to8DpRL4pi/h4tCp2pIYgNig8RlIVf6O04u8j1U05DhRCuY6A8o3SSfkk9k
         cdELjCR9BbKyIVirf6/x/jIvIpprMK9INlmHOUwCPnje+fAMS1wZeA3fnVaWf13XypA1
         UguA==
X-Gm-Message-State: AOJu0Yzhm7oiFqC5L1HCt+LJamgrkD2xwVtkAxdW5DH8LMXfrYBSu+B+
	wjsHuTJDtwD2oiM02qkHKAUDVM8mEC6qcIZeZtnIFHkiEHimtuj1gCZOzTNuVuYaKlAioYDX8+D
	huEZXHjCM/Q+NjMaTM2r5W0DjRUWvxObRO8HTiK/OrEzDYZ7dxKTwJOEVz+68e7+CcUxf987ypI
	nVqg==
X-Gm-Gg: ASbGncubLHrjaUfvsQ/OdlcEvZtynRYjevfauRW60BI/N6rV04QinoX3dOvC715ShIS
	l5hZxVnirtFKAjo8LxLzYHo6GVqhurQa0jrXuTedN6vgygeiLBtUv1bXHYhf9k7emLXRpgH2kfY
	cSts2iqvMiL5Nlpr8VaHNJCx+ZiCko77dXMReH5Fo5WGKkSqDs9Z4AeZJijtW6lveboHj68hxGU
	4X6MBywANE/LSYCIX1pPn1o/ggPf7rMqPqEATF5dDckSYnr78/nPoEdsm6JjM9HXjsb5E1sVU5E
	Yr+2duGily3m+6vU/6Flj0EczyvLJQnAH5/uu+J1abiQ0AAijGyqNZzXAOhCpF9H
X-Received: by 2002:a05:6a20:7b04:b0:262:4ce4:f694 with SMTP id adf61e73a8af0-2624ce4f91cmr5237696637.35.1757910376120;
        Sun, 14 Sep 2025 21:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmpfTE3UkL4Hl7I1NDnkmmsJmGcdmRnPkHHBCwUynKWcVl63KiF4CFG8s0DiUey39ghC2/GQ==
X-Received: by 2002:a05:6a20:7b04:b0:262:4ce4:f694 with SMTP id adf61e73a8af0-2624ce4f91cmr5237671637.35.1757910375609;
        Sun, 14 Sep 2025 21:26:15 -0700 (PDT)
Received: from [10.151.41.63] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ac02de2bsm8043501a12.17.2025.09.14.21.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 21:26:15 -0700 (PDT)
Message-ID: <51e6a40d-8f1b-40ed-9105-4b0af0c544b9@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:56:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iw: bitrate: support link id
To: Zong-Zhe Yang <kevin_yang@realtek.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250912095423.27266-1-kevin_yang@realtek.com>
 <20250912095423.27266-6-kevin_yang@realtek.com>
Content-Language: en-US
From: Raja Mani <raja.mani@oss.qualcomm.com>
In-Reply-To: <20250912095423.27266-6-kevin_yang@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c79569 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=n9Sqmae0AAAA:8 a=UsckkpPA16D0HaNa0YgA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-ORIG-GUID: fk3Od_zodSCaYOw1VEoZIh43WRwyftbu
X-Proofpoint-GUID: fk3Od_zodSCaYOw1VEoZIh43WRwyftbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfX7lB/YQw1JL/r
 +flC30ctMO76swCmQRgzpbJduswJN413d9/p+Kj5fB7OKdVwhv4kx6IeNWjdyI2WyrLJHpnKWC3
 +zwP4E6Bs1f/SJWzpT9m5xYO0sV7qYDqGo8292Y/7hVcbRPQ8GGBFyJYzf8bM5lnLnBZnJ4oxdo
 BEi/kJJVwDcrZO0k+JXO6PIova+JWCKhCvvyqPfV8NSg7s2/59G0qfcvDKvc9SIDdiWm3xr6/Fl
 xev+tdFDEzVT9ioF5V6KuKJiEODHtc+D/kx1hV5cnXfA4ZDUIJabnIVz/czyTfQ/5oenLXozfoy
 s+YOuFgSRKQUU/K9GOZCpBLhHuOXAYT9zUGLG01rY8pcqr0a0P+eiWoZp0hrXzQjpTi7oIcE5vI
 JmZd8tOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017



On 9/12/2025 3:24 PM, Zong-Zhe Yang wrote:
> Since nl80211 requires valid link id (NL80211_FLAG_MLO_VALID_LINK_ID),
> support link-id field for MLD. For non-MLD, just as before, no need to
> assign link-id field.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> ---
>   bitrate.c   | 29 +++++++++++++++++++++++++++--
>   interface.c | 32 +++++++++++++++++++++++++++-----
>   iw.h        |  2 +-
>   3 files changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/bitrate.c b/bitrate.c
> index 16f118cce4ec..78d399d227e2 100644
> --- a/bitrate.c
> +++ b/bitrate.c
> @@ -195,7 +195,7 @@ static int parse_eht_gi(char *eht_gi)
>   
>   int set_bitrates(struct nl_msg *msg,
>   		 int argc, char **argv,
> -		 enum nl80211_attrs attr)
> +		 enum nl80211_attrs attr, int *link_id)
>   {
>   	struct nlattr *nl_rates, *nl_band;
>   	int i, ret = 0;
> @@ -242,6 +242,7 @@ int set_bitrates(struct nl_msg *msg,
>   	char *he_gi_argv = NULL;
>   	int eht_gi = 0, eht_ltf = 0;
>   	char *eht_gi_argv = NULL;
> +	bool has_link_id = false;
>   
>   	enum {
>   		S_NONE,
> @@ -250,6 +251,7 @@ int set_bitrates(struct nl_msg *msg,
>   		S_VHT,
>   		S_HE,
>   		S_EHT,
> +		S_LINK_ID,
>   		S_GI,
>   		S_HE_GI,
>   		S_HE_LTF,
> @@ -347,6 +349,11 @@ int set_bitrates(struct nl_msg *msg,
>   			eht_argv = eht_argv_6;
>   			eht_argc = &eht_argc_6;
>   			have_eht_mcs_6 = true;
> +		} else if (strcmp(argv[i], "link-id") == 0) {

Missed to include this new arg in 'tidconf' and 'bitrates' option's
help text ?

> +			if (has_link_id)
> +				return 1;
> +			parser_state = S_LINK_ID;
> +			has_link_id = true;
>   		} else if (strcmp(argv[i], "sgi-2.4") == 0) {
>   			sgi_24 = 1;
>   			parser_state = S_GI;
> @@ -427,6 +434,11 @@ int set_bitrates(struct nl_msg *msg,
>   				return 1;
>   			eht_argv[(*eht_argc)++] = argv[i];
>   			break;
> +		case S_LINK_ID:
> +			*link_id = strtol(argv[i], &end, 0);
> +			if (*end != '\0')
> +				return 1;
> +			break;
>   		case S_GI:
>   			break;
>   		case S_HE_GI:
> @@ -618,7 +630,20 @@ static int handle_bitrates(struct nl80211_state *state,
>   			   int argc, char **argv,
>   			   enum id_input id)
>   {
> -	return set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES);
> +	int link_id = -1;
> +	int ret;
> +
> +	ret = set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES, &link_id);
> +	if (ret)
> +		return ret;
> +
> +	if (link_id >= 0)
> +		NLA_PUT_U8(msg, NL80211_ATTR_MLO_LINK_ID, link_id);
> +
> +	return 0;
> +
> + nla_put_failure:
> +	return -ENOBUFS;
>   }
>   
>   #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
> diff --git a/interface.c b/interface.c
> index 65a4006963e5..0f1e9647f0e4 100644
> --- a/interface.c
> +++ b/interface.c
> @@ -796,10 +796,11 @@ static int toggle_tid_param(const char *argv0, const char *argv1,
>   	return -ENOBUFS;
>   }
>   
> -static int handle_tid_config(struct nl80211_state *state,
> -			     struct nl_msg *msg,
> -			     int argc, char **argv,
> -			     enum id_input id)
> +static int __handle_tid_config(struct nl80211_state *state,
> +			       struct nl_msg *msg,
> +			       int argc, char **argv,
> +			       enum id_input id,
> +			       int *link_id)
>   {
>   	struct nlattr *tids_array = NULL;
>   	struct nlattr *tids_entry = NULL;
> @@ -989,7 +990,7 @@ static int handle_tid_config(struct nl80211_state *state,
>   				if (txrate_type != NL80211_TX_RATE_AUTOMATIC) {
>   					attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
>   					ret = set_bitrates(msg, argc, argv,
> -							   attr);
> +							   attr, link_id);
>   					if (ret < 2)
>   						return 1;
>   
> @@ -1020,6 +1021,27 @@ nla_put_failure:
>   	return -ENOBUFS;
>   }
>   
> +static int handle_tid_config(struct nl80211_state *state,
> +			     struct nl_msg *msg,
> +			     int argc, char **argv,
> +			     enum id_input id)
> +{
> +	int link_id = -1;
> +	int ret;
> +
> +	ret = __handle_tid_config(state, msg, argc, argv, id, &link_id);
> +	if (ret)
> +		return ret;
> +
> +	if (link_id >= 0)
> +		NLA_PUT_U8(msg, NL80211_ATTR_MLO_LINK_ID, link_id);
> +
> +	return 0;
> +
> + nla_put_failure:
> +	return -ENOBUFS;
> +}
> +
>   COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>] [lretry <num>] "
>   	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]"
>   	"[bitrates <type [auto|fixed|limit]> [legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*]"
> diff --git a/iw.h b/iw.h
> index 145b058d86ba..5c4ab6b0b38e 100644
> --- a/iw.h
> +++ b/iw.h
> @@ -302,7 +302,7 @@ void nan_bf(uint8_t idx, uint8_t *bf, uint16_t bf_len, const uint8_t *buf,
>   char *hex2bin(const char *hex, char *buf);
>   
>   int set_bitrates(struct nl_msg *msg, int argc, char **argv,
> -		 enum nl80211_attrs attr);
> +		 enum nl80211_attrs attr, int *link_id);
>   
>   int calc_s1g_ch_center_freq(__u8 ch_index, __u8 s1g_oper_class);
>   


