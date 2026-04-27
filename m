Return-Path: <linux-wireless+bounces-35338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMUDG/wK72l84gAAu9opvQ
	(envelope-from <linux-wireless+bounces-35338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:06:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3BB46E109
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 632F0303FF96
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7138F653;
	Mon, 27 Apr 2026 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JnhWHvPh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apq/JPSg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653762949E0
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273249; cv=none; b=SKMsW6kdIMMVYbcXfaZC/rHvlOuuppQX2wPSrvP9cirzvd6vhKFedo8sIDg21rg+rz6/FEbLLo431j7fCZZD9iehAk0nnksRsmuyD74uIlzt/4Lqpf7Fywk7BAwJdS/FTrtsDS8gTA4TNbEuLZSYplMgKCTNA3lwPoyNRu5xkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273249; c=relaxed/simple;
	bh=781JDeG6Lz8AMiStfmG+9+hEpa+W1cDMNN2KksNJZL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FioE3KHBdaiXO6wgmAeOrB3v/cRW/pYyrAk3h36qNTfmEZMLzWzo2MJMaurmdpe+dRsJ2p9vcydgx+9Eplxs47jyfCS7gY5Cqb8IHe3rFF0MJnA/OsWzUpEWQMRP1vb/REBMS5wAc57jcv6ND7shcW0A3MqPnMmht2Q9B695OyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JnhWHvPh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=apq/JPSg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLOH143646807
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 07:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AOCdBsfFvhzm82Y7HwVDgjJ5b3lEg+pk3ko
	rNa2Gw/4=; b=JnhWHvPhrWxthpIILyoPN64gvPMxZ5hgdDCLq7lXrcJDeyj3ZSt
	fH8Wl+ITSXPd63GIrGJBlgicLYa2CEGPryZBU+dHSiOEDxxXrZIh9X1uTHhNjz2s
	dBdN4dZS5xSNamCMSfSG/HNgcIPa0qoPR6Qjir9FefgqWPz3ulcGCCw3h0Xv9eM6
	hah1XSq4jcTRIQ7Z9vuUdNUqcqJ4qBakkZQegzjgDROz6BhuKKz5BOZlnYYfJkVq
	2QpyDHXleAFPEz+gUyKu9RGpkAFb+vLYUhszlEUR4d0VN+2PVGWHZfRHHDto6xsP
	hHkm4LlDFVFbBF8btAWjfoCJAfLitg5nLtQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnpw4tju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 07:00:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fae95c82cso172739261cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777273245; x=1777878045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AOCdBsfFvhzm82Y7HwVDgjJ5b3lEg+pk3korNa2Gw/4=;
        b=apq/JPSgQFoVTOMNzvT2Bg70JoDdZR7fRI/KDKoZa+h4mECavAjzdP2WAYVNP9gPM4
         IBn1O4AYtcuvL9j8EG4mQMG4OOemge8hPWLKAyRIH73QuWMjJqJ7Cg8n5FkzY7OJUqNB
         YYRrBkslL65VCoi4ULsI5m9lvJJi+DBdyxAC7FOxkHX3FswZrelSqe8hreq9L0MY0qct
         R4hvldRUF0snOURNWSx7LJUVDp2nqwi++ERXSmKWaLCH1xHwPdCanSt+bi3CFB4ND3F/
         s8cNcwLACmvf7pOXqmx3G0Sjr0fKbWZ9fx6cgvnXwhuLQZ5E/50zU35dUEdBWifGV/BB
         fZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777273245; x=1777878045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOCdBsfFvhzm82Y7HwVDgjJ5b3lEg+pk3korNa2Gw/4=;
        b=R3xBTaN5HhQ9gQBQ/AJJcaAzP7D7ymgNWr58BB+31q/hjGz+nFj5HDY6kkeNIUP4Ei
         dTaP3uKtGlo1zomDFN4ElRa64TwGSJ6jdMg8jmPAcIwl0fXU5HaEgkq9fCsgm7g6u89T
         F8fmqaj8BJs0d7fKqqp/unKffYnwzzPVFW0Z5Z3Im/iCrdwGevrqN8EKPFgsHDa66xmS
         Lr2LAy9A48YagkkcgN4JBP1TLfZD/jmoGr3mLLy2hqWBwBo5b/1vOZ8//ZaoX/38Ohko
         Sa1LNCiwHdRxhxRtwjdgKSDlxIv1oXnZC2gsmqlh5jXgXn1NOf6SIn2xF00dlOMIUvbT
         1KhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dWNTmXbswBZCbxZ9sHyrGiMvQlF7ly3GipUwVE+Nlnmlp5/seHhomAb3ogzgRSL+HiBD87B0LXVLR3PsrcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcZr8zuP2dKRi0dVDGKp+o7jPIZoeS71LNjMCevWbF3QAdR/J
	yMmxddMzDDEZdFJqZRsGq32AHCoGaQiQmrWHgX94c7tkJkzlXHRdHwrz/VSJ1i2VwO//wq1T0Ov
	Kw1M0JcGZ0S3RRv8NojhSA+kaUcoU7knsAHfhu8VCkKbViUSqyPgamHafPYd9wfSnrCzi+w==
X-Gm-Gg: AeBDietR2nQsZberhCHw28eohgeiwEBHl7kZI0NnmBxL15cwY5E7iIiWmqeHOhLUlzZ
	hyuACZAkJi49dcoWu1MZ8QGWrn+EQBncQto/3jDWhnWW+jPnrJNCyhcdaUvb6gKKiK1ZsHTxQxL
	T2YXLh2qhih6/Us+JMAhE8FiM1ZcwQM3KLdZ7z2MCxQiXlOsUfM12gL873otx5S0t+hUtTDTfsn
	zbXZA77qPm3RMRQKXzoIIDx6diN3cfL4MtxjHDjsK3jAr8xmhLdA0YV9LO6gCJf/H49JFp7PL9A
	ecy/bmWWDq9Or85V2k1OMwPKJAFEiaidYz8sh4H9BkcLJ+gNGph+A9aff9lQWXoL4DnmKQ1jmue
	LWfFmMjJMQsW/s/EQ0Mt5FX0tilpyWXVTEYhmRDyovIvLtvz1tf9rCpVMpCK3kFZFA3dtR2OA+2
	BcNIMCtr+V3Q==
X-Received: by 2002:a05:622a:4ac7:b0:50e:60b8:347e with SMTP id d75a77b69052e-50e60b836f6mr480760591cf.59.1777273244640;
        Mon, 27 Apr 2026 00:00:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4ac7:b0:50e:60b8:347e with SMTP id d75a77b69052e-50e60b836f6mr480759731cf.59.1777273244019;
        Mon, 27 Apr 2026 00:00:44 -0700 (PDT)
Received: from quoll (5-226-109-134.static.ip.netia.com.pl. [5.226.109.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489207ebd3asm265836175e9.6.2026.04.27.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:00:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] wifi: ath: Unify user-visible "Qualcomm" name
Date: Mon, 27 Apr 2026 09:00:41 +0200
Message-ID: <20260427070040.17928-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=781JDeG6Lz8AMiStfmG+9+hEpa+W1cDMNN2KksNJZL8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp7wmYIlWEmGon/ehJbKFgm/iqgZwK5llIoV4h2
 SjcczTCT5eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCae8JmAAKCRDBN2bmhouD
 1/mmD/wLsNSth6ayXMU5ThL/PVny9qMuzbLALU+OlaCD4IGolE8i+MBzeR0fZzOFSqkCWwmwBmw
 af11vr1NYYnkgUvA2LC0euYT0Dbzmnw95ADCadS6UCmCcBir/6WyykfTqf77AEFrIeJ/bSp2xWD
 EKjr55sqGDykyyxQ79ciSa/nqiTkWdXPK2dSIhYHDO8Jjx7N4eWBpHnTWoTEhuVg5X0Q8nB8PCS
 97Q5f/Yqel023+WJg6WVA/1UpgMspty2PZHyvVkOgUHDeSKXxmYmA2+0JivsiAXpwhzzMvrLtnn
 s3rokyjUYLFmjdI1yTTGjxWQ38PVR2T/mEW5VKoFpW+edkxRb4FDElr/GtF62rPNXFRFNPNvlL3
 9IjhPJtnjld6PmaWfxNGnJYdld0K3DbvPkJxRDDCmDQrzURRrmuImrEkuPAVLzV4NUGe3uz7TBW
 TdbbbAt7M2RIcSVv1TGH00GyZzSS0bZO1ahRERs0ZrrC9yZ9vjW6kwGnQLTuMDPFnReUw4PZ2m1
 ptbzOnJj1zKhXv5oJZzoN437RN9rxBNxAjiiQArOc8FO03TO7XQVR4QYBnYQ/5I480/CQ5Am+Ne
 5iYg4X3uWOG7vDrjIaGenOA8vpUY0TyCkp1DR1nmj6PshulRFTitM9qqd6NASpuPm5A7t/e9wMn UI6vqhrUWybBFYg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA3MyBTYWx0ZWRfX/+hP8wYxXc91
 Td0UIwgFC/joW9BprmnQKN5XWUr97e5sXqce/My6ly38jiCVv6Z1P5zI8FUm0yU27nNVZmGocYn
 pwkWocojeKNWQ8msZG65x+HAAgDDdmQRn1txkfe0jJRuSrwZEOkwCDqSgv78jjLBn37GSHZqdp6
 h69sfFny8B6dGsJ7gv6X1BH7q1OIZ7rocqepLYwx116s/7XtsU9ZFjGIrzfQ6VtksEUTRE3OSk4
 Sr7HYUUwd4/SCJM3hABv5Otvp6FIF2JBrs1SL47f3OdvbtMh2LPxbRYGLc5nx0I3sU9QGqoXU0m
 gIANAWxCd1nSrpZ/vsQmT9JY8ox/ROBvxKiFyvybqFuF1ngffjCElUlpus5ErJAxzCX1wZCVYVg
 +K9cjwiaTP3UKpIvmRQfzui0YGqvoW40SaXF1NQvjHDdPeoODc6Fj/ncg+lh1rvt7CPvwi9SXiu
 op2YQ/y40Uoh7Z33YaQ==
X-Proofpoint-ORIG-GUID: tvJtm1O7FT4zQivQybs33IyoXlDTV9TI
X-Authority-Analysis: v=2.4 cv=RaGgzVtv c=1 sm=1 tr=0 ts=69ef099d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nnYKl1aPHK5ktf5uHVwi7Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PHCmJKGvDbSP9W6LhaoA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: tvJtm1O7FT4zQivQybs33IyoXlDTV9TI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270073
X-Rspamd-Queue-Id: BB3BB46E109
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35338-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/net/wireless/ath/ath11k/Kconfig | 2 +-
 drivers/net/wireless/ath/ath12k/Kconfig | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 385513cfdc30..122726f84492 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 config ATH11K
-	tristate "Qualcomm Technologies 802.11ax chipset support"
+	tristate "Qualcomm 802.11ax chipset support"
 	depends on MAC80211 && HAS_DMA
 	select ATH_COMMON
 	select QCOM_QMI_HELPERS
diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index d39c075758bd..4a2b240f967a 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 config ATH12K
-	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
+	tristate "Qualcomm Wi-Fi 7 support (ath12k)"
 	depends on MAC80211 && HAS_DMA && PCI
 	select QCOM_QMI_HELPERS
 	select MHI_BUS
@@ -15,7 +15,7 @@ config ATH12K
 	  If you choose to build a module, it'll be called ath12k.
 
 config ATH12K_AHB
-	bool "QTI ath12k AHB support"
+	bool "Qualcomm ath12k AHB support"
 	depends on ATH12K && REMOTEPROC
 	select QCOM_MDT_LOADER
 	select QCOM_SCM
@@ -33,7 +33,7 @@ config ATH12K_DEBUG
 	  you want optimal performance choose N.
 
 config ATH12K_DEBUGFS
-	bool "QTI ath12k debugfs support"
+	bool "Qualcomm ath12k debugfs support"
 	depends on ATH12K && MAC80211_DEBUGFS
 	help
 	  Enable ath12k debugfs support
-- 
2.51.0


