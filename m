Return-Path: <linux-wireless+bounces-32129-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI8mM9nYnGkFLwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32129-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:46:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D317E8D8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B643096EFA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006BE37AA72;
	Mon, 23 Feb 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig2tXgWb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BB3783DE
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886593; cv=none; b=ljnMdNcmxt1O6RoDq/z0yLmJZCExMfPg9Y2g7olga752GKIr/CdrdDX24e5JngczbvKZgBe7vuypzrmTr962M+J4x38ce8ti1+HrnTT7W5qL4foKnwoekn2/ZecC8MlGGBWzmPs2u3sBlmmTJiPNYwHHX9uYbu6uEiMnZHEMXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886593; c=relaxed/simple;
	bh=fA9S2AhxnAOmqqHU0gNRU8ri57DzFNJjWsSPhJryMVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIy1P0a0vQEuTd/X4S0TBZ5REjERMFjXn35s1XcjLVvpHCobDP8ErXEM7bmVX1hj5wFMUzR3VHZgAua6bKbN3bYYI/e8ho9VLwxFknR2l98plQXxq6Eqixxx5EHXKcA+ybXTBT9ZWV9tIDZX2gMbruC+3TgZG3D0rY1cGr4CIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig2tXgWb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso2478794b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886592; x=1772491392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zA8neqIU5RolfFhf2Lp4LEYhHtdffFh3y3a13wUOp+g=;
        b=Ig2tXgWbE0VDLOJq6/XDlpyfMp0vMRUJM2cF4hIHw/OyFiqyQP1+a9WOM1jf2JMdWW
         gFKkSHogQVfqfenxGxXBCt2xQk+6kYNygVIVSPMDOXL+cAQTavziu+fCKTbdcQJ9AZLj
         xhQheZWJ8/mbNVDz/f3SmOLQYGedVGBx156L2a1UaT24HxGRBBNdJpvTp2gg/6RN1l+S
         /bw6nVoG+uwAzSJwCkKDrlPsN+YQb9ZLuL6r57PLLqtG9jTKi04tSOcc042f390T3IaS
         CyVtQNUwvpQKP9QuqVDe9bH6gH0bG6PDml8W8pYiKXoFWF13Eic+uWwF9nhb6dNVBMJr
         Gg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886592; x=1772491392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA8neqIU5RolfFhf2Lp4LEYhHtdffFh3y3a13wUOp+g=;
        b=cf64YH2Ec694YDSSXJyffQnVVqIHaom+j/tGtcZ6zHzBIdsjtNwLfnUa+vD8n7U3cD
         QOnvBe7+eOPlXbLjebWlsnI7bAQ6z65ziejbyn8ujDZBnHg8AjEjSqzy8/L/PpzmBJgm
         dkPnRQbnQDnoxpAmvvnRtt3xbpUoi+7kaOwHlrc9IFnDrq7TwtXd4ESlYJFLmy2lVGUr
         Y/RHyJix9QtX67Dwz1hU9Y+zosK9vrbrCfWtIJjMfgwB+tjZcbnnxXLCkIV1Zb75S0yF
         +0OlGPfYqZLabFao+iALtOUh1Qx5yohl8lUNjj1zr1tZZJWwHs4b0/xlAdUH5C01mlGI
         2wUQ==
X-Gm-Message-State: AOJu0YzJFNCXTh49L1XxKIjxWjrEFLtNHO8Fm4m9VWPe/oZpn84Dgw5E
	dJw5JOa6APGdTnGnlxEqubmTlq6LB4xG75Oyfy2rIXUNkM7NsXdW10pqYNKv4Rhj
X-Gm-Gg: AZuq6aKxumzicpYKAN+0xQ+um97ZhCWSQGtkYq4+ZWIi4/8G0uzlB0lRwj3XcB00E5T
	PwCFARZjk+1Ey+hsmQZSRNqhXst2ni5W0si//LMDlQvEdquPA53y5b2sN1EjlEso80eLtFUtyBk
	E8pctCkHNsE0tP60/kY6+hBf0GDV+OeXgX+3Xv563ahWHPGRdpAgorxxVkRbQFRCKJvqhOkhiQB
	qj3YySctGGr4PCC3wiElpSrQxHrBOs7NMFGj9woJWxO6/DthKi3+bUtnacOjMcU8cyGBm9u8aA1
	KKP3ZtOVZ0aDrT3X7xg1e/EUZNu6CC7/QWa3xpgMg1wWX9E+3zNRtuzGFVvcx5bpjimFc5piPMT
	N3wdt7BYxWSdolizP9+D5HTUdaQwQjlQIvQWTPNi044/lidwP1wcvANn3k4jhJ9YrQrWLqDdewJ
	CGMzqMucfFV5ae9ahXL/w4hx/wWzPr+acLV4qtQUW1A5lCioxF/pz3YfIyBYrDoxxM
X-Received: by 2002:a05:6a00:130c:b0:7e8:4471:8db with SMTP id d2e1a72fcca58-826daaac4c5mr8310461b3a.60.1771886591857;
        Mon, 23 Feb 2026 14:43:11 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd693845sm10614461b3a.26.2026.02.23.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:43:11 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: owl: move name into owl_nvmem_probe
Date: Mon, 23 Feb 2026 14:42:54 -0800
Message-ID: <20260223224254.27081-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32129-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 535D317E8D8
X-Rspamd-Action: no action

There is no need for dynamic allocation for a simple string.
request_firmware_nowait copies the string internally anyway.

The error message on failure is also wrong. It's an allocation failure,
not a find failure.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c | 31 +++++--------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index fe1013a3a588..b9ef34709202 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -137,24 +137,6 @@ static void owl_fw_cb(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }

-static const char *owl_get_eeprom_name(struct pci_dev *pdev)
-{
-	struct device *dev = &pdev->dev;
-	char *eeprom_name;
-
-	dev_dbg(dev, "using auto-generated eeprom filename\n");
-
-	eeprom_name = devm_kzalloc(dev, EEPROM_FILENAME_LEN, GFP_KERNEL);
-	if (!eeprom_name)
-		return NULL;
-
-	/* this should match the pattern used in ath9k/init.c */
-	scnprintf(eeprom_name, EEPROM_FILENAME_LEN, "ath9k-eeprom-pci-%s.bin",
-		  dev_name(dev));
-
-	return eeprom_name;
-}
-
 static void owl_nvmem_work(struct work_struct *work)
 {
 	struct owl_ctx *ctx = container_of(work, struct owl_ctx, work);
@@ -195,8 +177,9 @@ static int owl_nvmem_probe(struct owl_ctx *ctx)
 static int owl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *id)
 {
+	char eeprom_name[EEPROM_FILENAME_LEN];
+	struct device *dev = &pdev->dev;
 	struct owl_ctx *ctx;
-	const char *eeprom_name;
 	int err = 0;

 	if (pci_enable_device(pdev))
@@ -215,11 +198,11 @@ static int owl_probe(struct pci_dev *pdev,
 	if (err <= 0)
 		return err;

-	eeprom_name = owl_get_eeprom_name(pdev);
-	if (!eeprom_name) {
-		dev_err(&pdev->dev, "no eeprom filename found.\n");
-		return -ENODEV;
-	}
+	dev_dbg(dev, "using auto-generated eeprom filename\n");
+
+	/* this should match the pattern used in ath9k/init.c */
+	scnprintf(eeprom_name, sizeof(eeprom_name), "ath9k-eeprom-pci-%s.bin",
+		  dev_name(dev));

 	err = request_firmware_nowait(THIS_MODULE, true, eeprom_name,
 				      &pdev->dev, GFP_KERNEL, ctx, owl_fw_cb);
--
2.53.0


