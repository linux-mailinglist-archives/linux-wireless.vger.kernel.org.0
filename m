Return-Path: <linux-wireless+bounces-37958-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OMzgIwrEOGoShwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37958-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:11:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF46ACA9E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:11:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=iT9FYQiE;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RmoOtfSr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37958-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37958-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E34413010EF7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 05:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9E3546EB;
	Mon, 22 Jun 2026 05:11:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C42245020
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 05:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105093; cv=none; b=MLuBM+9eNokOuT/MwqOWDYs9kEeN17JOdSdRHMOGx0LsL1muTCz58aHXPuvcVYj3+0KolbbahgSVReuHK6thUARYSascQ410jAvitXFap93KBsxTf+aXmYYfUlgZDOHkWJtU5C6M2zBBjARkb1nQEMVraUo/jVt6Ss+Jp6ppZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105093; c=relaxed/simple;
	bh=J690Tlpj02yje90WpI7kzHrjgdRxC+3O21IfvD1l2+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCf1ZWXxbhU7xQUsq9IYKWNqQ11YEi7oLRF72e6qwbD71jFFQRAYhIHAXyd4QltLmHmKR4Ckycl0NMMMPfY7z+3d0mvQhPsEYBgsQjS46UVYBrjpmb7EuUMn3YVj8FC8NxlEKeVHKrWTGVmZZpmZNvqbV92AU0N/TWBKTh9RsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iT9FYQiE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmoOtfSr; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59EVn2427838
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 05:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60bpPo7bB923QwBAsdBtArQLCaqk1Or+3USoOTjJavk=; b=iT9FYQiEkGN/7lRV
	E6xxiGQZ8xmGm70OwlpJLw/9EW6QFBhGQw2OP37aC154b1auSiXRUfmI0GtHXe8B
	nxxZ/vlZq6nM3kIwK7ecqAL1UQ2DCmY8vsmGvz03T+R7yNIcnihA3HS27gW3PJfV
	CSHiTGAwdXJP0ZXaQlqIlI7ZaU0EZzIW1qTWfy1+q49lLoX6HlczatzeZbh3Kzdt
	Az/Zdmdq1C5celIxD+6cR/87xwLD3UE2Egs2sPjHYZSkQMxAayhPSoiYs7X+gtnD
	UVUC70/NmMbYZgRIounxiF9NkBGIyeRw0KtFrcgiXE5V/BPt4GVyYV74UQ7gZzcq
	s+bqpw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhtscxc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 05:11:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c6a20348ceso47180615ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 22:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782105091; x=1782709891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60bpPo7bB923QwBAsdBtArQLCaqk1Or+3USoOTjJavk=;
        b=RmoOtfSrmIcPlXK+BRzre5JkjeeKbDzoCzLUhxjHV1LcFl7FElFlD7PgBU5mAojR40
         RQ2j3Yea2DV+u7+QwUm8bZHFjBZZrAtkOokMwGF4t0kw56tcjIywADWu/dapxhmM9bSv
         BzvdMwZwaeSRSe1+bGeHuMz6ZOKa1591IYexLucBrR42sdhvO44YNfConkKHLsT6C+9v
         cNiCzatXiQr3CGmeIk40dj2yaAQd/0e/mjuotn21yl5EHTm9WnVbyHj/2GaRZR+n31F+
         zkD+C56m1wt/1B2J9d/JhnRW+89d82QIGMWpKqbjpJ2QywaNNpH4V9uSZLC8rs7eB4Xa
         2ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782105091; x=1782709891;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60bpPo7bB923QwBAsdBtArQLCaqk1Or+3USoOTjJavk=;
        b=ICYT4K4J52Tvbg+L23j15E5lb2vpJt3OHgZjOmlgTkNh3RU1NTVI2zxGFF44MFA0IG
         +uGF8yfY0eJKZ/L6pGwII7F5xI/Gg5aMkVkmm90dADNS34pD8l/VfJLPNJ90wVjU+aCo
         HjhBLgGVEp/ueUWvvcCRdT3q4+OOsN1XjmRuOrJxeGkhb+veE3LOogXFfbDihi0LyMVd
         OkthMubaZYFuA3SWzZDWZx71SMVG8hP2st7B5GHKjBZ/Pa/FFpMA//ee9t5d/lHBjmtk
         bgqoCF7OtUlqUN1HZm9YldP0f6zjIb6e88551jw3bVo213LWcbfBsAfNLRZ+PpBN6XuS
         if8A==
X-Forwarded-Encrypted: i=1; AHgh+RoJ5y3hvrcyvfPsq//FyqV1r+23XvgDlJoTDwb9haRfHdxrPyfj8Vp/D7w0eH8ywTDwbQDFjtNXpFAAbaoi0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTI+CPXubr1MBiI5f719b8y0iwwoh3lgENRKpsve683aKxAfN
	f5tXREkfBzyEFj44QeMTAMwrDN92mCJOT8aoK+OzjjfpK/XVH96MZfUbM8+xPodcsWwM87yewIO
	1mVCLEQkRo6a30DQZ2PnBU6vFrqANM1O8O6QonzsPQS9GQE3BpWcpQUugo0X2257HSjBcxA==
X-Gm-Gg: AfdE7cnLfWoVOuQayOZ9iC6uMXse3Kzz6EX27qxW6mN7/+e5d8AXQTOjo6a2tgA9BfU
	Ev7aiCUhwSHZuvRjsnSsgS6XWjPIu02/L0vqE+1ZEmKsdSgTF8cT9Ex2XwbiAccIU0AaEuEyUt7
	OlcGN1PIKz/qJCc3n5+e7+0fXYmPwrBqDM31+RJ20EIMeB+MSxU7jF699ePHAkUK+SxJWr77V5Q
	dWLXtVeyDbfXqHqEbY5r5xW3vARRIYd3sETrdJBRJSt1ErmWxT0pFnlO75qSG1InUBvcBllavd3
	QsHHmKglPMDOpuCPLjG6TtMTUYrYwNkws6JZQK0PgMh+5QKMTeqpr9iUm8UhHrmkmL+mWclyxQs
	RJNjHibBIsB8ww6tZDR7JCFvnEKwNO+pe808iw8Z9GfOnEYxIMV0=
X-Received: by 2002:a17:902:f68e:b0:2c2:9a1e:6099 with SMTP id d9443c01a7336-2c718f64b9amr133429525ad.23.1782105091063;
        Sun, 21 Jun 2026 22:11:31 -0700 (PDT)
X-Received: by 2002:a17:902:f68e:b0:2c2:9a1e:6099 with SMTP id d9443c01a7336-2c718f64b9amr133429235ad.23.1782105090607;
        Sun, 21 Jun 2026 22:11:30 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436aff98sm63304345ad.3.2026.06.21.22.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 22:11:30 -0700 (PDT)
Message-ID: <106a3e99-eebd-4c12-9677-11979a92c268@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:41:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix survey indexing across bands
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R
 <quic_srirrama@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20260617-ath12-survey-band-fix-v1-1-e7d9555bb478@collabora.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617-ath12-survey-band-fix-v1-1-e7d9555bb478@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m_KtLSVGMiU-AwlZ9GLgqJsG861FlsiS
X-Proofpoint-ORIG-GUID: m_KtLSVGMiU-AwlZ9GLgqJsG861FlsiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA0NyBTYWx0ZWRfX6lOHWdfVwHOa
 5FwganEiLJrVYSgOdUQdiv2osXjUUpEGlkBgKdgJRPgs3IQ/xM8RbRIXt/X9zslFBux/2v5FcWZ
 8uCwMLinQnpT+zhYsiRqKCQmWXapqi3JNgmYmFy1dIp+OoxPzVGIQfhqKrUuKldIL3lcXqlKUgA
 o6dy7EEoynkFJ3KY+anH6C9SWmSu27+uI0yYrY8qYGMPiBFRh52+lwiW9HNV0M5ASqPYBztApdn
 74MJaPFpuh7C4F1sUj9+wzQpvS6tqelPShhW1q1v2RF0Sbay6F6fxAI6viuIoiedvbFm6raKcoY
 9mR67yatw2M/ARfMSShFO1KoJhn0obD2a520UZdCZDJ1GJ9RtxSwxrflM6dA74HJCtUfWmhy+oP
 pon8/IiTAfvOJT1gujATSgACkNwqmsihgOueUqE3TO2mdpg7gPtNMQfM6j+vPETC8kmMrQmkOF4
 rDagIj7b8WHDCqpwOqQ==
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a38c403 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=Se1BA6vDASlMqV_I0t4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA0NyBTYWx0ZWRfX/MMoa5s8ibTJ
 xVHC/4oERzXai/5t4hiwpH2n/xH4LeMO3ovLY/YQHVhWytowVEefXSfyOqRYNyF6v9uX+t8Ac1u
 XKIBEGBO9VjuCjHnsfll6sXwIFnx4YQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220047
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37958-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:matthew.leach@collabora.com,m:jjohnson@kernel.org,m:quic_vthiagar@quicinc.com,m:quic_bqiang@quicinc.com,m:quic_rgnanase@quicinc.com,m:quic_periyasa@quicinc.com,m:kvalo@kernel.org,m:quic_pradeepc@quicinc.com,m:quic_ppranees@quicinc.com,m:quic_srirrama@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kernel@collabora.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1DF46ACA9E

On 6/17/2026 3:48 PM, Matthew Leach wrote:
> When running 'iw dev wlan0 survey dump' the values for the channel busy
> time have the same sequence across bands. This is caused by indexing
> into the ath12k survey array using a band-local index rather than the
> global index passed by mac80211. This results in surveys for 5 GHz and 6
> GHz channels returning values from 2.4 GHz slots, making the survey
> unusable on those bands.
> 
> Fix by indexing into ar->survey[] using the original index passed by
> mac80211.
> 
> Band busy-times Before this fix:
> 
> 2.4 GHz: 9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 5 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 6 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 
> After this fix, times are independent:
> 
> 2.4 GHz: 23, 5,  5,  12, 2,   12,  26,  5,   3,  1,  27
> 5 GHz:   30, 40, 29, 27, 118, 118, 112, 120, 11, 11, 11
> 6 GHz:   1,  0,  0,  0,  0,   0,   0,   0,   0,  0,  1
> 
> Tested-on: wcn7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")


The Fixes: tag is probably too broad,

4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single 
wiphy") changed ath12k_mac_op_get_survey() for single-wiphy handling and 
moved survey lookup after band index adjustment.


> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2cff9485c95a..9474d7e70823 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -13351,6 +13351,7 @@ int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>   	struct ath12k *ar;
>   	struct ieee80211_supported_band *sband;
>   	struct survey_info *ar_survey;
> +	int survey_index = idx;
>   
>   	lockdep_assert_wiphy(hw->wiphy);
>   
> @@ -13385,7 +13386,7 @@ int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>   		return -ENOENT;
>   	}
>   
> -	ar_survey = &ar->survey[idx];
> +	ar_survey = &ar->survey[survey_index];


There is an existing discussion on similar lines, see [1].

This could break survey dump on multi-radio/single-wiphy setups, for 
example split-radio QCN9274 configurations.

I would suggest to move the survey results from ar to ath12k_hw, since 
not all bands in ar->survey[] are effectively utilized for a multi‑radio 
wiphy. In that model, this patch's approach of preserving the original 
idx would make sense, and freq_to_idx() should also stop skipping bands 
based on ar->mac.sbands[] so that WMI population uses the same global index.

  -        if (!ar->mac.sbands[band].channels)
  -            continue;


[1] https://lore.kernel.org/linux-wireless/aYtRBg498h_aLPBK@pilgrim/

--
Ramesh

