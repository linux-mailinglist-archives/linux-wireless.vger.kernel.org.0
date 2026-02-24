Return-Path: <linux-wireless+bounces-32149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAYBBKzjnWnpSQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:45:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89018AB04
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04F903012B59
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA55227BB5;
	Tue, 24 Feb 2026 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AF3CIrlJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H99f5GVU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAE1A9FAB
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955114; cv=none; b=Ky8+tRtuENq5rpI9QGXOPMmp/DuB9bur8LOej1rkDsYeRoqzhzFHj/KplZYpqUSiYDB5v4lsdEetuGIT3ccJmwKR/h6UYUiNZSQlx00NvlceDPIQo+JjK6c9BcBIolUKO7SLIxLrPxxdeYQqUQweLMVK38wWJbsUjvqR4OHxOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955114; c=relaxed/simple;
	bh=L/Bttm1FBY63H/wuBfQnp4cHn/AtmGnjSjHZS9O25Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnNUNcBYKwSH3ctb/kp+OgAeETSaoCitfuHJm7dX2dP9ymQFbEw2jDtNkyUnV2wKMb77huOM2TXP5YftupCSfhZ6y3nAY7R0qS82rtbi/3P5qQKvbflBdZdVIqT5s6A788VCQTKzzrMKnxzoebs4rfL0h02GjMn48cZFugMe04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AF3CIrlJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H99f5GVU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OH45Ki583231
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPCItbDtBEONJNy69SneGRiRI4cCNLcki4QuEmBceVQ=; b=AF3CIrlJIV7ovpCm
	i5knySNXDIPgqtkxlbBDrw1Ur3eZfUMItYGAxRAiVQg0r2EstIkt5komgp3fEUhs
	9kuUSxl+ELjdUOVbR67ccj73y5rg8+x90LmkIDpBqosRB3UzGUqPuvq1sEAjrkIn
	XfPAZeWwxayinGSf181BeLTW/yAB/iE8UCt1gMgEjEIXQjZEorn826lfYXGJ/Nbf
	pgcrmfY66ZqbDENIjZ/pTT4rFlelWJK4+qxDeykDZJQSTuWsEMEEdwgOzlwRRJhY
	GgpWUDa/WHcEJX/gO2E8+yhYjDsQNoM02S5u/77a2kHrYQrTsy2V3UaNTjzjTXc2
	DORi7Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg2gr5pv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:45:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e1919fb7bso3529654a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771955110; x=1772559910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPCItbDtBEONJNy69SneGRiRI4cCNLcki4QuEmBceVQ=;
        b=H99f5GVU44uw9tVO6wes5c76+1i6iYrgNw7bsmWBSsVbs+WBmC5CNLNFFGgtJewGt+
         58Q8UXWBzfNNyEO9DY0AE+Fvi3i+9aO71x//69HlocIYFR3FaOm+cosQ84qz4BgGvKva
         uruEQpDSE/LDQ5DKL74mSqx/EmY9Z4aR7uzsP7V6VPrzdIqRmBkQN8RJtCPqNHBrjsIA
         y1ScEzeOmK/FpRR6K5wbr3/ZsTMOKl5eRK8VgboLBtuNSjEqvW8HLw2BcO5SR6VlG9BO
         Z46pxNOC/EBFrM+e5a+6tYujNAA3qoRRhzZQjJJ7E61oxpStxpH1MLDyMD95NLnsiGG8
         mB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955110; x=1772559910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPCItbDtBEONJNy69SneGRiRI4cCNLcki4QuEmBceVQ=;
        b=CkDEDDV40EZEFbYIO5MUNVDeKG+/l8gnTRMHi8dEJiwrv3s4eUJ5AK6a87FmUmgwex
         5R5ryx2/StcB12VtCJv9z2iRonKABBy37+NKfQz1WDsutqY7jm1XXnp+dg6OVYHR3Zg3
         gK+BrvVRDceacNPUiYhb7DJ8dPQrSEv1+HomrYtE++Dj+nlz9WakWrb1r81HI1EcDxL3
         iidY2SRG0hlAyF+bHdt4DFzmdtAHwURn9SLcnvAlBLBPrFvU5QJTE6ivY09s6z+Ng3wG
         jjG/Hgo4WS2jvex0D0Ovs+I1pGQzzfrDWG33eE1PGZVdIg498Xz/xhVSIViNWWGLYZxo
         L1rw==
X-Forwarded-Encrypted: i=1; AJvYcCVj+RAeG67rvXWsPlvqlMPLRJhhGbX1K8FDR2Vol12wHAD7khte7PwK/2nWey/WsE8AamwUwvCRj+5IgDDKUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDrU/lGvuGY4VLwFpa0YcmEmZIZ9MEFNHXtttooo7enQ+6vyG
	W0CP5lBYusBzLP9+ZVtVoltaGuVl7hFLWWKGKov5WjC6Pna2j3036dsJTSwk+uLBQAnC5df9PkE
	SPYZwb4IlOEqSLnMOdMWELaBRaX/rsBKKn35hdStUeH9Mu6bItCuao6lFiWL9yS2uE9aVcSoEoC
	exKA==
X-Gm-Gg: AZuq6aIMeEfzr9fTmm/Zka5524AkDz2ZhjSBEm4Z9Xk8VLcbcMwvHd70xbxfTKILjAL
	IsMBMpThPdsSAwI31d8H0VarRhx7I6wA6oIWGDlfX+AJ7R9xv1sTvKDBTW9Lqad4QVzgiOEa4dh
	tvjSkPGam7SDkAn7dq4/2hv+drC6tSklRB94XNzk7etOKu0eGYZ9tJYkJEQH0UG0bEeloKCSHaj
	7uxFzTkV8rRXJYvAoERdzVUIgKi9NHcp4lfUyylUsrdo8H8VJlvEZKEbJgITUgy1rBjWnjktJ1C
	NTQwDa/NxFR67JA8PqwMNoZVRSWkwtKF1ZtPnjl/mIQIjm666F/EmCsUU9JPtPB/kdUDsqgl7A9
	zUJ4hKlWRivCiu69N3CRA36qgmO8TB2VCt89IdYNEjbTdDLHF1qDnx7embeU=
X-Received: by 2002:a05:6a21:9d48:b0:38f:df47:87b7 with SMTP id adf61e73a8af0-39545ed2bffmr10597839637.21.1771955109985;
        Tue, 24 Feb 2026 09:45:09 -0800 (PST)
X-Received: by 2002:a05:6a21:9d48:b0:38f:df47:87b7 with SMTP id adf61e73a8af0-39545ed2bffmr10597804637.21.1771955109280;
        Tue, 24 Feb 2026 09:45:09 -0800 (PST)
Received: from [192.168.1.11] ([122.167.98.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7255491sm11180662a12.26.2026.02.24.09.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 09:45:08 -0800 (PST)
Message-ID: <fbacd977-ab61-4399-b70f-554abc5afc4d@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 23:15:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/8] wifi: mac80211: pass station to
 ieee80211_tx_skb_tid
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
 <20260223133818.c932d807e54e.Ib7be90db0d3712d14e7a292023ff3d922baef860@changeid>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <20260223133818.c932d807e54e.Ib7be90db0d3712d14e7a292023ff3d922baef860@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V56PKNMBoUOPMSlcjaEcWz0v4vCPOvin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE1MCBTYWx0ZWRfXzpvmFZNkuFZ7
 Co1O3oMBgcVW7g1DU5iCRu3w9t0X4HvcjbawPSS9+9aAsohO01YJP9oU934e3Hzkkm+NLtpMEgB
 Lk24lPvlHUVm+6rwAF9AND3GfmMqkB52T+O5WOh0q4hSWtad2LxKs+q6I7O7X1wzmNzMJw+lxo+
 utXYchF7V9cZb308Li4FXKe8BOwul0MKSaoC+2Zgf8xVJhbOrMOe3zlD3UaMBdQuX3QoCTMWuUZ
 dOsFMdx4wWu2K54/juq+ctnRDIYxDzN4fRXf0V+uOG8fz3bBpA7s/oIfatwYB7I25+FQ1gfT1Dl
 VNqBK6F6cZ9uty7ky0LkjzK6q/ypgLkt7oNSgpHVjhjMxzfWK3+NCpcIyh3Ya0Lyl+TW63S0niM
 ASkZDHWbxP9oljxYLkG/oIol5g9Uq5UkhkHyuJxt4ELDiz7AnN9UPYHKqpVERMXzbDHIyhqFklW
 f163JrwjW94Q/aJquRA==
X-Authority-Analysis: v=2.4 cv=ftHRpV4f c=1 sm=1 tr=0 ts=699de3a7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=3qja58XoCTMbiOcPuMMiMg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=skU_J7KqAAAA:8 a=tSMSu0TP9NhcYwYMD1EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=b6CkM2rtsW-bHoL29FmJ:22
X-Proofpoint-GUID: V56PKNMBoUOPMSlcjaEcWz0v4vCPOvin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240150
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
	TAGGED_FROM(0.00)[bounces-32149-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,intel.com:email,sourmilk.net:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 9B89018AB04
X-Rspamd-Action: no action



On 2/23/2026 6:08 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The station may be relevant for queuing and will also generally be
> resolved in some cases. However, we want to be able to prevent looking
> up the station based on the address.
> 
> Add a station parameter, which can be set to the correct station, to an
> error value to prevent station lookup or to NULL to get the old
> behaviour where the address is used to find the appropriate station.
> 
> Also disable the station lookup for ieee80211_tx_skb_tid_band already as
> it does not make any sense to find a station when doing an off-channel
> transmit.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>   net/mac80211/agg-tx.c      |  6 +++---
>   net/mac80211/ht.c          |  4 ++--
>   net/mac80211/ieee80211_i.h | 14 ++++++++------
>   net/mac80211/offchannel.c  |  2 +-
>   net/mac80211/rx.c          |  2 +-
>   net/mac80211/tdls.c        |  4 ++--
>   net/mac80211/tx.c          |  8 +++++---
>   7 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
> index d981b0fc57bf..6a5754351f08 100644
> --- a/net/mac80211/agg-tx.c
> +++ b/net/mac80211/agg-tx.c
> @@ -9,7 +9,7 @@
>    * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>    * Copyright 2007-2010, Intel Corporation
>    * Copyright(c) 2015-2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2024 Intel Corporation
> + * Copyright (C) 2018 - 2024, 2026 Intel Corporation
>    */
>   
>   #include <linux/ieee80211.h>
> @@ -97,7 +97,7 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
>   	if (sta->sta.deflink.he_cap.has_he)
>   		ieee80211_add_addbaext(skb, 0, agg_size);
>   
> -	ieee80211_tx_skb_tid(sdata, skb, tid, -1);
> +	ieee80211_tx_skb_tid(sdata, skb, NULL, tid, -1);
>   }
>   
>   void ieee80211_send_bar(struct ieee80211_vif *vif, u8 *ra, u16 tid, u16 ssn)
> @@ -126,7 +126,7 @@ void ieee80211_send_bar(struct ieee80211_vif *vif, u8 *ra, u16 tid, u16 ssn)
>   
>   	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
>   					IEEE80211_TX_CTL_REQ_TX_STATUS;
> -	ieee80211_tx_skb_tid(sdata, skb, tid, -1);
> +	ieee80211_tx_skb_tid(sdata, skb, NULL, tid, -1);
>   }
>   EXPORT_SYMBOL(ieee80211_send_bar);
>   
> diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
> index 1c82a28b03de..f98f5a9a2ebe 100644
> --- a/net/mac80211/ht.c
> +++ b/net/mac80211/ht.c
> @@ -9,7 +9,7 @@
>    * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>    * Copyright 2007-2010, Intel Corporation
>    * Copyright 2017	Intel Deutschland GmbH
> - * Copyright(c) 2020-2025 Intel Corporation
> + * Copyright(c) 2020-2026 Intel Corporation
>    */
>   
>   #include <linux/ieee80211.h>
> @@ -571,7 +571,7 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
>   	info->status_data = IEEE80211_STATUS_TYPE_SMPS |
>   			    u16_encode_bits(status_link_id << 2 | smps,
>   					    IEEE80211_STATUS_SUBDATA_MASK);
> -	ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
> +	ieee80211_tx_skb_tid(sdata, skb, NULL, 7, link_id);
>   
>   	return 0;
>   }
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index e60b814dd89e..793331c1d748 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -2393,7 +2393,8 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
>   		    struct sta_info *sta, struct sk_buff *skb);
>   
>   void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
> -				 struct sk_buff *skb, int tid, int link_id,
> +				 struct sk_buff *skb, struct sta_info *sta,
> +				 int tid, int link_id,
>   				 enum nl80211_band band);
>   
>   static inline bool ieee80211_require_encrypted_assoc(__le16 fc,
> @@ -2411,22 +2412,23 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
>   
>   static inline void
>   ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
> -			  struct sk_buff *skb, int tid,
> -			  enum nl80211_band band)
> +			  struct sk_buff *skb, int tid, enum nl80211_band band)
do we need this hunk? There’s no functional change.
>   {
>   	rcu_read_lock();
> -	__ieee80211_tx_skb_tid_band(sdata, skb, tid, -1, band);
> +	__ieee80211_tx_skb_tid_band(sdata, skb, ERR_PTR(-ENOENT),
> +				    tid, -1, band);
>   	rcu_read_unlock();
>   }
>   
>   void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
> -			  struct sk_buff *skb, int tid, int link_id);
> +			  struct sk_buff *skb, struct sta_info *sta,
> +			  int tid, int link_id);
>   
>   static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
>   				    struct sk_buff *skb)
>   {
>   	/* Send all internal mgmt frames on VO. Accordingly set TID to 7. */
> -	ieee80211_tx_skb_tid(sdata, skb, 7, -1);
> +	ieee80211_tx_skb_tid(sdata, skb, NULL, 7, -1);
>   }
>   
>   /**
> diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
> index ae82533e3c02..0a8b4c5e8c12 100644
> --- a/net/mac80211/offchannel.c
> +++ b/net/mac80211/offchannel.c
> @@ -1026,7 +1026,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   	}
>   
>   	if (!need_offchan) {
> -		ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
> +		ieee80211_tx_skb_tid(sdata, skb, NULL, 7, link_id);
>   		ret = 0;
>   		goto out_unlock;
>   	}
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index ec718b7f3e16..5109791546a7 100644
> --- a/net/mac80211/rx.c	
> +++ b/net/mac80211/rx.c
> @@ -4072,7 +4072,7 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
>   					local->hw.offchannel_tx_hw_queue;
>   		}
>   
> -		__ieee80211_tx_skb_tid_band(rx->sdata, nskb, 7, -1,
> +		__ieee80211_tx_skb_tid_band(rx->sdata, nskb, rx->sta, 7, -1,
>   					    status->band);
>   	}
>   
> diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
> index dbbfe2d6842f..39a880ab7edb 100644
> --- a/net/mac80211/tdls.c
> +++ b/net/mac80211/tdls.c
> @@ -6,7 +6,7 @@
>    * Copyright 2014, Intel Corporation
>    * Copyright 2014  Intel Mobile Communications GmbH
>    * Copyright 2015 - 2016 Intel Deutschland GmbH
> - * Copyright (C) 2019, 2021-2025 Intel Corporation
> + * Copyright (C) 2019, 2021-2026 Intel Corporation
>    */
>   
>   #include <linux/ieee80211.h>
> @@ -1067,7 +1067,7 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
>   	}
>   
>   	if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
> -		ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
> +		ieee80211_tx_skb_tid(sdata, skb, sta, 7, link_id);
>   		return 0;
>   	}
>   
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 007f5a368d41..c788d48ef365 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -6235,7 +6235,8 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *pubsta, u8 tid)
>   EXPORT_SYMBOL(ieee80211_unreserve_tid);
>   
>   void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
> -				 struct sk_buff *skb, int tid, int link_id,
> +				 struct sk_buff *skb, struct sta_info *sta,
*sta is not used anywhere in this function, do we actually need to add it?
> +				 int tid, int link_id,
>   				 enum nl80211_band band)
>   {
>   	const struct ieee80211_hdr *hdr = (void *)skb->data;
> @@ -6292,7 +6293,8 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
>   }
>   
>   void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
> -			  struct sk_buff *skb, int tid, int link_id)
> +			  struct sk_buff *skb, struct sta_info *sta,
> +			  int tid, int link_id)
>   {
>   	struct ieee80211_chanctx_conf *chanctx_conf;
>   	enum nl80211_band band;
> @@ -6317,7 +6319,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
>   		band = 0;
>   	}
>   
> -	__ieee80211_tx_skb_tid_band(sdata, skb, tid, link_id, band);
> +	__ieee80211_tx_skb_tid_band(sdata, skb, sta, tid, link_id, band);
>   	rcu_read_unlock();
>   }
>   

For the no_sta tx path, The sta lookup happens in ieee80211_tx_prepare() 
(invoked by ieee80211_tx). My understanding is that the skb still ends 
up being queued with a sta.  Is that correct?


Thanks,
Ramasamy

