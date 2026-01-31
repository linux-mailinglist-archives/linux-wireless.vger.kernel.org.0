Return-Path: <linux-wireless+bounces-31409-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFZlMqVNfWmkRQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31409-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 01:32:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA73BFA24
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA45930056D5
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 00:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE732F8BDF;
	Sat, 31 Jan 2026 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ali4QblL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223918027
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769819555; cv=none; b=qbFy43iuZikBCb2gSDxxQvwk8rthkdwoPFHtoJGjW40OpIhiJ6AEJtT9dI6paFzWG9OPscfdf1uMLHJoY85D921s/u6ybTCcbInItXi7fOtxv0mI15/cWVm21ix69beaRKGx18K1eYASmZiL2IVK0KsGBzUbiN1zWkC9Rltc7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769819555; c=relaxed/simple;
	bh=qHLwm3foGsLyRfN/w8M5G6gWqz7qzuvoYSrEcQQG3d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8KKU7BzU5lLkgut24p3ESYNM6GKc2t+9F0GxOFnS8b/+twvoGpBU5giieHdw+CTelKmGh5ahDpyzvxRUh5AchuXs1SmFiTd4VFA526+N829tpHounwiR066KtwBFviqXhu2WyleHXsLF+DHrKyX/q8JMO5poTVO7BDCQVjyUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ali4QblL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c7199e7f79so413415185a.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769819553; x=1770424353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdZ/Sc5hV/uhGzu0pWshiyKD65Sr9XHMviGrv3h2kCQ=;
        b=ali4QblLrYOCgRe5ZNd3f8CHScWtIfyQ0Xtun/YcbAKK+IAo1UGM/ljXExFFeMN0kU
         zXf32Fbe8BEZ1E3+jvc0vmmB2ypc4vO1qGyS+Az92hmckUz23M/jDyzDe58Qr96QbVZ3
         E5gBykYFYsSE3g8oWhryOhTABBL8Kt2i/C3hafQnSgXJ7wp4Ay4zefBOTNapwaFSM5X0
         EKNvFo5LlhzvOzJSIik4rIwmj67bl2JsxkDyPr/iJJlcoJPr/7jg/m6V9cAN1d0hi9ZO
         KJx/7TmhS/BLGmVcAgFgvxT0BZwxTERKzb8WikqVrIxy8e6lfU2nGl1hYTTdyo524Jqc
         Orng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769819553; x=1770424353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdZ/Sc5hV/uhGzu0pWshiyKD65Sr9XHMviGrv3h2kCQ=;
        b=dyG78YexmKDGU26Ta3xjpJQY7aw9OYYt8Pr+EBtm3Ghbaeh5gkhZ4Xm2zbHeJiIXh3
         b2swaEqSRK2vlHZqTiQSuw/ZtlrBocuMX1A4iyHgZoqDGIo6/2xdocyxtsjRa4WzblPA
         aoccwKob/vlEMtUvh/wfPfVhMcaXzmGRfEi4I/RWZbfe3GEEdfhCReB/s3/QbijRgAfK
         5iffIpJm19DQ9j5O3R03VFunx6CouU8P8sKT6gMsFxDSHWndxDS2thqiH/dayi6G7DCe
         3lvoRKyGQGGrFZo8jN9FSpOXFfcS8vRqEarSvkALjARxuUbkTElz8faD1dJnFEbi/B4v
         fYsQ==
X-Gm-Message-State: AOJu0YzujGIECw3jwQ36tvY4wB7K3g1cXoPJQMTeo3Tca9Lz6zXYxZxf
	gjlOIUub4M9TiumIdRDVmNWW46JHRNwRDN9dRRhDCqpEgtJo6OW3C0gJ
X-Gm-Gg: AZuq6aJANb0J9yqYGujjV0p4VUacFi0Gy5YdJMz/NgWdis1Y1YKcklQY+outs+CGKM6
	hj4qH9gUl9ubfMufm6jSvpk/DGEeYtLADb5HzhZC2j5G4odcatZtB2+9Hfmn8w/C0le8ur8SoDW
	fOju6IEr78D3iZIAjMfNGp+y9IRT1L6F0gRkxI5nDywRQg45iEtlBhdDBYaVpld++Y08PC/nC6v
	2NP6B9SEkOFb2728kxdT8kmYuKMN85bIRliMUUIRUYaEYojj1KSXGC6qiigCWTv3pYbZoRFBUFC
	n09OjiFfJhQvRR7Q61u6xc3xH2E1Yo4pC2dYnHMHPwc+42E32AcUDQd/gzKMGNyLOXCUKKq3rLq
	7kKtofQEoyGcyZM2p5ejx5nIUZSfNESPm7rI70yV3qxb2aVIkUmiu3jqKo+xMcEcg7+vddg==
X-Received: by 2002:a05:620a:1a26:b0:8b2:e17a:37 with SMTP id af79cd13be357-8c9eb2fa58cmr623720085a.43.1769819552944;
        Fri, 30 Jan 2026 16:32:32 -0800 (PST)
Received: from dev.lan ([2601:19b:4201:3e2::ff7])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8c711d29044sm719968485a.30.2026.01.30.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:32:32 -0800 (PST)
From: Andrew LaMarche <andrewjlamarche@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andrewjlamarche@gmail.com
Subject: [PATCH 1/1] wifi: ath12k: support calibration-variant from device tree
Date: Sat, 31 Jan 2026 00:32:22 +0000
Message-ID: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31409-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA73BFA24
X-Rspamd-Action: no action

ath10k and ath11k support reading calibration variants from the device
tree to locate the correct Board Description File (BDF). The ath12k-wsi
binding already describes using qcom,calibration-variant and
qcom,ath12k-calibration-variant, but it is not implemented in the code.

Many ath12k designs expose all the radios under a single phy, each of
which typically require a separate BDF. Without this, the radios may not
come up or will not be calibrated correctly.

Fix this by parsing the device tree for the generation-agnostic
qcom,calibration-variant node or ath12k-specific
qcom,ath12k-calibration-variant node. This allows the driver to properly
select, read and apply the correct BDF.

Signed-off-by: Andrew LaMarche <andrewjlamarche@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 25 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index cc352eef1939..e45f76d81337 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -806,6 +806,31 @@ int ath12k_core_check_smbios(struct ath12k_base *ab)
 	return 0;
 }
 
+int ath12k_core_check_dt(struct ath12k_base *ab)
+{
+	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
+	const char *variant = NULL;
+	struct device_node *node;
+
+	node = ab->dev->of_node;
+	if (!node)
+		return -ENOENT;
+
+	of_property_read_string(node, "qcom,calibration-variant",
+			&variant);
+	if (!variant)
+		of_property_read_string(node, "qcom,ath12k-calibration-variant",
+				&variant);
+	if (!variant)
+		return -ENODATA;
+
+	if (strscpy(ab->qmi.target.bdf_ext, variant, max_len) < 0)
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				"bdf variant string is longer than the buffer can accommodate (variant: %s)\n", variant);
+
+	return 0;
+}
+
 static int ath12k_core_soc_create(struct ath12k_base *ab)
 {
 	int ret;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3c1e0069be1e..39700a780ee2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1352,7 +1352,7 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ath12k,
 			  struct ath12k_board_data *bd);
 void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd);
 int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd);
-int ath12k_core_check_dt(struct ath12k_base *ath12k);
+int ath12k_core_check_dt(struct ath12k_base *ab);
 int ath12k_core_check_smbios(struct ath12k_base *ab);
 void ath12k_core_halt(struct ath12k *ar);
 int ath12k_core_resume_early(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b7c48b6706df..22ef5aab871f 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2903,6 +2903,10 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	if (r)
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
 
+	r = ath12k_core_check_dt(ab);
+	if (r)
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "DT bdf variant name not set.\n");
+
 	r = ath12k_acpi_start(ab);
 	if (r)
 		/* ACPI is optional so continue in case of an error */
-- 
2.43.0


