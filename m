Return-Path: <linux-wireless+bounces-35485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ts2bOv+D8GmsUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:55:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 615E2481F41
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D459B306C511
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5763A6B88;
	Tue, 28 Apr 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVwt1E64";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jnpeh1ft"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154223DBD48
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369845; cv=none; b=aoiXZCNZd7iHtszWk8RdjOGpp4bCWqDrKEv0kbtxwB+S32iHVMDLR/TLMmJKVUEPp75oNe9/tUhb+tRm0VqPlOEIrjDBb4UygtGQB+ErR8GlRKAY2C7GWXq3PextgCqJ1SXbZNkQ1HkSkjy0Dp5VOwxUdQQQfkZN0Eb1Sn3W9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369845; c=relaxed/simple;
	bh=Jqog205frAqA/0779yEq89T16+35oFWCHfzjNjjAwkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9DdkRBgNjAdi/zAC6y60plA2fWUl5b9LWoTf+WRgF4L7Gp/P313PHwV0xKc9lodYSN7rMgfwmym+NLRBYt1GcOHHJzZLzohxFjHr1LH+fcsoHhiIfWNEq14WExvOuHSKKilnI6TRtkyauOZbo1CPDSKn1PXT6HnthG/3OGZJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dVwt1E64; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jnpeh1ft; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7uuHd3968092
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u6ZWVOLEabM1Q1/TAsy7ZN2TCZOO2dSSjesAd9yiZhI=; b=dVwt1E64iK6nvC4M
	KXXf67fsu4pLiLnFKfGKyhVL/iIyZ5Bk/kQLz/UVEfp3806Zwrva4qrGL/ijUwnl
	I1PgDmsFg6NPo4iq/h7o2Cn+3x2L+YKboxcMk1+NZ3CFFOBSPiis1SrpnXZGhfVl
	t//eDGhNqBnNjGpIlIjfnx8Wkl3dyq6JwmODfPSnOIFq1N/eJq4pp9hJ6eEgmMdc
	r8LHJr6//Zl70Snlh7m8pfe7HRJ/qwWiL40mFfzyYBsSG4BhpFOOmFKxZG9eJtbm
	kkD42AdBAIO8HyoTmWWZ3oWY8+6eds+r1yTRwT4bI9Y5V3GLDEy90VWu/LEstbas
	HlhLNA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0gex5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:50:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fb969a4c0so12170717a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777369841; x=1777974641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6ZWVOLEabM1Q1/TAsy7ZN2TCZOO2dSSjesAd9yiZhI=;
        b=Jnpeh1ftxC+w02hGCqXw80qSoqlvfciIiqiMyPT42MebaKEntHGXuCdaRk/frapRLX
         Z9OkOmkqZmyksRDMftd+5nPIuhrImg0Mj0x7CQ5hFPvJSLrCtGf2+mf3ZyACGwV5DgQx
         Wes3QuTAIzcM5n5JACW/AfOe4Hslq5LYW+wHo4ZhX0xuuAaifUAvL0vIWhZClVMP2Q7u
         y4XzCltMCmzOGdysWbUOt77jo8tWE/i3guXmcuBVENrsNhYfgyLQeQ9f1pitM7aglxuw
         0rF56DGkGzMkPxUHcDwcYg71pU1JYiaFTfEawlU/RQXVqPyIkb2bpJlatxyb1QC/pPMv
         I7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369841; x=1777974641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6ZWVOLEabM1Q1/TAsy7ZN2TCZOO2dSSjesAd9yiZhI=;
        b=ItCbURS8LarRIIRM/CnTEvvogMkV4X4ztUG4OMJ4AZ7ZMLUTV6Gr0av74tpuJJQIre
         an2jazHKmcvmBlYAu/1phy8oj1eMd7h7JepH0PbTiIN2QerQ1yfY6jnbyjw6CbWvm1u3
         TJhjlAJed79tXDp7T62ZDiD7neiDL3yOhOaFPaETB9dnL0r37F6pyrr1ESDzl4EQYNUB
         z2fVvno/0smtPSFfRkzsQqOII2ZKW3CoyrbHr3arZhdOw5Z+ZBiUXtT++sL14TL8TdiF
         Y9wW+GEFmgR7Gfs/Ejl9R5jXA4+Ureeo1piCzUSiCIQzh8qJSX2X2iEHDOnDuvYzGPlC
         3gBg==
X-Forwarded-Encrypted: i=1; AFNElJ+b2Hvt3qOh3X1aOmJ7/rUOfmXv6ARieuRs7uBRHDD6UkTFl/I+sxjpRsIcXqz0Jz7+elM0PNtknY0lh6/sfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DJftMMnQTjM0BVqmnTZmIkU9DAGbYyWoWwZNY8oNP9Eot/Ds
	/ZwRW0ETiRBAflsoWcKgC8jNHzjlZgmrdU2vmy+eAC39/CxP4mkIwHzbdfDzpUCYmtf3mRjd7Cf
	ELBuOiDXo7bykFhANSJHDoKIndUV2193wvlTXw1uTMPUZSwl3gnaRmUsylNIItQ1/Whwuzg==
X-Gm-Gg: AeBDieu9ct3WZGgzYlaY7LYZyLMMscqEFe2ZwDg8wgYhpfgllH2pdjbRlYKEKET0UXR
	UPV0twJQX9rDwN1Qy3Kik9gCoT53DkRzj1n25DM4AW/Cdcb/hsv96JBI8vR6me+/5ReufXw41Sz
	ZJqWl9UUFi+vbr/e9bj/inbLrwBkBgGemSdFLpClxoI2iz6KR+TpnM/GkLh5ZQKFaJko4vi2CNi
	Sa0gl5sTpLf4d4EJVAN9KlJinS74PxU/J4hPXym4W3yCSv5opHOlY8xIaBmmCoGIZ5Azw9Ctzmz
	a0omYpsDiwIRbQzvFe6YO15Sk9hQ6AoyEP4qjWPblpNMcb0lqiSzs5mT1dw42W2NyqeKQvAjwlS
	J2qXzGgzPVzxjro9e3kN9N62Oo9pgV+WKXnImmEnjkeQHfEHHBNlIGPevX809NQ1VG4YOKAOe
X-Received: by 2002:a05:6a21:6d9e:b0:39f:91e9:cada with SMTP id adf61e73a8af0-3a39c049fe3mr2900873637.9.1777369840811;
        Tue, 28 Apr 2026 02:50:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9e:b0:39f:91e9:cada with SMTP id adf61e73a8af0-3a39c049fe3mr2900836637.9.1777369840254;
        Tue, 28 Apr 2026 02:50:40 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc35d0eadsm1983071a12.27.2026.04.28.02.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:50:39 -0700 (PDT)
Message-ID: <582155ff-1cac-4d88-a6b2-006146ba4e67@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 15:20:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260421231205.77361-1-rosenp@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260421231205.77361-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f082f1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=DUA8lF3kxO5kyfe6QosA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: skXTXHocLYnjalCzWSDiznyZtpO3YN7X
X-Proofpoint-ORIG-GUID: skXTXHocLYnjalCzWSDiznyZtpO3YN7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4NSBTYWx0ZWRfX5DcUDY7iEvvO
 diPTtYSOSfnMozF9VLyfjDXTJ/Q5X0h4RFPSCM/0wztCo4ku3F29YzPlHa406lWc0nUzmDWp+k1
 S1cKiD2pp6MNzorApJHBtR3dafY6Gjz9UjT4fqscGvrJJ+7Dodll4iIUIR945aewdDVi3z7Wo0B
 UyNg+pjZh8/imCUfYlDBEjMqVrrvKbAvZxtMXOpxDtL+H4a0TR3vUn3CqMtpjexx+AuzOToUb7r
 C+RQ3lvpRzY3f7qKUoBMl9qUsrGjYNcuo31nZNIDULlLaMOKK8Oy91RxZzwuJ2wLwl5TRslWzy4
 PFd3ppqtUcor7m1RM+b2/lk0P2F9IdHyXuPk57b4AyRgW1sP8Ch5UCgMhW3gKuQSyq5Pj3iV+Zb
 2Sk5LDM/iCEMkg3oo+M8jskUaHCIsF+ZCOy3u1EzCF5jHQRZG/Ec268eOKNvpC9p18MmtIEkiVg
 a4NLpe1c8/iFZ+Jgd+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280085
X-Rspamd-Queue-Id: 615E2481F41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35485-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/22/2026 4:42 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v2: reword counting variable comment.
>   drivers/net/wireless/ath/ath11k/mac.c | 71 ++++++++++-----------------
>   drivers/net/wireless/ath/ath11k/wmi.h |  2 +-
>   2 files changed, 28 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 4a68bb9ca4fa..b5f3d7221b5f 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -4228,13 +4228,14 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>   	if (ret)
>   		goto exit;
> 
> -	arg = kzalloc_obj(*arg);
> +	arg = kzalloc_flex(*arg, chan_list, req->n_channels);
> 
>   	if (!arg) {
>   		ret = -ENOMEM;
>   		goto exit;
>   	}
> 
> +	arg->num_chan = req->n_channels;
>   	ath11k_wmi_start_scan_init(ar, arg);
>   	arg->vdev_id = arvif->vdev_id;
>   	arg->scan_id = ATH11K_SCAN_ID;
> @@ -4262,38 +4263,27 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>   		arg->scan_f_passive = 1;
>   	}
> 
> -	if (req->n_channels) {
> -		arg->num_chan = req->n_channels;
> -		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
> -					 GFP_KERNEL);
> +	for (i = 0; i < arg->num_chan; i++) {
> +		if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
> +			     ar->ab->wmi_ab.svc_map)) {
> +			arg->chan_list[i] =
> +				u32_encode_bits(req->channels[i]->center_freq,
> +						WMI_SCAN_CONFIG_PER_CHANNEL_MASK);
> 
> -		if (!arg->chan_list) {
> -			ret = -ENOMEM;
> -			goto exit;
> -		}
> -
> -		for (i = 0; i < arg->num_chan; i++) {
> -			if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
> -				     ar->ab->wmi_ab.svc_map)) {
> -				arg->chan_list[i] =
> -					u32_encode_bits(req->channels[i]->center_freq,
> -							WMI_SCAN_CONFIG_PER_CHANNEL_MASK);
> -
> -				/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
> -				 * flags, then scan all PSC channels in 6 GHz band and
> -				 * those non-PSC channels where RNR IE is found during
> -				 * the legacy 2.4/5 GHz scan.
> -				 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
> -				 * then all channels in 6 GHz will be scanned.
> -				 */
> -				if (req->channels[i]->band == NL80211_BAND_6GHZ &&
> -				    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
> -				    !cfg80211_channel_is_psc(req->channels[i]))
> -					arg->chan_list[i] |=
> -						WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
> -			} else {
> -				arg->chan_list[i] = req->channels[i]->center_freq;
> -			}
> +			/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
> +			 * flags, then scan all PSC channels in 6 GHz band and
> +			 * those non-PSC channels where RNR IE is found during
> +			 * the legacy 2.4/5 GHz scan.
> +			 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
> +			 * then all channels in 6 GHz will be scanned.
> +			 */
> +			if (req->channels[i]->band == NL80211_BAND_6GHZ &&
> +			    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
> +			    !cfg80211_channel_is_psc(req->channels[i]))
> +				arg->chan_list[i] |=
> +					WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
> +		} else {
> +			arg->chan_list[i] = req->channels[i]->center_freq;
>   		}
>   	}
> 


the exit: label at the end of the function has kfree(arg->chan_list); 
which now must be removed.



--
Ramesh

