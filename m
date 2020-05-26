Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E451E42B8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgE0MxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 08:53:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36011 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgE0MxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 08:53:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id e11so10826157pfn.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOBEOlJCwRVyUrO7obeZe7+iAPzekeZt6xLUEcXHiBo=;
        b=t7UHbFMU2DutgLcHwrnQ3/nF24FDJxRuCQ4NA6KunaP5Z6fl1WPbarZzm3dbgtXRpu
         N9eDE1rx7vJgOMymC7vf5nJ5Cy6MsfhUgVZGExL7mTaLFa8lFW5tDB+1aKPtKgP/K2wK
         H15zUU72tewomZLD4zckx+kCCwA3ShyAT8JT74aAnrvqtwtD+//1zmSdOuknJqp73Fnt
         fGrZFjt4RGBMceR4qYKRoDQGSciH/2048DTndpWSn68Rb+NCLn6FOPL1tRWdDPbpzuko
         XEKoCtihbqpclQlCJxKy9X4SiXP8sTmLKRM51s/ChrvLs0Ba7+CgEgkUADdzBx9PJWRN
         VrdQ==
X-Gm-Message-State: AOAM531bj72EbxobJt7IN5oAO3mb6jdf4FyN3YL1gl5hA4oPLAEMKb/W
        tGObbsb5xtbO10ctn+s4ktok20ymiRpZvg==
X-Google-Smtp-Source: ABdhPJw74r4jz1NFbP9PfWTp0TcW0IDRd+JjEhsryiAFRLW+nIVjUkb/9DSfOTscCG0tL92lKb4fww==
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr3771086pgi.439.1590583989750;
        Wed, 27 May 2020 05:53:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g1sm2069069pfo.142.2020.05.27.05.53.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:53:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 62E6C40605; Wed, 27 May 2020 12:53:08 +0000 (UTC)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r69sm15995450pfc.209.2020.05.26.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:58:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B4A6F422E5; Tue, 26 May 2020 14:58:18 +0000 (UTC)
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
        linux-doc@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 6/8] bnxt_en: use new taint_firmware_crashed()
Date:   Tue, 26 May 2020 14:58:13 +0000
Message-Id: <20200526145815.6415-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TUID: 6RHjWPRLSqR3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

This makes use of the new module_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index a812beb46325..776a7ae0ef7f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -121,6 +121,7 @@ static int bnxt_fw_fatal_recover(struct devlink_health_reporter *reporter,
 	if (!priv_ctx)
 		return -EOPNOTSUPP;
 
+	taint_firmware_crashed();
 	bp->fw_health->fatal = true;
 	event = fw_reporter_ctx->sp_event;
 	if (event == BNXT_FW_RESET_NOTIFY_SP_EVENT)
-- 
2.26.2

