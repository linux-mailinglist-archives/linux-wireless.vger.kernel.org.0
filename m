Return-Path: <linux-wireless+bounces-37844-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w6poDqIqMmo7wAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37844-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 07:03:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DB696904
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 07:03:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=J+3stysH;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UquRzYGk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37844-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37844-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737E630C8D3B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 05:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77D37A494;
	Wed, 17 Jun 2026 05:03:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD234D929
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 05:03:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781672607; cv=none; b=K4YbalvhUVfyoZzNJ646gxzlU2xvzy6eRyDnAh8dlzih2sD7CqJvj8kVqPOKKagJwVNwDZ4d65o6EyJ14gFCpTYsTA3/dZQBYYDVrdmvOjrCp1az7an9COOl7BEs72PD11KjImz3hrfbbXeOXdkkGbvVzwMsp6SLdokGnUjyCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781672607; c=relaxed/simple;
	bh=aDIEjiAIfYlGafZXoizkGOYBuWaQhMMJT7lwd1hrT8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj/ry3l1fSv8v6esmWRs0/txxCFN+M2uU1s70BO1n3P2KBWCxaSMClwv6AsRfNT3kuq4xAfWjWQP3cZtEVoVuGIBYySp9kwm43Jzgxs9M3msQ+SVrhl3GLEtvDbdbhYvkF3uuBRN/ZFP1W48zzFrT62VI8CCtBHu6X+BWvQRkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+3stysH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UquRzYGk; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLTHGN736088
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 05:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JgI+Cd0eSg5v7nwjX9kRNWHWUjEtqaXIcA4x0uTN1TY=; b=J+3stysHJ5gd8CKX
	J/jMfx8SpS/LqbunMC0hbI+Hb4E8g3sk4lQs9ggvIlqcXda/yQp7ife+e2oDepbq
	AzDrfcpq9Oz7kh/TSVmw5e4krGlsG20d26+xiu5cH3arFBjXJXGhZK31mfxrxVl7
	Eqn+VoN+TMioBOMV+P59epyAVyGCCLKD3i6rW0+trIf6vjTl/ps3xjVFq1Pqt+qj
	LZnP/LZgGsSSFMCbkReIZmCwPcAlTZ2Ntn3GUXAh26KJojHq+pNNcT8LkE9NTVL6
	/I+2EJcfn/IMyLoiXLUQqmkZKnGSyaUmsHLsgdRAGE+y3iw4E5xLeMAJIW2c0ZUA
	ZqhRqg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueeshg6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 05:03:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6c431a04fso1729675ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781672599; x=1782277399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgI+Cd0eSg5v7nwjX9kRNWHWUjEtqaXIcA4x0uTN1TY=;
        b=UquRzYGkzBPruGcsCUcTxih9FQ8Onb/x5Buz/FVY/UMw8ZR4CfdDBxr5tLyhgr+rim
         4KeyWKXTWR4QkXrpIb8Q9j2yk9WJDYVCfwmhyfXJdNuIgOK/m8PfsYDklqSlKMnH3KRM
         KmzcnEz+lzpIeljJLk5BvQjEGy1+16AOJ0GFsanrOt+QjMK67aCFnpmTFzD/dBLRNW5o
         vd3k8DzqvQ4tzx9KCGkF69ivyENAggAC823MjmMS7ZmxXQckbZlfqxkcjuV14XLGCd5x
         Pl1jVUM8IuWhNYe6QzW+mXPffusctqnTucBJiyepyjMvdMoBl9wlxroqMT3CP707H1Yr
         Q20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781672599; x=1782277399;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgI+Cd0eSg5v7nwjX9kRNWHWUjEtqaXIcA4x0uTN1TY=;
        b=F/NXuyJBQ31B0UqGXx+u+10kBMfe2mIWWG4IUKaz8+X2mTb26DabCRyQkdJMg/aRzV
         c93FTgkM55VOMwuCU/uVcDNwuROPyZa8ZsUwgQ/luCBQj6+4qvdeo9Vpx8KItAXY5gM7
         S7ln0Oa5S2lRgig+YMVFUhhLCZ7okUIWCyeCynG5RMfgW/AkYFnRdsla75Bco6LhUsZw
         Ab3KBb6aXjAbD0MgN+AQLpLs8zCcZ3Kr7SAlAL4ix5jhSNPfKIUI8742NXRfhzRbbqO7
         eYbjwGuu/MdtiFEW4yjD/ak96PEO6rRXSUFEm7EELuEevuLaBhM4Iw9iDrSa9D8FnWWm
         mD+Q==
X-Gm-Message-State: AOJu0YzR/G6qzPy6jEFDIgLxFYmhmSiQu8elp2EXb3NLtcBT3eoPF1is
	7S5lU4VUKa1cq3nPuVM8x2raFmlxvbps5qkNCGAwGUJF4o7V6u3GVmWDlGLoeUgpNs9biSdQivF
	RyiC8mF2r9p+VdQ+yqehzvYzRGM4hvPr4Yo5ZiVGQs60DtEhnGha3tiab6tOSJ1YpJV4r7Pn2Qh
	xPTw==
X-Gm-Gg: AfdE7cnrnkccKG+QKn/dgbqqOr+nM5TpO6NrOE3aH9Ob3Cn4U1hKyK/72gHDX6h/u0V
	8AA6z9FVFIHkK16cEAcpFPwaI7Ir4u0LZvwlJvXCuQk9lyNfOztRBhwDcM2I5E81cvOqF1JUUnH
	47mzO1UnQvkCLBHvjUsksM2vWCn+5GkMrRjzSpAVfktPHQuqINEwqUE4tMn3eTdJ7VUfIvPE87l
	umThcmCNU6Bqx55VYzUONmmm6RgSEl0RcE1/wC+Ay+U6DSDVXASAhE9MMQkC4GLmR+nUH7P3BtN
	x35CSQL78vCguAshKx9cQ4UicniRA+FSn7mVvwL3MPH7kxV7R6XzN359QTwkiALO1jGWqI4ttcv
	em6ghs3UyGq1qawpqRYoQ//AAua/bjt693fskAYGjGsDIC/sQH6U=
X-Received: by 2002:a17:903:1b4d:b0:2c6:9358:3ad5 with SMTP id d9443c01a7336-2c6bc20f6d4mr23015805ad.17.1781672599138;
        Tue, 16 Jun 2026 22:03:19 -0700 (PDT)
X-Received: by 2002:a17:903:1b4d:b0:2c6:9358:3ad5 with SMTP id d9443c01a7336-2c6bc20f6d4mr23015515ad.17.1781672598711;
        Tue, 16 Jun 2026 22:03:18 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43336937fsm152362095ad.72.2026.06.16.22.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 22:03:18 -0700 (PDT)
Message-ID: <3fb00a3b-2092-43d2-a8f8-9f934505dcee@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 10:33:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611084422.1511513-1-nico.escande@gmail.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611084422.1511513-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0NCBTYWx0ZWRfX59invRMv/grc
 i+ngMvTM6P1+XR6k7pf2VcOloZwMqRFhvLSe6e3n6QXV8E7zpWkIL6Ob+3kUDSBRK6j+ZWf/ice
 OOpjIkUczaAjsISwCPnKnfQpOJ2SnVOgVV5gNWAOe5yEuT/2KW6Z1zOON0HCQje3xtBqgVuUCTe
 iGvXzqO0wpxclG+wQ9wjrzczflMqI7mbU6AiTb39HK8EaQGo43pwl9uSkggCMQEJpZmOIIriAIo
 LgyQtqIUMRFyq87jNuKrno9qF1qvn2OkLRAFON6D8blULq6Cj0QvbTN/8Uy4k4RAY94QMSRk/yC
 XdgUa1KNmOen1hfyi4P6NgE51SvlvGI21TSa8Xa1EFDZllF/14GkEOOsFUVIlXsurEUf3/SVgK7
 JbVYINRSy3GKu5sJPI9kTcgcRogSg8YrJi8j8jUwttw21J9rmpXpCcVo0R5nTFR90YTGcmWNDMJ
 sI9ip2Ul4NMMHEz99MA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0NCBTYWx0ZWRfX05tJ6V5iESwI
 7K93MAGH/01Z0IlfH54+qEtqb1E01KEe+TfO+4W3OLMzW/gAqIavkYCrXPAJv5ghstPSHQjuD1E
 w0yiUDHl14LpZsQ2NbAx2/Z+dJsNMX8=
X-Proofpoint-ORIG-GUID: RsgqFejSsUD274qdXHN2ne_pGW3TKk6A
X-Proofpoint-GUID: RsgqFejSsUD274qdXHN2ne_pGW3TKk6A
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a322a98 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=0TnLR4_Wa9VIDZeikcEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37844-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nico.escande@gmail.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:nicoescande@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A33DB696904

On 6/11/2026 2:14 PM, Nicolas Escande wrote:
> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
> realated features on the 5GHz band while it should not:


s/realated/related

> 
>      Wiphy phy1
>      [...]
>          Band 2:
>      [...]
>              EHT Iftypes: managed
>      [...]
>                  EHT PHY Capabilities: (0xe2ffdbe018778000):
>                      320MHz in 6GHz Supported
>      [...]
>                      Beamformee SS (320MHz): 7
>      [...]
>                      Number Of Sounding Dimensions (320MHz): 3
>      [...]
>                  EHT MCS/NSS: (0x22222222222222222200000000):
> 
> This is also reflected in the beacons sent by a mesh interface started on
> that band. They erroneously advertise 320MHZ support too.

s/320MHZ/320MHz

> 
> This should not happen as the spec at section 9.4.2.323.3 says we should

Reword the spec citation to: IEEE Std 802.11-2024, subclause 9.4.2.323.3 ...


> not set the 320MHz related fields when not operating on a 6GHz band.
> For example it says about Bit 0 "Support For 320 MHz In 6 GHz"
> 
>    "Reserved if the EHT Capabilities element is indicating capabilities for
>     the 2.4 GHz or 5 GHz bands."
> 
> Fix this by clearing the related bits when converting from WMI eht phy
> capabilities to mac80211 phy capabilities, for bands other than 6GHz.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 

The commit log mentions wrong `iw phy` output and wrong mesh beacon
advertisement, so this appears user visible. If that is the intended bug 
being fixed, please add a Fixes tag.

> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> Changes from v1:
>    - rebased on ath-next
>    - clear all 6GHz / 320MHz related phy capabilities fields from the firmware
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 84a31b953db8..a8a4654c4f34 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5154,6 +5154,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   				       __le32 cap_info_internal)
>   {
>   	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
> +	u8 *phy_cap = (u8 *)&cap_band->eht_cap_phy_info[0];
>   	u32 support_320mhz;
>   	u8 i;
>   
> @@ -5167,8 +5168,22 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>   		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
>   
> -	if (band == NL80211_BAND_6GHZ)
> +	if (band == NL80211_BAND_6GHZ) {	
>   		cap_band->eht_cap_phy_info[0] |= support_320mhz;
> +	} else {
> +		/*
> +		 * It seems the firmware can report capabilities specific to
> +		 * 6GHz also for 5GHz, so lets explicitely clear them out.

The code comment should be less tentative, how about:

      /*
       * Firmware may report 6 GHz/320 MHz specific capabilities for
       * non-6 GHz bands, so explicitly clear them.
       */


> +		 */
> +		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> +		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
> +		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
> +		phy_cap[3] &= ~IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK;
> +		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
> +		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP;
> +		phy_cap[7] &= ~IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ;
> +		phy_cap[7] &= ~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;	;
> +	}
>   
>   	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
>   	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);


checkpatch warnings:
ERROR: trailing whitespace
#61: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5171:
+^Iif (band == NL80211_BAND_6GHZ) {^I$

WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
#66: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5176:
+                * 6GHz also for 5GHz, so lets explicitely clear them out.
                                                ^^^^^^^^^^^

WARNING: space prohibited before semicolon
#75: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5185:
+               phy_cap[7] &= 
~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;     ;

WARNING: Statements terminations use 1 semicolon
#75: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5185:
+               phy_cap[7] &= 
~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;     ;



