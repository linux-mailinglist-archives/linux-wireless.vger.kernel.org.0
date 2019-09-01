Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58090A48E6
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfIALfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 07:35:00 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41925 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfIALe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 07:34:59 -0400
Received: by mail-lj1-f180.google.com with SMTP id m24so10332414ljg.8
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PIos16FjiE5GoL1yJskqfiUeYgV7y62AOMsmaPsaEs=;
        b=hBirwzCZSHdqow7MQZ7/n3/eGut9v/gJwrpGrzIy0M/AP+/b4BRNUDjXolOtwr6Ous
         +zh3b6HRjujcf6TmTJrGJ5JgeQNvb8jAAIVZoWfGEi1KgIYb9gJXBqoG/10hhr+BuFXK
         05nQ1YzMG9NtkJgaib5LEUdsxTobT3MhcjSxc/z3X6RmAzs6ure7xSdsFxOeiTwdOd/l
         xIvIDRyOv4NSwHtShsSMHLCqYrxPQM1gWbELowWGOSG9yNq8Q4xaXi6SwaW9kzEOyqKn
         w3OCoNfV7qVsHRPPpgsDzHyHelHAGbNt17IXI2ujbXUi6FZ51xqzMq4gdHmIOgSx2A3i
         GieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PIos16FjiE5GoL1yJskqfiUeYgV7y62AOMsmaPsaEs=;
        b=OZn7OK6iLiagjqua6NSE8yfgtoPF3F002a8PRPBiW8ritElY80Bpq3SHicSSmdisxu
         gxgIB9cC7g+8I0nhrEypOFseoHN28BXfgddkjaEvDawyLj1C4EUIv04gzSWvr3zW/HjV
         vcHPsGCtD/49nsZnkdLO64DMn/x/4WCq7OGSaRB70YM556KwwxqxMyG90jGvLUcW4mV9
         3MC9ZHT77fGbl+QghpQ0n8ticU6htFDD+CX/+cFjHVmVlvvPt4HTDohgJltlbo6f9RBY
         dO53E4m0KV6SD2YU+gTY4rBlnzxIDhmEVR21HJ+153xeLrzVabW58uroXHAieelZKbcg
         2fjw==
X-Gm-Message-State: APjAAAUmw4hR4ID/eUGOCWPXPy/6Pfc6Qb/vIgLl1kivof2o9sNWP7xK
        Rrdn2/oHkMG+8gKuYdoNQpc=
X-Google-Smtp-Source: APXvYqw8mCvqhTTvNoRjTmv8looTeWcLoYitah1sFGFWd9NAQ//+rHLPC5uwfeIOQTt9RxlVHRCvwg==
X-Received: by 2002:a2e:91da:: with SMTP id u26mr13378916ljg.125.1567337697716;
        Sun, 01 Sep 2019 04:34:57 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z30sm2197045lfj.63.2019.09.01.04.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 04:34:57 -0700 (PDT)
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
Subject: [PATCH V2 1/2] brcmfmac: add stub version of brcmf_debugfs_get_devdir()
Date:   Sun,  1 Sep 2019 13:34:35 +0200
Message-Id: <20190901113436.23665-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

In case of compiling driver without DEBUG expose a stub function to make
writing debug code much simpler (no extra conditions). This will allow
e.g. using debugfs_create_file() without any magic if or #ifdef.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
index ea6e8e839cae..9b221b509ade 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
@@ -121,6 +121,10 @@ int brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
 int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 			       size_t len);
 #else
+static inline struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
+{
+	return ERR_PTR(-ENOENT);
+}
 static inline
 int brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
 			    int (*read_fn)(struct seq_file *seq, void *data))
-- 
2.21.0

