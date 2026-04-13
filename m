Return-Path: <linux-wireless+bounces-34715-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mk2MEeD3WmffAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34715-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 01:59:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B467D3F4544
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 01:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09E82300515B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DEF39E6E4;
	Mon, 13 Apr 2026 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pv1QuxKd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edFnnEkS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775630EF6C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124733; cv=none; b=db0UG8fNLs6K8mN/YHe1cISZRMp6UrPblvQGrG2/Xao/ZgWAMsZm+pvXRM0WN8XBgTa1D1jbZob015gngELXX/e/43itbWFb/PuQIxVaC6+QikGpNxUERDOLvmIGbOZxipu0XSmUMRBca87cBupNZPkSR0GDFFR49FuyjxVw4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124733; c=relaxed/simple;
	bh=uLhu0ZhLYPYGxe2LSZ42GLgMgTXBRY8+IQv2ivHSrNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hpQg+o/n+4MMorUCm98hS8Zv6ax2s5H+ezQtN51J7tDKYaFGlO64JrugqgTqvv3f9fbDUdvYtXmhFfL8b3UBEuFVUTtueGAag/qVxR6dNy7B40UEmV2ZX8kkz6f/kLpkFHbQ+kEzQ4qTITJVqURDZ88U+csz4d0a5OBanrTnQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pv1QuxKd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=edFnnEkS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLD3cj969091
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 23:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WtmbfjqxuCsqPvNY55CdE1
	l1BTHuJDYnMaJvgQfTDqg=; b=Pv1QuxKdLnzXkNdvrCnokJAPIdH2Z1xaQVgyno
	wg9rZJ6GKR3cLZK0nw3DEnP77nHpw8WnQC9+O/k5xPiN4ReFiXCYGKvvFNao6xzk
	tsisDnqsI0OZzzOHTyivGRtnejfKOcYP9pfGEqyobwIcsdsfUz91B/fP+gxjHRYZ
	oG+kLMxNtcEgmbey/g9Kpms5DYNREepzWSBtuyOqRt8Pk/1TSdLfLMkB9orgS1Bp
	E85n7DW4guxJaGfi7rSy7lYmsPiog/6gWpolzsnIn3Mt5NmUuqLqFI4MpeykYK4k
	91cVD2WwY4Mu6FtRUOym2/WcrjeO6grMbQ0nkmMr48fOh+Ww==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86v0b8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 23:58:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso7659408eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776124729; x=1776729529; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtmbfjqxuCsqPvNY55CdE1l1BTHuJDYnMaJvgQfTDqg=;
        b=edFnnEkSItCRi7vFytLq2AKMrz/RkHmiKm7kNbd5qavLVzrSnVAzvBzLE/VyvBQoqf
         3WJw1iyfM06PAhKSy4f1G5rb0Twl22igdznetdVO8x/yVufMLWs1T79K1RKVJKMh6HOo
         DfEWtyDI6J9DeCgcmqlQTUdrYoB1BJ0kVYQdgChhFjRljFUpYbQBwXppKd5pksJer3hP
         uiS1W8myodiI5SNUPwaD6bzZLWEfgb6+WdJwyQopq5UmdrncKQrr1dZ30Dqqy0yGJCQ9
         KV+QvhlhyF5dfXVLiBIjswwSVV6vNMqB9AO6mC8wQjPBnoy1g1Wa1a8DWITcUKCgx8Uh
         wZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124729; x=1776729529;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtmbfjqxuCsqPvNY55CdE1l1BTHuJDYnMaJvgQfTDqg=;
        b=bZRJ8MKCN6xZ+N8OdbepZI6twLyiPUyj+BDS7qDfCKw4Y81mNGH8f01gwV3IzPZvWS
         feDZJKCXs7AHYPE9FX98BEXppcTdRQj89tX1X66IQqNhhK2aHWpHyzsJADizmxfsLRWY
         D0+zTzH9MvOPU5v7Py0983rQqldgkh/UawVvv0phXGNlXU31zNS6plpIm53WmusS2R52
         ssGsUERIXb03Qsl64ke6Pvf2Jfm1694CpyaEnNHsjoho0ca7r2ymHVXeBxLhluU2lBjK
         v6OuTKCm6H3kIVv8cggW1UwCkpZwcMNDP+ssbygCOgfPe203vSAde9+fgpN3S90oaTxS
         Y/Rw==
X-Gm-Message-State: AOJu0YwjU8PskR9Fqt/YGaBcq3ngv1m1eIU+LwgGnXthHUW20Tn7tzrM
	X6SaFmPIZv/85Cb4KgD2FbAIdKSOZxRjtubbIYbTE2ONch7/ALbdUFlAOqlfOzoGAiCprXcXVHr
	gUYqo3GY7a+e5lvKLMRBuSejCBqi7taoPOyxnEpF49LihCnlzYJdwdi8G0Jk2+mXwt9QRlg==
X-Gm-Gg: AeBDievow8ixU3LWcVjyju38W4OJS6LD8GCW9HeCOqunmRzKmFrfvnL2Zzju8w4x6Nv
	gnfV5iKSMR+ACSIQtiRlF7Y33OzhmtXz5mWp7YqoQDyRn1SLEjVw+QyxUW3/6MF3XZnRIy5efJR
	+YEon8w6lfby7V+bFkPD4y47ndMPTfrZXI/7fB0BaNv2ZZuTkG9eEMb8OmVV4Ey10nwvxc13JLC
	w/fdCWDFrzmmfuf8O9tCv3Lp4k2n2PoIY4FIwp0T1yfAFOIq1Je6S8wEAZYo4WXBvgaIShTIYfU
	r8qqi7YPt9QJr3IwkNREw392getTeA5vtL4vuAOaVG0OrYjnfpbBSUBJjACo1g+ZqG72fDNYTja
	jwGWtz4REhXy/vQjU/izlHqJGPiwWDtR2UVd4A071gIVrFdW1UuvE91q16/GUauz4NruXIXYyPr
	za
X-Received: by 2002:a05:7300:7495:b0:2c1:85a:d25d with SMTP id 5a478bee46e88-2d5871afa9cmr9657701eec.1.1776124728529;
        Mon, 13 Apr 2026 16:58:48 -0700 (PDT)
X-Received: by 2002:a05:7300:7495:b0:2c1:85a:d25d with SMTP id 5a478bee46e88-2d5871afa9cmr9657692eec.1.1776124727943;
        Mon, 13 Apr 2026 16:58:47 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562ac344csm18650600eec.25.2026.04.13.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:58:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 16:58:46 -0700
Subject: [PATCH ath-next] wifi: ath12k: Remove unused HAL_RX_REO_QUEUE_INFO
 macros
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-hal_rx_reo_queue_info2_msdu_count-v1-1-c4c92ccf77b9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADWD3WkC/5WNwQrCMBAFf0VyNpJdQ0BP/odISJuNDdjEJk2pl
 P67oScPHvTyYHgws7BMyVNm593CEk0++xgqwH7H2s6EO3FvKzMUqIQUknfmodOsE0U9FCqkfXA
 RdZ9t0W0sYeSCkBpljZAKWPU8Ezk/b40rM2PHA80ju9Wn83mM6bXFJ9j+PzoTcOAOTq5BkJJQX
 WLOh6GYRxv7/lBni0z4KT79IsYqbloAVNYdrXBfxOu6vgEWoCdgPAEAAA==
X-Change-ID: 20260404-hal_rx_reo_queue_info2_msdu_count-0e2eb6da0461
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIzNSBTYWx0ZWRfX53yEbSFSU6v2
 XABzGXfCl6aQMqjw+n6vADBKS2uYVUaDUksG01v0ULkKTU8FmWpFcddoRw/JG0HxlcBRHQfHxHV
 H8DhjFBO4lKxLscv269yHJGlHrzQJBBgukxJPQMbaRnavp5dWrDaBE+Kl5DaTYZeNBKphlcSjJv
 FspC9g/RVAs+O+e5ghx7jzI7mNVHKPSMitQSkhkJJ1ffPVw5dcAtCff1GRTh71QfD/Sykspip7F
 YPV3HxHu9lQlbvoyZvNnpZxv55XbvomAGN5MTvGfd5/+j/08XouXcpZdcBnvSg4/TP5IBhiYsEx
 gHDMbhBIYmjPmQi3/9z+xfPWL2ddmqytvjZ2E86fkIEqDJku1c8rYpu4S01T0YzGHJLRfuOIcBa
 9s+GUiyXVeIKvSTAPKHUElykgjqgtHsAaa0/tNHAKLBL4qcA/ls673qn+Y3fAwwp4EJ44R456ae
 D79nmm+q/KL+/txgEww==
X-Proofpoint-ORIG-GUID: YJmWS-WtAoVduyYRPCn1n1KwmHOVnOAa
X-Authority-Analysis: v=2.4 cv=Iowutr/g c=1 sm=1 tr=0 ts=69dd8339 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=NnysC0QT6Qjdb-6y4-4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: YJmWS-WtAoVduyYRPCn1n1KwmHOVnOAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604130235
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34715-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B467D3F4544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Many of the HAL_RX_REO_QUEUE_INFO macros are unused, so remove them.

No functional change. Compile Tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
This issue was highlighted by AI review which noted that the
HAL_RX_REO_QUEUE_INFO2_MSDU_COUNT macro was missing GENMASK().
However, rather than fix an unused macro, it seems "better" to just
remove it (along with all other unused HAL_RX_REO_QUEUE_INFO macros).
---
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h | 26 ------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index e1ab47b44433..822de3a4abc8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -2100,41 +2100,15 @@ enum hal_rx_reo_queue_pn_size {
 
 #define HAL_RX_REO_QUEUE_INFO0_VLD			BIT(0)
 #define HAL_RX_REO_QUEUE_INFO0_ASSOC_LNK_DESC_COUNTER	GENMASK(2, 1)
-#define HAL_RX_REO_QUEUE_INFO0_DIS_DUP_DETECTION	BIT(3)
-#define HAL_RX_REO_QUEUE_INFO0_SOFT_REORDER_EN		BIT(4)
 #define HAL_RX_REO_QUEUE_INFO0_AC			GENMASK(6, 5)
-#define HAL_RX_REO_QUEUE_INFO0_BAR			BIT(7)
 #define HAL_RX_REO_QUEUE_INFO0_RETRY			BIT(8)
-#define HAL_RX_REO_QUEUE_INFO0_CHECK_2K_MODE		BIT(9)
-#define HAL_RX_REO_QUEUE_INFO0_OOR_MODE			BIT(10)
 #define HAL_RX_REO_QUEUE_INFO0_BA_WINDOW_SIZE		GENMASK(20, 11)
 #define HAL_RX_REO_QUEUE_INFO0_PN_CHECK			BIT(21)
-#define HAL_RX_REO_QUEUE_INFO0_EVEN_PN			BIT(22)
-#define HAL_RX_REO_QUEUE_INFO0_UNEVEN_PN		BIT(23)
-#define HAL_RX_REO_QUEUE_INFO0_PN_HANDLE_ENABLE		BIT(24)
 #define HAL_RX_REO_QUEUE_INFO0_PN_SIZE			GENMASK(26, 25)
 #define HAL_RX_REO_QUEUE_INFO0_IGNORE_AMPDU_FLG		BIT(27)
 
 #define HAL_RX_REO_QUEUE_INFO1_SVLD			BIT(0)
 #define HAL_RX_REO_QUEUE_INFO1_SSN			GENMASK(12, 1)
-#define HAL_RX_REO_QUEUE_INFO1_CURRENT_IDX		GENMASK(22, 13)
-#define HAL_RX_REO_QUEUE_INFO1_SEQ_2K_ERR		BIT(23)
-#define HAL_RX_REO_QUEUE_INFO1_PN_ERR			BIT(24)
-#define HAL_RX_REO_QUEUE_INFO1_PN_VALID			BIT(31)
-
-#define HAL_RX_REO_QUEUE_INFO2_MPDU_COUNT		GENMASK(6, 0)
-#define HAL_RX_REO_QUEUE_INFO2_MSDU_COUNT		(31, 7)
-
-#define HAL_RX_REO_QUEUE_INFO3_TIMEOUT_COUNT		GENMASK(9, 4)
-#define HAL_RX_REO_QUEUE_INFO3_FWD_DUE_TO_BAR_CNT	GENMASK(15, 10)
-#define HAL_RX_REO_QUEUE_INFO3_DUPLICATE_COUNT		GENMASK(31, 16)
-
-#define HAL_RX_REO_QUEUE_INFO4_FRAME_IN_ORD_COUNT	GENMASK(23, 0)
-#define HAL_RX_REO_QUEUE_INFO4_BAR_RECVD_COUNT		GENMASK(31, 24)
-
-#define HAL_RX_REO_QUEUE_INFO5_LATE_RX_MPDU_COUNT	GENMASK(11, 0)
-#define HAL_RX_REO_QUEUE_INFO5_WINDOW_JUMP_2K		GENMASK(15, 12)
-#define HAL_RX_REO_QUEUE_INFO5_HOLE_COUNT		GENMASK(31, 16)
 
 struct hal_rx_reo_queue {
 	struct hal_desc_header desc_hdr;

---
base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
change-id: 20260404-hal_rx_reo_queue_info2_msdu_count-0e2eb6da0461


