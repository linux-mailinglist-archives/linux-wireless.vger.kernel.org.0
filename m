Return-Path: <linux-wireless+bounces-38145-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YyBxDaUtPmrJAwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38145-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 09:43:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A26CB080
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 09:43:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XFXeJxeu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JCOKuygP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38145-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38145-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42D08300E2B1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D53E3148;
	Fri, 26 Jun 2026 07:43:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412483E1233
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 07:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459809; cv=none; b=W+X35kgnbg8/ww7+9FjjJmB8g6UCb0p3ofqLROFE0nVrhj4TDAMmi3JCyNnbqn+FBuD2xqAxsfUcMYgrB1pxR9klt9LPJ+vbOUw0k5Q6Cykeq/OEE/1w5ewCLGDs1nWTgyOfnB2B96Mx6zlsDz/SzWmNJ+h8UOegGguxw3+nZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459809; c=relaxed/simple;
	bh=WrI+okIf5QA7Q5N0oD1bQeNcjmcAnNBDX4ZScK5lraM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmFOVaxF/berf5KUMnMvQaxO1ktaK1xx/C9Y9BgJw9r0+8e+1ScNF2DA6z+hilcCNcug5TzwBIJJF1h7lTgUXSE95qxEKkxPqHEBG9iG9cgs1D1dJEXX+cj/wP9JnnFtcDb1gsgRhEUqe5Hl2bRVYH+pXnAkKjT+oElUK39Tob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XFXeJxeu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JCOKuygP; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6VhgR045724
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 07:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WMVum4Llswm97WxJGwBAdPE2BDgwQjioAQCyEqQctP8=; b=XFXeJxeuHmC2BvJ7
	5Ua1Azd92w4o42fV6cdtMUpozmb18QaRJNEAAmbuBxAgQx5uP5A2cYiAGOdYDzu+
	M6mck5c0UW0l3WB3dYGb3HcKpnNWYI1Eg+3QLlNMF2HMHptOber2BJLPPaMZsY7F
	cE7htaWHXid35Wo19GSjEInDqu0jaJ1OBJV3TVBE3hkZ94AgBUDyiLOEbQP+s3rO
	9M3YJV7tTIi+ltq7yFjuDr1zCTSMw1m5l2vg+0thllrRnIpSxf17HEOM19oNR/m+
	luHqAKaqNP/5cp/3meBrKAa0n3CYb1dN9+ghwYJ7igwysO2SRI0O3nqz6KlsXPHW
	1DRlJQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1asjaf52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 07:43:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37e16f658abso202897a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782459807; x=1783064607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMVum4Llswm97WxJGwBAdPE2BDgwQjioAQCyEqQctP8=;
        b=JCOKuygPfjbxFGvsKNNW0p/3OtHhamUuVJy/RgZdUaK+fVy820v88LcZJqQvxT5Mog
         WOD65XQgAjYmfX0EmJtXKz23TIYDChYYtkvhAV+KOgdBaz9xiJGLiCg08XyerGzvaZ9j
         AfcwGXCMI+x+pQ9lco6EsvqgXqqn1XBOzhkBu6Nh3jkELx1gLH7VKhpNsOMvxr1hM64D
         o0CcnfwyqEbrVaf+Gqk6FrfCK6NMIqxDaXeuojxgeKA/j97GHE49tG+uFVbK2p7wswJO
         GGmDBux31i2trkxbdZJqLqmhLH711CvTLAF13OS5eTmLTOC7Hm/wPqwGxHSm1AsaqijI
         jKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782459807; x=1783064607;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMVum4Llswm97WxJGwBAdPE2BDgwQjioAQCyEqQctP8=;
        b=bIBQcbzYJ/h89n1VMltwj40KeDg8y6ilDSmG1jlJJzFdoJWPQavqs8piHI3EW55d+N
         FqFsxoSKmH6rgC+vhDlv1i1m4hiaSiaXA9fygk0vLvFE7DayoGuc4MF1xFrh3YYErXaV
         Coq2O0bCiSRuyf+Um6CbsoYz0Nh1Qw9C2wYTZNy13QYsx5OyqtiKaVTOZt0RP8uRsg4o
         HXCMnodY7iLOclRXNvcDQV6elR59btfOnaWnYZLEg5sC7tPTp2HuUoAAZ1hCUMKtbHjo
         h4p+oycJtE8XAXhTCIgyfLNxc+7FdtjlJLb1RiKxhhHwJRAIBbHIvImj6t0Tlz08N3ER
         c9gg==
X-Gm-Message-State: AOJu0YwjgHQsf+Pz6H+77A8Ljwo5AiI1GK/JTA9D/++GP+xgngxlm2Z4
	D5fjIXdkZLQl3lHxxRfpXgYVk0/YTdTh7Z06gqS/t3c2YvpmnJw9eSLUieIIYjh5mm7Tzyl2yZb
	SYj0mEdr7lrTAd9lv/sxFM2IGr48FBciMehHksefidyzKtqGHQs41Dbyx3fsgG8TcAhi6+A==
X-Gm-Gg: AfdE7cn1crh6l3wu+t1zX1K4iqDziVKWrxQ2yYyz1BP7lA9ZwwMVc0g2JiXZ1jOMI50
	76ZWJr5VIzEB1dzz8j/QJdF98YMj1RpBOY/trGcirSnY7V/Bjgt56Khi3I+3KiHPKOwWiSsihmc
	3FG7NPecLYETpN0O2rKGphBFocr6XMQ8TmjpQjTngtbeECM8xfZep6H0yOqn045o9vRRg91DNeY
	+nk/mw2Fz9JW3CJW7ExxSlKsuFe1mEmI8ThRKExqBcnZgHu3Es0LH5kBie4YQWvOwDaLTVp72N2
	cgGpqXc9/AhK/X7CCWejIg6zXT7Wsr3/9wO92FEU79VGLpDWmutRc2wS90UlUpZmfMSumB7F+J7
	H7mTp5adRIVqaDfNac9WxdLFLgpPgI+7jDGLagexnQZhVG4TBGHqI97WrJsUKvCTb0zzsMvi03l
	w7ceYNGS0=
X-Received: by 2002:a17:90b:5843:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-37dfa1ce3ebmr5721120a91.9.1782459806732;
        Fri, 26 Jun 2026 00:43:26 -0700 (PDT)
X-Received: by 2002:a17:90b:5843:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-37dfa1ce3ebmr5721100a91.9.1782459806243;
        Fri, 26 Jun 2026 00:43:26 -0700 (PDT)
Received: from [10.133.33.10] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e12c9229dsm372724a91.1.2026.06.26.00.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 00:43:25 -0700 (PDT)
Message-ID: <402f57ca-5abc-4b56-b1ab-a4c1c0a4da2b@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 15:43:22 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623151613.72113-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a3e2d9f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WkRSpPLlV-rx6YGWqRUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: uusmF0TSdOfEpI_lPU49BlCFsF7404Vl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA2MCBTYWx0ZWRfX+UGaHJ4pHwfy
 W/A1C+SvoLn/6s4toPtsoqoFLFh98/fGanrm3VwgXP7/JOfieiO9eo82q+7vCuo6MYSZotx5H79
 rLVBkM/DN0CAUIdMpdsvivyj1hQz2KQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA2MCBTYWx0ZWRfX5aNZ02d7VSw7
 8VxSMVtEXNHovQnuNXrdNDSSRRkck9XuLXOF1xiyqi8TEbVUwiOBShUlu7gcmNCLW7dIPH60KW7
 UiRujy42FSOkGLXF9xA6Uw79aSWuV3V9WiWXCl51wd8Dt54RPXXdVKAgmLPNKySg3KJ71wPi4hH
 ESHaYG1S5Llw1QbZWbOdnhCwFkCybhBM+T7FQz/+ywPZf7svOafvqkMhH1VBaGMxnYxbfX7r79d
 X41SBst6CtLNuADE2DGt2vzvKaB7eN8sls3zUD+zYJVc++EgJJvfEKyyAvv4qTKp/K5CngEbIiT
 Jhkv11iyscgLbiv6Jhvv/wUvIRwUZxpGa3s+oV4F2+/hQujjHNkjIH2IN1I4hHgAh9hNdcQATRo
 KIeaL7cmCYSD5uoedsYP7hfaae/sew2lE7CaDFfGMKpyH9MnbqSdwZTfKsg+sEShETZJuzv3Hxz
 X+Mi+vtUqo1aspp5GVQ==
X-Proofpoint-GUID: uusmF0TSdOfEpI_lPU49BlCFsF7404Vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38145-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nico.escande@gmail.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:nicoescande@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C81A26CB080



On 6/23/2026 11:16 PM, Nicolas Escande wrote:
> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
> related features on the 5GHz band while it should not:
> 
>     Wiphy phy1
>     [...]
>         Band 2:
>     [...]
>             EHT Iftypes: managed
>     [...]
>                 EHT PHY Capabilities: (0xe2ffdbe018778000):
>                     320MHz in 6GHz Supported
>     [...]
>                     Beamformee SS (320MHz): 7
>     [...]
>                     Number Of Sounding Dimensions (320MHz): 3
>     [...]
>                 EHT MCS/NSS: (0x22222222222222222200000000):
> 
> This is also reflected in the beacons sent by a mesh interface started on
> that band. They erroneously advertise 320MHz support too.
> 
> This should not happen as IEEE Std 802.11-2024, subclause 9.4.2.323.3 says
> we should not set the 320MHz related fields when not operating on a 6GHz
> band. For example it says about Bit 0 "Support For 320 MHz In 6 GHz"
> 
>   "Reserved if the EHT Capabilities element is indicating capabilities for
>    the 2.4 GHz or 5 GHz bands."
> 
> Fix this by clearing the related bits when converting from WMI eht phy
> capabilities to mac80211 phy capabilities, for bands other than 6GHz.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

