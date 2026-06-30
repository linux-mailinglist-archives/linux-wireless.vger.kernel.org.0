Return-Path: <linux-wireless+bounces-38319-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n9ATKLZgQ2p7XgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38319-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:22:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C06E0B65
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=phFuGcRE;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VIO4Ec+X;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38319-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38319-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF101302C0DC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2A2D5432;
	Tue, 30 Jun 2026 06:20:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D219CD1D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:20:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800458; cv=none; b=FV42X3IC7BC6p/nz3tf+2ly7ekkNtTpE45uAqQ+myN0/D5nTfmYWnTFcxAsmPqaia3QpSb/+UDL3BBwQAY+Dgpr04IjfU+CgjQbxuVJ77yyGn4hel8QBWUgp8KNrgYbyCDM61kEd3UTIeflQAHIQ+2kl83Zh0Y6HntJtIA7IYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800458; c=relaxed/simple;
	bh=rc22qAdLH/ol933d5p9dnkrMR9IFqkWCL8TVCEM6cMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RfkiwqupEcpuwKq6bQ1Wr14XS7sxrm3bjOETyosoGK8TPeGYQxE3+3IIX+eCfgx+UVaJKGe0mM99dLGdK3X6pabi7ppMbPBuABiFTLH+9Fu18bl79cc39tI8jCe2lxho92MOFeQlIDiE9GKVXQGPgDcaxda06jkVroZj25p5K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=phFuGcRE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VIO4Ec+X; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CkUR1091060
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9Fj6jzLmNOt4IG8VA0VK//9IlB0OZyzcd3P
	9YxWwLm0=; b=phFuGcRE22mquORdSV2vI8VNYVGlLyryD3cEtSH/8nIsiEtaM4E
	ZOq5cnnMGyTq+DpygjDKzVAqVbn/2VthNsYrexJhjDKu2GyXBUA6vJzdWGJLd4Mi
	B7aQkryPLowCaBmgbiNrqVTqISYif2EiFrNhImFMWoXALSyx67GhZibWgQx1lMZN
	4xrGXkUHv6mU8+BgQAlT+7VOyoVBGBqLJKXuaohsqvPFuJS/lTv496W2NaDBn8bs
	UYAqgFFuoETQ7sYBqWjm5gGNblT1651IF2dmsBxWNWGCGpdXxKf7lX5wgHMjg9rN
	SbMkP1BaZvkQVDRTBJjaKhD1QzHUHr98EAA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5rmyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:20:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8952346bb9so2526016a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782800455; x=1783405255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fj6jzLmNOt4IG8VA0VK//9IlB0OZyzcd3P9YxWwLm0=;
        b=VIO4Ec+XgvENjHGyy5gH405TNAiTgJ1QN+ZM8WHNWz3cmIF0VvNhWuJIHr8oBMgoE0
         DcDzvo71BKoOLxBqZAHGcO21sVQQlFwfICk7MWTH49Cc5qf4a4bHPXssswRHufS31hU0
         p47o9eKamFLO9gHC0rTFdWreFYY9Bq7vQnu0HH3afQ/N1a5wsrqpnxNToMOAmhAmuvl7
         jdaRrhNuFqrcEQ8RUKVZY3E8LUHkNbbIoZZ9XWzRXxVRa/0iYDf/HMlWAAKcxlxV0r5w
         UAJkZ96bREuNMiUT2Jbvb0r8XvEQFNJIaRqMSlRVyGLdZvMoH2xlV96gJDCasaV3dEpr
         8jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800455; x=1783405255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Fj6jzLmNOt4IG8VA0VK//9IlB0OZyzcd3P9YxWwLm0=;
        b=O1PiopwckWXzTn0rx/KOSMrVXae01cE8mP3a/cXQIEpL3QqO2CGRbgWOOZ/U7JAWcH
         p/NE7uxEWpImxsKESyaobq4Fbfc5VJWf21/Pd+8HhVSMsg45wXCjmhLiQLy4ufFUMJ0j
         C4WWUbPu9IczpOF6kmWDZ+Dx6cEvCYDsHu+/gRWJxFQEPIOVqoi5l4aFm+SsLv9B/XU4
         vw2e47f7nftotFHKxWmoWJwNAmAqDI+fBGqgtR+cPksUQQl7SMkhKcrxQAoTc5QLRMJY
         mEpxLVlqzi1O6Sf6Mv3/WLZ+lh21CbVvTHofV1GCX+8fNttO8vUMK03+FVh5UdZEYDIf
         k+Cw==
X-Gm-Message-State: AOJu0YyALGQ5hU25w4cQhEGygngQu8JL8suewF0ynTI7gdZBvszR7qYc
	ae6yFMTl9mFRt1dw+NdZhejlqofYTc+GUQ5uF6LHC7E8+teQH+iUPaXYPoVoou83A50qXTS/TGA
	fQr0mThTacuGIDCyZtRAoe9bXASDpz4J9VIGBzljA8qC7On5RkCl1Jw5GOyBrpKEYUt9YgA==
X-Gm-Gg: AfdE7cnh0lEsGL5EeLNswmxhplIGPqXjhvDCIVjidhcMEqYxCuBdu0iQIls31sQ0hQq
	dSxhzg8utQWJ+MSTdzQkTdNWCYwbC7m78e0/IY2wZuoWJ1f5caYndIWNcjRI2f9mDzHubFTgIxT
	Y12Jz0/PGbvSNHDywHk6CGTWv74qjh1q63BoTGpu5hH/MwmR4Ynudp+y27Di8ojfPT40J3t/sx1
	PCtxMwzaCa6uK/hHZ2Qi8CN/yvFzLdYvcGfzMhg9eWQ8JpZ06egL9xYG0fvCOIuBmlD9iK++qRK
	gv0cn8LzrLckbVo77n1+mkvbYM2mHr6ZFEUuYWd8dJZVSePP37ZaHzixtHdW/Zd+y3guZmozd0c
	lugEKzmL0nHboJpG4R8m1g4YTIZcSiuk8ZncpS6lt/HlOS7P3jRRM9xqz3IZ8X8nPUm1+7EZS+H
	5jEEp95mTChPvFtrXmwc9jRGI5UiF1nnTt4A==
X-Received: by 2002:a17:902:dac5:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2ca2d3eb9b1mr17151515ad.0.1782800455010;
        Mon, 29 Jun 2026 23:20:55 -0700 (PDT)
X-Received: by 2002:a17:902:dac5:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2ca2d3eb9b1mr17151355ad.0.1782800454500;
        Mon, 29 Jun 2026 23:20:54 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382d0d22sm6413835ad.80.2026.06.29.23.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:20:54 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/3] wifi: ath12k: Fix memory allocation and improve reserved memory handling
Date: Tue, 30 Jun 2026 11:50:45 +0530
Message-Id: <20260630062048.1615178-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a436048 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=l_aBv7j6DcCNCqDfN2oA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 5GRNW4DxJp7chTzr4EhLxe04I9ehgoeK
X-Proofpoint-ORIG-GUID: 5GRNW4DxJp7chTzr4EhLxe04I9ehgoeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX80hGnSsOmCXs
 FsatjrU4H9t6FnztqEeW6f7XkTRoKdyYCIdtlksXIDNLJ01OoPQDg8Nt3VFhfsE0CE0p09e/qLp
 v6RkYu7Z1bisOD+VBUmio5CT71cW06i/8guzOhe2ENDHis9BcUw+m/knYgUrRo+dYT48MGYCpAX
 KU+E55oaUIKB01AHF9JyhLAXTp9uZzAfcI2N8ebS7N1wNvgDj6XkQrbes6ZuftWo3Il+R9CimM8
 MTghYImrScIWqBDABEu6W+wGcM5di2XyFzbN4OIpruPVZLHrf3G7AXDPPBWNhEXAerv+G24GiKV
 tzioS/ntbuA0KltmDeMqRyfn2kCXDI9SRK7HKFYNH6adqamBIBmFSiEKGKSiEWtMvBEJpHaTMDg
 8QDG5Qwtvvt7DoZiQyLhqJ6spNWXQ+Z1PatdsD8FQs+mxkZMcfsL+JXl4wd407CwzCkUyjkCs5X
 zN4BGusCG85bDSTAhqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX9tfsRs3ptPYf
 +ravynnleJGVoriXEOYofFoNw6SFjY8Nhl/AvN8H3PG8mi/LUvRvO1W80OHH9uV6nzJCerxkQje
 qpmr3CUiVixDpi3Fmtm4/z5Z1tbyV8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38319-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 237C06E0B65

The current implementation relies on index-based device tree reserved
memory lookup. Different platform variants define reserved memory
regions in different orders and combinations, making the index-based
lookup fragile across platforms.

Currently, the driver allocates the HOST_DDR_REGION_TYPE
starting from the base of the Q6 region, which overlaps the Q6 read-only
firmware section. This causes firmware assertions during QMI memory
allocation, as the firmware expects writable regions to be placed after the
read-only section.

Address these issues by:
- switching to name-based reserved memory lookup to remove dependency on
  device tree node ordering,
- refactoring QMI memory assignment logic to reduce code duplication and
  improve maintainability,
- placing HOST_DDR and BDF regions after the Q6 read-only firmware section
  using the bdf_addr_offset parameter.

This series ensure correct reserved memory handling across different
platform variants, prevent overlapping memory allocations, and maintain
backward compatibility by reusing existing reserved memory region names
defined in device tree bindings.

Overview:
  - Patch [1/3] switches to name-based reserved memory lookup for platform
    compatibility.
  - Patch [2/3] refactors QMI memory assignment to eliminate code
    duplication.
  - Patch [3/3] fixes memory allocation to place HOST_DDR and BDF regions
    after Q6 read-only section.

---
v2:
  -Added bounds check for reserved memory offsets in patch[3/3].
  -Moved system includes before local includes in patch[1/3].
---

Aaradhana Sahu (3):
  wifi: ath12k: switch to name-based reserved memory lookup
  wifi: ath12k: refactor QMI memory assignment
  wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region

 drivers/net/wireless/ath/ath12k/ahb.c  |  18 +--
 drivers/net/wireless/ath/ath12k/core.c |  25 ----
 drivers/net/wireless/ath/ath12k/core.h |   2 -
 drivers/net/wireless/ath/ath12k/qmi.c  | 169 +++++++++++--------------
 4 files changed, 82 insertions(+), 132 deletions(-)


base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
-- 
2.34.1


