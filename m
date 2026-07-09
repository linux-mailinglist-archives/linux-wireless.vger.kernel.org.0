Return-Path: <linux-wireless+bounces-38831-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2UoYMu25T2prnQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38831-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 17:10:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE193732A8A
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 17:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=H74RRCgd;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bsnbb2fr;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38831-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38831-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC9B31C14FE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF5382F0C;
	Thu,  9 Jul 2026 14:49:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C783F6601
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 14:49:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608598; cv=none; b=R/YWhoPBMOpI6XhXd9tdZ/oqTa91UplbzlcTuT0/rYAYNqS4rj9zSDOmyyhsyuC3YPQ0IXRWmhJGiDIeU5NsOcF4ld62/jvMb4HtOiyp3ERvojiPIFUzJwhP93aZX+MErFV21ZXM2X6X42lJWidtPdaY69fG3fXJz9T7wAswMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608598; c=relaxed/simple;
	bh=sPLeI9gI7T9nooekhXLptSy0NmmozstbVUIluCmEfq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k8EUwySnpGn6asEraVarW2a+YFDdI4QDNkqK96+M4LEartdhoHG3fDhD08PRj+094zfuvTcwYuLf/I7Adt/e8C1gZNWkq6L5i+BBdY+1My3uCaViAVw4GG4qw6iLaIp5dd98hMPTL1Asu2Je8sbo188NxMiYy+EUKoVxA4PXY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H74RRCgd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bsnbb2fr; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669DwMd31834257
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 14:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zH4q7BWi2hgwClET7u+00rOznpP+Ykf1PL9gpdCfoHs=; b=H74RRCgdHLu2YCyC
	DPR0TxCBM43IdK03QWzGeNG8SziPIBWoNYgwWq1WJNV5k4+xPl5S6kQ15LEjGYhb
	fECYv/kQWhU83PCaXttlWPeiFZEbhUs8yVTtknVJR4ASUh/RsH905Yken/P1dRD1
	ba4gMbsJvzwOUM/+pRWNndwGl6UWuaUEFmRrq7o0Isq5cUPqh0GbBqtqMLVV1At3
	zSF+oU3DyE8435JKNu2UErzOsSeGboKJQjMjUMUZGIa7fDdNYxCilI5Y5g409vQg
	ngg7/OjMzyVMasWGCbyJUWUfH9LR4IFxJxzdeG2DZNwJlb5v7mE5stv3wfgBYlVk
	ua83lw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfut7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 14:49:56 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7fe835353acso14941157b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608596; x=1784213396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zH4q7BWi2hgwClET7u+00rOznpP+Ykf1PL9gpdCfoHs=;
        b=bsnbb2frvJVqBO8Ddilnn7BdjosBCcGI1p9RAgHRjTuw3PC8O+fb1lyVWuWydEugmz
         COCOZYh0tH+7HwDpxnw9dMsEw2r57PlYwjPvXl8XYpwhKcLU3oO9JiqM/kx3vAhQfm3k
         5yolhQxEHAP7TjpfTU1qGbAtr4f4uXFaZgFF7CMdIOLB1T6evHK5NrDARFWX6WcvEGfx
         Laru3TmEZIwFbXd8OW1Q343HRgMWSlgzP32Zb6elXEF7M5bju3GEX7uaBKYFzszAQ25w
         pPJcYod7VhG8J1WHC8zYq3cmG9QRPC1VVuCaxuTg6inXSm4NBxnPCwcZZGOxFOCqEGNE
         kAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608596; x=1784213396;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zH4q7BWi2hgwClET7u+00rOznpP+Ykf1PL9gpdCfoHs=;
        b=cd7Je47MzREmjrrRLEUAlprYGEi0KoMCaOR2HoZUAJexwgJsOUdhhqbBWEbt7M2yPK
         WF2ZL+xpst1EtNRuwK7dHjzf1z1ZPqrURPty2DL4V0skIAKIQplRPuj+T1tinjO6tPAu
         0aRUV9Nx+f45JGSqlC7tzM0yXLhAUiBdMO/fDPevRP2Dxy5Fk6x+bsXX3PXiQK3J6DDj
         gELgYcNTMTBPGI7NOe1FkSLHxRUefTbTm4OWmoOax/HHEITcuBp12DF1eI3CMyQrRPCd
         y5FafuoL/ecW/LxcJznLOYjVQ3Il7xh5vUh9rH4BoT6DTrw8xAgtyI7xfHcALinUsg+Y
         9hlA==
X-Gm-Message-State: AOJu0YyjuLyI0yKP62Yci5j/YVywqJbCPnQONxEK6DBH12W9iRnTY+Cp
	Ly1F5IFJ504C2M5bUWr3of9O2JKsFyKVt7+vLm3SZjUC6s7cPnfdEw8iwODL+bMXvZiD2MjG6Qs
	mdjERATsgfVqd55z7My0sv1lM213AYZ7iozfeE+LdodfjLJ2Y40zrsytn1ektkoyWqZT+ug==
X-Gm-Gg: AfdE7cnmDrnSoCfnyo5CP4mcMbDvGKL6Fsxtg+sUbC+7I0lLXmFpDJso7IY0B4bBFFY
	v4NJVl0VidfZ7t6imYHHF60QkrCdW+NBI1akuBIDlwRoxJsIZDVOzwIHMKHOm9N5gQHCAVmKmgm
	nhb1ssy2pCUG22ibarnfT3C3uO4rdRkGRHk6QOVYF5g78b26XX7SCQ6CR3lIb7xx5JtRPTm7Bey
	INsPNH6XgHmv6TnZYH7+IVzGeNf7AootNh9LanWW/lVLK3DnvaxrgCmRmNSwtSsrUsgReJ7nF6z
	HnuL7cpKMwU8yYKDGwYTKOLeTjiTSaITsJplvbn6wE4bLT2Rj3GPrV5ZAcNNuz+QyeO4t6s2f6s
	Y6IxrkTAhRNvjhWVLHnsKCnPtkEe2Yvhf2+9kBiYQ+eYUFAybkaKP4PIBNj8NFt5dOg==
X-Received: by 2002:a05:690c:3707:b0:80d:d0ab:6d2b with SMTP id 00721157ae682-81dc0be096emr63289407b3.53.1783608595770;
        Thu, 09 Jul 2026 07:49:55 -0700 (PDT)
X-Received: by 2002:a05:690c:3707:b0:80d:d0ab:6d2b with SMTP id 00721157ae682-81dc0be096emr63289107b3.53.1783608595327;
        Thu, 09 Jul 2026 07:49:55 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm4989277b3.26.2026.07.09.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, Alex Williamson <alex@shazbot.org>
In-Reply-To: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] wifi: ath11k: Flush the posted write after writing
 to PCIE_SOC_GLOBAL_RESET
Message-Id: <178360859334.1031194.3081866596289507374.b4-ty@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 07:49:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX/tJCsrPqTTc3
 vZAv6dX8Fxfyzs818qdGaIi3imCZJWWli2np8UuxJ3mdYiCokr0k1bf+jsEqduyiVGI9MJZoOlj
 jeCiGmAKcQFVYcVeRKam0juc3vTpr5FM2vRJAuk1htT8RibOv6jn2UBl0JVW6F28ZtFAaWMFzy7
 N1SEf/hGKcjbn3e30aShQkrr7E3gbQuO5zrLvhiDMGq+AAtXz/meIFCSW7gowLzvB6htrrgEuFl
 yZhA5lWq9DSbtA9LdSbLTol4fFmrou3r+zC+24EsBl+A7QFynOxjX36PciccyN2X4/HvdOQm03k
 +1jEfSO9tz3kvyayoGPrv64G+PWyqQ5AZ6Un9thwwbSp30B92kam/B4zsz04VZnHaRBvY0E+/hA
 Q33afs/6u3pV9JsBBKq2vRTmVxkkJPtLXK9MOO73VbAOzwyxmuIunh0el6I7EAehTovnglQtpGC
 jGz1qQEjTPUSic1Tmhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX/e6EkqdfpjBg
 qYgtmFWjAb9s/nEFjnatRgg1LA8Fs2C4yLc1LMRbMpKNhFjt/iVo95Jw0XW5dxyQa4ZuQOYpUlY
 4Wm4gAqIWsU+oHbUOvevIY/8qvcKTSU=
X-Proofpoint-ORIG-GUID: 6qozhCczLgzwXBULvddaPxmwKqvUtuji
X-Proofpoint-GUID: 6qozhCczLgzwXBULvddaPxmwKqvUtuji
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4fb514 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=fjTVS2QutaehiSyZ5pEA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38831-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE193732A8A


On Tue, 23 Jun 2026 16:16:48 +0200, Manivannan Sadhasivam wrote:
> ath11k_pci_soc_global_reset() tries to reset the device by writing to the
> PCIE_SOC_GLOBAL_RESET register. But it doesn't do a read-back to ensure
> that the write gets flushed to the device before the delay.
> 
> This may lead to the delay on the host to be insufficient, if the posted
> write doesn't reach the device before the delay.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      commit: 0fe8010fc5b147607fc19ba010ba469afc95f35f
[2/2] wifi: ath12k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      commit: 55f3aa06951cac78b0206bde961c8cf11929a27a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


