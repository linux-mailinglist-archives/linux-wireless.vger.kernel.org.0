Return-Path: <linux-wireless+bounces-37964-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0wcTMsLlOGpGjwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37964-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:35:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF886AD474
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:35:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="K3/p9302";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=baEdYda8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37964-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37964-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD707303113E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA6C3612E8;
	Mon, 22 Jun 2026 07:34:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB03603C3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 07:34:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113668; cv=none; b=WTgnYTVDBD1CYrKo9hBTRWsxE1NDn3gZLgJVNTaY9H7P7mVpLc4QSJyYMdrJ5J+w3olKjXCrwPDftndBlc5foJCRm7IzIMTmfNdQMNTmPtS9zw/gL7gbSXLl+UXJ6Dz/7yEeGPx581h9OgekgCv5gDNyLx+u1RQsCEBgZWJst94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113668; c=relaxed/simple;
	bh=hl89oKts6hGvDAHAVZNsghxjD/cPVpJgMSnmpra5QDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8XTzmrWnXNox++piYL+wxROW3nMvWwjspg5PFbiyzS5VufGB4pXdTOnjuQJIVrpw5Pz2+9LNy6DNpRxqJSP64d7sORK4i/xYKCYyA+jPGv21AnzB5in7bV93+ij5BpqaxpoHo+++dx0YIRC6pgB0c0o4/1/UDDfHXUPK+afudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K3/p9302; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=baEdYda8; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5AMr1227641
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 07:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FV8VvFG57wj4BlxGVgeaWnLGG6mPu4wqlRTGx9btkQY=; b=K3/p9302PUVLEB4Z
	jt4cW6ZPtL1dGiQtJ1txynS+uJW1UAPleikhNfUpkY6dFHvg2ZzTKkRlPnJ5oz3H
	DTb0Iyjg1TkTvXS4Z9o2B0zYpqNXBsauBA1bryYgv/74GwHVNQE3yJ8SXCDjBIar
	19bwesjw9g6GTXg0N6e8bTdnV5C2NM3eBt/EbT20DvrtEjxD3vebqhj0O3ADdTEX
	nzXSJziD+FUiyFrBUnA9jprKJVo3NkEo4nA4RA0bOSkN1fGveEKk4FgjFKu9S25n
	s9Mu9hLav81gXQiDOFI3rggTFqlLiehhSgxkk0jAhRKpNkSbPMPCELrkBkoMSzzq
	xYMGoQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewjxud7kt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 07:34:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so79885085ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782113665; x=1782718465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FV8VvFG57wj4BlxGVgeaWnLGG6mPu4wqlRTGx9btkQY=;
        b=baEdYda8TE11+90DhhSqPW4vkrmYopgm8pGRG/bntWn+H2ZQB9H3WKK4gQK9lIhAOO
         yaPt7orAHWtYaLHYpPszRk4z/219uuVOd4bwQ7t5/oJ6+sVPCNDVY7JuWDa8AMzxmtO5
         OQbqPUGwxdcKRK+I8AmkHssqBpJMYAFPQZSTSk0eWFniJAuaKsLYHvfM0DQ5D9tnhiQv
         /MDtk5qLmfTkRi+nJDBEtVE8Mfen7NBTbqglnuNfZr6hLUrhVk4LyyXJERmJaOIyLxP5
         eORlIj368MhJuvncR3d+oyR1zIgdNfmn6TxzA8BLqvcgq9RflL9yzI6RzKhDRyEjEe3W
         R65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113665; x=1782718465;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV8VvFG57wj4BlxGVgeaWnLGG6mPu4wqlRTGx9btkQY=;
        b=DuM6L3e/cjJVWxFK3Dpvbbc9+AfJ91C5+MAeVBsv0eidPNmkp2boFOnSioGeS+b5+s
         uULi8sZM4oRsT6QF22GKBXxe898tBWVnBcr++PnzxRjgzGpHmz/5kawb+QO6HkiBmg7O
         8KteOTPyMuo5czctvFXZG76RLsUjAXRCpE6EMqIeMOcKCP+2pYVAAC7tAKSksCrOM//W
         LFiqL9hM2Ko3HYWJLKWUnC2lEk9Scv6nxlLMwAYmRF5OQwzHwtoAx6rm3bwbwfYA1Uyc
         6h9jytsUOgttWYob8NC14Ti8E7RD1D2KqrijSB1BzYQr5pu8+r2BlGvIAoYYvp5290vO
         4TDA==
X-Gm-Message-State: AOJu0Yx1zrFE7APZB22OV0H7gH6ARqKrfemT4TEd1kE5rroUhgjgWp0Z
	TLDT3+XPqjw7QSLhDcFZwTdZ8x1sD2w0Ql0vKPdv8hrRQNzase8pI+Qoz9mTVKgljSk/0vjHqDd
	btwCPw20N/P4IGsJqfwBCzsOM/td63HaPntHERfLdCgDRZ6Z0+ezywS7FRoE0m1eO990/wQ==
X-Gm-Gg: AfdE7clalk4kpRc/3naD/jKnIxeM4/NApSJBuOI4SdauoxyjsiWvxE5zvSZhdVF4FZG
	oURnbHbWoeStcsAA7E/fYfMnZNV62W+VzYe1v794jLsBdjo16YdCb1MVrBd9+EPDFUJRAS0QXPj
	p5dUJipt5cKcNcoP6kq/kxq+zLFf5xUk5HR2x00cPLpTKyhwtQE8qA33pOt+4Vslz3dEniMPR/B
	3xOkCP4u8MJ4BMnQwHFyvGVjdRVrNTItaPzVD5G+R94hhYDnyO+jlRMgrBC/SSasFwGD4leZ3F9
	+BPZ1aRZxfwMTq6MfSOAZEAxkluUt4jn8SV7rr3B01EyNVKO1ux2a7t4EtqllDUofnSLdhkD5R5
	0F5X4Xm9Oaa9fEmVoVA3I19wEdMCKuaaYe8RfyylfSfxBh2xUa39rmfWmjIaQM7J+5vuqare3o5
	83GQFk+F0x
X-Received: by 2002:a17:903:388e:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c7253af6bfmr127017825ad.0.1782113664706;
        Mon, 22 Jun 2026 00:34:24 -0700 (PDT)
X-Received: by 2002:a17:903:388e:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c7253af6bfmr127017505ad.0.1782113664198;
        Mon, 22 Jun 2026 00:34:24 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm75241645ad.39.2026.06.22.00.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 00:34:23 -0700 (PDT)
Message-ID: <2712d819-2555-4223-b92e-3148f2d17497@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:34:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: reset REOQ LUT addresses before
 firmware stop
To: Aishwarya R <aishwarya.r@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
References: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3MyBTYWx0ZWRfX5kvc62eo8PzB
 /QAHXEptk7hWatpuKSGIhR0PWps1djNwQ2S7+hqsVbL2h1Ciui35QxVS8DSqqLq/pyLtsVO2+wH
 3hrjp+kU3qi5Glg1sqK6Ys4ZIvOxewI=
X-Authority-Analysis: v=2.4 cv=G/ws1dk5 c=1 sm=1 tr=0 ts=6a38e581 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=rEWi-qFIhFxvFm4LqcsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: IbavGVh3gfTMgf8QG49ksfq0N-n7V7hC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3MyBTYWx0ZWRfX81ZTrooMqd2l
 NHn/xAFvntqsFEoIujucXO4eg4oWMLW5szLcmW4Y4BNcJXVR/+QHeb8iOIdSgmzLvjXuI6a9QM6
 Ubi9+yZ4q2E+Ek8p9V/xZpm+ncuVwkITFCJIMllG0rwi4Ok32nsZvn8sY8sBIgETxpFI97yMu3Q
 ketEsfDJwk7mWB51DerPZuPikh/4VBGXgglbAJFZhhhROLX2TVgf3AOa0dfELJU8BCpqvK0PttT
 omKqKfbIUdQpVlrpQjYLOrwGXbBPaQnSKZtRL2CyxF+j4Sgg5Ww8OcHcytgposrwquhpmQ6RwOK
 EGIYqevta4hIgoZtYIO1frryLoZc70Bfd7O8XN6rgAxT8r6lBGV0Ck8AhNfU1uI7AzEhBWmCtIX
 JzonhxUPLyhvBzmqzboVD1dcGc27wdtrpyR6yACwv3GfyaCILPgy2lebteqZjwvuuDXWMCEukRn
 7XTn+tC5lA163oIt95g==
X-Proofpoint-GUID: IbavGVh3gfTMgf8QG49ksfq0N-n7V7hC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37964-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aishwarya.r@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FF886AD474



On 6/19/2026 8:07 PM, Aishwarya R wrote:
> During module removal, REOQ LUT cleanup writes 0 to the REOQ/ML-REOQ
> LUT address registers. That cleanup runs from ath12k_core_stop(),
> after ath12k_qmi_firmware_stop() has already stopped the
> firmware (mode OFF), so the register writes can hit an invalid target
> access.
> 
> Move the REOQ LUT register reset before ath12k_qmi_firmware_stop(),
> so the registers are cleared before stopping the firmware,
> while register access is still valid.
> 
> Additionally, handle the error path where firmware-ready setup fails
> after LUT programming but before core_stop() is reached, ensuring the
> registers are properly reset in that case as well.
> 
> On the crash-recovery path, ath12k_core_reconfigure_on_crash() calls
> ath12k_core_qmi_firmware_ready(), which re-enters ath12k_dp_setup()
> and ath12k_dp_reoq_lut_setup(), so the LUT registers are reprogrammed
> before use and stale values do not persist across recovery.
> 
> There is a brief window between the crash and when the LUT registers
> are reprogrammed during recovery, during which the registers still hold
> the freed DMA memory addresses. This is safe because the device is
> non-functional in that window and will not initiate any DMA access
> until firmware is restarted and the registers are reprogrammed.
> 
> No functional issue has been observed so far due to this sequence.
> However, this change proactively avoids potential issues such as
> invalid register accesses after firmware stop during module
> removal and error handling.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


