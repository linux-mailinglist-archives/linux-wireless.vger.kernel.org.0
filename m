Return-Path: <linux-wireless+bounces-38251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Xa0F78FQmqBywkAu9opvQ
	(envelope-from <linux-wireless+bounces-38251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:42:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A16D614C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:42:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=WKy24ugk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dFQ0Mt1y;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38251-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38251-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7465300F54D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979338B7C3;
	Mon, 29 Jun 2026 05:42:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51C38A700
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711740; cv=none; b=P51VJftHA9DWoXNoukroeRJT3vi1WQ0iEXF3FZzvLnUHSPJbVeKz22pPiwOF5+UflBhLAO061y+Ia7YxwHYncMzVmo5NXb2/pe9k6nDSbQFLaY6sBQFnD/p84c5696H3W3yzhpDurrLNCH8SBfMnCXLWaJd/naOThrzj1b7TLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711740; c=relaxed/simple;
	bh=gm1w+0nfD15SZ2Gnvk1C4+1s83FsUZlj1jdFyjmn+uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI68cLlfgtyEnjlxFQHB6f+kriPTXy6cPY6KvwHFpm7+xKvZU2jaTX6Y8P6ksFHXaDVZfEUcKAYAns9bWOnChUe2iwh2t8RHtgzp5+Fxmx/qM8SdqkjxhGLd+gC1fj90dmsCkY07Z2TP1Bg3QFV1dzknsydKSiDfltci+07tnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKy24ugk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dFQ0Mt1y; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NORd1766950
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pS8cvZxJAhKc4BMxA+98qFjlhTjbrIv3l5VR4CZyZp0=; b=WKy24ugkTSh48SGJ
	1zZpM2bCXfA5NqsU5z/07z8KtIZ2cBpUyFz/Vny21f6lMTxnQG7MH2ZBVl2BGaUa
	9CXC4KcdPeSKQXKFIboudBpsSiFSwPsQYl7qXFj6OWnh4rO/I4mmf6f1c0a7Jqt3
	A1nZYFcxNQWwq/QkOs7ZT1G5NdTNkmIXfktateWpUbG96zVSE65y+tNXx712DKEj
	2El3oSQUNkh35hLrfMRjUSMIWxMLK9r2+B5/l/AjBZdoWvzjwsm8AizvNBQkmCTc
	JidefiISKqlyL5bHVMJF2klsGPF57ePNBoReaxGCv+aVC4Gf1FIDI3YjUsxizp21
	prGlYA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a4ru0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:42:18 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137fc6f8e9fso5019680c88.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782711738; x=1783316538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pS8cvZxJAhKc4BMxA+98qFjlhTjbrIv3l5VR4CZyZp0=;
        b=dFQ0Mt1y8DOJ9mXeYCMOnrYVlKTTDwW5uHyyZTHsW0dyidvSt/ojTWhJ3n7NvzYXhw
         wsVpkLcsCs8LY5HhDYDnUUHqN1tJuUovnin25V18QRLeHgIProAEj9GkxrlJM5Ln9Rgv
         Kb050KxZ8ANIzDNUlo5w2kNHEitJjoq7fyBl+fsLs9W0c8mfeIrmYgeKRsSuT22UGsQo
         7/IopaoClTniBdf+e2Vd+0SCy2bnLS3WhjU+gM9CgLOn0DlDG+idkPK4IstVc83OKdzY
         WmmI5g3ZSfqekYWZAe/SWdQx50/jh8sEkLJQHlzfPfW0E/0epiOsfcrKRa8UvqZIFUf5
         gU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711738; x=1783316538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS8cvZxJAhKc4BMxA+98qFjlhTjbrIv3l5VR4CZyZp0=;
        b=INPz4qDCHwWV8pHScNd0cEAOuJvlKokwonR5kHqLOIzorWohHzsDIyPt8Zrw4PJMt0
         Y80RxVX3DkoZl2DrTF+aifKCDOqosOtjqlpfSRjOzzvALOqozzLd56cHVVs1iiFUO4fH
         z2JjOJL3rxL6phG83htg1Zu3kcAoquOcoD1a4PP+wIH2LCBYBNI03bQ+UgmtbALwUEyb
         ChFKgndRYNXCz5G0S4dYYg2ekM0hZHhiRkPcWpkGXbFf73AHJ2BXoQ2ybtHtAcQ0HtiY
         nLB3fjiONuwkN+2pwbQ87dU2CODnfh+FsWUcbsdDA9Tstoejn6u/9j6EOmZ0THTcYKlF
         F6Zw==
X-Gm-Message-State: AOJu0YyZcPFIrtGyC0qDlahIcDJYhiSXIiOHcutPBWQXZd0tCWu6enAz
	9D+qjsrNceO1Y9ifn8xsEtFch6GsUONWH7vCKtVpYfyHqWOLwxbbXCyop7lmQOVcV6yaFTJqN7H
	OGJx1vR/0cpWm30tZE4O64JUY5lT2IlDtUCKwVcOeytwsWrS3Cq/uKeChbayZdw3BQOnnqQ==
X-Gm-Gg: AfdE7clS1zrYxxmkuqTxmCuhk394p7DNu1bLBB8A7UJERSZCKDR4ChVPN/17/9PNfDH
	NsHtTMDVUHUhkkv6aAYDNJS3WAN7PM24jDY+5wsoam2j8QqwP3TL921c239eaUQCnAIou+4ddue
	jbcFm8iWAQdOnXWCfz4NPTY+H2AgtSyBDtrtxgjzbD7VN2Afohz1AsMv62SlqVIwELbbxe9Ah0i
	c6ajvzPKYmFfT74VksBPeaqs5EKpgMyXdRXp1dFnjiBesQaBHDNbZsEF0FbFcGNuGTrA0PhHlW5
	f1LJNceOigppG0bEKGR0By38n6cEDJQVJpKshwhRKtvC5CvcNZtjC0qofmzUiXZu08gFLP8R0K/
	yPks0wfXxECfIKk6lRiTVLNr6YB/DR9v7w+dI2Y5WtYRAwjjYkpk=
X-Received: by 2002:a05:7022:410:b0:133:3bb1:8d40 with SMTP id a92af1059eb24-139dba6db68mr11548588c88.15.1782711737835;
        Sun, 28 Jun 2026 22:42:17 -0700 (PDT)
X-Received: by 2002:a05:7022:410:b0:133:3bb1:8d40 with SMTP id a92af1059eb24-139dba6db68mr11548572c88.15.1782711737298;
        Sun, 28 Jun 2026 22:42:17 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139f5901f73sm12123581c88.4.2026.06.28.22.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:42:16 -0700 (PDT)
Message-ID: <a5bd56d0-ea90-446a-b94d-26046df32586@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NiBTYWx0ZWRfX+76eBt3nxlok
 o7T+G0QaX6rb7mPQNNIsDSF6SOqACZRyhMHSSpN3mAFR9k80Qu7NMMvlqL6+6dKoM/u68N3FISY
 4MSz9MuX2w6sKl4CVM6Bl5FUHVrk/DZrRN63zVLG+R7PqnVY6ocVctFK57B38FG/WGZXFS5apfj
 xUaNLbt32iMS/7ZB2kzgJZBLdnDNNH3VetcfMJy8Ok/syl2oBxLmhn02a+99dDG+XafR7q4FQ4v
 kbajLUSJpwfeFLmt4Dc6m70kFsFM5ZaKXfTdmDhjJJin3X4iAzVRM3kkIY3w6DIVDxS61QeWXbV
 XvR7qixZjZa2xCQH09PPmhtdbh4s5LH3iY9H5keo2t6g1kVIEaADZCcjoN4xr/KOqV6atCfniQP
 +4IDpMzrWpDNV+wxmHEHWVdenLPvQw+dFuZyVsvXCzbtoyC+Y/Pn6DHKsu7VCrTEpETchFQMA9i
 K/ZSuKBeRzGdT+59lcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NiBTYWx0ZWRfX0mIczTEa0E76
 3i5cYYsrUnwToiF9di3Y9rVStCWEgRHykK+hvYWJOl0oIw9i+a+hXoZERrZzUjSp593nKm/LC86
 M3E8xICzVUGWELA9Ko64QvY+zJP6+zo=
X-Proofpoint-GUID: YQ5JJdLVh9mAsbthMNt5377x6RYsLLT3
X-Proofpoint-ORIG-GUID: YQ5JJdLVh9mAsbthMNt5377x6RYsLLT3
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a4205ba cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=vXOABIWjEGlRoqXTTScA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38251-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C12A16D614C

On 6/26/2026 2:13 PM, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> Introduce QMI capability negotiation to support both modes. Add a new QMI
> PHY capability flag dynamic_ddr_support which is advertised by firmware to
> indicate it supports dynamic memory mode. When the host detects this
> capability, set the dynamic_mem_support flag in the host capability message
> to signal the host is ready to provide dynamic memory allocation. This
> triggers firmware to send the HOST_DDR memory request and use the
> host-provided address.
> 
> For backward compatibility, if firmware doesn't advertise
> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
> where firmware uses predefined addresses.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

