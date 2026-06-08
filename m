Return-Path: <linux-wireless+bounces-37527-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JRCCOFXDJmq+kAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37527-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:27:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BEC656A1C
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:27:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dmjFTONZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FI+ZjwPy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37527-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37527-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 883F8303505A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA8372B57;
	Mon,  8 Jun 2026 13:22:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EB376467
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:21:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924920; cv=none; b=EOvdwG/Fcns9VgoUhr9wrRP4uScNnLUv60JQ+2mq+hmw0yZapvRoFElHA4ElG49xsgofGMcFprESruqgbjN0hCP0sZ9kOm0wVgHfwfxOTRImu6p+eIR53hYxGBtXevRiX/yOum2FL7FAihenUwWC50Apa0mY7bMPvWU4hKriwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924920; c=relaxed/simple;
	bh=zmZHKVlcaPvEEOZZFGRWnV5Gt6GkTRAdvY1ttKS/oxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oY1Se7Vtr+ZhFHBDTUF9vPnw4er6DeJWGs9cVbzUOlCb4haNcMojhqoUGuemtrDJZwXRjEgjsUMB01skyEjkQJ74zZT+m2Vaca+i4O5Qwcw51Qgy6bPFdcnkhNR5g4hFx3C454QbDq0NqF8h7Eua2nc3IeTZE5eP6bXd7ChrCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dmjFTONZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FI+ZjwPy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9PJl3038189
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+1JnV+L2QiJG9BruAfU9DnSDRh/wgHdKyo+tpx3iTvw=; b=dmjFTONZoYj83Me6
	pAY7niq9uXjobmrkbbOifA2pJVVWZIsgJnHiidXr93blZZDg5Y/7u3AYcPQFJ5WA
	xxVQoKb6zjwqeikNVGv0NJQfHtpvkxAM60FORdmTUrOC4VCr9qGSvOEjWuIcqOWp
	Lrb1jfnjAyMylL3aWXMiCWEtSAWExxTo8zxlgUu4hYsmnVqRH2iinZSve8w6stWI
	TMTzU5ZeZJk/WoPwTy4iTQPT6sNjuuBjZjEgvBwZnEvPrPP8CKxu2DUdHyFv1w4t
	zfnTwc9YVUF44OhBoD0MJZHAxNveiXnHfyPmJIYBCkgzkLvWPqsDc5nPggbg7uIe
	+wfJOA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8m7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:21:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3074797dfa9so5902035eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924918; x=1781529718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1JnV+L2QiJG9BruAfU9DnSDRh/wgHdKyo+tpx3iTvw=;
        b=FI+ZjwPyEBnVEZn5NGeakr3HwgTTJysQvU4yRrl4KblC5ppCbX0I8pCInnwHGSSrQ2
         DmaQCoxIj8NFVqB+SljdZEDIN6YbQvi/W375bD5V7TsftaL0R7kkoHPtWqYrfLf+K57J
         KhuaTbdlOPMH1Z3C39e2WyPxIY1zXHM/KC+8kf4GHy44VcVwvp+IxYeBUnQiLvcZtGOH
         f2iBeX1xmV7+r53msFjmYBcv3lMc1fayen1ioGkQ353TQzYUtWQZgPpRr1MUk89fYKmI
         aconylJz/I3lVxzPE/Bn+GlRsMgEBNJo9aEKpA95DKWfMRVhW45Z5atTBOa5+3MpW6nw
         LSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924918; x=1781529718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+1JnV+L2QiJG9BruAfU9DnSDRh/wgHdKyo+tpx3iTvw=;
        b=g0RrpvK2H1x7c+xDJ0ApBxwU7bvPgvGrLkJvd1sSbCDP+hpcgrw60Q9Sojr63h0Qaq
         7UxbSuAbU+JD92kMA0S8xPM/VPDWi20V395yz9fv0oPO5fN6DNJYOA3/SN3ifMJk7VUl
         fQp8+gK9Nq1Qd490a4e/NP6fnxk8Ej0jCSLDNuDq+npNBPP3YosmnEnzi4ZXVWPw+hdx
         rF2KeI0vCOe4lx1kRWyAGMIkd6of2RhmN4OuQc2RX0lpOu4tcWgm7lPg3G84AP93th9q
         acTcWd3BeqauWmb3302oso04P+p8+EQ8gNbTbbryX0rkrgLEBAkCZMIQMekJ2k/1NL6B
         ipig==
X-Gm-Message-State: AOJu0Yx/YNDuxv8eQmaEZAVBnnDMYNgtdNXy7M9snWS4lkGrTbPtdqpy
	0msakUQEUUYeY+Kz0E4ITOrVDUGn9/2tqAeY91X4BIiT4KfsW4jl080E/mm1a1xppuTMWQNP7Lk
	PG/7MuJYl9v59P998MEMCbHYjeqkSxSnTc83MQsv9wkhArT43oumJzSINjk6gEdvOOxZa1g==
X-Gm-Gg: Acq92OH0ir90LE2Q/JrH56RZPo9TVtvzbBns+5Zx8Ztvi8z+e8FfV2HfT5wpvHf0kn8
	SOEcP3iYw8/qFaskT0gouhFcoUH+OXzKpNoOrfSZSrnSFMPKOeTNTg+edNIkNt0Zjxzeg/AstQX
	xhrHO5r9paflAPDJjJCRDN3ym/99HDoYH3zQLjIEIm/oka54PX00lHG/DebroauXt3BMQWwzlj/
	rsIWcG7FgOB0KDnfcLu89y6fra63Iwhrsq+f8/HqFhwKwBHo36MAjxWXjVSieT/gzVJPnRkBqkW
	7Sfun6NE4XMWv8r9Nv9fF/+rRrsI1eJ1GQ6TVWhuJcK939NL0W4m7c76/RYYwWpjwBTgCtw1IM7
	rYRl9lB2rRPe1Ce4wxHsTlQLGh0MOdWF6bZul4NFW0fpyk97/R7jmVS/2Dc5GL4KFDRb+8Ulam4
	VupSSwg8XFock=
X-Received: by 2002:a05:7300:8cac:b0:304:ab8:f87c with SMTP id 5a478bee46e88-3077af051efmr9016481eec.12.1780924918029;
        Mon, 08 Jun 2026 06:21:58 -0700 (PDT)
X-Received: by 2002:a05:7300:8cac:b0:304:ab8:f87c with SMTP id 5a478bee46e88-3077af051efmr9016453eec.12.1780924917534;
        Mon, 08 Jun 2026 06:21:57 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm21607280eec.13.2026.06.08.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:21:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 06:21:35 -0700
Subject: [PATCH ath-next v2 4/4] wifi: ath: Update copyright in
 testmode_i.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ath12k-copyright-v2-4-37504d70b03c@oss.qualcomm.com>
References: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
In-Reply-To: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: sZ2xxSainQXLuWA6MqH8L6A0n1ddhoQ-
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26c1f6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=E4j0M03IeE_1wCd7Dv8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: sZ2xxSainQXLuWA6MqH8L6A0n1ddhoQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNiBTYWx0ZWRfX8rngYFujTGfn
 HxAcO6I7epFYfTHgZKoCBjUIDqokxVxxKllKbbxfz4SHfmHLPwyGaj9TJ6novMmboSXqqam5nrA
 yCVLMCPkrI3/P4bVnhgfh1Qr+AEYKuPjSF8JWfqSN0GDotCn3jwvM0d8RnrFup7oF8JK0ISMu2p
 nwwOdIwzymEeCVQwOP5/qNrd8I6fwgNBPaEpL4OuSa8xvdAYAMMM3//OIjS/zuarzqTEgWwWtxz
 l5VQolTvMnbdQejUHBuOWGPNwmqc9Gkw937fCq9A9LSvMXvdXyKeiAInRN6TiZn3PH5vnUBlfAC
 Ti31GqUv0AOHx+yDw5Yybo4x2DV+MAWe+erVRegZSLOplxYe1Zgd1vni6H6fweiKfTfTpdLTZx/
 10X4iSI6gJVTClW3/BxHZ78er62xnJ2vpXqAhFDVQOXY12+MF0GoFzwdcZl3OBCewYCsKv2UyW6
 Dp1NhVeJYFeDKuAxS4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080126
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37527-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7BEC656A1C

Update Qualcomm copyrights per current legal guidance.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/testmode_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/testmode_i.h b/drivers/net/wireless/ath/testmode_i.h
index 980ef2f3f05f..78109d21a655 100644
--- a/drivers/net/wireless/ath/testmode_i.h
+++ b/drivers/net/wireless/ath/testmode_i.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 /* "API" level of the ath testmode interface. Bump it after every

-- 
2.43.0


