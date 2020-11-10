Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C52AD1BB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgKJItX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 03:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJItW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 03:49:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49FCC0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 00:49:22 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so10799774pfn.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvISL/qdLkdwPYX88Kdh3n2uLpOi4eNhrcHOaqAjvcs=;
        b=Uk6yrwwZGt6DbAqXYz56yubQ3KJD8KXkW0xqOw7DyDlcECvaACAPsdILReYeN5q82/
         8Gy0PFGdCY/NgzKWoQ5uyEdbr1oYQx5rcLyPcBh+4Ww+uUqA64xsNRAd6KJGsyR/m/q6
         //UUuS0stlkHCcQa1lVULK6afpmnXoafSeu6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvISL/qdLkdwPYX88Kdh3n2uLpOi4eNhrcHOaqAjvcs=;
        b=W/Secfzcjyb9owWEqX9RAQkbqS+HMY4NC/ghrqsJx22F/VlKKFGF033zPUsDdXoh/o
         HVD7bjv+9LnIuRvPfUWl9o8rHEMIxViWnocHafHh0Jk9447cPlL/p5CII7h0PVrgdJ14
         AkX0SxQkJ1Ac6lmaOilVUK61gvga2v+oFnQ9qBXflM1qRK3BQbCbAWS1UZTBXKG1tnuv
         mxfWS02rHF5cEnGjPIbqLIWT5NdMj1eVZo3fzKqcA5R0mm3vmojgw4zzWfVUV/XiPiQV
         krFh2aXUQZNF+7Izt55vsPdEsM22oQ3odfp0q57slUOh3ROsaO/kccg83c/IEkLgeTfM
         N/DA==
X-Gm-Message-State: AOAM533xiL1HuwKM67LOKaUrKUmYnvH+WjIbCDsryZHDEUE4jX411f3y
        gbqLFHpptkDfTV1B6U+jYD508A==
X-Google-Smtp-Source: ABdhPJyVW1uWC0lJQFwCgm+h2n2t4eQeWlgNVFy8vHOeVWyRrVPIW/AOUseN+NURRWL0O0Xvz7sPUA==
X-Received: by 2002:a62:870c:0:b029:18b:d345:70f3 with SMTP id i12-20020a62870c0000b029018bd34570f3mr13536858pfe.30.1604998162297;
        Tue, 10 Nov 2020 00:49:22 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id i2sm2173330pjk.12.2020.11.10.00.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 00:49:21 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        hdegoede@redhat.com, marcel@holtmann.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH] rfkill: Fix use-after-free in rfkill_resume()
Date:   Tue, 10 Nov 2020 16:49:08 +0800
Message-Id: <20201110084908.219088-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If a device is getting removed or reprobed during resume, use-after-free
might happen. For example, h5_btrtl_resume()[drivers/bluetooth/hci_h5.c]
schedules a work queue for device reprobing. During the reprobing, if
rfkill_set_block() in rfkill_resume() is called after the corresponding
*_unregister() and kfree() are called, there will be an use-after-free
in hci_rfkill_set_block()[net/bluetooth/hci_core.c].

BUG: KASAN: use-after-free in hci_rfkill_set_block+0x58/0xc0 [bluetooth]
...
Call trace:
  dump_backtrace+0x0/0x154
  show_stack+0x20/0x2c
  dump_stack+0xbc/0x12c
  print_address_description+0x88/0x4b0
  __kasan_report+0x144/0x168
  kasan_report+0x10/0x18
  check_memory_region+0x19c/0x1ac
  __kasan_check_write+0x18/0x24
  hci_rfkill_set_block+0x58/0xc0 [bluetooth]
  rfkill_set_block+0x9c/0x120
  rfkill_resume+0x34/0x70
  dpm_run_callback+0xf0/0x1f4
  device_resume+0x210/0x22c

Fix this by checking rfkill->registered in rfkill_resume().
Since device_del() in rfkill_unregister() requires device_lock() and the
whole rfkill_resume() is also protected by the same lock in
device_resume()[drivers/base/power/main.c], we can make sure either the
rfkill->registered is false before rfkill_resume() starts or the rfkill
device won't be unregistered before rfkill_resume() returns.

Fixes: 8589086f4efd ("Bluetooth: hci_h5: Turn off RTL8723BS on suspend, reprobe on resume")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 net/rfkill/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 971c73c7d34c..97101c55763d 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -876,6 +876,9 @@ static int rfkill_resume(struct device *dev)
 
 	rfkill->suspended = false;
 
+	if (!rfkill->registered)
+		return 0;
+
 	if (!rfkill->persistent) {
 		cur = !!(rfkill->state & RFKILL_BLOCK_SW);
 		rfkill_set_block(rfkill, cur);
-- 
2.29.2.222.g5d2a92d10f8-goog

