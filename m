Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A173BBC62
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 21:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfIWTtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 15:49:31 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46805 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfIWTtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 15:49:31 -0400
Received: by mail-wr1-f48.google.com with SMTP id o18so15291192wrv.13
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lK6WlBeQcjY7Not1nMx9ZS5+6Wp3U85aur3QzZr1FA=;
        b=AhBHyFJgbx7ML1bQqxnUg1XlOIo3uu/rqUHrLIGn/QlzNb2sRelCeoxIsF8KvQnyz9
         1R1aRtcwtmtbRnU9mm84CroTa0WBiwwUj1Zhvb4tIxp6uR8zC7RKqJoNLD2Ptyg9Hlwh
         Il9yhAy6L1H/s8uFFvaTNWe70l0YO30PTSaOft5HXIYIGGOJMl9c8i+l+q9P/kB0XFRd
         aS0ECl9ysYtzBPzj+AAiovGMjQekzYqWAIG2wG/kPDUa3QVVhiKvwRfO9w6ru46fOZE2
         xU+6Rrk4zP/4YxugTG+IyuQzkd4KA2vXUXwZ9bDD9gxRpi27xPLnI8EifkqDcB+2VYeg
         WvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lK6WlBeQcjY7Not1nMx9ZS5+6Wp3U85aur3QzZr1FA=;
        b=msq4AkaeLtb0YvQKexn310IaDyZ2GN/HEl7C3IAJAv9cqayTwaa9tJfyA5EPhyc4m+
         YHIA4/Z5ipXLCq2lM4dtFQNk99d0ysEgxcyrYEwc51TP2gOXTRD1/Lnn8eQznZBYpzGd
         3E7GgvpjenVhIu7aec9RV5O19cGyH9VPbHlRGA7LQ+pqE5afugcyePjOmFSauTsWtors
         dcECSa3mgaZwr19spy9NFroY0+R2tBexVqoHmqXyvliK3UbowKLkwjCbp4T5O10O+MID
         Crjm3mLzRr+kC8TcDWi5BCy4z5vLcxfjliOsLoSfNLziKliPc74Rsl5lvrXF2GQ0lvxG
         XIOA==
X-Gm-Message-State: APjAAAWHPFOTnZ2wXnFD37AnmuNdcpwqkOblMoDvoZUu2dSAQJWZS5c+
        gzxe3iXF5keYUV3eAJpbRWhdosEz
X-Google-Smtp-Source: APXvYqzfXPfuj8hKWKJL2QQ6nISmLt+VACR6pfnLr6MlfHcXleAdCC4nCekzlP95ch/PBmkO5qrsGg==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr766764wrp.278.1569268169290;
        Mon, 23 Sep 2019 12:49:29 -0700 (PDT)
Received: from localhost.localdomain ([31.147.208.18])
        by smtp.googlemail.com with ESMTPSA id o188sm25108013wma.14.2019.09.23.12.49.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 12:49:28 -0700 (PDT)
From:   =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org
Subject: [PATCH 1/5] ath10k: add 2ghz channel arguments to service ready structure
Date:   Mon, 23 Sep 2019 21:49:21 +0200
Message-Id: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add lowest/highest 2ghz channel arguments for use within WMI service
ready structure.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.h    |    2 ++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    2 ++
 drivers/net/wireless/ath/ath10k/wmi.c     |    6 ++++++
 drivers/net/wireless/ath/ath10k/wmi.h     |    2 ++
 4 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index c96d1a1..2a0a008 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -967,6 +967,8 @@ struct ath10k {
 	u32 num_rf_chains;
 	u32 max_spatial_stream;
 	/* protected by conf_mutex */
+	u32 low_2ghz_chan;
+	u32 high_2ghz_chan;
 	u32 low_5ghz_chan;
 	u32 high_5ghz_chan;
 	bool ani_enabled;
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 363fd0b..bda52ca 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1207,6 +1207,8 @@ static int ath10k_wmi_tlv_op_pull_svc_rdy_ev(struct ath10k *ar,
 	arg->phy_capab = ev->phy_capability;
 	arg->num_rf_chains = ev->num_rf_chains;
 	arg->eeprom_rd = reg->eeprom_rd;
+	arg->low_2ghz_chan = reg->low_2ghz_chan;
+	arg->high_2ghz_chan = reg->high_2ghz_chan;
 	arg->low_5ghz_chan = reg->low_5ghz_chan;
 	arg->high_5ghz_chan = reg->high_5ghz_chan;
 	arg->num_mem_reqs = ev->num_mem_reqs;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 1ec609d..3ef6ee3 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5362,6 +5362,8 @@ static int ath10k_wmi_alloc_host_mem(struct ath10k *ar, u32 req_id,
 	arg->phy_capab = ev->phy_capability;
 	arg->num_rf_chains = ev->num_rf_chains;
 	arg->eeprom_rd = ev->hal_reg_capabilities.eeprom_rd;
+	arg->low_2ghz_chan = ev->hal_reg_capabilities.low_2ghz_chan;
+	arg->high_2ghz_chan = ev->hal_reg_capabilities.high_2ghz_chan;
 	arg->low_5ghz_chan = ev->hal_reg_capabilities.low_5ghz_chan;
 	arg->high_5ghz_chan = ev->hal_reg_capabilities.high_5ghz_chan;
 	arg->num_mem_reqs = ev->num_mem_reqs;
@@ -5400,6 +5402,8 @@ static int ath10k_wmi_alloc_host_mem(struct ath10k *ar, u32 req_id,
 	arg->phy_capab = ev->phy_capability;
 	arg->num_rf_chains = ev->num_rf_chains;
 	arg->eeprom_rd = ev->hal_reg_capabilities.eeprom_rd;
+	arg->low_2ghz_chan = ev->hal_reg_capabilities.low_2ghz_chan;
+	arg->high_2ghz_chan = ev->hal_reg_capabilities.high_2ghz_chan;
 	arg->low_5ghz_chan = ev->hal_reg_capabilities.low_5ghz_chan;
 	arg->high_5ghz_chan = ev->hal_reg_capabilities.high_5ghz_chan;
 	arg->num_mem_reqs = ev->num_mem_reqs;
@@ -5454,6 +5458,8 @@ static void ath10k_wmi_event_service_ready_work(struct work_struct *work)
 	ar->phy_capability = __le32_to_cpu(arg.phy_capab);
 	ar->num_rf_chains = __le32_to_cpu(arg.num_rf_chains);
 	ar->hw_eeprom_rd = __le32_to_cpu(arg.eeprom_rd);
+	ar->low_2ghz_chan = __le32_to_cpu(arg.low_2ghz_chan);
+	ar->high_2ghz_chan = __le32_to_cpu(arg.high_2ghz_chan);
 	ar->low_5ghz_chan = __le32_to_cpu(arg.low_5ghz_chan);
 	ar->high_5ghz_chan = __le32_to_cpu(arg.high_5ghz_chan);
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index bdeebc5..9ccaeb7 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6870,6 +6870,8 @@ struct wmi_svc_rdy_ev_arg {
 	__le32 num_rf_chains;
 	__le32 eeprom_rd;
 	__le32 num_mem_reqs;
+	__le32 low_2ghz_chan;
+	__le32 high_2ghz_chan;
 	__le32 low_5ghz_chan;
 	__le32 high_5ghz_chan;
 	const __le32 *service_map;
-- 
1.7.0.4

