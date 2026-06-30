Return-Path: <linux-wireless+bounces-38385-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MtqsAm/GQ2r5hQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38385-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:36:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6906E4EB7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:36:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PZZ4wZI4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38385-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38385-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B84A3145CB8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4929BDBF;
	Tue, 30 Jun 2026 13:30:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D432264A86
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 13:30:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826218; cv=none; b=Ckm9gWqJWuk3neI6cG17SBRQ36ZqiD4XYY76cpYor92zyCoaPEVRdu84g/uJrLgBuEtw9QHzS4F4aqPZg/9bhbWmjPdyu4BMQhGvrxuOYwqWw9VCv9x2/Ihnn46Sn7VyE4VfnDlQ0j883Spm2g2ER1xbUGgmgGlgiIBlp/h9FEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826218; c=relaxed/simple;
	bh=se8oO18KwTGJI+h1AL7a07PDyLW5Lj3zt4kqe00qAWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lz/xt5OOvgz4cHo2/FO/vPXHdR3xtwVMVhiVlOdGKBPoqIqCEmVRi7YPUtbXBL8cKbpOZeEilrOIyiCb6A7u/tOwEy5kjqcvFZA1E/NqGRmCtPF3dvnQe58YkB4codj0HMO8m/BY+UuAzzS+H1DzWG2PMg/CmMLiiG9NQXKdjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZZ4wZI4; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eeb4508f29so33940956d6.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782826217; x=1783431017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDoAFc8XKizPW/kSqNJO42Z0ejdb4d/GRE8OyCY0WHU=;
        b=PZZ4wZI4qKGtR5TIMw5s/uRJMwYpT3Vw5qz4HLCUmrxEMONwqUw6T6KbZvmyR/z36K
         NA7FjvzIhob7Db2nq1D5LI6WaZ3L1Fqtk/d9bA2lDsobYj4xC2RiD+4va3zTGrQR+eve
         0BlBmvvibuT3lUsoXxsPPVKlbWCSqzuJPGm7+VBl28UjYjK6+71RRIeZbAAc2brpgN7H
         Dd0Zx8QmONFHMzD9KhLVKnJz2DiaiC9lPf652LrGNnzMJHoicY/J1vz9MnGnMmWm5ktF
         blU59yDM/kSjkLsg2KEQld7fa5Hb4vJd4kZj+nYN0JhH2qUrI0QAG0YeCrWkXo7uMO7y
         YfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826217; x=1783431017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDoAFc8XKizPW/kSqNJO42Z0ejdb4d/GRE8OyCY0WHU=;
        b=hQ1qqSPV61jhQcpgY2R2cTeTfK/IrEexGDbhLeM65ToNhU7syZYcQ1CU9fbFUIdyF2
         GdhKFsLTmCXrLE26No+glIJ2FwzSk3PyGL5/dZ58N2PDzsJFM69EwOvytza7DqixYLDn
         jjz63VDuUs2gWeD6+HTiqxSfm/USjP7Sii44is9t+S75Wigf17RYBRkRCIvuphvVs3MU
         jQ/tzZTHl9vACZ/tKjx0n04LMCwRwjh41LPjBPQ3hVHjrb65pCB6LdvPgntiYXbuWHn6
         dDloBPbvhU/spVg82WCARZMCu+xSA2VpgYbnDD+8pAFpxr4AeMcol3g+U39oXe3rpAKd
         DbIA==
X-Gm-Message-State: AOJu0YxQv3UjfYyoWqS41YAogxPDexoybRtQgHBaZ8TVDHFAMixPKpAp
	vccBOPau5vHnoXMIcpDsn8Lf6R58+zM1VQ8Mk5p9yMOuv1kjVzzRdfMeAWz9QI4w
X-Gm-Gg: AfdE7cnnpeT0nOAqhnL7nJJG5MgDHno6ey4uwmpko+lWEWysa9F0rSP89o1rUl3INuR
	Npgbm8blDtZJm7xtLMV5T9eWoYwaYEp4wQ1cPQ5CoU4FHwcETDiEoDPq1smJZ1EtDXHSlMq0zx4
	vzx5sGw9a/x+RbaEZwhe0ZVo/RC1uhL5QxGpOlpF/X/ElgPvFvBd07yDgF6IhhRpuDkoqXMrbfD
	eGGqE1gojpWORDvYz/PKwwWPMfrtBv20sMnQTZ9tFNEX/sVOvWnoqoNsteriw86OIe1UYD+7rWj
	Jy51OjX5AezS1TWiv+bH3jBl7BwGAp953/cNt+ncguR2nMiPfecu0hHma++xUaSofTJkpGcnW3d
	c/itfY1QZvexOwW33TZ9KGDX+bAR/VhrsKnaU/AAcdsAk1sI0vma+7CC1okk5TreFo4HvOI+zbS
	NzAG4s8+0wSiWrpKUs68+b4klUm79PCLm/Z0wzFei9BhpBFA==
X-Received: by 2002:a05:6214:8082:b0:8f0:ead1:a00c with SMTP id 6a1803df08f44-8f2d25b4bc8mr7948476d6.55.1782826216155;
        Tue, 30 Jun 2026 06:30:16 -0700 (PDT)
Received: from dev.lan (c-75-67-38-46.hsd1.ma.comcast.net. [75.67.38.46])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-8f1a7b26b2csm23003536d6.45.2026.06.30.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:30:15 -0700 (PDT)
From: Andrew LaMarche <andrewjlamarche@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew LaMarche <andrewjlamarche@gmail.com>,
	Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH v2 1/2] wifi: ath12k: support calibration-variant from device tree
Date: Tue, 30 Jun 2026 13:30:00 +0000
Message-ID: <20260630133001.1426824-1-andrewjlamarche@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38385-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrewjlamarche@gmail.com,m:ernestvanhoecke@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D6906E4EB7

ath10k and ath11k support reading calibration variants from the device
tree to locate the correct Board Description File (BDF). The ath12k-wsi
binding already describes using qcom,calibration-variant but it is not
implemented in the driver.

Many ath12k designs expose all the radios under a single phy, each of
which typically require a separate BDF. Without this, the radios may not
come up or will not be calibrated correctly.

Fix this by parsing the device tree for the generation-agnostic
qcom,calibration-variant. This allows the driver to properly select,
read and apply the correct BDF.

Signed-off-by: Andrew LaMarche <andrewjlamarche@gmail.com>
---
Changes in v2:
- Drop ath12k-specific binding qcom,ath12k-calibration-variant in favor
  of generation agnostic qcom,calibration-variant.
- Link to v1: https://lore.kernel.org/all/20260131003222.2011259-1-andrewjlamarche@gmail.com
---
 drivers/net/wireless/ath/ath12k/core.c | 22 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..52c28864c63c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -812,6 +812,28 @@ int ath12k_core_check_smbios(struct ath12k_base *ab)
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
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..3cf39ae06fd3 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2945,6 +2945,10 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
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


