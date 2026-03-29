Return-Path: <linux-wireless+bounces-34118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5ufeASbXyGkErgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 09:39:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF635121E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B29F300E245
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5B175A6D;
	Sun, 29 Mar 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSeehxt2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF122C21EE
	for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774769952; cv=none; b=peZh4zFFId0F9YIiWe2tvedVroK+gzY/Yy+5vdPGHNEX9bkIdbyHZ14VTOURaAEqim51ZmbtJpRIhNJfPGtIprleOODKc/gHhz5qivCceFEkxDdOd+TFK45A0rs+QM/ocm6IBmzrQUzgqP9vjUdu/WkqVLSCNb+sG18kkTxdKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774769952; c=relaxed/simple;
	bh=TdDm38vrAmSUlvhXt9NlwDETtT5aTysm08q/2+oasyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbmlghfT+OaPDJqCGHO4rESQ3wNGzuFDl8MvbCk9HQEUp9qA9HvwWOJ6qcNC72C+MicrHiiZBr+L7EshnpTxtp2L/yJs9FQqdbjS3ZLA3qm49fjrwJcwfWxDJ+rePtF3oRgpcAwBWouQHaGKYzEficexUfJQSXWwM3RwTYO58yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSeehxt2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fb439299so31258095e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774769950; x=1775374750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEKJAdHSYTG77GQhnzcTFePsNoW7/3Wpn9Naib1NAmk=;
        b=TSeehxt2brJnnFYZFVCZy3rhUFylhUdZQ13fGBY4OYZArj6Io5HJNnCmMTOtjfEJht
         T+G1tRTU0AI+vXgcGMuXYh3QJAcaO39lCChCVdhdXyXJgrOyWLdIWiBR/4ciSIjFJLUj
         48LIRYbp7a5woO2v++MYfO/aDiUvI7BJioiNv+d8S5vmNNOblu90f2godUms5TZPMb1o
         x9X9EUv7fUnCsKSV9Es7W9asNLn6O9C45Iud43kjjheB/tN7UuYOsNZbPd9FDKxSN6tA
         Smz4jl5qktnYPbIO7FAwp2eAONP6sRRIJRVxrXcb3FRMZrM+AobNODm0VrBgNNXFljeq
         iZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774769950; x=1775374750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEKJAdHSYTG77GQhnzcTFePsNoW7/3Wpn9Naib1NAmk=;
        b=IH9RoSksslhFvfjIhgaw8x/FQtjANcBLoWshW9+A9TKkHDkhdE1yQWits+5tPM0tN/
         Sq2Lr6kX9ewwuCDP9Q/afyQEoG+LvmyVvmpNXYJOOUYpWY81E68sam2g2DrNNGJbUqBX
         pK8bwzlMiDZbssMnKI5S7UYnXRdpIqLnqi4B2r45sLLmsEHDg+vbkavKmJP5/S6zYhKD
         bC0TWVa4dIsQlEMAsmtUnIraxoBayLZwM6EBH6OIhoBdRwOcKKc35Ph3PhpphqzFtAVN
         yNCfLLG/twfVMfZVCixdow6I0b1TQyd4ViIwyBFAsJ2Ey1dAFPqv4X/Q7p6dYB9FVyj0
         KJYw==
X-Gm-Message-State: AOJu0YxGbnQOHCDonIButcRVJECvLlWMkzqmMolDp6aRnIzH4GQnXBJD
	Bs7eKupxUqIEPxkz6FyERCieTJ62mXuTiJw3MdRKnZ3Cjk4E28FN7Yoq
X-Gm-Gg: ATEYQzyf/pe9tzyzSA0JqWO3ipyThKjv+iNUIJSkiEbUcIJ0SkK8uN3svKaHs+3EZHV
	ofcHSHa+6TkOJR7u/TrKGGOVQVavA6kafD5c/+EJIY5C/bL5kEOh20dXf1QZyNHWHcyA/iWVWOp
	CQltBlvmh7ZCHQ4yKbl9YvkGi82MrXi4x6vJVpW60gyiuI01zzU37YQPwE41FNMVmipIa8tnX3+
	eDUN1HyYM3a3CZTkNi4wz6vciD1fRXSU7cgHJsfy/OAfdw1p3bGJRGB0aDrJ2LRvPqmYH54UWAU
	53Fh+mxPRekDho2nzv40aFyl7DK93EYq8lKWsWgn5mqIIWxG7HHyjfLUxzt52DIorIm9hYUcVFG
	M4YZixgmObR6CYgx3JpJzZttGXgcpuQNr3lqnjnA97M7v/N4K24bFl6tL+98DFmwOzb4yIshpsQ
	xsV9keODVxPiVsRh8QVFO+ZWPc48A13P4/QUOrvxfjWUA0iIeVDDHsKo3qZYvvJCkUCnbPhBYxY
	lz8Acm1gu28N9uLSAL+wOTZRj1Oxq0t1hdtA2puPiACRJHUhPU3xRrONhvGGTClyFHysD6pu+cw
	Qx6ARte55Gwe+TvRMG48TYx8ykjrBbrLj8b3vYJsv3gDkIy6ZLG4xqRToANYsMpjeHvrjw==
X-Received: by 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48727f2373dmr136434845e9.12.1774769949398;
        Sun, 29 Mar 2026 00:39:09 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712b268sm51754575e9.16.2026.03.29.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:39:09 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christos Longros <chris.longros@gmail.com>
Subject: [PATCH] wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers
Date: Sun, 29 Mar 2026 09:38:57 +0200
Message-ID: <20260329073857.113081-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34118-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[chrislongros@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BBF635121E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw89 stores an ieee80211_hw pointer via pci_set_drvdata() at probe
time, but io_error_detected() and io_resume() retrieve it as a
net_device pointer.  This causes netif_device_detach/attach to
operate on an ieee80211_hw struct, reading and writing at wrong
offsets.  The adjacent io_slot_reset() already does it correctly.

Use ieee80211_stop_queues/wake_queues instead, consistent with
every other queue stop/start path in the driver.

Tested on RTL8852CE by calling the handlers from a test module
before and after the fix.

Signed-off-by: Christos Longros <chris.longros@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 43c61b3dc..64554eb35 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4624,9 +4624,9 @@ EXPORT_SYMBOL(rtw89_pm_ops);
 static pci_ers_result_t rtw89_pci_io_error_detected(struct pci_dev *pdev,
 						    pci_channel_state_t state)
 {
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 
-	netif_device_detach(netdev);
+	ieee80211_stop_queues(hw);
 
 	return PCI_ERS_RESULT_NEED_RESET;
 }
@@ -4643,12 +4643,12 @@ static pci_ers_result_t rtw89_pci_io_slot_reset(struct pci_dev *pdev)
 
 static void rtw89_pci_io_resume(struct pci_dev *pdev)
 {
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 
 	/* ack any pending wake events, disable PME */
 	pci_enable_wake(pdev, PCI_D0, 0);
 
-	netif_device_attach(netdev);
+	ieee80211_wake_queues(hw);
 }
 
 const struct pci_error_handlers rtw89_pci_err_handler = {
-- 
2.53.0


