Return-Path: <linux-wireless+bounces-37230-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOSVOzccHWoeVwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37230-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:44:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649C1619C25
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 630543002E09
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 05:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540503093DD;
	Mon,  1 Jun 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/LNay5o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gba2SU6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7A14A8B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292660; cv=none; b=DnXHMomAdF0Bmk1BmkX/p4qGFRaG4mF/MkUy00m4F8zk2YOgz/83tRxJIIXrEAWPHJ3yehKYfOR76gT55v0dJuQyynTZtAqnDAyN4XJwXbZKBhm44KS6da5qZ+HsAO95fyOGyxk6NBcQM9DQgnuKNsR81ER5DcQSxe4fKbIAObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292660; c=relaxed/simple;
	bh=GQ4QbSQSRn7OgrARWFkNRP5yRHmfjDZ3sdK5w41s+c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cDsaaHALshml5vENvLK/8Fu3bj4d12T45NCjCJSEjm1/5vZIhtVUVPps7FjXqUdFSOWUAdM8veJcCIY3ifg4P6INclCAbdJ7iZvkFg5CwUiEgUt+MAH1eIM3Ij3fIkWHVsBzQFeVvemEacfYgxCsEzviq1joDSxiE0+JZ/YvCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V/LNay5o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gba2SU6B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VJUGXK3838769
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 05:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+nOHUqXMH21UAQ/wBMK8ailKQ1AtigkhDLTiNU0XgYg=; b=V/LNay5oSCTnzIXT
	upTViG07kQbUtOlU6nfa0D50bzGqR3cqS+a+TMgX1gbZTwYC3jRZH3uySibHJb/T
	/PqDVMg9rasWQLfsMZwvxF/QLYgWube2KN6Uv8Y5Rz+nBROyflm93isOlpO/ZR9U
	sf2/6jeWoEm7+SGOITpDxbN39AI9Mkhcu+p5F8p6gr8WGawVD8X+jdFMdc/RjAV0
	4+xX+F1IkBji4xpquzm/ydkVSnRM9IWcHFL/LdCZgWsF2rCRzyf8d8XiGKMpF9hS
	NMwlBflXL3HQWNejKy3ak+nJ8Z9Ieii55/UP8/QepTf/IYkh4vlpDx9Vq1PtOoy1
	8E68JQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7fdx9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:44:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0532a6588so15450785ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 22:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780292656; x=1780897456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+nOHUqXMH21UAQ/wBMK8ailKQ1AtigkhDLTiNU0XgYg=;
        b=Gba2SU6BDZ/o3olwUy89T9idjeZdodKjtkIX8tApsNHdVbkC5Ps4ulaQAalCqC1dN9
         YTWg3D/wJ1EMEQO0qlDsDa1/0fq9Qejg9w+UuI80wUdF6bcjJ3gY6NUA0lzZLBQN6tS2
         4OvTvHVw9eTikt34RT+HceLY1oAttLRmkRclkp6C7qCisheKeV8Ex58duiPUSGZz8ldk
         ks5atTQAruFCNRRj2K1Zl13vefuJx79Ki99Vix9iwKTmullfGF6oLcuKVUGes0yAa1bI
         cUh+/LEEPE9UjOIkPRROhlLUIgA+WynPCakHby/TtdRWv8/D3J0acJCNoR/C2KcJ7GE7
         Ar4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292656; x=1780897456;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nOHUqXMH21UAQ/wBMK8ailKQ1AtigkhDLTiNU0XgYg=;
        b=sjegem0EH6tUdSrz0Og+P5hdK2qTAE8awmJFGgQSAE8r79ZFYUT3V4AhCeKRHBlocV
         JbsG5NAWob3N/302DxfYOtuj+3CZAEw2FzpXHf6bTpJyYTCFfYk2SVMZ8LKJi8ehtExr
         ikfI2JSQ11IgQ9+z1d6WEmRaItbrcxzbdkps+OkBepE601XubLS7FSVPkS/BvTmCcrXt
         ctMWLQpLHTmlwr1dzzFBEB/iURDZDkSC7nRFU1AOWbh2FII2OwgsaefzqoraA9NQfkf7
         rGT3vkEpD3yeyJahyO18o9c7XPQDjq2LRqI7mXLXfrsBz3DeVkiEhr6GOGhb2WULNHPU
         9a6g==
X-Forwarded-Encrypted: i=1; AFNElJ+490nBOegcHRFs/oGJpjoPv/POgM8eyeo4NL4JDNyV1QNxJs96+BJl2xuws51jBARxelY7A5ltmOUtlaAouw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6WCypdOz9PP6PF3mvMiYbwFB1lcPHBnaNHHfmDmNSemAbAZ4
	BSKSm1LId9uGdJB+X9gWudahFvzmrnp32SaeRRZH+n8yFr8RLtFbNwhEzT6e3kFxZjesOYUDOUA
	lEjX0nWZ772AXj7a+C+RwBJ4LcSedGfw4EGuTDlziugRCeMTjO8J+KyRNmzHf1D2MqoyYGA==
X-Gm-Gg: Acq92OEtiRhG+BbS3H9JVPhU52vY15gvayy1ApwDZsBMLYvTsyGSiEnjNOMrMFpxQ9I
	HlPX+qY7a3mSEMY8nSLrpwaM3QnFFrZOk/JPQlr3o+6fhUvLZeLMabRd5OwuzJQznzw/2W0tiuQ
	654HuIdfpbOXsk6Eq9KrSdbg0qvtqdaFuQS00MxgnPqg8FFRF+mX6IRTT8ZkMAJY1ms2UifP87Y
	GarD6Fp5sdbcneOazZ1kvEuzslodVRgK04DI/omks98ehMVBwB+NfDrRfjzK9BChNnoNdliuaSw
	4xk7W8Tm0c7eJWabZbic3XRDsUDnH+1GkhlVQ/FMfW+mMQh0ok289wPCrLBsJ+ElYaxq+K5yoKm
	jR8YNrMrJQKO0B5MRZpUsMcpPji5BeYyEbQG5LIMfwHi6C2Ak+zmw5WfLxCkBIxZM4Z+K9B8rrV
	gF6BZPnEh8hbDrGDXTwzxPJI3uh2sc
X-Received: by 2002:a17:903:986:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2bf367950ffmr100346085ad.8.1780292656277;
        Sun, 31 May 2026 22:44:16 -0700 (PDT)
X-Received: by 2002:a17:903:986:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2bf367950ffmr100345845ad.8.1780292655764;
        Sun, 31 May 2026 22:44:15 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3a8afsm115481975ad.73.2026.05.31.22.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:44:15 -0700 (PDT)
Message-ID: <35f9b62e-cbe5-4b3b-b68d-2f4ddfd9ac23@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 13:44:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
To: kwan1996 <laicheehou9@gmail.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20260507015336.14636-1-laicheehou9@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507015336.14636-1-laicheehou9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8oGMxUB3cpZbTHeiVnqvT3v6C_x1Jhfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA1NSBTYWx0ZWRfX/ddz/WftbVit
 nA1erJQyj9P9aF8mW+p50Yx5qg7DCt5cEaqa/Z6YC/ilJTlhk+MRFmifsuNFT6R/ppUlzPwsI45
 W4sNTib2DP0nZXa0GFZNU+F32oZ7gq6ji66CQI85MD2Ouc53v7ydxdKgwUjaRRESVVBt28SqYu8
 2XIUYyGjL7uW6TZWcTu1hdT15cBOt+3DZnZMOIH6jeq5MwULFWePT4wAWuGQcgp8CjRiN5V3mcS
 u66RlNHoNIuxG1xrrGxlZvIdTL1IDhzRVnll4nVUwOFJrbiA0t+YDiMn/N+1f+00oUlqhTyMTjS
 W9qvj8lKq5zBS6r8chRaf6hBudwwwe1BSVEy+IQtNn/L5qmy5Ew9w8kypcPYeCRNLHOqYJQvMWY
 MFBUWB2G3rHsqjrAilXrswRZ7H/xXAoLu/Kg8B0e2mdEhA6C7d8IGrTYcpzVpdemkSzWjyXJJLk
 Z1XwCYpjiVtYHZWoGPw==
X-Proofpoint-GUID: 8oGMxUB3cpZbTHeiVnqvT3v6C_x1Jhfq
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d1c31 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7u1uBgKiGmSZLVGxGAYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010055
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-37230-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 649C1619C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/7/2026 9:53 AM, kwan1996 wrote:
> From: Kwan Lai Chee Hou <laicheehou9@gmail.com>
> 
> In monitor mode, the driver incorrectly assigns the legacy rate
> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
> frames, ignoring the actual MCS value parsed from the hardware.
> 
> This causes packet analyzers (like Wireshark) to display incorrect
> MCS values (e.g., legacy base rates instead of the true MCS).
> 
> Fix this by assigning ppdu_info->mcs as the default rate_mcs
> in ath12k_dp_mon_fill_rx_rate(), and remove rate_idx assignments in 
> ath12k_dp_mon_update_radiotap() to preserve
> the previously calculated MCS values (including the HT NSS offset).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220864
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ
> 

Fixes: 5393dcb45209 ("wifi: ath12k: change the status update in the monitor Rx") ?

> Signed-off-by: Kwan Lai Chee Hou <laicheehou9@gmail.com>
> 
> ---
> v3: 
>  - Simplify rate_mcs assignment logic in ath12k_dp_mon_fill_rx_rate.
>  - remove rate_idx assignments in ath12k_dp_mon_update_radiotap to avoid overwriting the HT (802.11n) MCS calculated earlier.
>  
> v2: Fix indentation and formatting issues in v1.
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 39d1967..79347c3 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -1910,13 +1910,14 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>  	bool is_cck;
>  
>  	pkt_type = ppdu_info->preamble_type;
> -	rate_mcs = ppdu_info->rate;
> +	rate_mcs = ppdu_info->mcs;
>  	nss = ppdu_info->nss;
>  	sgi = ppdu_info->gi;
>  
>  	switch (pkt_type) {
>  	case RX_MSDU_START_PKT_TYPE_11A:
>  	case RX_MSDU_START_PKT_TYPE_11B:
> +		rate_mcs = ppdu_info->rate;
>  		is_cck = (pkt_type == RX_MSDU_START_PKT_TYPE_11B);
>  		if (rx_status->band < NUM_NL80211_BANDS) {
>  			sband = &ar->mac.sbands[rx_status->band];
> @@ -2259,13 +2260,10 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
>  		rxs->encoding = RX_ENC_HE;
>  		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he));
>  		ath12k_dp_mon_rx_update_radiotap_he(ppduinfo, ptr);
> -		rxs->rate_idx = ppduinfo->rate;
>  	} else if (ppduinfo->vht_flags) {
>  		rxs->encoding = RX_ENC_VHT;
> -		rxs->rate_idx = ppduinfo->rate;
>  	} else if (ppduinfo->ht_flags) {
>  		rxs->encoding = RX_ENC_HT;
> -		rxs->rate_idx = ppduinfo->rate;
>  	} else {
>  		rxs->encoding = RX_ENC_LEGACY;
>  		sband = &ar->mac.sbands[rxs->band];

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

