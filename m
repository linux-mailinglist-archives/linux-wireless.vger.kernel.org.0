Return-Path: <linux-wireless+bounces-35732-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBW7MFXK82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35732-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:32:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C64A83AE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07BBF300F798
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A63BE17C;
	Thu, 30 Apr 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZfXhnHE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcJg/lrP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAA3CF054
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584656; cv=none; b=dyxwJgnKtl9z3lkbKKiAvEix0sg6fnQnp7wDAYeBmD1W1oyoiIrfkwSUyc7xohFNlNktRuUQksNZ81jO7eLZPcK4+lZfqfKjKJaS+bxPlm5B5NeHybOcNILvX2wkOm0NfgwInT4VzYK1OZJuPI3TrVdID5hv6yH3wxMGJYN4uHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584656; c=relaxed/simple;
	bh=0p+v3haOs21Z9PWSSh3lv3YzwCOXoA2cH5OdIzU4oKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cYaV+BOG2korRvRyvrXN/laZf1DDZoZIAW70YqeRRDklreMKIflBwj7Xs5mY5VupBsEROhX1RGmnq4m5IRZoPC67jm+UBipY2Sw3V2XmVIzHBcNsm3ru5UJqxsHGDrr3sY1s47DwYAfNBjOu4sgo1AiPNNdFE21YC7W9QbasSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZfXhnHE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcJg/lrP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UHfIGY440782
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eUAp8M5vMPPiqO0kN1a+WvkD0dOAkUEpzEqiuezew0A=; b=IZfXhnHE6OkO20+0
	7sEJhQzLk0A7Y7cqXdnKpQRMvlXVKHlUZG+SfO6nyW+NuAwjxDnsnPS34+ka/lme
	pVqD2bs4iiR89W9fZ2gGwi97hNbeU7VTDm2Hfw+VpgzPCXkmVTuEK9BG6M04rjI7
	z6jnurzZIq+fqPLDrX5PPxFxqniz7FwyUK1hIzyksq7K9c8fXzadLBAg+lozMIam
	dn5M89nAnFzTAc/CNehg/6LQLyysOBsX0kEHOXCknGIx2kPRGxdXD23S7a44jvCB
	sQjKu/eWJ+iJw+22fEgOZrzBvurzw+X/X8Two3z0wssGV6KFvNy31mWZsloCD4eX
	7I3V5A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvbpw90f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so1596442eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584652; x=1778189452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUAp8M5vMPPiqO0kN1a+WvkD0dOAkUEpzEqiuezew0A=;
        b=UcJg/lrPhKE1WkMbwjUZHyDNrZ/kw4vlHxHs3E2JT2O3mcwbo5DUFYtoqFiW6UhbUO
         wSZl95ynC4uO8XrLOjFtI4jRV8vjdtn38A0tWNZohjr2Hg2/4+JFgTJWMR5FJS+VFi79
         RkvsjdmSjLEpTdRNU7v1yQo9oe8458pz+kSDJJj87sZ+y8LwqtQjCCkUl2Y6lSnkLpCo
         ZBDX8KYv9VrsZ02QEOZUJBLM8S6qy0cCg8QC/xKZFNd7xSh30yh+ihla0de1iC9SYFOp
         lPAJGuYDRr3W+rFrdooaOGwGc8+Ge3L8nizahwoWAebgqnc1haqo6/gjKcP+u2G3eyfy
         JaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584652; x=1778189452;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUAp8M5vMPPiqO0kN1a+WvkD0dOAkUEpzEqiuezew0A=;
        b=YaXhHWuL/umzAwu2qglcMofX524RsBQh2B5G/SauBqIVJ+/3f5ujAZwOqTfA9YXTAx
         sssDHESEnD+nkJmdaTnEl7ZtSofTNF7+fYWq9yn5d3JUaY0mr6JfGf8WkLdEO2a2rNMP
         71R+OcUe002MUO7CJCUXxur/t85Od1jvH4Qam+gjHtnZYQkFMdCheSWzz/N/NscK1DBZ
         SC80HnSAzZ+hXhyYqVidb/a3hV/IoUrnBGM6ZsUOf1wWvwrrRYuHhVlqVhZFMTFe5L4I
         GZR6Q973Qx6sw7cluuq3dp9ODwGJIkIZdIjdejoZkp4M6e9mbng1ZoFZ7Dhl5Sr9ECj0
         y1Mw==
X-Forwarded-Encrypted: i=1; AFNElJ/ax2JfIcNPjX5c+zC/X9OPmU9sszfw+fA50U+lwD1RbkEwZ5RTC0jxzIJIwUWRJBPbwcBW17Vi/ZxMZeuCyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrs+QBLdvPItYi3mYz81rLZFKwxN8L0Tkx/JVj2Tam2Q0qkSFX
	EUb/ZF3L9kSFZMXlYyYI/ATK/h4DzFfKrqM5jLVOh6WuSka+mXcWW/1qj0+PZTrbgzwt+fGdgPN
	kDWL3dHJZtnIo6WcigpVRzdZiv0acHkna5+HTCfyYAIedSgKV/jhODt2VlKnrckyutWcl0wc7tv
	psFg==
X-Gm-Gg: AeBDieulkPJNoUWybXbQEwLQbxo+4G5ZoHkUm5KQ29M20r23NbysMtCgu6YUA6Zj/UW
	4M04WVIcQXKnsm+OF7i35ed7N5fKkCxEfG9sZxxlwjk0ATABMZAhoCzqTyp7dcVX3MrSXnrZIDR
	w5zoZ59ZBxqQWk3EAKpQYSI6Kbom2Ny1i9vw8pTKzFabFSwIMHlxo7gDoVXVeH6F2eOTR+jjN09
	7M4Bpvkn+mJyYJdXjaHAWrqLzE0P0tLOEqT0X7XIEeJlBlgVTC9+8iabeVa9u4PTtxztIdSo0YR
	S2ccGayJmSoUpt0M7cRzL5DAseHp2TbTCIypJWE5w7YmaXZubECtGrUAQ8qzs3d/Pr7eMgNMHe1
	uNiP+ODxyIVFybISBR6+kD8HE+8xgIXngWYPfedjVEir8Jbdm+62JshtxAiqEhFf4TW7gMkVEA4
	jUahWsWk2Ksj8=
X-Received: by 2002:a05:7301:2289:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2ed3e38dfdemr2271184eec.23.1777584651945;
        Thu, 30 Apr 2026 14:30:51 -0700 (PDT)
X-Received: by 2002:a05:7301:2289:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2ed3e38dfdemr2271157eec.23.1777584651356;
        Thu, 30 Apr 2026 14:30:51 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Wei Zhang <wei.zhang@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
References: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: cancel SSR work items during
 PCI shutdown
Message-Id: <177758465037.1848985.7425474739277158142.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dozrzVg4 c=1 sm=1 tr=0 ts=69f3ca0c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=78yTA9ZnydsJoXb-eLQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfXwNFdno1ci6+t
 aOKyN34Biz6ATp4ytxcYA6raC6a9AQRCd92oe9UAxfNimVA33XpUvewlMo/Sz7MRsUNBUzgqLIf
 dbLVtRQaZIdhFwqz9W0krsPYW3gDykMLoQT+id/tUOIY1ocPEDnv3eTv9DtG5vwsyDwWW7/W+Ex
 1AeYJf52iVEot1Dlk7aRb7GgUFpR3fUXO9l/DHgULVfzHDD5m9iRP/HRVlyxZYRSigU7dOFyTmR
 rRDbkm62iSsskay5FzqRYtN1bP6MA/7/4VfHZj858QOF27y66ZETcMtXjRVr7K5QaAfyef1E/UZ
 Cwf0p953ls1z6irZi8jlBTSWBR8BUmTG/lN0kX5kJK47bSLFlx4g03QedmT9zioBMWkVACzIA53
 GcjypKb3v7Bwpknzi/dxcx7ajY3IccI/9lphlsKAI//D9nTo7MjWt995s+Dww8yo8jgRCwbCswJ
 1GjNnN1INvd3JoatWlw==
X-Proofpoint-ORIG-GUID: QXtfMjpimEVV_HgAalHf4R3GNyXy16jb
X-Proofpoint-GUID: QXtfMjpimEVV_HgAalHf4R3GNyXy16jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: D17C64A83AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35732-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Fri, 03 Apr 2026 21:30:50 -0700, Wei Zhang wrote:
> A reboot can crash the kernel if it overlaps with WLAN firmware crash
> recovery (SSR). The crash is a NULL pointer dereference in the MHI teardown
> path while freeing DMA-backed MHI contexts.
> 
> Simplified trace:
>   dma_free_attrs
>   mhi_deinit_dev_ctxt [mhi]
>   ath11k_pci_power_down [ath11k_pci]
>   ath11k_pci_shutdown [ath11k_pci]
>   device_shutdown
>   kernel_restart
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: cancel SSR work items during PCI shutdown
      commit: 8c79aac429b583301f387374ff37c59be671df87

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


