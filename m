Return-Path: <linux-wireless+bounces-38109-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QzCKKDwHPmoj+wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38109-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:59:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F413C6CA342
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cF4w6Nfe;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gL6479VJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38109-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38109-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5F30302659D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 04:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D5149C6F;
	Fri, 26 Jun 2026 04:59:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AA3164A9
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 04:59:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449978; cv=none; b=VY72Smg1csxwBwy7r5rniEJib3Dyu0HyXqxcqBqyMVF+siHqgMpGcCDYuCXzYeqexqDYq6+cMpfpol+xH+cBgeEXZ3fOYK83bCRM8U1uztq+k3fbupclOCL77ud0qUhx+s5NwRXtJPPvw8OnA9qUA/ICmC6efFPTNIHIKdP55PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449978; c=relaxed/simple;
	bh=YsU5Tnzwr7xADGIBn1mIj69bwLLAYb01j537lIbbm3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De97VlTHzzN1N73c74ER9FiIME7xbf2ZloMrsAXpT7yuvsjTwKbuMRM/dXSlutzsg31VTdt0JEFVZ13VwwaMiwHfUJjpiFz+k3iF5YgJGUh+a1hrUeBQpqSNS94WVJuhud082njy99SEdl/LBML/DzGLUSflH1hHY1IJbN4Qp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cF4w6Nfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gL6479VJ; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2iodM4181766
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 04:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d4x12dkjL0wb12q5vpEWaaoCWW/6hMb2TMPQtPP0YbY=; b=cF4w6Nfe072Ul/bv
	QvQlJn12xq9nCoXutUtMNTp7NlOEVZzJMt5kesahR2PsmwD1R2WHohVT5T7YhFL/
	/PeZBX0gCyeGiHY29pak5/Pfuj+NsulAhlKuW/vpIPwS5PeFaDqz0ttD2JX0P5Yd
	9dOsHZFN6vt7SwraMAk1w7wmj2ILOgefyKIoJViDjfEPWFhB8CamrcDXAmSJ3TVw
	LCBouEzvWV1KNkskznBsLPTINyNO/xUSls5MjHASx7gWl/3ILSFjeSsRXctJvn/y
	/5e/l/bvL2Jp9TyXD0xFLWKf5IwEumAhO9eELTaVA1zibP6TEU0v40OICX4aJvz7
	WCvM2g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f17s8jsr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 04:59:35 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1370417c0bfso681884c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 21:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782449975; x=1783054775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4x12dkjL0wb12q5vpEWaaoCWW/6hMb2TMPQtPP0YbY=;
        b=gL6479VJx23ass+iXmLbDsMnrlQYgbregcV/tyL26ECvb7nb+P2PfxI0ZIMwvygaO4
         +wTwkmCBwx7mUGwAu7HEpWo6wHsIrLDK6RgF8AB/ipdEGspot03bM72uzb+3UdgswiH1
         UJ/QLYSArlLaG92e3Y9Gt2goNYkAMdPAIqpO+U7F3HxUZDjW0HA8LFvx8gixXNvp7TtP
         yZTAQo/M+YKynkC8Yw3e13rU/w0S1LxohDKJAyawdXgczTb//KDhR+6dE1zbm+DSEkCu
         lgRiYHKXpya0fV3j31PlOAU8RPyA7BfxME+sehNsaMvq3N+nUFXFnLUvpV5B5Ug0GAdZ
         E1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782449975; x=1783054775;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4x12dkjL0wb12q5vpEWaaoCWW/6hMb2TMPQtPP0YbY=;
        b=JlswnMVw+Z3dKoAL+2ksGeRC2YQuSkUayRUun8Gyby4zmIKPdBhQL2Uq3RAQ/PeGc9
         ZSP/i3kaeHG91fC7sw1BRLKdOmOdMAEWNdSzZgTrTLJDJBfa1gf4V/Duk8OZfssY+9G2
         47hohoWe+5Aw5KM8NWm48XzVcvijCsHO6wGmfuIKjkiiYPcTq/WwkaxIid/JLMJx/S3A
         VrEqQBhR28biP2ijuVaWrHwCp9uGhYoAnnwAVIqjLH6OVPZS++gXnpYH8f8URafY4kal
         cxP/fM/M9GjQhKhCXGBmiO2nk7hK04zHXPGWNPI4jRBZ0obOiN8nfk2KoEMahUqgZ8kW
         uSZg==
X-Gm-Message-State: AOJu0YxIo3upsFBcsez8I3rhbBkd/QG8Ak0hW2QBL4TffcBwDIl/aRes
	k8XrHldywMp58ICeFqAfNzYVG9NJOA3VVFJNqUtSXnTyTNy/nu0pq+5ZBDehVWopgV1VNPOGoI5
	sOJal6x113y59mFuRIfx7R0RgP49Eue2h5SSfz83NHSv3rTluMtQ8+psbxyIg9Fb9wNUKzw==
X-Gm-Gg: AfdE7cnOAo0awRcK3+DOw8pcRR40CHEYWRCFmj6tBz2I0JE6q9FHz/0Lp+dC6tnofYn
	CnYCX1kZOjLg2NUuJ0mZqMjtArYP5PgEmBdavFLzbMfIKH0yTgkDzl0KF8lCrFV8sLESZFw9jSn
	hd59K16jW36CWcK7eQhp0Rg7Sk/NuQFw4QR0dPWt8Y91wb3xm8jSi9Wo1Dicnxj30IlM9mssLdS
	VhkeygGmIIKMcR4RfPpB2/rVu4q3koLfEdJ9/LZFHGNuyrVFjUT5w58RCH/8OekokCD6UaqDifV
	OymDisHc59igL8s7er/zSrLonIuSQ7LjbfRdxO0iRqLYBQNpfXfpAj12i3RecCzkjIP8zfGyGNR
	cWAIonnxxGo/UaKMifTN/dPd2OLljUgMCYhBzdia6ZnSvosrTMYJm4pI=
X-Received: by 2002:a05:7022:f9b:b0:139:85c2:d7bc with SMTP id a92af1059eb24-139c3c1f8a7mr11542044c88.6.1782449974694;
        Thu, 25 Jun 2026 21:59:34 -0700 (PDT)
X-Received: by 2002:a05:7022:f9b:b0:139:85c2:d7bc with SMTP id a92af1059eb24-139c3c1f8a7mr11542022c88.6.1782449974098;
        Thu, 25 Jun 2026 21:59:34 -0700 (PDT)
Received: from [10.119.106.30] ([106.192.174.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6acf9sm13872852c88.6.2026.06.25.21.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 21:59:33 -0700 (PDT)
Message-ID: <6ff22e43-5f25-4568-8e81-4d29a8e7e693@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 10:29:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: avoid setting 320MHz support on
 non 6GHz band
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260623151613.72113-1-nico.escande@gmail.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623151613.72113-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uls1hGjGYQL-IwyIOEBRBf83aQ23Zi9g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDAzNyBTYWx0ZWRfXyNXf+JJ8h/+T
 3dHZeGq88NGGA5wtnqb5pttT+hWxxoQe7YwHIhsdpB9vH+i4ap+O0eLHUKZr3Iivcijm77is5FH
 zvQLF+wokcfjGvGumgNbKu0wWTzQJ34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDAzNyBTYWx0ZWRfXwsDV85cNGUgg
 HJEE7xA0/DdOCGV7ENS/oOFSAyyqqVL9QKtm10OfVho7sE7/O3+zT7R+fya40nynNEXdhVI0APy
 NJVtNref2myF3PUJtCG3lhjhS3X0wvoGYFfU4oQvfT+swSK11+86IloFzppQxeRJmGgVGyk/XJQ
 taxl8E9Hw4SzG2KpWh77sItKB34BaIbAdJxA0b1JSwuuMVJS9WKe9PlGMvZZWuv3vw5kdAoQ5mS
 0UIPifRuE+bPnL4F4hhxtSpVCqbk5AaZBmasEzfHhAkkKvSBrHyWwiaB+Q2l2zchbWs/1Rylf36
 O6SXpPNbsljfnmTrdaxobCf+/KcJ9Q2IfBOLrQXSlEb8klajyU15kuWuv2r8iS43I+ClAS/Yyth
 se9/8dfcXwTuoRylrMoX7x8/6RpaogpUl62DeSBe8larASyN0vj8rjcfxn+v38fQdzs+oVbtkEP
 Mr7He1rUwae6iHNjnsA==
X-Authority-Analysis: v=2.4 cv=GKo41ONK c=1 sm=1 tr=0 ts=6a3e0737 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=VBIsxqwor4dG7Km95D8Svg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WkRSpPLlV-rx6YGWqRUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: uls1hGjGYQL-IwyIOEBRBf83aQ23Zi9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38109-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: F413C6CA342

On 6/23/2026 8:46 PM, Nicolas Escande wrote:
> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
> related features on the 5GHz band while it should not:
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
> that band. They erroneously advertise 320MHz support too.
> 
> This should not happen as IEEE Std 802.11-2024, subclause 9.4.2.323.3 says
> we should not set the 320MHz related fields when not operating on a 6GHz
> band. For example it says about Bit 0 "Support For 320 MHz In 6 GHz"
> 
>    "Reserved if the EHT Capabilities element is indicating capabilities for
>     the 2.4 GHz or 5 GHz bands."
> 
> Fix this by clearing the related bits when converting from WMI eht phy
> capabilities to mac80211 phy capabilities, for bands other than 6GHz.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

