Return-Path: <linux-wireless+bounces-32582-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJhcKJ9IqmlkOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32582-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 04:23:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2821B06C
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 04:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20734302492C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E443537EC;
	Fri,  6 Mar 2026 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKJhL3Yj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NeC2HYet"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5B36B07A
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767386; cv=none; b=Ka92DJH904UuuJeJcoAZ0IwipHFG4Fyl17GixsWmHsxl21Gzj0y+8yZ4AZB7xCj8s0tsfLF5xZ7XZBZmx9v0QouGDpqgqvPP0P7PerBNJCTu+otqRxbNWOBeTefian7Vz/ae6nXIiS88hhtEGIO7RfpJ/QjtwxsPlwhZhpKQMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767386; c=relaxed/simple;
	bh=yBw6SwO1FOpKx7jrfI63V2xJa9FyExbEelF2VDQNDGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hta6V81n5IisjPCt15pJcx+dU6D6T/ebVJUMmCywt4HvPg3AfWsnwb8wYjGzrkzqKEof2FTCXth0bwBv3svpV9+MKmP9JuZXWwjb4jzBdQZ8vz4reNf8lPm0fIcU5GJFu4MdvB2+m9Iirzo4YLWK2lEhuxBPJjkaUIPFihpw+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKJhL3Yj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NeC2HYet; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Kn7e33139825
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 03:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ACNcy8M6MNF3eJ5ymytzBBTy5+vI8OGJjmP
	lI1G45Y8=; b=kKJhL3YjYvbJCW0XymaAub0VHZt0iHb4C1zU2smVVyZpBZnsYc6
	4Pc0UDtrJu89LmDeyUs2SglINAtolpk/IfK1Hkcx3MrvVOfqG0Na9r13U+g0ZOC1
	eorlZYlK9bbrEN9g+AC9BTJPD1XY3Z7hCRfDGl3WFq5pN55NA0Nrcfxhb14S84LP
	++kToiW0vrFKuUndlk0NBt3TCvtI7+pIuWPifpCr9/mkBg2Q4dyKykBHevvUnnhx
	OZNmkwsLU4jvpHo7Q9Pu81Tfj7cbirHr69Vx2i/la5QvtaSFtaGxDNjZl9NZiHni
	Ui3csxZ6Kx7tITKx7KcBhCr/cnv0ME3i3ag==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq1pk4e9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 03:23:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8295e8e9a36so8882616b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 19:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772767381; x=1773372181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACNcy8M6MNF3eJ5ymytzBBTy5+vI8OGJjmPlI1G45Y8=;
        b=NeC2HYetjAjH6gLUmhyHATxYI8tjV3lpacjMCpM2HQmKmmJMcGbJUF7COerrfyi+jd
         Uk0NpHVIdiad6eoCy2T3/ZL3lddgMLm9nl4yIxDbiSC6iwOURJFRBrCVZl8wj7jUQ0f/
         APyr9wdPS5fJM+AylOowM8ZJtmzsL7j7kML1IdQMYB5f1PbkgaTt/56ori8Zro7rWqKG
         MNKKF/ugNTHhNUwJDaH9dGxx5YdfeDsL5U4MImktA3mNhO2CcKCddtC12VFSejtUsxwX
         bW0oIhiotO5Gu2047E9Ik7uvLWsgZW0200WvkHkq8zaeE7aV/fBE0br3ueSNjSfR2nY2
         nUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772767381; x=1773372181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACNcy8M6MNF3eJ5ymytzBBTy5+vI8OGJjmPlI1G45Y8=;
        b=jD7sx7fPoiW2kSLKILjJMCf40ann7/I1m46A/H9IbrT0xRxOmYM5XHmMYWC/Doo4BM
         ozPacf0lgT7NcgzWsqIYQgOLAOszNhdXzD2qFL3wnbsnIa9wqZpRbz/nQknKQCPjYdAb
         J+Xf0rEeMR59/7jDqyFrk9JDb06/oOK3r9uLsKwTJtAj1WToQ/MEl6zg3aQswiXGMyE7
         6+MRMl0QEpp+LDyxmU/ymXNykplKJKLZKgPw5RTkPimO0OAYR2qtseDZSj0/qcIDP6M+
         Pk8tJ8EHW5yPuJ9hD2IBLF9oG0RIps3FTHPQ7oirNwflgczO496v6i3giE9NJMGMzEVc
         sGvg==
X-Gm-Message-State: AOJu0Yyr+WwAYEFe5MeWXxjBpx+tT1lVqLbNn6MWi6mx84pnfVNjeofm
	mAaRJZjmR8zmLbiWQF4CZdQ7EeUF7cENAV32RYIgHQHbWbu5WsxvQ2c0AuyBgfpP+KeY9Jnl4eL
	p1w5HKQ0G7eurB+i2J7dGc7u3G/E6VruPbChGN8SrH7NT6SgHju3lnlGekphIZ/DakeNvBIWbBF
	DeIw==
X-Gm-Gg: ATEYQzwEnWTDfbzpk9bjm9DFRP5R29yTJEXJGpAozngCFXXSzsyEbsShZV7zrTXO/ot
	Ty28LA617ZL7YB3pJzxr7+jDA5H1HfJRSDYXcDyjxmx+brJtEOYH8WElD6HxzKPwN/Utth+z24A
	5K3Wd+kLBrilCp98Pwvc7XNErTPLXWAuJC+x0vw6DZxjlIcr0u6pz4dY02e6HWQaLFYNJMychKy
	9GVAvdeuMwzAPGKuhbbqCqjQ/GQs4KA8pnXhiEdWhWtCXxiWH4LUyrpJAR85TVtgiwrP4TmAHkQ
	kkRCUNFLCPJx1q4okYhoNIK4sG7V3kfV/fK0DVN3x6Ln42OaNDOki/uOoQUQm6ywqsFGU0eZJcK
	oPgJlrcwvZ/YewKfHa9mO1OrE+wVjJ+b0UNCUCPK3yGlE8VFgqEIFmhmGaBJOdlAF+PPgfVEoch
	rZQc63PGgTH6Ah2Wb0EBABFnk/L9QKDO+a/VZ3BkgVBqOe
X-Received: by 2002:a05:6a00:2e23:b0:81d:dd3a:b8fa with SMTP id d2e1a72fcca58-829a30c1ffamr562955b3a.50.1772767381464;
        Thu, 05 Mar 2026 19:23:01 -0800 (PST)
X-Received: by 2002:a05:6a00:2e23:b0:81d:dd3a:b8fa with SMTP id d2e1a72fcca58-829a30c1ffamr562930b3a.50.1772767380992;
        Thu, 05 Mar 2026 19:23:00 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6d3sm160523b3a.18.2026.03.05.19.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:23:00 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Use .mbn firmware for AHB devices
Date: Fri,  6 Mar 2026 08:52:52 +0530
Message-Id: <20260306032252.2237722-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fR3KMyhu_pyioJVTKx88iLweRYyMYBqH
X-Authority-Analysis: v=2.4 cv=Gu9PO01C c=1 sm=1 tr=0 ts=69aa4896 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=t34rvWxjL5Y87QPrXd0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: fR3KMyhu_pyioJVTKx88iLweRYyMYBqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzMCBTYWx0ZWRfX4von2hUd5D7D
 MG5X34cMY1PpC5GNwdsdNKNE2qNcGKbgNMsHm+J+gEN+3Zouglvrq1j+BUr+diuo5SmA2iyVaAl
 GvdLR9VlRH9TIRHl+Y8ntIt0cYOzyXbqpTevvxckpOrAinDONTbQ8JArJWaQQo3e++vb5zaxamN
 QdegP5gMkPoh0fjRyz3s2OztHiWkXuGqMpm0KZunCEMptg084eZib3v1aoW2XKT6ZGLCyIQGxsW
 vOevlIsGYtW3woLHOS2iVXISA8YDvsPXDa9xNK/ZLcFqfBUA8g0HD3Sg+ga9QS7mQfZnC/aRTY3
 x3sY7R1VUJDexude5oPczE3HnB9NDzheER+VoJdAoIgRO7isu5EaYPqgg/e9MEbA+oj7/o9Qab/
 sTm7f8xhPyjXlNzZ8fSTlTmzwU9xqSAJmrTh/xp8ERsHYdNudLoOjFcwdeY5LNFniuPMJXTBRUQ
 oKvxU1qrZJyKb9rkOPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060030
X-Rspamd-Queue-Id: 46D2821B06C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32582-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently ath12k AHB devices request firmware in .mdt/.bxx split
format. AHB firmware is transitioning from the split format to a
single .mbn file.

Update ath12k to request q6_fw.mbn and iu_fw.mbn instead of q6_fw.mdt
iu_fw.mdt respectively.

Note: There is no impact to current devices since ath12k AHB support
is not yet complete and no AHB firmware files are currently present in
linux-firmware.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.7-00587-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index 8a040d03d27a..be9e31b3682d 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -21,8 +21,8 @@
 #define ATH12K_ROOTPD_READY_TIMEOUT		(5 * HZ)
 #define ATH12K_RPROC_AFTER_POWERUP		QCOM_SSR_AFTER_POWERUP
 #define ATH12K_AHB_FW_PREFIX			"q6_fw"
-#define ATH12K_AHB_FW_SUFFIX			".mdt"
-#define ATH12K_AHB_FW2				"iu_fw.mdt"
+#define ATH12K_AHB_FW_SUFFIX			".mbn"
+#define ATH12K_AHB_FW2				"iu_fw.mbn"
 #define ATH12K_AHB_UPD_SWID			0x12
 #define ATH12K_USERPD_SPAWN_TIMEOUT		(5 * HZ)
 #define ATH12K_USERPD_READY_TIMEOUT		(10 * HZ)

base-commit: 9942b3f80f4ebe6852663e0d35ecaf6b7a97c8da
-- 
2.34.1


