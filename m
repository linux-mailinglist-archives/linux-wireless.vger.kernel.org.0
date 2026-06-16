Return-Path: <linux-wireless+bounces-37834-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 77H4IxDsMGoRYwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37834-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 08:24:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D22C68C7E0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 08:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cvCxV5Hh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cXaXoo3w;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37834-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37834-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB65A3005330
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C613CF673;
	Tue, 16 Jun 2026 06:24:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C43D7D75
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 06:24:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591051; cv=none; b=omfeFNQqMqXCTBL7OAlaCO2XuNKjKC9DbPR9Ls1FE5JkKgbjGFie4FE7ZWxw54QupckLGd73yUK40TneIc/NF3D48NFnuyDvLB5yP6AgcbSWeS2bBL27mN0rtl1lUHEUD3jsp5UQyp1c+E62miuCaW8oPrGXKzWWGCRft5eBPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591051; c=relaxed/simple;
	bh=JgCU67R75ekxf4BnS9A6h6Yty3IaPnkzklGnfhm7wLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hh3XcTkbo/XNx9MIPysqseB+Tiqf+KmXvzSNQJwl/bn76HlkJX17RDaOAwVxrvK25J9sCieKL23+hhHJPnr96o9ACI8bQTybHmzjYbX9TUK63NGaHy9YziO9M1xmje2h7wxQ9C4XSD5X09Yx0WeI5ZFzLXq3g52Q4we5z4wbQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cvCxV5Hh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cXaXoo3w; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G66nqr2824384
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 06:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Tr5DEdIRkbYwn8L1Ccvfl5JRCBDqiEewip7
	ejeOVPKA=; b=cvCxV5HhDMSPIFJcn6hrHvV8fvsRSXSK85bDL7WH5fujTqwjB6/
	h7fGW8zuQXOgXttYpiOwmN/Ab7XWaphyuCBqhFmYYB39ulqx0sI2JH8SVP8MWQt5
	9VbszJAx+1eNhTHJ6DhahpNVEz/gPZIiVrkJxERKQD2RuWKpyQtUVdq7Q3bUHVa8
	0Z1FS+788v7mgEsi2ksJfsTosp5wt4Lpr58DC44nhoHtx9Wv/1PLFIJKjqQUP12s
	+qYBJwixdHcneZrXWEMgFW9XnU24BoYtqhAmrQIZ++r5qUbcrn/VAUnXF3NtGk9t
	ft04b/2IcvHuh6V8Kqz5uWUPmi2hjZW8JrQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteguw842-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 06:24:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2ed88c8so4059671a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781591048; x=1782195848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr5DEdIRkbYwn8L1Ccvfl5JRCBDqiEewip7ejeOVPKA=;
        b=cXaXoo3w/jCQ7m/kqwfCOCTYyuwnGCfXrh3oQgBzaZPG9WOLzMOlvnvCUh4QBJ8fKq
         4GEWivFTPnCBmtrS2WZT1ZfIYJoNaFjQrEbJSFyyPxTkqV76iB6S6P9JCOWdtM7BMq9Z
         upzPeVGpq7lrHZRVaXi06xGuoElhA/b/rMYcx3bcjnkrEGzfMLeqdcDeJn8wUJVMbfKR
         ja+jZNf3mHhT7B0c5hHpOwz0+gyoCZ2GK/3Y8x6QlwDnHidmXMyAHpmqJhz5oqjw6CIL
         WgCSFMNuHJljX7fBMyPGGnK1IDzgmtci/S63tDRDFtoHoUQd17CDFui3JKC0RHCpHYl0
         GhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591048; x=1782195848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr5DEdIRkbYwn8L1Ccvfl5JRCBDqiEewip7ejeOVPKA=;
        b=oijKGkvXwyiTPdtj03J9eiNu0luQAmeIAQ8KxaYRRK8DopV0bLYmCxzTciLaGXZm8Y
         qIFFAeeeeMopkSKEIbMtzmsfzObi+YN9hrCUEJFXPjxTVSAvh/INI3B14EzY9b4AtG0M
         jXbJM1RLHiZTznCeYZgOVp8Okp5tehiTeM+HKMsrJQQdtEGtFKyxHj9AVyY+fKirm6RP
         Xrb0+VNi6U02l4eefthRRQnz2/ebSbucRrJvBGx6JZDdGo6KuJbT4W7bGlVE1SrUyjLC
         hBner24hnc6ZpyIKkDn34F6uN3TxPyLV6SYf9CLE/wUhf0j4tSgtPs/hizCzn5uRihxu
         d1qA==
X-Gm-Message-State: AOJu0Yz+vgo8mudqWORaBtW2vIbOHPpNHlsAaheY0cevuxfgbyJ6ZIIC
	lQSQUn/YU8h8HjWs7b/Na2FX12r/U0z+C3mzmZxLh6p1HUqISEmac2HIXLFhrYm+yrTylYBtbyK
	jPtFiM34PBH6u2xTgJ3oShUFZ65VgzR8Gk3Tv5ta53XpdIKkXjz566nxrG7KTHIZZMCCGXIP403
	efoQ==
X-Gm-Gg: Acq92OEkV2TAZcx06NBGyxGgs1t39l9TNnHsgtTmFWuUE2xF5pMaxQB4YEF7oG8EXLv
	wvTlVXmsud+9iyRwpV3rRMCAHbE8uev0+s8xHdYE5Hz2arNVuCTf7B/bPrZJwQkWJTdAqnH+Ofc
	NBx3PNUKNQl1BqiGFgzvT+hhJXvHa/rPzLVW1PBtuwBl9aVZW8DKJHRyeg8evIlFgCPaQ0xjRj9
	7wiGR82z0v/oRe2BgdJLzNx/U3Hb/9cH+5oy2Pe/9C+HjrjmD+kRuhrGvUiKhgNh6Pc3OY7T/iF
	3OkW6OV7i6IrGSAkpYkkn/ipMZEWmFAue27qdOJeyove7mnqPiq5WphBiZgnXlpi8W1w2dqYpA9
	IyPXK/Ea+gy/o5yYfGAFD2MxyGpTorQ+UGt33UP4GVUuYswsahpod2C0qmU7mtwSxpPA/VCpyMt
	m3+rt0NhqTPmF5D3nSXVdGuLsyGM5qa3dI+jHLRQf58VVf
X-Received: by 2002:a05:6a20:2443:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3b7841ab01dmr19896338637.36.1781591048157;
        Mon, 15 Jun 2026 23:24:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:2443:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3b7841ab01dmr19896319637.36.1781591047718;
        Mon, 15 Jun 2026 23:24:07 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm10591529a12.19.2026.06.15.23.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:24:07 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: correct monitor destination ring size
Date: Tue, 16 Jun 2026 11:53:42 +0530
Message-Id: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MSBTYWx0ZWRfX8MHtPV0/0+eL
 lClQ1VgmbS0+3rrcYts+eJJtv+vl+Koz2LAsvDy1GG+LH5KP1fA+23bBYEQtoLB/hO85xUJY2iO
 x4i7eozqbWstkku4uvKdL5s5ty9Uaf/bq4NWl7C9e1dt1aoDxtAE1MkFZb06Y6SeUPTTS2HYkUA
 1pMvGvcRKAU3S2Ec6K1Tx2OvtA6MceNcGhN1enrFH0fCMvECoTuOkd+7acFdixwT6t/Dm9ZDTOU
 p6AN4Vw8vKE1iQZuDwxFiuZWU9DALfTuCREmVyfuAIRinyEyJS4qHMzCOUBh6wYErhqwbQR9UaX
 vuiyj3Tr3+TWl1UL/8Mwbuo36XjXjIadphyRsaOv/AjPzgGZRzrMFBcGmQSoozm7oxZR+M/l9fu
 rXk6RlX5GnFI8nDtVPC+LvAvtCBDq2e5jv/F3s8+pygJZj4+rcLzTEX9IMeDVP1X3Yk+Jb0k2Hi
 o5rJdEN0KGbstZtEuuw==
X-Proofpoint-ORIG-GUID: G8Od_VwgFKmCsIAawuYZuEpzN3JLxotE
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30ec09 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=b5TSSxGLzCK9vQyPxlUA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MSBTYWx0ZWRfXxnnmIEJRrq1v
 dL0gbk992jm1tphhv6jXf9lILZxDwcyFekjMm4GaAb06MhiZjNOxNVNCPJvM++rdQ6CeGbNZ07r
 cABg0lUyClMT3bwxJPsCf0WWdduJmlE=
X-Proofpoint-GUID: G8Od_VwgFKmCsIAawuYZuEpzN3JLxotE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37834-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D22C68C7E0

The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
which is a typo. The intended value is 8192, consistent with all other ring
sizes in the table being powers of two.

Correct the monitor destination ring size to 8192.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Fixes: defae535dd63 ("wifi: ath12k: Add a table of parameters entries impacting memory consumption")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
v2:
  -Added fixes tag.
---
 drivers/net/wireless/ath/ath12k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..b488bd8fea9a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -49,7 +49,7 @@ ath12k_mem_profile_based_param ath12k_mem_profile_based_param[] = {
 		.dp_params = {
 			.tx_comp_ring_size = 32768,
 			.rxdma_monitor_buf_ring_size = 4096,
-			.rxdma_monitor_dst_ring_size = 8092,
+			.rxdma_monitor_dst_ring_size = 8192,
 			.num_pool_tx_desc = 32768,
 			.rx_desc_count = 12288,
 		},

base-commit: 83f028be15fe071efbee8e27837538d6cca77e87
-- 
2.34.1


