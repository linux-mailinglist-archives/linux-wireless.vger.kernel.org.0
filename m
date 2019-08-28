Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1229A0695
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfH1PsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 11:48:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34642 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfH1PsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 11:48:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so2599795lfe.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2019 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVd3kbi/hgouNhLyAxTt4JN+8o8Ew7a4R9O5k2+jamQ=;
        b=BHQVBwYY73VY2Cla/QfZoxLWu6vYT8gDMz26oSxNdWqFVz4tkdeZFZLmvzkU8caYgZ
         smX48UGapwN48rPZ3h/mlv51y6tfl6FPu1X26oRM3EXqnxM0LPbSaNuyy/ORCGrK+l3I
         3+m+8bHK2Cu6RMIv2RUR9MulB+HwdSEiLcr/4D0Vz6cSu3GxJy850NO+trr/eEemi+MA
         syqg0kYGt74eSlXFSPTWEWoF+zghCj1jC8smwHVjkx8rHj10UoGSo3MtL2E1CD4Uk9YI
         tJlG5mJakE9iVLUfrBQvbpKzxDzdjwRvwZhkKUVAHrNE964hcA7fcCmLwpIxk8AhSSkg
         hK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVd3kbi/hgouNhLyAxTt4JN+8o8Ew7a4R9O5k2+jamQ=;
        b=job/B/85DRXuGu3sPWMOF1glrJYBNzh9j99nmLsdJS6w0316gbLQnVhc+zmAWfmoaf
         zaYEhtRc83Ts/3dVRKxpqkvsaq3MD5aObvqR7Jg0mk0fHtMTMNea47QEtA4NtoYZQPaN
         VwbW4VYaPq60lMS/zoGJIthclwzzWpfSMxrVNc24hirSm/9iyAL5MJ3yEsznKq2E0HJn
         VMG9BT8l39O+fUs4Efv4pMMnSBm3644A5GOO1SfV0Yea0s2w9fJmEmEM+BslMnTc45If
         BSDfhj+sSKHWyZwDfz8970o0mN3MZlUUoYgOpMMlaP+8g3IualFGVEXAZi5UGRUSgJc5
         rXTA==
X-Gm-Message-State: APjAAAUVEf00mM86U9bZnN4Sr9HRT2pw0u9bESxL83XUaMSJ9rckBpeK
        CLEar2tvma5xNLbwqUp67o4=
X-Google-Smtp-Source: APXvYqxLQ7hNCrrZrpHczZlJxVa+P46h3sZwJ0oU8bpuNifdtCO2xfE7lGtZGUadFr5pTCYW6gSuJw==
X-Received: by 2002:ac2:4474:: with SMTP id y20mr2793766lfl.31.1567007300318;
        Wed, 28 Aug 2019 08:48:20 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id x15sm1078036lff.54.2019.08.28.08.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:48:19 -0700 (PDT)
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
Subject: [PATCH] brcmfmac: add "reset" debugfs entry for testing reset
Date:   Wed, 28 Aug 2019 17:47:33 +0200
Message-Id: <20190828154733.3910-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
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

