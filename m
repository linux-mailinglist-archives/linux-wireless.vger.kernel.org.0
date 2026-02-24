Return-Path: <linux-wireless+bounces-32148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M7aGMTinWnpSQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:41:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034718AA63
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CBB330234EB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038927FD4B;
	Tue, 24 Feb 2026 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oYkfmbvz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gC5mzdoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA01E555
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954881; cv=none; b=VnqvbNgXLp6GEMcHYcrsiGM+dgWMceiNXiGcxtxUjfF3VunTpDwrelB2vRNS9Vhtnez4odsnVikPWdJFm/1Tl3VnYKIBIeC48hRlseNU0V7Doy4O1tBxuTIa+rGeFXO8W5P2k+SJCB+C6hyuqqFcFNpueykTztHuype7uQvYmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954881; c=relaxed/simple;
	bh=V6Mtq1OVGcn94fZRhHzp8QGdQ9UcJd4djKdE8zQQxUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=up3uv/7Y62HLnl5Ls58Do6uuhNZXGFJflWO0WPKg5+bC+t7GK7inOIjQbws1NEDjEPUuF0sEOYwi5H6xsE9NXwvA5K+DjWPl5JcTFHvUgWkjJe9YYu75ZCgs0xWo4LlDP/jqo4CgcnIkG0FQT2NHpG20+YedQsH4Mvd4b/w6Xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oYkfmbvz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gC5mzdoT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFL0l2560017
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yBDF/UnIDin6BtUGNdzYw6S/Woupvn+QJ7Fmi17LgVI=; b=oYkfmbvzzd4icwsh
	rZQmSK+HFQ5RjuTggk4DhpHky2c40KQFIBNz08CfyCd0qWrlfc3/GkecNwhaOuKP
	BZ/weFraeBIKIjJoPOGxW7SHSaLb2zimH4KufmAJbZ42bTjNBxzmOFJJSOmy8RNC
	Nj/U6Yi9Id6aTvFBfwNsbOf7l2HSQK0yhrHzeGOv0G5bKUnEhW1FXOtgy0uadGi4
	tVsk14kxA9u28/vBkrIMsNC0DbdmUmnPkjib0Xqd8Co5i+xiCobjCzBKVONKAeKS
	TJ1zzGKKwS3OQ55ry4zCn0wQ4KuTXxEGat9+BNGvst3qYdbW9fkbhvi8ahJEfE4J
	UAJM5Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e3adsx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:41:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3545b891dd1so34140794a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771954877; x=1772559677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBDF/UnIDin6BtUGNdzYw6S/Woupvn+QJ7Fmi17LgVI=;
        b=gC5mzdoTU1Q8DvJHDep8aGtHshsQstVhqSG7x/Xp99Yy7kq4sYbA+d07d8FK50xAEV
         Z8WsvLkqkiec/UPLSU95I5UCRqFMk7ZtzryvYz/zLHgf3hnUENvgUNO27163nadHb/X1
         LsDgkrh1rgTQTGTeh/HkCN/ZFGMVmFRzgfHNBSCgNfSuLJM/zT/dMt3WobSViNhHxV4q
         bJyivCd030/7uPFNCdGI7K+QIat5AxxcIiuUKBMCCsF8ybNd1jfWZXCYctAozZvj8PJa
         6D9gegzr+WGo68sdKdBya5PoCkz410ffgtMRvZySmeDJlOmTtREfVgaJN378i4v9e/YI
         2aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954877; x=1772559677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBDF/UnIDin6BtUGNdzYw6S/Woupvn+QJ7Fmi17LgVI=;
        b=KRud3HUlIqUSn0b+G4d6GhCxR3y0udR4OFszbBwTTKJ3ELZRBngZ4UkRnNzm6zdwOB
         NsayAi1rMS5E6aMWPCBqUMHWPxYjd5wdZQvurprQku7kRDSfPGXbBpkNo2QxB0ZgnzmZ
         ZL5Yc+xkFQ/J0mySog+R6unJMM+MZb4Xhhiq7tDj2aPsJZPsYazM0/Jc6M14RFImFhkn
         hLkNhbaz2Ppa6Tao3YqDTcWIi5dzh79pTBcv6nyotktTzj6MOaFDnCHZ+q1VSvlkJ1XI
         rs4XFUkkuvF9ZsqH0pw7v/A7FUJNNE8VC/JlPNnsLFI7MWbHf7d5+8YajypDOGE6nGkK
         Gqeg==
X-Forwarded-Encrypted: i=1; AJvYcCWd+0JtzglJekdjCWEHFSRltFMOPumIaUwLJ0OGTS9BXNIm3d+MIW7LEVgDcfstKQNm45KDD3Q4/ToioCEo3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwIW2QtXmG00U3HM4RdRQ4Ds+ijS7EC5RYCRidyN0bY+y3XDl
	2h50DkOONJzBjbx4bHStTPgsARGt5bQDKSbhs/FC3B3feVsHOaaCXnHty6wb7trO/VyZfD9S2fN
	LjgPtFit68HHSEfNP+S8KBXbhTzgISRtfmTUMZAmt5NI72Y/nFjEqUgjD65pJKIvKSYVFqw==
X-Gm-Gg: ATEYQzzQw6tcx1huH793Wp2jiRts+Vvfc9bHEjJ0Gh+QIOCSEZ+th4h/o1HboiSPjMg
	uaaOIiP/gBgnyMTWnyPiooHoCfadU1AITbM1XRr6iU/3GGmmNynUZOGK4NdW/rL+/WLUVhdT3Jb
	2+3D62CDXW+cecMdLljzJF7pUijV8l4eTEO1qvAZ8MySWvY+W+pdTU1X74ixzSLTRfHAHINKVff
	KeS3YkogCWL5cD+o3aljx2Mt+gU69gCpMp2gKigDE87CIV/78j7MZp/d+oFuMuUF/MwkofuBxM0
	InHQ5JM3EAD8VgUsCThZ1F/EretQcBwcPHak9bpSq2ylFiQHzkx+GSyJnhA2maadN5jFH8iX/s3
	qcbnk+h9wZrhfoVwQAMxyRRLDQX4Bl8r0PIsUVCdmwZX2VdJkusYwPVwhRH4=
X-Received: by 2002:a17:90b:2550:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-358ae8d5d3amr10180959a91.26.1771954876756;
        Tue, 24 Feb 2026 09:41:16 -0800 (PST)
X-Received: by 2002:a17:90b:2550:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-358ae8d5d3amr10180940a91.26.1771954876177;
        Tue, 24 Feb 2026 09:41:16 -0800 (PST)
Received: from [192.168.1.11] ([122.167.98.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71814f8sm10902348a12.4.2026.02.24.09.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 09:41:14 -0800 (PST)
Message-ID: <b2679df4-c8e3-43f4-81f3-8434cd9efd12@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 23:11:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/8] wifi: mac80211: change public RX API to use
 link stations
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
 <20260223133818.f2ed2b718c41.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <20260223133818.f2ed2b718c41.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UtFu9uwB c=1 sm=1 tr=0 ts=699de2bd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=3qja58XoCTMbiOcPuMMiMg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=QyXUC8HyAAAA:8 a=wMgrsyX3M-sN5H06RxAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: T4cX2yJjIrlAx40LaAJ4oEqvM5G_VxWh
X-Proofpoint-ORIG-GUID: T4cX2yJjIrlAx40LaAJ4oEqvM5G_VxWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0OSBTYWx0ZWRfX3Ypa8c5SIHp/
 mlJVWlFOQ7sZVSdsm0cz9AEivouhDiZgrXrtaGioiXg+NzEyCCEcuJhI8c6EywYItHlBgPqnBwL
 mV4nApH7JJo1MypQMStl8n3cKErckODjHTqzikFo1uvUrIcscAfVixWx1NPZ7vN6Lg6phdljnMA
 s1iwANiS4EFPLiwQa1u0fjZHoYGIwVSPqxZguCWwUYci1nVZmpIUcy1g/X49g079/5drrLhKHwS
 RXzymHIPLnhL3fzfqIEBYUpXTGqBPz+LI7hoTF/dBf40ZLcB8HOcUnkl/ggDBptdtYxOhQXAhiS
 f+HfRLvFwYUKV1OMvWvH4xHu69iWnDZz2SeoGJbD0TZV/3EmTwKuZaxG1PcAF5l88lqoM3sppxU
 6cNvVIl/AZfuFX+cFEbyW9r4bTu6OLb6BsOM91FFpkmJ/OpiFV+UqfsSuHt9VWVvhrBcn8nQaVx
 k2B6NA5O3JyV6UOsrGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32148-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0034718AA63
X-Rspamd-Action: no action



On 2/23/2026 6:08 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> If a station is passed then the link ID also needs to be known. As such,
> it is a more natural API to simply pass the link station directly rather
> than pushing the link information into the RX status.
> 
> Furthermore, having the link ID in the RX status is not actually correct
> because the link IDs are VIF specific and there may be multiple VIFs. In
> the case of a station this relationship is clear, but then one may as
> well use the link station.
> 
> This patch only changes the API and emulates the old (incorrect)
> behaviour for now. The mac80211 RX code will be updated in later
> patches.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c       |  2 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 18 +++++++--------
>   drivers/net/wireless/ath/ath12k/dp_rx.c       | 15 +++++++++----
>   drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  7 +-----
>   drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  6 ++---
>   drivers/net/wireless/mediatek/mt76/mac80211.c | 22 +++++++++++--------
>   drivers/net/wireless/realtek/rtw89/core.c     |  6 -----
>   drivers/net/wireless/virtual/mac80211_hwsim.c |  3 ---
>   include/net/mac80211.h                        | 16 ++++++++++----
>   net/mac80211/rx.c                             | 20 ++++++++++++-----
>   11 files changed, 65 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index b9e976ddcbbf..911e40178234 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2500,7 +2500,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
>   	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
>   		rx_status->flag |= RX_FLAG_8023;
>   
> -	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
> +	ieee80211_rx_napi(ar->hw, &pubsta->deflink, msdu, napi);
>   }
>   
>   static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 737287a9aa46..71f14f2e15bd 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -508,7 +508,7 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
>   	};
>   	struct ieee80211_rx_status *rx_status;
>   	struct ieee80211_radiotap_he *he = NULL;
> -	struct ieee80211_sta *pubsta = NULL;
> +	struct ieee80211_link_sta *link_pubsta = NULL;
>   	struct ath12k_dp_link_peer *peer;
>   	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
>   	struct hal_rx_desc_data rx_info;
> @@ -517,8 +517,6 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
>   	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
>   	u8 addr[ETH_ALEN] = {};
>   
> -	status->link_valid = 0;
> -
>   	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
>   	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
>   		he = skb_push(msdu, sizeof(known));
> @@ -532,12 +530,11 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
>   	spin_lock_bh(&dp->dp_lock);
>   	peer = ath12k_dp_rx_h_find_link_peer(dp_pdev, msdu, &rx_info);
>   	if (peer && peer->sta) {
> -		pubsta = peer->sta;
> -		memcpy(addr, peer->addr, ETH_ALEN);
It appears memcpy of peer address is required, this shouldn't be 
removed, right?
> -		if (pubsta->valid_links) {
> -			status->link_valid = 1;
> -			status->link_id = peer->link_id;
> -		}
> +		if (peer->sta->valid_links)
> +			link_pubsta =
> +				rcu_dereference(peer->sta->link[peer->link_id]);
> +		else
> +			link_pubsta = &peer->sta->deflink;
>   	}
>   
>   	spin_unlock_bh(&dp->dp_lock);
> @@ -583,7 +580,8 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
>   	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
>   		rx_status->flag |= RX_FLAG_8023;
>   
> -	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
> +	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), link_pubsta, msdu,
> +			  napi);
>   }
>   EXPORT_SYMBOL(ath12k_dp_mon_rx_deliver_msdu);
>   
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index a32ee9f8061a..49b161c5a878 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1329,6 +1329,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
>   	struct ath12k_dp *dp = dp_pdev->dp;
>   	struct ieee80211_rx_status *rx_status;
>   	struct ieee80211_sta *pubsta;
> +	struct ieee80211_link_sta *link_pubsta = NULL;
>   	struct ath12k_dp_peer *peer;
>   	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
>   	struct ieee80211_rx_status *status = rx_info->rx_status;
> @@ -1340,9 +1341,14 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
>   
>   	pubsta = peer ? peer->sta : NULL;
>   
> -	if (pubsta && pubsta->valid_links) {
> -		status->link_valid = 1;
> -		status->link_id = peer->hw_links[rxcb->hw_link_id];
> +	if (pubsta) {
> +		if (pubsta->valid_links) {
> +			u8 link_id = peer->hw_links[rxcb->hw_link_id];
> +			link_pubsta =
> +				rcu_dereference(pubsta->link[link_id]);
> +		} else {
> +			link_pubsta = &pubsta->deflink;
> +		}
>   	}
>   
>   	ath12k_dbg(dp->ab, ATH12K_DBG_DATA,
> @@ -1388,7 +1394,8 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
>   	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
>   		rx_status->flag |= RX_FLAG_8023;
>   
> -	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
> +	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), link_pubsta, msdu,
> +			  napi);
>   }
>   EXPORT_SYMBOL(ath12k_dp_rx_deliver_msdu);
>   
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
> index de2feeb74009..2a12ae412bfd 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
> @@ -131,7 +131,7 @@ void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
>   		return;
>   	}
>   
> -	ieee80211_rx_napi(mld->hw, link_sta->sta, skb, napi);
> +	ieee80211_rx_napi(mld->hw, link_sta, skb, napi);
>   }
>   EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_pass_packet_to_mac80211);
>   
> @@ -1765,11 +1765,6 @@ iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
>   
>   	rx_status = IEEE80211_SKB_RXCB(skb);
>   
> -	if (link_sta && sta->valid_links) {
> -		rx_status->link_valid = true;
> -		rx_status->link_id = link_sta->link_id;
> -	}
> -
>   	/* fill checksum */
>   	if (ieee80211_is_data(hdr->frame_control) &&
>   	    pkt->len_n_flags & cpu_to_le32(FH_RSCSR_RPA_EN)) {
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
> index d0c0faae0122..a83bede06487 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
> @@ -90,7 +90,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
>   				fraglen, rxb->truesize);
>   	}
>   
> -	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
> +	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
>   }
>   
>   /*
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
> index 7f0b4f5daa21..fe5a2d0a798b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>   /*
> - * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
> + * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
>    * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
>    * Copyright (C) 2015-2017 Intel Deutschland GmbH
>    */
> @@ -243,7 +243,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
>   		return;
>   	}
>   
> -	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
> +	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
>   }
>   
>   static bool iwl_mvm_used_average_energy(struct iwl_mvm *mvm,
> @@ -2528,7 +2528,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
>   	}
>   
>   	rcu_read_lock();
> -	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
> +	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
>   	rcu_read_unlock();
>   }
>   
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
> index 75772979f438..a0b887c83591 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -1232,7 +1232,7 @@ EXPORT_SYMBOL(mt76_rx_signal);
>   static void
>   mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
>   		struct ieee80211_hw **hw,
> -		struct ieee80211_sta **sta)
> +		struct ieee80211_link_sta **link_sta)
>   {
>   	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
>   	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
> @@ -1279,11 +1279,15 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
>   	       sizeof(mstat.chain_signal));
>   
>   	if (mstat.wcid) {
> -		status->link_valid = mstat.wcid->link_valid;
> -		status->link_id = mstat.wcid->link_id;
> +		struct ieee80211_sta *sta = wcid_to_sta(mstat.wcid);
> +
> +		if (mstat.wcid->link_valid)
> +			*link_sta =
> +				rcu_dereference(sta->link[mstat.wcid->link_id]);
> +		else
> +			*link_sta = &sta->deflink;
>   	}
>   
> -	*sta = wcid_to_sta(mstat.wcid);
>   	*hw = mt76_phy_hw(dev, mstat.phy_idx);
>   }
>   
> @@ -1507,7 +1511,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
>   void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
>   		      struct napi_struct *napi)
>   {
> -	struct ieee80211_sta *sta;
> +	struct ieee80211_link_sta *link_sta;
>   	struct ieee80211_hw *hw;
>   	struct sk_buff *skb, *tmp;
>   	LIST_HEAD(list);
> @@ -1518,8 +1522,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
>   
>   		mt76_check_ccmp_pn(skb);
>   		skb_shinfo(skb)->frag_list = NULL;
> -		mt76_rx_convert(dev, skb, &hw, &sta);
> -		ieee80211_rx_list(hw, sta, skb, &list);
> +		mt76_rx_convert(dev, skb, &hw, &link_sta);
> +		ieee80211_rx_list(hw, link_sta, skb, &list);
>   
>   		/* subsequent amsdu frames */
>   		while (nskb) {
> @@ -1527,8 +1531,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
>   			nskb = nskb->next;
>   			skb->next = NULL;
>   
> -			mt76_rx_convert(dev, skb, &hw, &sta);
> -			ieee80211_rx_list(hw, sta, skb, &list);
> +			mt76_rx_convert(dev, skb, &hw, &link_sta);
> +			ieee80211_rx_list(hw, link_sta, skb, &list);
>   		}
>   	}
>   	spin_unlock(&dev->rx_lock);
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index 6e77522bcd8f..f6bcf309936d 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -2953,7 +2953,6 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
>   	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
>   	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
>   	struct sk_buff *skb = iter_data->skb;
> -	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>   	struct rtw89_rx_phy_ppdu *phy_ppdu = iter_data->phy_ppdu;
>   	bool is_mld = ieee80211_vif_is_mld(vif);
> @@ -2988,11 +2987,6 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
>   	if (!ether_addr_equal(target_bssid, bssid))
>   		goto out;
>   
> -	if (is_mld) {
> -		rx_status->link_valid = true;
> -		rx_status->link_id = rtwvif_link->link_id;
> -	}
> -
>   	if (ieee80211_is_beacon(hdr->frame_control)) {
>   		if (vif->type == NL80211_IFTYPE_STATION &&
>   		    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index 4d9f5f87e814..7d529aa129f8 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -1755,9 +1755,6 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
>   				sp->active_links_rx &= ~BIT(link_id);
>   			else
>   				sp->active_links_rx |= BIT(link_id);
> -
> -			rx_status->link_valid = true;
> -			rx_status->link_id = link_id;
>   		}
>   		rcu_read_unlock();
>   	}
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 7f9d96939a4e..4d9dbd35369b 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -5207,14 +5207,18 @@ void ieee80211_restart_hw(struct ieee80211_hw *hw);
>    * mixed for a single hardware. Must not run concurrently with
>    * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
>    *
> + * For data frames, when hardware has done address translation, a link station
> + * has to be provided and the frequency information may be skipped.
> + *
>    * This function must be called with BHs disabled and RCU read lock
>    *
>    * @hw: the hardware this frame came in on
> - * @sta: the station the frame was received from, or %NULL
> + * @link_sta: the link station the data frame was received from, or %NULL
>    * @skb: the buffer to receive, owned by mac80211 after this call
>    * @list: the destination list
>    */
> -void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
> +void ieee80211_rx_list(struct ieee80211_hw *hw,
> +		       struct ieee80211_link_sta *link_sta,
>   		       struct sk_buff *skb, struct list_head *list);
>   
>   /**
> @@ -5232,14 +5236,18 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
>    * mixed for a single hardware. Must not run concurrently with
>    * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
>    *
> + * For data frames, when hardware has done address translation, a link station
> + * has to be provided and the frequency information may be skipped.
> + *
>    * This function must be called with BHs disabled.
>    *
>    * @hw: the hardware this frame came in on
> - * @sta: the station the frame was received from, or %NULL
> + * @link_sta: the link station the data frame was received from, or %NULL
>    * @skb: the buffer to receive, owned by mac80211 after this call
>    * @napi: the NAPI context
>    */
> -void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
> +void ieee80211_rx_napi(struct ieee80211_hw *hw,
> +		       struct ieee80211_link_sta *link_sta,
>   		       struct sk_buff *skb, struct napi_struct *napi);
>   
>   /**
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 11d6c56c9d7e..4098f63ec824 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -5432,7 +5432,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>    * This is the receive path handler. It is called by a low level driver when an
>    * 802.11 MPDU is received from the hardware.
>    */
> -void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
> +void ieee80211_rx_list(struct ieee80211_hw *hw,
> +		       struct ieee80211_link_sta *link_pubsta,
>   		       struct sk_buff *skb, struct list_head *list)
>   {
>   	struct ieee80211_local *local = hw_to_local(hw);
> @@ -5440,6 +5441,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>   	struct ieee80211_supported_band *sband;
>   	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> +	struct ieee80211_sta *pubsta;
>   
>   	WARN_ON_ONCE(softirq_count() == 0);
>   
> @@ -5562,8 +5564,15 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>   		}
>   	}
>   
> -	if (WARN_ON_ONCE(status->link_id >= IEEE80211_LINK_UNSPECIFIED))
> -		goto drop;
> +	/* FIXME: Emulate the old driver behaviour for now */
> +	if (link_pubsta) {
> +		status->link_valid = 1;
> +		status->link_id = link_pubsta->link_id;
> +		pubsta = link_pubsta->sta;
> +	} else {
> +		status->link_valid = 0;
> +		pubsta = NULL;
> +	}
>   
>   	status->rx_flags = 0;
>   
> @@ -5595,7 +5604,8 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>   }
>   EXPORT_SYMBOL(ieee80211_rx_list);
>   
> -void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
> +void ieee80211_rx_napi(struct ieee80211_hw *hw,
> +		       struct ieee80211_link_sta *link_pubsta,
>   		       struct sk_buff *skb, struct napi_struct *napi)
>   {
>   	struct sk_buff *tmp;
> @@ -5608,7 +5618,7 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>   	 * receive processing
>   	 */
>   	rcu_read_lock();
> -	ieee80211_rx_list(hw, pubsta, skb, &list);
> +	ieee80211_rx_list(hw, link_pubsta, skb, &list);
>   	rcu_read_unlock();
>   
>   	if (!napi) {


