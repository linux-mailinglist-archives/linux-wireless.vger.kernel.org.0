Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA51E42B7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgE0MxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 08:53:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37140 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgE0MxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 08:53:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id y198so11788458pfb.4
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llTH2n++tTVLBhGsV5Icw97tnABVgUx2YdNChWoYrTA=;
        b=oAdsf3LLhmBs8GGuSSBUHvt7heO49m9lCyZCOotAzmT4YnB6Lt0mDNtgdsXfdb/Csx
         gh+HrzIie1GxzioH6bytRSqbjfm5mok2XU+XiKViiqgwzwIeOt/Eu2PhweCXW+OWW5z8
         JlWF4Mg1bRwpxxP+PqsiOkiUYgij1Io8hxZ62hNnenqIfMmUUGFP1QvgrpVnRRaELvuS
         cea1TcWHkxHSvzBknL7Ybl5YvX+ReLbOTzSFehTAsbn/rVHYwUhrdl/oT+6z1qOSseFZ
         njg2Ak1kDmHl7MkIasQ8J6bTN7BEomqHAcmde66bm/18NF+01isOfOjpZgoADrUEzF16
         jI8g==
X-Gm-Message-State: AOAM532sfJFBakcdHx+4TvJhoOAtGvep0v91x2r2y2xDGQEUGYWJfaBn
        BfpaCvRaIruENWHT3cobuI5Yn2W82gxTiA==
X-Google-Smtp-Source: ABdhPJy0TH997SfMFNXCr3v3tA1+3QTRfSxSG5OIRqlN75TW4aUaaK4K1tPejSsSPz1D0XiSSimy/w==
X-Received: by 2002:a62:80ca:: with SMTP id j193mr3659612pfd.41.1590583986192;
        Wed, 27 May 2020 05:53:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h4sm2439636pje.29.2020.05.27.05.53.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:53:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3CC2240605; Wed, 27 May 2020 12:53:05 +0000 (UTC)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gq19sm79574pjb.5.2020.05.26.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:58:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9028741DCA; Tue, 26 May 2020 14:58:18 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     michael.chan@broadcom.com, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, aelior@marvell.com,
        GR-everest-linux-l2@marvell.com, kvalo@codeaurora.org,
        johannes@sipsolutions.net, akpm@linux-foundation.org,
        arnd@arndb.de, rostedt@goodmis.org, mingo@redhat.com,
        aquini@redhat.com, cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, derosier@gmail.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: [PATCH v3 5/8] ath10k: use new taint_firmware_crashed()
Date:   Tue, 26 May 2020 14:58:12 +0000
Message-Id: <20200526145815.6415-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TUID: YO7eskr2sX9X
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes use of the new taint_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

I have run into this situation with this driver with the latest
firmware as of today, May 21, 2020 using v5.6.0, leaving me at
a state at which my only option is to reboot. Driver removal and
addition does not fix the situation. This is reported on kernel.org
bugzilla korg#207851 [0]. But this isn't the first firmware crash reported,
others have been filed before and none of these bugs have yet been
addressed [1] [2] [3].  Including my own I see these firmware crash
reports:

  * korg#207851 [0]
  * korg#197013 [1]
  * korg#201237 [2]
  * korg#195987 [3]

[0] https://bugzilla.kernel.org/show_bug.cgi?id=207851
[1] https://bugzilla.kernel.org/show_bug.cgi?id=197013
[2] https://bugzilla.kernel.org/show_bug.cgi?id=201237
[3] https://bugzilla.kernel.org/show_bug.cgi?id=195987

Cc: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org
Cc: Kalle Valo <kvalo@codeaurora.org>
Acked-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/wireless/ath/ath10k/pci.c  | 2 ++
 drivers/net/wireless/ath/ath10k/sdio.c | 2 ++
 drivers/net/wireless/ath/ath10k/snoc.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 1d941d53fdc9..818c3acc2468 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1767,6 +1767,7 @@ static void ath10k_pci_fw_dump_work(struct work_struct *work)
 		scnprintf(guid, sizeof(guid), "n/a");
 
 	ath10k_err(ar, "firmware crashed! (guid %s)\n", guid);
+	taint_firmware_crashed();
 	ath10k_print_driver_info(ar);
 	ath10k_pci_dump_registers(ar, crash_data);
 	ath10k_ce_dump_registers(ar, crash_data);
@@ -2837,6 +2838,7 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 	if (ret) {
 		if (ath10k_pci_has_fw_crashed(ar)) {
 			ath10k_warn(ar, "firmware crashed during chip reset\n");
+			taint_firmware_crashed();
 			ath10k_pci_fw_crashed_clear(ar);
 			ath10k_pci_fw_crashed_dump(ar);
 		}
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index e2aff2254a40..8b2fc0b89be4 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -794,6 +794,7 @@ static int ath10k_sdio_mbox_proc_dbg_intr(struct ath10k *ar)
 
 	/* TODO: Add firmware crash handling */
 	ath10k_warn(ar, "firmware crashed\n");
+	taint_firmware_crashed();
 
 	/* read counter to clear the interrupt, the debug error interrupt is
 	 * counter 0.
@@ -915,6 +916,7 @@ static int ath10k_sdio_mbox_proc_cpu_intr(struct ath10k *ar)
 	if (cpu_int_status & MBOX_CPU_STATUS_ENABLE_ASSERT_MASK) {
 		ath10k_err(ar, "firmware crashed!\n");
 		queue_work(ar->workqueue, &ar->restart_work);
+		taint_firmware_crashed();
 	}
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 354d49b1cd45..071ee7607a4c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1451,6 +1451,7 @@ void ath10k_snoc_fw_crashed_dump(struct ath10k *ar)
 		scnprintf(guid, sizeof(guid), "n/a");
 
 	ath10k_err(ar, "firmware crashed! (guid %s)\n", guid);
+	taint_firmware_crashed();
 	ath10k_print_driver_info(ar);
 	ath10k_msa_dump_memory(ar, crash_data);
 	mutex_unlock(&ar->dump_mutex);
-- 
2.26.2

