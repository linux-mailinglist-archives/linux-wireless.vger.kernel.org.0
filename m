Return-Path: <linux-wireless+bounces-31918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD3cMP/+k2mD+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 06:39:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C4D148D80
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 06:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D8C30125D0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A628DB52;
	Tue, 17 Feb 2026 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjANaizP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sj/LCjRY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517F28C5B1
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771306749; cv=none; b=bG5qSaA39mEwVZs4D4DE9B5WazasOOLtEDV+L3dN65dMammVNrcmzCTY3e5QkkwmAIY2Bn6o/jSRuidOhutVCkG4HKgPj3bi6Mo/c+gVpM7gmOyPAwdYJKqAFgJXLz7CVeXLXpVV9hZ4pk/OB/fQDpXiPddIrhvougkUCDuBwuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771306749; c=relaxed/simple;
	bh=RQdfzRc2RUoIaJnp45Ulq763EkXypXkPYzXXF6xYZQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7mGSH8LT9eDLA3LVSPNndw7e18YBPgs5T87ynrDXX7GDN8RbNP0vqTTyTui30Wwn4ta/nnKCSsXcDj+mv5zwAB3MLWjKSYAl/IgXCRy6puN07XJWtrkUD2tu+uhT6xV+VkpdEVNuhg2HOHPS1pJMvfBQOQkYrtDwKZMtKZkCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjANaizP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sj/LCjRY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GKDTKg597252
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 05:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1KhEwYEVHGeSfIYaTq9pN0sRx7U6U0doOq8x0/hOejE=; b=UjANaizP0KlPUoPA
	4WKv4xjn0AOpCTuWP/WPHbRGMZ6mgZSlNRM9ZhSgbuZ5Rfbxg+M21hyBKOUs5xQ4
	2AlNaF45FiozclRW1Nkj69JPzWGlbWtnVsCz7Wv4F9KvWoS1cLOgqH+ZdXskrQVo
	K/+PyWVN4t/Ja3MXHUmbuNFt2g0KNsy/vkIyPlhR350QZ7nvmCuNRcCN4cMKu7F1
	gy08mfr4fO2rfIiA1jkPBC3VuoByqkicOcUYTfeJkVj7hl+7TaBdIFRu8ybAzI4M
	dQ1EN2V1QqiPhpnKeJ05JbUtFUwNvFPYwHZRnWnLjqP50PTGOxxWVKByx8I4mzpg
	NIz+xg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca360s7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 05:39:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad60525deso199662415ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771306746; x=1771911546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KhEwYEVHGeSfIYaTq9pN0sRx7U6U0doOq8x0/hOejE=;
        b=Sj/LCjRYfArAqVm6CqDYM7HQNXeCG+/uiLHak+VW5sHvacypNERH2vOue8dOrJhFq3
         aIahCOQfKQujfDvAa0ofzseyzdHtrXLY6GtwtIt1Q/kpElXN6xk9zZJHYsQHXdyFcNT7
         3AEJ9LTKaTVWHP4emAg+HFAdmonLD9W4G0PWe4XH5e3kgg7DuvVYBsvQyyQyyGLplgBK
         /kPoqFzR9CzjtehZ10H7itnCdXTD7WTgFMcVjNhaMyysTI7+SrgTjswOQx8z/X2DVRqJ
         0jfozFupRpuvaf35CcbvuIWR5qrNrRnm6qMg9zVmlowy1vgccrAALoXkuWlxeLT8tfWW
         +GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771306746; x=1771911546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KhEwYEVHGeSfIYaTq9pN0sRx7U6U0doOq8x0/hOejE=;
        b=KGgFURt55GZo8cpisttgq0ASxSDbL5jwPJ5ST2hgVrvrmBchZu72gXSmb76B24I+PO
         zFpNAuXlgteNl/Rb/Z3SteWlZYF4InmulWi1f499W6nmeyxb62sK1KmlQYigMbZLZThV
         Jk10GK+k4Ar6NOKllGWd7M2JGq29UBXv8pRwcHN3Y198fEBZlbkvPsP8RMaqb9f/D9Kl
         wzT02HHYfBw/V2cSDIb2L9Sx4V/rESqpkfHI86zsaW0MRNi87l0nGAR5OBQKQPK0o2oq
         BLm4joQMs1mq9ptg9ACiXSAuD5dI3452DTRAkBruAcAnTnyW/qyV0H5Bwhpw8JON/ivc
         tYhg==
X-Gm-Message-State: AOJu0YxbcWPFVJTgPSxVGbS7ZD+Fy+AcqGEGIiRjVOwWWQC734P/5gQ+
	40m/Pb8wmtTQ1O3Et57iWIyvNnqt0yxhLowEWTRjf7uGwfBTJNX8Map7Vsmhomh++7/5t3Dbxfw
	6ZvRVqI88ww/O0Gi8hiZahuLn9/ROZbzR9eZBwbUWeDI5ePK6q2WgR0AJK0UFifnQvVkYGRRxtf
	BxQw==
X-Gm-Gg: AZuq6aIXtYrfDlG+lEfsgOYyiAJdgqY+2+8GHh56xRrLmUS3S4V/FHNeUjdK6v5lGct
	pnZzijcs2ffg5Z8TH0hPVEUQhKmwetEAfSF16pq992FTum5cLZomslh0W3lhIPGEvDvR74M+GXi
	zoiSIeN/3aLQblUaQHPL0FgpbXxHkDHyhdKCo5CgGBosHh6a/F3T8xOHoNS++gku/IkyyIua2UD
	MSJrzR4dc7UUeVrhS/swaoSXRxwRSy4hZJRJo8NbZXinlFoyq6OecaUiMcmxDtb6RaQsnwHaFpX
	3X0PcssptiZNCcIXzUygHzmeJ6WK94jhARkmX3ZSLiHxTCq4wzDhyN27mbCZCxuE+hfPp/3C9f4
	X59dbHGPcaj2DtoK1gB4yKJE9mf4VZWH3GpiF+FVFxvaUhMxf03KV/SYx9mGjFUw=
X-Received: by 2002:a17:903:298d:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2ab4d04cf5fmr145666385ad.40.1771306745806;
        Mon, 16 Feb 2026 21:39:05 -0800 (PST)
X-Received: by 2002:a17:903:298d:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2ab4d04cf5fmr145666205ad.40.1771306745310;
        Mon, 16 Feb 2026 21:39:05 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a743570sm90759915ad.41.2026.02.16.21.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 21:39:04 -0800 (PST)
Message-ID: <64809633-6e41-4c2a-92af-1426c5903927@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 11:09:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 2/2] wifi: mac80211_hwsim: Add UHR
 capabilities to the driver
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260212180128.257565-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20260212180128.257565-3-karthikeyan.kathirvel@oss.qualcomm.com>
 <4dcf82f8-21c1-4704-8575-7f526ce1c77f@freebox.fr>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <4dcf82f8-21c1-4704-8575-7f526ce1c77f@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NCBTYWx0ZWRfX/yG6gE04Ujtk
 wVGj/fzu2hkH5UcfUEKrfyhEbejQqIssvouSJuoOiZov9wG/fteQpTmEnCceNocRFBFl/s9LcY+
 EqEbXtlj0tZwT+sH3uxlC38kimRLJfausqfVutPiWe6/vrTq4hbTxIhdbdn10g1ceA/QlnMyn4s
 PczQukyVYoRqW6LbeRt7ouJ66kwkdUwVA6y3XI25kAHh7uj5VQ3e4eR25ehKt2Y7uhUwhkmcyX/
 CZVaDUaMAt1A29KdonBmj4ioO+TO4P1ONtZNsnO10CRTpgKLDabF+/F1hLxdudtHUtv7fnpn0oE
 evK0aOpdT2jVIzbiDjNpqMhpSo+DK4dH2+yJwMHIZKODpL/zhFCfOFMYEBgjcwsHWOWfu3iHeG5
 eczW25goGCEZYKmX2GS0ZJOvgCohbPqbo6ZI3Wa40nmPGPJHkWAletEh3WTR8sIy0vIweehauZo
 A3qmPxEgHYvTObttPjw==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=6993fefa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=3nDsj4ppMIx4tQw1i2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: c7nRArBsHVRP8vOz_1ZxFa59j385oPuE
X-Proofpoint-ORIG-GUID: c7nRArBsHVRP8vOz_1ZxFa59j385oPuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31918-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 21C4D148D80
X-Rspamd-Action: no action



On 2/13/2026 8:06 PM, Pablo MARTIN-GOMEZ wrote:
> Hello,
> On 12/02/2026 19:01, Karthikeyan Kathirvel wrote:
>> Add UHR capabilities for bringing up the interface in UHR mode.
>> This is required to validate UHR test cases.
>>
>> Signed-off-by: Karthikeyan Kathirvel 
>> <karthikeyan.kathirvel@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/virtual/mac80211_hwsim.c | 285 ++++++++++++++++++
>>   1 file changed, 285 insertions(+)
>>
>> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/ 
>> net/wireless/virtual/mac80211_hwsim.c
>> index 4d9f5f87e814..5a576bbb7688 100644
>> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
>> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
>> @@ -4478,6 +4478,49 @@ static const struct ieee80211_sband_iftype_data 
>> sband_capa_2ghz[] = {
>>               },
>>               /* PPE threshold information is not supported */
>>           },
>> +        .uhr_cap = {
>> +            .has_uhr = true,
>> +            .mac = {
>> +                .mac_cap[0] =
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
>> +                .mac_cap[1] =
>> +                    IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
>> +                .mac_cap[2] =
>> +                    IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
>> +                .mac_cap[3] =
>> +                    IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
>> +                    IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
>> +                .mac_cap[4] =
>> +                    IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
>> +                    IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
>> +                    IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
>> +            },
>> +            .phy = {
>> +                .cap =
>> +                    IEEE80211_UHR_PHY_CAP_ELR_RX |
>> +                    IEEE80211_UHR_PHY_CAP_ELR_TX,
> 
> `IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80` and 
> `IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80` are for 80MHz and lower, 
> it should include 20/40 MHz of 2.4 GHz, no?
> 
Will add it in next version
>> +            },
>> +        },
>>       },
>>       {
>>           .types_mask = BIT(NL80211_IFTYPE_AP) |
>> @@ -4586,6 +4629,50 @@ static const struct ieee80211_sband_iftype_data 
>> sband_capa_2ghz[] = {
>>               },
>>               /* PPE threshold information is not supported */
>>           },
>> +        .uhr_cap = {
>> +            .has_uhr = true,
>> +            .mac = {
>> +                .mac_cap[0] =
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
>> +                .mac_cap[1] =
>> +                    IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
>> +                .mac_cap[2] =
>> +                    IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
>> +                .mac_cap[3] =
>> +                    IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
>> +                    IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
>> +                .mac_cap[4] =
>> +                    IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
>> +                    IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
>> +                    IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
>> +            },
>> +            .phy = {
>> +                .cap =
>> +                    IEEE80211_UHR_PHY_CAP_ELR_RX |
>> +                    IEEE80211_UHR_PHY_CAP_ELR_TX,
> Same
Will add it in next version
>> +            },
>> +        },
>>       },
>>   #ifdef CONFIG_MAC80211_MESH
>>       {
>> @@ -4755,6 +4842,55 @@ static const struct ieee80211_sband_iftype_data 
>> sband_capa_5ghz[] = {
>>               },
>>               /* PPE threshold information is not supported */
>>           },
>> +        .uhr_cap = {
>> +            .has_uhr = true,
>> +            .mac = {
>> +                .mac_cap[0] =
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
>> +                .mac_cap[1] =
>> +                    IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
>> +                .mac_cap[2] =
>> +                    IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
>> +                .mac_cap[3] =
>> +                    IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
>> +                    IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
>> +                .mac_cap[4] =
>> +                    IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
>> +                    IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
>> +                    IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
>> +            },
>> +            .phy = {
>> +                .cap =
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320 |
> I'm not aware of an operating class that allows 320 MHz on 5 GHz (or 
> even a non standard use of it), 
> `IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320` and 
> `IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320` should be dropped
Agree, will remove it
>> +                    IEEE80211_UHR_PHY_CAP_ELR_RX |
>> +                    IEEE80211_UHR_PHY_CAP_ELR_TX,
>> +            },
>> +        },
>>       },
>>       {
>>           .types_mask = BIT(NL80211_IFTYPE_AP) |
>> @@ -4880,6 +5016,56 @@ static const struct ieee80211_sband_iftype_data 
>> sband_capa_5ghz[] = {
>>               },
>>               /* PPE threshold information is not supported */
>>           },
>> +        .uhr_cap = {
>> +            .has_uhr = true,
>> +            .mac = {
>> +                .mac_cap[0] =
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
>> +                .mac_cap[1] =
>> +                    IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
>> +                .mac_cap[2] =
>> +                    IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
>> +                    IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
>> +                    IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
>> +                .mac_cap[3] =
>> +                    IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
>> +                    IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
>> +                .mac_cap[4] =
>> +                    IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
>> +                    IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
>> +                    IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
>> +                    IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
>> +            },
>> +            .phy = {
>> +                .cap =
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 |
>> +                    IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320 |
> 
> Same
> 
Done
> [...]
> 
> Best regards,
> 
> Pablo MG
> 


