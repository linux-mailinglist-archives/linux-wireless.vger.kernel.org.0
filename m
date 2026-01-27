Return-Path: <linux-wireless+bounces-31195-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJgiO6MveGn5ogEAu9opvQ
	(envelope-from <linux-wireless+bounces-31195-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:23:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB98F855
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5510C3007AF3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 03:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8F5309EFB;
	Tue, 27 Jan 2026 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LaLpgMeS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ID17OpWq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C72FCC06
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484127; cv=none; b=o+WhB1vXgHODpzkRGoQDkJHqf7pu7+9dbXFgYvRO6xsgD/lfcO4oTZSmNn6CTPl9NIn5JjyxKxXKQ0rQtmgtqHh7Uxx5xxpveXI5nvriRopX8SWpPHXLFFnB+um1O2Elok2HK8fnGSCVRdShqjP2isORviISKTUC3C0LOGt7ZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484127; c=relaxed/simple;
	bh=J60omGT77Y75FY6vd8N/cwaJ6oJO2y8si+NTyE3dijc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCnrBwFddZawFN7Ai8y0TGj8R6faUjAaqASh//7bIuYtb6Z6N3fhoPK5AiEunCOYL+FtZXpSnELPB2YZcjcew03BzTu61cHClpevizowVHVMsFEKaYjnARjbGCjkwl/c0ppHldaoi7Qc9JvUkCIEhlm+WzcQnkar3Etw8q8P3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LaLpgMeS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ID17OpWq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgIbH3399283
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S5xXWCoWg7LQszRz0+jab1sYAUXDotCHY9l9ynoFcM8=; b=LaLpgMeS/Z0JX2yZ
	TVebAhn7Mu8oFYnTI6H6oU71VXvAWzcfMw6xCkS/kXDEEeLhXH7MzbzZtx6KypEZ
	NAzFx2TWdNydlnrM8tzu98hAGE5F4l0DTxZwaAAtX4arUsE7euPupmfObYQ9z8C/
	uXdmS49EsqpnHVGefPux629p2ztAo/7CTZBzYKNE2BZWUCY/Kyl4LoyFcWyrfOwb
	wUKfG1rrfLuxF6JSsE4JNx5cvTkLXUOq/pDMN2ZwHb0w3ilYawaTDCS2cXxTgkoe
	526tTkQx4drf3DqKD5jnSHxP4tHehl9mzUxOTq9I/VJMXKaWZBlhHJlIDQygwxAi
	MQViAA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv9h8wd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:22:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f2481ab87so4089846b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769484124; x=1770088924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5xXWCoWg7LQszRz0+jab1sYAUXDotCHY9l9ynoFcM8=;
        b=ID17OpWqjDr2F+mCeCd6hqFbCrV705Urq8glSkQHmTI6eJArBxlsqghoVk4fbYHY07
         l2mbmaXoaXORN9yyHFTiViVe+ey0Zsene9uR+9GsYtN+y8VzHrzqCoRZmn+qbt4CLtAp
         42IME+nt7SJv1du+3vnXxrmOJ+bgKT6cFiXqXanma423rn2Utsr/ntF4ZUg/f3BUYF7z
         05DQZj9SRSPjHwPBCNKE74fLPOyPgdA2w0vAFFzzB6TVVoLcMIMaQ8Ol8GTL74Z+JjZs
         LujWuDHu+KzKKYWSFM5ymED+QcFo77glNzWql/lguX9U1eoxeHgTNz3KHqVMsF3fvK3v
         422Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484124; x=1770088924;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5xXWCoWg7LQszRz0+jab1sYAUXDotCHY9l9ynoFcM8=;
        b=VPe9//poRndxvMwTCiPIh5AbMAYJ54Qmrn5FOBC6MyBnS0POeWk6VpR4Owk1x1abtU
         GUZkaQLPoHwxAzlgghWhbPd9c43YtQL9XJgrGRgTeZxBCNcpBLROyaKaKhb3KnJJQmtS
         2AXVdGQb1iif+JkGNZRsvSA48P2Yi+DBfpTJYSz4mYeUSgXs2JFKPPzdQTNkObphO66i
         mtGWRL8+JerTgi61CERef2/NXt0cIL3LrplDmJ4hu3DEIZC9xkTsxrBsnGJeBadOmxCV
         Q2QQ8soyLcG98eLTJw9DmwllGY0S3+xURTqu4IKr7bfzoZVnD5HU9i6STwKvCA7x9x38
         XnIg==
X-Gm-Message-State: AOJu0Yye/vpEWQq8W+7RThDs1ziYaGtbiIyHLdyIbeWljQGLZsJbSNy7
	bk9VRaiFhj9t0/j145yChGyrbCqNNTb9IE/eolrQ/3jAq5B+SvtiljwiZWncEtwOt0rEq7WLTa1
	WKjLjE8OpdDrDqX+anMBNpoSzhyluNmzagkbbvkLnkj9QOqPr9NB2Rm2eYCoI/6pbPjbKoA==
X-Gm-Gg: AZuq6aLzkMYeNIsmwnlaQYpL5gkaj4TM1j0+/YJFblAikcOWq7o/Y0tsItUzf+680Sg
	O2ewUIYfbNtfZY4qvJvP4BcHwvd9rxrdcrsmEwMaqkhl7BTgy+KzLJwuFHkdKJD5FlQsNWJSpyI
	QK4OaZPXyhB9Rk/trnqrOukX7+riAvMTvIEZfZ4Sq6yGkft2STNkQv2rYkp2r8X0enenWgghUqt
	DZso33NGxfsFafKXZhyXI7LmeWpf+y4oVn+LHrdj+kRMHFL2ydyCxik31319dQN//K1tZmb07eg
	+OPRCkAAJfONW2HsMPVPVZiiZmGZiN1eG0upW4X43aSZzxoqQ1s6L2EJlBlNZ+1K0Aa4w9Y502t
	0KbBJQ7zfM8jsD1dogHRomx9YSYk0MZsKJF4Q232l0LVNJ+qYIG5uQcZymg9KlWeAz4GJR1I=
X-Received: by 2002:a05:6a00:2d12:b0:81c:92ec:ccf3 with SMTP id d2e1a72fcca58-823691732a9mr465836b3a.19.1769484123673;
        Mon, 26 Jan 2026 19:22:03 -0800 (PST)
X-Received: by 2002:a05:6a00:2d12:b0:81c:92ec:ccf3 with SMTP id d2e1a72fcca58-823691732a9mr465808b3a.19.1769484123177;
        Mon, 26 Jan 2026 19:22:03 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318663addsm10500641b3a.20.2026.01.26.19.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 19:22:02 -0800 (PST)
Message-ID: <776ae681-9db7-4051-abe1-07530f87d485@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 11:22:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: Remove frequency range filtering for
 single-phy devices
To: Saikiran <bjsaikiran@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
 <20260126095244.113301-2-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260126095244.113301-2-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OYOVzxTY c=1 sm=1 tr=0 ts=69782f5c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EQzWbPYLQmh-4cZE9FEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: jd8Nc0-XJYMBqtEVGbOlm21hgEg3sjO9
X-Proofpoint-ORIG-GUID: jd8Nc0-XJYMBqtEVGbOlm21hgEg3sjO9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyNSBTYWx0ZWRfX0hi5wtiXixyR
 V1RI8YM1Kg2EFXYlgAwgivFyYl85Yk5rFx8N9sOJ/1rV0E1lwzpAwi8pHHsNhjTW7/8vLenkz4r
 TXFVJl377dxPKZXY+XL75uZqeuaO/wp7bCa1RT9u6tDAuanN8Kpww3FZYL4irBybMTrGWpln7nN
 +hsxLlOYcboG4BXyE3qIfTagrtGMvlaj1IxHCEJQlvRnWU0vSng7+LYYil4jni6JLXAKtZhZ394
 f1wMYP/ZHf6xo/pptuw63F0rNMZwMD49bizqxy3A9ZDcmVdA3QOlweK3U3t+nJ9QZw0U1kY2kkX
 UteRLp86XGwNKa/d9gF42Pil+nPYzUy+kQWbc09QCQDNtiOVXXewV0oae5H1NZkA67xP/BoSulo
 X0+Usu39XGe0x7aTFBAIcROC3AbEjkPR12qsHGdhhQI3Tkv/obTT6JEIespc241/BixvI0O++kL
 hGwkpP7tITE7prY/GHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31195-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62DB98F855
X-Rspamd-Action: no action



On 1/26/2026 5:52 PM, Saikiran wrote:
> The frequency range filtering added in commit acc152f9be20 was designed
> for split-phy devices where multiple radios with overlapping frequency
> ranges within the same band are combined into a single wiphy. Each radio
> in such setups handles only a subset of channels within a band (e.g., two
> 5GHz radios covering 5GHz-low and 5GHz-high separately).
> 
> However, this filtering breaks single-phy devices like WCN7850 that use
> a single radio to handle both 2.4GHz and 5GHz bands. On these devices,

To be accurate, WCN7850 still gets two phys in hardware, it is just in host that we treat
it as single.

> the freq_range is set to cover the entire supported spectrum, but the

exactly

> filtering logic incorrectly restricts channels, causing 5GHz to become
> completely unusable.

how? what are the actual values of freq_range when you hit the issue and how are they
calculated?

> 
> The issue manifests as:
> - All 5GHz channels filtered out during channel list updates
> - No 5GHz SSIDs visible in scans
> - Only 2.4GHz networks functional
> 
> Remove the frequency range filtering entirely and rely on the firmware
> to handle frequency restrictions based on actual hardware capabilities.
> This approach works correctly for both split-phy and single-phy devices,
> as the firmware has complete knowledge of what the hardware supports.
> 
> Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in single-wiphy")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
> index 7898f6981e5a..48c362a86524 100644
> --- a/drivers/net/wireless/ath/ath12k/reg.c
> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>  			if (bands[band]->channels[i].flags &
>  			    IEEE80211_CHAN_DISABLED)
>  				continue;
> -			/* Skip Channels that are not in current radio's range */
> -			if (bands[band]->channels[i].center_freq <
> -			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> -			    bands[band]->channels[i].center_freq >
> -			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> -				continue;
>  
>  			num_channels++;
>  		}
> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>  			if (channel->flags & IEEE80211_CHAN_DISABLED)
>  				continue;
>  
> -			/* Skip Channels that are not in current radio's range */
> -			if (bands[band]->channels[i].center_freq <
> -			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> -			    bands[band]->channels[i].center_freq >
> -			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> -				continue;
> -
>  			/* TODO: Set to true/false based on some condition? */
>  			ch->allow_ht = true;
>  			ch->allow_vht = true;


