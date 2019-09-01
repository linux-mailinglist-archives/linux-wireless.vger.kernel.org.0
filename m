Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA274A48E7
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 13:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfIALfD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 07:35:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46102 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfIALfD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 07:35:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id f9so10269121ljc.13
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVd3kbi/hgouNhLyAxTt4JN+8o8Ew7a4R9O5k2+jamQ=;
        b=sYPN0KzhudKap67e4ZnJJBKcAG8IJNtCigbqzHJ2Hge7l5KlCHDGm3XweCKm/L5wtq
         pKbi5su9mxNuHVMh/BaY846eF8+cFtDJWylnAJ1T3mRyhJlBSqqa5j4Xjk/Mg867I+cx
         Q8YpGI0V+aRlG31koeSQy+bJJNuWWYfh9YRVtUAaCVbP+khEC3uqHn6W2eI82qMjCGuc
         U5v3IIhhg55GqRlAz2Z03n/MpTb1fBn1zAEHOUGYM3OJq8YqHOvkYg4s84YvIBDBlhPS
         sv6K30NeB9n6PKTVai3CYly6BLaVMFtwVIJxS5ri/dc080aq8Q0AxhYzt7yhjaav96R8
         32eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVd3kbi/hgouNhLyAxTt4JN+8o8Ew7a4R9O5k2+jamQ=;
        b=E+7WcQPZnO5nMzVGT9ybg2TPVC/gg8dgApJk/waZ5Av1bify38ZeFyv34r4FBV6TmD
         L6E6qUgv8aYkSn3puBIlfraUvBzcZvAylQYMODDBTHZP2awYS6J+XgTR59V6DlM1fFwC
         zXjsrdGdig8xFi5xr6os8t02Mx5ZTdpsmNzLPH85stWxZP1mIFq0ZNr7gQlLMjQ37C6A
         wIvVU/Byv47w2UV+FsoszreYQe1VqpMViNtpb5Qj+P2aAOfl5j3286plhTKIjk8vb/y9
         cJEj2beNJM/Lq5jkxeGexuQAiDKTUBZAF+JuM8Z507MpMjf+kOeBQEhaaQtx7qZgbFmM
         1m2g==
X-Gm-Message-State: APjAAAXF3yRJT7lbTZGdXcCs/iUjjMzCUjEREAUsvEV4C5kYa88+dX6N
        NFSGbNrGz7Lz3CACu6UUxv0=
X-Google-Smtp-Source: APXvYqwYxjf+7/VJITLhng11ECja6O7L1vfTYQpvksz3N8BgYMwMeatsLRJRqJ+8q5uJI+ZJdB0PuQ==
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr2834343ljj.75.1567337701304;
        Sun, 01 Sep 2019 04:35:01 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z30sm2197045lfj.63.2019.09.01.04.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 04:35:00 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] brcmfmac: add "reset" debugfs entry for testing reset
Date:   Sun,  1 Sep 2019 13:34:36 +0200
Message-Id: <20190901113436.23665-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901113436.23665-1-zajec5@gmail.com>
References: <20190901113436.23665-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This is a trivial debugfs entry for triggering reset just like in case
of firmware crash. It works by writing 1 to it:
echo 1 > reset

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../broadcom/brcm80211/brcmfmac/core.c        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 705b8cc53c3e..21e07d1ceeae 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1086,6 +1086,29 @@ static void brcmf_core_bus_reset(struct work_struct *work)
 	brcmf_bus_reset(drvr->bus_if);
 }
 
+static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct brcmf_pub *drvr = file->private_data;
+	u8 value;
+
+	if (kstrtou8_from_user(user_buf, count, 0, &value))
+		return -EINVAL;
+
+	if (value != 1)
+		return -EINVAL;
+
+	schedule_work(&drvr->bus_reset);
+
+	return count;
+}
+
+static const struct file_operations bus_reset_fops = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
+	.write	= bus_reset_write,
+};
+
 static int brcmf_bus_started(struct brcmf_pub *drvr, struct cfg80211_ops *ops)
 {
 	int ret = -1;
@@ -1161,6 +1184,8 @@ static int brcmf_bus_started(struct brcmf_pub *drvr, struct cfg80211_ops *ops)
 
 	/* populate debugfs */
 	brcmf_debugfs_add_entry(drvr, "revinfo", brcmf_revinfo_read);
+	debugfs_create_file("reset", 0600, brcmf_debugfs_get_devdir(drvr), drvr,
+			    &bus_reset_fops);
 	brcmf_feat_debugfs_create(drvr);
 	brcmf_proto_debugfs_create(drvr);
 	brcmf_bus_debugfs_create(bus_if);
-- 
2.21.0

