Return-Path: <linux-wireless+bounces-38312-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xVlsJ6wYQ2qsQAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38312-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 03:15:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E81226DF8D6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 03:15:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LI8A+i0u;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38312-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38312-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B973031EB7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0D282F15;
	Tue, 30 Jun 2026 01:14:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A1235BE2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 01:14:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782069; cv=none; b=J57N1Msyw4dxU6OYkHyPM7Qeftru1P8ReZ8glc86nM8emnYqU0BGNnBgdl1nFlIp3+RSuhvqE0UIj7Lq8jw9l2t2JQoUuIvIdeo7eQyaj3Nr9j94T+tEcADEpyY4JALAH8HCkTpfljgDpO1xeQvbKGxhqSbOiGZMAkXKqVmS+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782069; c=relaxed/simple;
	bh=se8oO18KwTGJI+h1AL7a07PDyLW5Lj3zt4kqe00qAWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCaNDR9+giiziGpri8r00RqOKkIyxBswfE4M1IuN5ou2fSgrD2q1hipb21ueIj/zZKNEsqAepVeFXhMo53GbHkMy58waRgCXGuLc4WI3U+k5J11KraYXhc8brOsyxPDBjTeuJ5v3mLHDxGVuM9edX/299Do+Lk+BW/TCGELOPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI8A+i0u; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c15bf5000so515901cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782782061; x=1783386861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDoAFc8XKizPW/kSqNJO42Z0ejdb4d/GRE8OyCY0WHU=;
        b=LI8A+i0uApDbD7bVUcgrGEMW/o13hiv80DJLe1AkNvJ7+mHhRonYvpQ60kBIMuC0M5
         hkuKBAtuVCXRGQYFGmTTraiM2YTcnKR2eHUhheS8Wgz9bdSNbvlUQwlgHFx3ZP0/szQJ
         P6ylUX+GHec0zORloAd2wI71YyPH53ZGWDQ5fndsH3Z2kIrm4epeVuUlao8cB+jIBX2e
         /asfvU+BQi0RzHLGO34DwM4zGw2A5alPYOhUy+PdcCHMNunVgZCjnXJAxA0f3n+Me6HK
         PSV+pxDkf4D9B3A87+TQhC8SNMUQq0pAW2RmM4yXPrP7K36Jbx49R24Vr7vt92kLnife
         A90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782782061; x=1783386861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDoAFc8XKizPW/kSqNJO42Z0ejdb4d/GRE8OyCY0WHU=;
        b=JXj+IRZYQPFctlFN1WZKwsUHgcIciGXRi6Q/Hm28jC+WD4Ae3DZ9TH8C71GX5KrlSU
         dM36IgGTjtlrh3gvwzeFNnyB+a7glNoZIWd36LClzi5CKD6TE8rmWeOO0hD7T9E9+cA5
         Gf3M9adOVzBJbb4lMEDQ9U8PaFM7+MjaI6iRePR4iK0RFiQJO+CLak852v6UB60KCx/3
         /IHKQECOmCsrBYpkgmdykwLvrDn/tLwJnF7n7S5u+a75FqVogg004kM0y3EpYg2DHujU
         BRnU84VyomSI0mYESc3Ot6mtO5it0HLhXLlI1ZtgafddKt5bmqyKzDOsX5MpPJI7iO0U
         CDLg==
X-Gm-Message-State: AOJu0Yznvr3hntgx6jtr4upPNu5+o3I2b2dU0V+7QEe9y4hgrh4Y7Ozj
	tMfQipFGa0jlykNE2rkc0Dlwxz617lE0jeVsuEiotK6+5mHW/+OxvOLd
X-Gm-Gg: AfdE7cmfZH9ryLED9+FVx6ZK0MRs6lSX7DqM071m+oyPEjeJQTGNLGJv6z+jiyfAidg
	YEtzu7davVccc/e1LEJPzpGM0WpRNXaN3/fKbJIVaIu0lF/3M1Qa0W3ISbCtZi9mPWtzubqaXGn
	AsjWtUzi0Nv5p2qbNIlDKgPoe2uxnL+dCzlThioh7MPVlaGJ3N2cqLuXOonx1TsQJx6Ob0ERzCN
	ecjTDqGEYW4KfbzSTYisPclqXDA6vetuxLk+68TNkFDRoeBH75T7FJvP+9ePnZ+SJjSZR8PFdWx
	J0CiJK4xGoD0vHhEesK+yvuo9BkzNG8csTfGgSgf2C/l18234Z+G5Yh+okNYc0auKo7ZvFXEBHz
	oAjCsUEV8d57dNQdZEnVi0KtJvFFd7figYt8Hk5hAzhDvQHdjt8bkpnRPwvRfy7a5wr+ygYWW5K
	U3gfH7dRnZ8OCNA1bOGja0B877pd6q85Z1vqCRZzhMxFy7Bw==
X-Received: by 2002:a05:622a:5d1:b0:50e:6313:6e13 with SMTP id d75a77b69052e-51c10751ccemr24874721cf.5.1782782061019;
        Mon, 29 Jun 2026 18:14:21 -0700 (PDT)
Received: from dev.lan (c-75-67-38-46.hsd1.ma.comcast.net. [75.67.38.46])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-51c1099aca4sm7719801cf.17.2026.06.29.18.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:14:20 -0700 (PDT)
From: Andrew LaMarche <andrewjlamarche@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew LaMarche <andrewjlamarche@gmail.com>,
	Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH v2 1/2] wifi: ath12k: support calibration-variant from device tree
Date: Tue, 30 Jun 2026 01:14:12 +0000
Message-ID: <20260630011413.1424654-1-andrewjlamarche@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38312-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrewjlamarche@gmail.com,m:ernestvanhoecke@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E81226DF8D6

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


