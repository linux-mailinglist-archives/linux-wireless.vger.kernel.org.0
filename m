Return-Path: <linux-wireless+bounces-35114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE92EMLn5mkv1wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:58:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535A435A43
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D1B300F15D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B39251795;
	Tue, 21 Apr 2026 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hr/6XMls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMaNIV63"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE826AE5
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740286; cv=none; b=OQZDjcahiHmPdndhnrujzE28jVNfeN3g4M7xGDymvv0+OFphmpi7GqMCpke3ZX34FXV2KdwXw3OlFxuD3gjgvZAC3K3nVFH3vvvO4+K3qLJE1X+OlbriBnqhMPrbFar6fygEM4kPCNWi2mpl9lS6YELy+3b7e+prD2uauNGtlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740286; c=relaxed/simple;
	bh=mAp4db7soZOaZdDNXd9/pvgbaR0dh1jMmc/3WxiaWXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6ocd09H0QJtS9Q2jztnMyrG1mvNhN7eex0vPDmQ7/TQlP7grx+zt9N/+9P8L4QAjKQn1o7e0r5ykN0MBYQjrXiD9kHXyK0T/nuatAMNMpEXFeENoEPgcBgAiXPZgYCCJ04DeK9ev7Ioba0tfOT32UxqUENlzVP4I2DnnGKE6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hr/6XMls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMaNIV63; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KMgtHh1127136
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I/tQyHpTIj6gAoQkkZhhfUvw9xO+T3VL6kyfhHbNpMQ=; b=Hr/6XMlsbhqfNmj4
	8B7dAN4/ADgxz3y28fyMgmaPRzOn3fpS0SdfbJYc/uh9OtaftwZGLCOzvACt3eoE
	C9ZLZrVo9fLc+yIzW0MWQdUi/54IaTJcvrG9zw2X6/uNO22iogGsG6a9d+LLdxeh
	pYiiEK/5jRZufaCjj3rtINqNHSofp3y2H9aPEI7z7aQV4TQHmjqglIaUrlFLlqFo
	b+kCbQRcEHeYav9N09o8R5uTgfbkImeHq4DKJWZY0T0NlvVCT2KuNabYECPEU05b
	9LNios8uCyJVTtZWwmgWqaHp8sQgsBBCvJqS8gzWLqZ0r9dxqxVgC/jumQk99Q4S
	EVEOSA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnw68rkjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:58:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b461b36990so38311155ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776740283; x=1777345083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/tQyHpTIj6gAoQkkZhhfUvw9xO+T3VL6kyfhHbNpMQ=;
        b=TMaNIV63XYXMp8S6+I9cm+aEDaRjNDGMmJvJt49KQUdA7381Dg+BhTMNxYBCwZp8vt
         m5Mys0As+/u1Cw5iSAzuNyGLLXY5rw99KXyvQzuhgRNrnwfNgHTI6spe9naNweZNck8t
         2V8asOtv2FtCC1GWnVMR7FUYlO+ekKl/bjFm8geNcX3aOtswc+zdFK4KzvfOQCN0uCqG
         bwqU9hXfAbw9GXVA+hMlSDK734P6LNtsPezu2r2tzypqsPHrj2JV8QwGuT1KbUueZzNT
         tt49iFPt53iJM0hh86gDe+SJzy1AfYBa87QGrQ8Z/Wc2FIvW8Gj/FrebALU6GDH7vDRl
         YQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776740283; x=1777345083;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/tQyHpTIj6gAoQkkZhhfUvw9xO+T3VL6kyfhHbNpMQ=;
        b=BDWrI91q1uhXIzBWpLnK/bHG/voA1EFPIBgSxuB0MW+D9LgkbtE/wzMnkyAUmeKkSB
         MJcTmDUHZxYetZabskw9ld0l4YbDqsthVlAZOrJ/7M9NgUx/0iO9ddWTN9JI8rXULuzx
         qO4ESsoZcBcLul4SppKxmsRMym80cnxKw5jkbwsDd7spQECkisLSGX6pi6cvtu1jfPbm
         nnF5I62azLM5a3beMzxCxS/9cpbYgHg9mCyulCvcV3Nkm0/VCcXZE+DZONHRrztXEiYh
         F8ABjLQ1xX1awh+ln0ss1fVg5mb+xja1OvFnkhVVkZxcLk6+ps4bb3FxOn/h9gi9JA8P
         5XMw==
X-Gm-Message-State: AOJu0YxW83kTBWXSYP1ijjDRqdYpzKFb8iTKmBoKuJvjfJJaEVyJLHJR
	viNTbX722ThvBMJ0aKjJ2Vg5/BsWNKKtUW6kEs54OybTMXaFiiHZEV2uYx3QTCzCa7IfHJYJb0p
	gPP68yGwb7MMoy+E24afAno8c3hSRDHj9s9U97ZSjtKdOIbAnsP/Ko3sbYC8InWU8oeIGG0UqCt
	VYIQ==
X-Gm-Gg: AeBDietSDemvuRDLD3ibti2dnzPXsCxwvudZtmGIcnuXF8DwJICo7J+RuY6QpKnZCTF
	/3C8EZMj4HU697uT3Lps5veqvnP9yCQcKZFkHWGxvj7jCdsxi47N/gGuI+Sl+nqsXdsAghv3Nxv
	oMQArYFLt6BjgmwZxSVwxRnRjGKSABN5Zq+14VHjjfAJ/DNYTyBUkUGYo3lRWOaFmRD7eMBu7Rc
	Uins3KPpxSNbY7lByP8B/G14L1pHrYbMV2bCETYErPJaKu23kymyL71n/eHTHgLY4MuzSnscyiu
	mSX83VWaGkCOutTm2Hz8dX6ouhhwTKg8XiPGjmGch6XHbx0iiBSU14kw9L5Y7y1TOPfZ6C/9WHX
	oZNqJPUpcCbn/KQFvKA9ulAJ+LCWMqRBJlxzncID/JCEA5wVbn7rvFOcNINAV7FH6CtBUkSY/Wc
	KeDOyowd9U7uhXp4hOEzHoyM3yHw8sYA==
X-Received: by 2002:a17:902:ce0e:b0:2b4:5c20:ec7 with SMTP id d9443c01a7336-2b5f9fddaf4mr161038945ad.41.1776740282741;
        Mon, 20 Apr 2026 19:58:02 -0700 (PDT)
X-Received: by 2002:a17:902:ce0e:b0:2b4:5c20:ec7 with SMTP id d9443c01a7336-2b5f9fddaf4mr161038755ad.41.1776740282243;
        Mon, 20 Apr 2026 19:58:02 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm146196885ad.7.2026.04.20.19.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:58:01 -0700 (PDT)
Message-ID: <8dee7c0f-ab0a-4b49-9c66-e80c9c305522@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 10:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add channel 177 to the 5 GHz
 channel list
To: Yingying Tang <yintang@qti.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yingying.tang@oss.qualcomm.com
References: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jbd1Hjv4tyGAKC7R_7HX9QBR3VtI9EwY
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=69e6e7bc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=dw5P4lFgFakpHNxb41EA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyNyBTYWx0ZWRfXxvsbpt2V2YY2
 UnGVcIxIbLaO6l1Lz3sf2Bi9/1AVMNs9jAEJgT945eJzNesfE9dv0UY0Hcy8+bYOZm+yzPW4kSA
 ZF/lHTEAKTYI+SCOHY8DR0XfHc/2B0KMHBS1aU/LkEyDL0x4iNdyDMmTPe+spKyrzUg7KWXFTaW
 QfCOyEWvdkFBuGbmnsc9v4rtt6fyG5HSZwsUp+/oWRTMZTBfgCRO/UmWUZEjuPAgnomi/AWiE3s
 ORbUckHOb+s/sxw2j358Dgm79DfVIijQxKhXW2jsK7EG7QbTPet8PTMJUwoGuLgG4PLXNccUQKq
 RNikGGKauNLZDfmmhq/9j9bj2FFPAqzbuwgw2tkkrpXXxW2Ng5wC3b8B9m2b7Lqa94CoeO6Ho/R
 tvxQE3n1ztfFbICMlItQtQ5aECuqtY0g4VEILa1O+lAWFAbWu3tGlH9dcuojO+qoPsEUhMzzFbs
 1T60HCAtJc+Lwj/raQQ==
X-Proofpoint-GUID: Jbd1Hjv4tyGAKC7R_7HX9QBR3VtI9EwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210027
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35114-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5535A435A43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/15/2026 2:38 PM, Yingying Tang wrote:
> From: Yingying Tang <yingying.tang@oss.qualcomm.com>
> 
> Add support for 5 GHz channel 177 with a center frequency of 5885 MHz and
> Operating Class 125 per IEEE Std 802.11-2024 Table E-4.
> 
> Channels 169, 173, and 177 are in the 5.9 GHz band and must be disabled
> when 5.9 GHz service bit is not supported. The 5.9 GHz band is only permitted
> for WLAN operation under FCC regulations.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c   | 26 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h   |  1 +
>  4 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..17b31c969cd9 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -541,8 +541,8 @@ struct ath12k_sta {
>  #define ATH12K_MAX_5GHZ_FREQ	(ATH12K_5GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
>  #define ATH12K_MIN_6GHZ_FREQ	(ATH12K_6GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW)
>  #define ATH12K_MAX_6GHZ_FREQ	(ATH12K_6GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
> -#define ATH12K_NUM_CHANS 101
> -#define ATH12K_MAX_5GHZ_CHAN 173
> +#define ATH12K_NUM_CHANS 102
> +#define ATH12K_MAX_5GHZ_CHAN 177
>  
>  static inline bool ath12k_is_2ghz_channel_freq(u32 freq)
>  {
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index f0b4f607b845..5327a427c26c 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -17,6 +17,11 @@
>  #include "dp_mon.h"
>  #include "debugfs_htt_stats.h"
>  
> +#define ATH12K_2GHZ_MIN_CHAN_NUM 1
> +#define ATH12K_2GHZ_MAX_CHAN_NUM 14
> +#define ATH12K_5GHZ_MIN_CHAN_NUM 36
> +#define ATH12K_5GHZ_MAX_CHAN_NUM 177
> +
>  static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
>  					   struct ath12k_dp_rx_tid_rxq *rx_tid);
>  
> @@ -1284,9 +1289,11 @@ void ath12k_dp_rx_h_ppdu(struct ath12k_pdev_dp *dp_pdev,
>  	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
>  		rx_status->band = NL80211_BAND_6GHZ;
>  		rx_status->freq = center_freq;
> -	} else if (channel_num >= 1 && channel_num <= 14) {
> +	} else if (channel_num >= ATH12K_2GHZ_MIN_CHAN_NUM &&
> +		   channel_num <= ATH12K_2GHZ_MAX_CHAN_NUM) {
>  		rx_status->band = NL80211_BAND_2GHZ;
> -	} else if (channel_num >= 36 && channel_num <= 173) {
> +	} else if (channel_num >= ATH12K_5GHZ_MIN_CHAN_NUM &&
> +		   channel_num <= ATH12K_5GHZ_MAX_CHAN_NUM) {
>  		rx_status->band = NL80211_BAND_5GHZ;
>  	}
>  
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..7fb6507cebf8 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -51,6 +51,9 @@
>  	.max_power              = 30, \
>  }
>  
> +#define ATH12K_5_9_GHZ_MIN_FREQ 5845
> +#define ATH12K_5_9_GHZ_MAX_FREQ 5885
> +
>  static const struct ieee80211_channel ath12k_2ghz_channels[] = {
>  	CHAN2G(1, 2412, 0),
>  	CHAN2G(2, 2417, 0),
> @@ -96,6 +99,7 @@ static const struct ieee80211_channel ath12k_5ghz_channels[] = {
>  	CHAN5G(165, 5825, 0),
>  	CHAN5G(169, 5845, 0),
>  	CHAN5G(173, 5865, 0),
> +	CHAN5G(177, 5885, 0),
>  };
>  
>  static const struct ieee80211_channel ath12k_6ghz_channels[] = {
> @@ -13900,6 +13904,26 @@ static int ath12k_mac_update_band(struct ath12k *ar,
>  	return 0;
>  }
>  
> +static void ath12k_mac_update_5_9_ghz_ch_list(struct ath12k *ar,
> +					      struct ieee80211_supported_band *band)
> +{
> +	int i;
> +
> +	if (test_bit(WMI_TLV_SERVICE_5_9GHZ_SUPPORT,
> +		     ar->ab->wmi_ab.svc_map))
> +		return;
> +
> +	guard(spinlock_bh)(&ar->ab->base_lock);
> +	if (ar->ab->dfs_region != ATH12K_DFS_REG_FCC)
> +		return;
> +
> +	for (i = 0; i < band->n_channels; i++) {
> +		if (band->channels[i].center_freq >= ATH12K_5_9_GHZ_MIN_FREQ &&
> +		    band->channels[i].center_freq <= ATH12K_5_9_GHZ_MAX_FREQ)
> +			band->channels[i].flags |= IEEE80211_CHAN_DISABLED;
> +	}
> +}
> +
>  static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>  					   u32 supported_bands,
>  					   struct ieee80211_supported_band *bands[])
> @@ -14033,6 +14057,8 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>  			band->n_bitrates = ath12k_a_rates_size;
>  			band->bitrates = ath12k_a_rates;
>  
> +			ath12k_mac_update_5_9_ghz_ch_list(ar, band);
> +
>  			if (ab->hw_params->single_pdev_only) {
>  				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
>  				reg_cap = &ab->hal_reg_cap[phy_id];
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 5ba9b7d3a888..8fab8ddaae59 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2259,6 +2259,7 @@ enum wmi_tlv_service {
>  	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
>  	WMI_TLV_SERVICE_EXT2_MSG = 220,
>  	WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT = 244,
> +	WMI_TLV_SERVICE_5_9GHZ_SUPPORT = 247,
>  	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
>  	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
>  

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

