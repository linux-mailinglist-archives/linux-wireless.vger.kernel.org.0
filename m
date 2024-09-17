Return-Path: <linux-wireless+bounces-12924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E386D97B3EB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5F7286A00
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9541779AB;
	Tue, 17 Sep 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LdDdL6Jj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650E38FA1;
	Tue, 17 Sep 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596628; cv=none; b=tV8DnXNQnAnPh+AYXSTb/yFspKiyjmS+3eOcOnDeytZFI5B+QIDxROtC+euqNaimmI2QGNUJ6hZrpCCkoY/TQqNRtwEyA1Ch4g44H/qnRqg73H0OXy3byQ5FHnt1CtSW89B+arejUJFpSXUjw5F3gd5krgIO+WBaUvdAN6dimNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596628; c=relaxed/simple;
	bh=xtvyd1hf4SBhNzbONKOrGmyIrZ9Gk897DoDSdjF3cnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dcdPhmWjhak2zkVV2jLaKS52ZtOHR9mkFienVQY9eNK4emUExpnv7qK6GqjYmNKGNA9njb683EXUkzy0YlaWh73I0VaDH5giG/ICVM6s7XCxZl3beHJBLyMvEoXQ2hy5kHFYfGYnr+httNvc8jb7SnOg2BySo6qq/NwLEiUKw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LdDdL6Jj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HI2rTx021517;
	Tue, 17 Sep 2024 18:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xsaxpigv0/6kI/TwNwYU01A8ExRcLlAuGWhHEBR602Y=; b=LdDdL6JjwYOT278j
	FT1+wMyqlTbagzMt/ronQmdigKvEMyk9BEUY0cDNAxwenLk78ukZN+K4YlDRyIl7
	Uo18yYLLjtexTePXkrzjQtpeqovFdkb3zeIHQq0CmnUtkKakFEEbPbM0GgHhbaDW
	9KrjeCBVLU4b7ItM+Iz92G6HLlw4wXwret4ERurFBS6Kxy8gYSjzxwl7O8oeFb6Y
	9QK1eA007WsNGR6KSg6F6+CGTv0lzhzFnE8s+jNaruRGZZXXfyV5npQqegzrQ2i2
	UPj45JmYGVDR4Eajk8WkuMhKy9ds514XkqHXDM3A01ByUXX/4OrSTErU+W2ESByL
	r4ZgVg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4k0qp26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 18:10:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HIA90t027026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 18:10:09 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 11:10:08 -0700
Message-ID: <1b2af606-ade7-4550-b1ba-a78202b257e5@quicinc.com>
Date: Tue, 17 Sep 2024 11:10:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mwifiex: Fix memcpy() field-spanning write warning
 in mwifiex_config_scan()
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: David Lin <yu-hao.lin@nxp.com>, Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Sascha Hauer
	<s.hauer@pengutronix.de>, Kees Cook <kees@kernel.org>,
        "Gustavo A . R .
 Silva" <gustavoars@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <20240917150938.843879-1-alpernebiyasak@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240917150938.843879-1-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XNHH2m2FdLi6QtOc2glCzeIvTBj5VH4A
X-Proofpoint-GUID: XNHH2m2FdLi6QtOc2glCzeIvTBj5VH4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170128

On 9/17/2024 8:08 AM, Alper Nebi Yasak wrote:
> Replace one-element array with a flexible-array member in `struct
> mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
> on a MT8173 Chromebook (mt8173-elm-hana):
> 
> [  356.775250] ------------[ cut here ]------------
> [  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
> [  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]
> 
> The "(size 6)" above is exactly the length of the SSID of the network
> this device was connected to. The source of the warning looks like:
> 
>     ssid_len = user_scan_in->ssid_list[i].ssid_len;
>     [...]
>     memcpy(wildcard_ssid_tlv->ssid,
>            user_scan_in->ssid_list[i].ssid, ssid_len);
> 
> Also adjust a #define that uses sizeof() on this struct to keep the
> value same as before.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> I found these relevant patches that modify other such arrays, where the
> second one removes a -1 from some sizeof() calculation:
> 
> https://lore.kernel.org/lkml/Y9xkECG3uTZ6T1dN@work/T/#u
> https://lore.kernel.org/lkml/ZsZa5xRcsLq9D+RX@elsanto/T/#u
> 
> So I think we need the +1 to keep things same. But it appears to work
> fine without it, so I'm not sure. Maybe it should've had a -1 before
> that I would remove with this?

I think the original code was incorrect and was allocating too much memory.
I do not think WILDCARD_SSID_TLV_MAX_SIZE requires modification.

> 
>  drivers/net/wireless/marvell/mwifiex/fw.h   | 2 +-
>  drivers/net/wireless/marvell/mwifiex/scan.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index d03129d5d24e..4a96281792cc 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -875,7 +875,7 @@ struct mwifiex_ietypes_chanstats {
>  struct mwifiex_ie_types_wildcard_ssid_params {
>  	struct mwifiex_ie_types_header header;
>  	u8 max_ssid_length;
> -	u8 ssid[1];
> +	u8 ssid[];
>  } __packed;
>  
>  #define TSF_DATA_SIZE            8
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index cab889af4c4a..50af78ee935b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -32,7 +32,7 @@
>  #define WILDCARD_SSID_TLV_MAX_SIZE  \
>  	(MWIFIEX_MAX_SSID_LIST_LENGTH *					\
>  		(sizeof(struct mwifiex_ie_types_wildcard_ssid_params)	\
> -			+ IEEE80211_MAX_SSID_LEN))
> +			+ IEEE80211_MAX_SSID_LEN + 1))
>  
>  /* Maximum memory needed for a mwifiex_scan_cmd_config with all TLVs at max */
>  #define MAX_SCAN_CFG_ALLOC (sizeof(struct mwifiex_scan_cmd_config)        \
> 
> base-commit: 4f3e012d4cfd1d9bf837870c961f462ca9f23ebe


