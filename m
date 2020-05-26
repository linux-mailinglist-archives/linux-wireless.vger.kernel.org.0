Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2301E42BA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgE0MxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 08:53:18 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35210 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgE0MxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 08:53:17 -0400
Received: by mail-pj1-f67.google.com with SMTP id 5so1492394pjd.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLNCK+WRq9ug4fTBP9sca/wv2hUwl+4zOX5ypfLbsKY=;
        b=ipuT9cBXcwk15LlCsWc6uFhqV3X6F8SYJ00yqhr2/8xQZT9EPw4y7MNd8hFgOGjeVM
         eLJaq1C+CyJejpogb2hSB3aTQKmxA5eVYQYarhENIMUQTPdlG79PvPqSq7HteUh2EXjR
         liwI2FTiezEnputrexTUNdZGc2OukgHay8X7FX+7uS5P7ys+ZXW2rog6G+PRe2VMg4TU
         Sr4Ppot0Bf9OkXXpqstNeITpmOOZyN5G2M0rPdvaTT9vjt2DKXzR/dSqFsfaGOVc59FT
         931+8/3zqPLdxE5fBaHPNXWu3q/GiCRgOCzD6Xx132YdSovhFuGrLSPUbRwvQCsvPbWW
         7Qpw==
X-Gm-Message-State: AOAM530uvanuBBPk00ICNf2XdFaJpRym9qvreAamboA+GBfwVgWtjzLU
        N+fpXpE9Mfus4eRbWcOLzjLkQEWzzkWaBw==
X-Google-Smtp-Source: ABdhPJw02sl0t/dA62cYxQC4t2rcjEd1E7uQMG1gOeGf1c8/8uma+SnNHzaBo4Nm2MNbvV0BBNa2VQ==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr5006195pjr.50.1590583996288;
        Wed, 27 May 2020 05:53:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id dw13sm2531331pjb.40.2020.05.27.05.53.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:53:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2FEAC40605; Wed, 27 May 2020 12:53:15 +0000 (UTC)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y14sm15686666pfr.11.2020.05.26.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:58:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D804142309; Tue, 26 May 2020 14:58:18 +0000 (UTC)
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
        linux-doc@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 7/8] liquidio: use new taint_firmware_crashed()
Date:   Tue, 26 May 2020 14:58:14 +0000
Message-Id: <20200526145815.6415-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TUID: qc+Is70wjb5b
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

Cc: Derek Chickles <dchickles@marvell.com>
Cc: Satanand Burla <sburla@marvell.com>
Cc: Felix Manlunas <fmanlunas@marvell.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
Reviewed-by: Derek Chickles <dchickles@marvell.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 66d31c018c7e..ee1796ea4818 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -801,6 +801,7 @@ static int liquidio_watchdog(void *param)
 			continue;
 
 		WRITE_ONCE(oct->cores_crashed, true);
+		taint_firmware_crashed();
 		other_oct = get_other_octeon_device(oct);
 		if (other_oct)
 			WRITE_ONCE(other_oct->cores_crashed, true);
-- 
2.26.2

