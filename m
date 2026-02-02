Return-Path: <linux-wireless+bounces-31474-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJxdJgLggGleCAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31474-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:33:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997ECFA1F
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415D93007E21
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6A5385ED7;
	Mon,  2 Feb 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKGjUTQX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Buj9IbSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C138551C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053628; cv=none; b=PtOF+wD2x2cjsUAknPGct4c/qeyd/MzRgkIhObddEvqNHw64BvZ1QyTta577BoVCa1fDlhSOK+AhpOJTefSgaPrThCW12u+3axgsL+q7LO5GU7YmKu25IoIHxjKoFBykAjB6D/9ByAU6In8/5MTYjghhteipBXTMCzgj5tZC7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053628; c=relaxed/simple;
	bh=A2QKL4fy2+2hJfGwggWwADu855LqhxDrKi59y8EfSGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMt7m9EJf1RTdMeCxwpL0zViUvHLHxc3NPurdMQeXPd03Nka6BIavnojuK47fLn7MSABxLUr/U9s8kKH+cBhOyTYdM269UWwfeNTPpqt1f12qt8EvUSntIISTV2o9anXLsqZ5mvhfAjoZaIVdRleVPGEo+MOLPTRAR+tUe+Frdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKGjUTQX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Buj9IbSF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AtODL3916180
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 17:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exYXSULKIXWJ7+qi6EhctYumdtAcXsMje+i6zUcMaPA=; b=KKGjUTQXuWsHnl0y
	M/9sSs2O0ZgQqcGZ15PLflqQssYhMWKnkAx51nkiNSYt1n62pxtSrmxThO0bfcI7
	wy/Nme2eNoWBjMFu4pKS++Oq7+N+dalke2rHwBMGyQUHV8ZsAALdjzMDXQq5dWid
	cYeGA29n4R4EJ488ReO5uiyqO4cdMDVMo6htTXyco3bQ3udqa3GFEpuTeZ651dHR
	/QuUSc20f4mF+uM6rktqbSs2jPvdhOFIezphrwILYMf5V+m0Q4B8Y1B+g1xL0IS9
	pDXaW+nibPAl6SVr16mjiU12oNpetLYIpfgciql96sXd8F0QXA2s1KQXX0dtfAD6
	8abBpw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tkmh6k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 17:33:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a78c094ad6so47948075ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770053623; x=1770658423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exYXSULKIXWJ7+qi6EhctYumdtAcXsMje+i6zUcMaPA=;
        b=Buj9IbSFrNWW9BJAGPILjvxVUNRmJJ9en4g4PExJfmfvAiVHzqXuTvRtSsZU/3LSIK
         SaewgIfDCPcfIfYVd0aiz9nC8NeQk60kmsAQ7NcTS84pOaawcYr8XYg3frkFjYHDTz33
         lR5z2yuGP0LUerfTLQ//o9PN912i0gdTj0swEY1GYqaymqA9QcL9D+b20SiMwDqkOS9L
         Chcc32z7MZ0yBpGg7H2nL0qhBdotYP+/ZMnnW+ADSkkLyGQuSFTCmQxFQIFUrAcyWGfB
         OHxz0ghDjcE/Mop1+QMCF56Mhl6CAuADkdm2WD9VIwbR67XvUNuQj5O+6sTE5M09Lcqa
         9Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053623; x=1770658423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exYXSULKIXWJ7+qi6EhctYumdtAcXsMje+i6zUcMaPA=;
        b=v9LLCeO4vXJUhmBaYdTCtNwp31TaRQrun4fyKG10m5SlaSWzqoRZC4quxcHFADsxGI
         F2jrVZZCoPJ8ZgVn3Fz/V6td8K/gfr6vI21j1QbOVdoH8GrRCPdsBG63BvNE+SZQDPlk
         IjyP4TS78UoT+4XHIUiqttoU1FcHTyY7AHrh+Cktq9n/w/3KWrsiJ3XtHs13qqm9wMKp
         i2TLPUZEDB2tYPR9kIU852mYhaUbfENe6u9PVl6i94ghznClhU9duACc9w5UuFs9KIrO
         mwHaQNCqZFNFEp73IAeJzEKWMtsxdUFOJSEZTQMA9G2uo5ohxb03ReGPc2I5F6ujBuuN
         uR6Q==
X-Gm-Message-State: AOJu0YyfLpYNzYtbDosIUUvXpnvb3g3EgjvWpcJEeMURczpGrNMBsIXE
	C3AApr4SkBXw8eMzo1sZRmIahsYvspJPXecOl2PreEtZiADGD9KiJ5Z3hC/85dlCMFK1gL+j9o/
	7cnzvnE65X/RERTahBu6B3rBTGwlj9qWnp5uR9BgUcBMD87EqAFjvFaAtcRP/PU4hwb/YsQ==
X-Gm-Gg: AZuq6aKd6iDLJxN+2x29fcYNbTl912s8N8oOxLA5OxqsSm5ldw7PpEmsJrwmVTrvceF
	9giItdmZBXIwiuKQORAJNXmW221XYiX5GDRpz5FVTWiPYBjqq/LZpnI8W6/dQ6GhQI7KbdPt6PF
	muu8Xb72f139MuKfsaKpohZ63KuueNIF6qd0sFme8QRMbbQJRc1BvIUk+Q5eOhMbEyyssFmr1S3
	v9XpmB3ZxJD5r/bH2mJZOkoAV9AcTF2KknehdwgBlSIcf/FSjjOj4BCRSTD2uwVozelfs9RpqgG
	osJehHsq49kFYdY6cyUmuJDOCZybiZJM4IaKO947VAu+aDmpihWAXcuzSZG0dInkTj4jlKdBgvB
	ObQfv8j51pNnytH6LbZXrtAUp86+SmRz9NPqpdvSH06bR2XRgYJ3+OInTgPfJ
X-Received: by 2002:a17:903:298f:b0:29f:cb81:8bd1 with SMTP id d9443c01a7336-2a8d81b1ceemr119991745ad.55.1770053623536;
        Mon, 02 Feb 2026 09:33:43 -0800 (PST)
X-Received: by 2002:a17:903:298f:b0:29f:cb81:8bd1 with SMTP id d9443c01a7336-2a8d81b1ceemr119991535ad.55.1770053623016;
        Mon, 02 Feb 2026 09:33:43 -0800 (PST)
Received: from [192.168.225.142] ([157.49.220.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8b47f4717sm143958335ad.18.2026.02.02.09.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:33:42 -0800 (PST)
Message-ID: <c36bd8b7-9957-42d3-b472-8dc07c6c71a6@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 23:03:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] wifi: nl80211/cfg80211: add MAC randomization
 support for PD requests
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-12-peddolla.reddy@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260130160039.2823409-12-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TaebdBQh c=1 sm=1 tr=0 ts=6980dff8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=QJnItKZWF5a8ZOS8l1mWfA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-i9gtH3diP7AeRchq2gA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 95WfV6TlOKzMUJ7dfejtD9ndjPYa5YjD
X-Proofpoint-ORIG-GUID: 95WfV6TlOKzMUJ7dfejtD9ndjPYa5YjD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzNyBTYWx0ZWRfX7PQc+0VrSw+n
 yVGJ3l8lnQPVb02QJ7hU3PJBCaw6ehK1ujvYMzRawcDAvJFg+Kz15GyJIiybxZV8wH60ttcVma3
 xP7T+G4LIG9nKfSV2Si+Tkpzev0+jwrZKoAp+D2xuBwDImsXic0ypuSsT6VOFqAK4mKTIA3gds+
 UZoYJz6Fb1uZymDiklJ3kMi35y+Zg18nIMpoBzFRply0jh/lrbZB79vxZ2IfDoQCnvfiTUbNtjz
 PIXolnTcqkkK31Ziu6E/Mp8ednYEqRc9gPWI3rQA4WtaZwXQCsoRwRodZAxTZL13/YQZlnP+SlK
 UNapOxlZFqtwvhbqe7Ltq8F9wbaEFj5DDNnCZ/ArJNe+OCmrDYc3kTYHSPjEGpGDrpoxbuUAIBb
 COe9WDv2s1mGNJ734ODS094SESgsBBxtwuLgyIJpE28rAGp587vYFhNdZgU5wo/k4t14lNkxAon
 5+FFbbmuBrOa54+lTfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020137
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31474-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1997ECFA1F
X-Rspamd-Action: no action



On 1/30/2026 9:30 PM, Peddolla Harshavardhan Reddy wrote:
> Add support for MAC address randomization in proximity detection
> (PD) requests. When enabled, the same randomized MAC address
> used for discovery and authentication phases will be used for
> the ranging measurements, maintaining privacy throughout the
> entire PD session workflow.
> 
> The implementation adds a capability flag for devices to
> advertise PD MAC randomization support and validates that
> randomization is only requested when the device supports it.
> This ensures consistent MAC address usage across all phases of
> proximity detection while preventing invalid configurations
> where randomization is requested but not supported by hardware.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
> ---
>   include/net/cfg80211.h       |  7 ++++++-
>   include/uapi/linux/nl80211.h |  5 +++++
>   net/wireless/nl80211.c       |  6 ++++++
>   net/wireless/pmsr.c          | 10 ++++++++++
>   4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 00ef211f20f1..dd45dda7e619 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5734,6 +5734,10 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
>    *	multi-peer request this will indicate if the device can act
>    *	simultaneously as initiator and a responder. Only valid if @pd_support
>    *	is set.
> + * @pd_randomize_mac_addr: flag attribute in capability indicating that MAC
> + *	address randomization is supported for PD request. if capable a mac
> + *	address used for discovery, authentication will be used for ranging too.
> + *	only valid if @pd_support is set
>    * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
>    *	operating in the ISTA role under proximity detection. Only valid if
>    *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
> @@ -5795,7 +5799,8 @@ struct cfg80211_pmsr_capabilities {
>   	u8 report_ap_tsf:1,
>   	   randomize_mac_addr:1,
>   	   pd_support:1,
> -	   pd_concurrent_ista_rsta_support:1;
> +	   pd_concurrent_ista_rsta_support:1,
> +	   pd_randomize_mac_addr:1;
>   	u32 pd_max_peer_ista_role;
>   	u32 pd_max_peer_rsta_role;
>   
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 85223b16eb84..c102a54ff335 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -7776,6 +7776,10 @@ enum nl80211_peer_measurement_peer_attrs {
>    *	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
>    *	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
>    *	max peers supported in case the request is of peer-to-peer PD type
> + * @NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR: flag attribute in capability
> + *	indicating that MAC address randomization is supported for PD request.
> + *	if capable a mac address used for discovery, authentication will be
> + *	used for ranging too. only valid if %NL80211_PMSR_ATTR_PD_SUPPORT is set
>    *
>    * @NUM_NL80211_PMSR_ATTR: internal
>    * @NL80211_PMSR_ATTR_MAX: highest attribute number
> @@ -7792,6 +7796,7 @@ enum nl80211_peer_measurement_attrs {
>   	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
>   	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
>   	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
> +	NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR,
>   
>   	/* keep last */
>   	NUM_NL80211_PMSR_ATTR,
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 6d53eb3eb78c..2909520bb949 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -414,6 +414,7 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
>   	},
>   	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_REJECT },
>   	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_REJECT },
> +	[NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR] = { .type = NLA_REJECT },
>   };
>   
>   static const struct nla_policy
> @@ -2441,6 +2442,11 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
>   		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
>   				cap->pd_max_peer_rsta_role))
>   			return -ENOBUFS;
> +
> +		if (cap->pd_randomize_mac_addr &&
> +		    nla_put_flag(msg,
> +				 NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR))
> +			return -ENOBUFS;
>   	}
>   	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
>   	if (!caps)
> diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
> index a55eb73e6938..fcd7af0c61ba 100644
> --- a/net/wireless/pmsr.c
> +++ b/net/wireless/pmsr.c
> @@ -376,6 +376,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
>   	struct cfg80211_pmsr_request *req;
>   	struct nlattr *peers, *peer;
>   	int count, rem, err, idx, pd_count, max_pd_peers;
> +	u8 use_random_mac = 0;

bool instead?

