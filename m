Return-Path: <linux-wireless+bounces-26551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C34B30DD1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C61A029D9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B728934F;
	Fri, 22 Aug 2025 05:09:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05198266B67;
	Fri, 22 Aug 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839344; cv=none; b=EzZ4fSa1Tf9Pqf6gm6NO2PKf/DPpA3uxnlMjTp8A1S3zvMb1vnX+9MSCjuBtqhfQAxznjjVgswZWaQy50uawiSMPEc65vZH6kHKFxerFngWISsCtqVsLXQiRtzejdUl2/wtH0yhs37NshYTs8Zxb9//hrPVTF3CLs5zlqOERCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839344; c=relaxed/simple;
	bh=ImzbWSeUVNC5unK6e2Xdbt/EPWZNXA1qmCgfG7zJiXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GEHbwQ8LhekoeakM4+W18jS+Kym3wjcMW7ZwxnDyP2laE1drwI5niP35XTsrpAGWO//keNCjILt7BnF7z1+OlsuxdUfOMhn/eirYl+i2MvWpX6zwJs+xa6aiJKDWJDHEkvEnM7sVoNycNrocIObWQhtRMFrb324vyCPS34yfsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.21.37])
	by mtasvr (Coremail) with SMTP id _____wCHJGlf+6doK096AQ--.18128S3;
	Fri, 22 Aug 2025 13:08:48 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.21.37])
	by mail-app1 (Coremail) with SMTP id yy_KCgDHHNha+6doUlRxAQ--.48590S2;
	Fri, 22 Aug 2025 13:08:46 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	arend.vanspriel@broadcom.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] brcmfmac: btcoex: Fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Fri, 22 Aug 2025 13:08:39 +0800
Message-Id: <20250822050839.4413-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgDHHNha+6doUlRxAQ--.48590S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwAGAWindnkDJAALso
X-CM-DELIVERINFO: =?B?XBWk/gXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1+FKPRRHSLOk9dZ6tUQqRhJiqWo8QcKJNUBNPSN6B4l5UJbmYI+M+3mlBheizaJvNRuQ
	3dECz0taxrGnZuv6MqtMe5xQh6TzeVOiyZZ44+8EP+AOCOuPfhje8WtXyKsysQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxJw1ktFWrCrykWFyfCr17Arc_yoW5tryfpa
	93J34ayry0qrW3KrWkJr1kZFy5KanrG3Wqyr48CF43uFsIqr4xtF40yF12gFW7CFWI9ay2
	yF4FqFy3Jrs8tFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU801v3UUUUU==

The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
runs as timer handler, sets timer_on to false. This creates critical
race conditions:

1.If brcmf_btcoex_detach() is called while brcmf_btcoex_timerfunc()
is executing, it may observe timer_on as false and skip the call to
timer_shutdown_sync().

2.The brcmf_btcoex_timerfunc() may then reschedule the brcmf_btcoex_info
worker after the cancel_work_sync() has been executed, resulting in
use-after-free bugs.

The use-after-free bugs occur in two distinct scenarios, depending on
the timing of when the brcmf_btcoex_info struct is freed relative to
the execution of its worker thread.

Scenario 1: Freed before the worker is scheduled

The brcmf_btcoex_info is deallocated before the worker is scheduled.
A race condition can occur when schedule_work(&bt_local->work) is
called after the target memory has been freed. The sequence of events
is detailed below:

CPU0                           | CPU1
brcmf_btcoex_detach            | brcmf_btcoex_timerfunc
                               |   bt_local->timer_on = false;
  if (cfg->btcoex->timer_on)   |
    ...                        |
  cancel_work_sync();          |
  ...                          |
  kfree(cfg->btcoex); // FREE  |
                               |   schedule_work(&bt_local->work); // USE

Scenario 2: Freed after the worker is scheduled

The brcmf_btcoex_info is freed after the worker has been scheduled
but before or during its execution. In this case, statements within
the brcmf_btcoex_handler() — such as the container_of macro and
subsequent dereferences of the brcmf_btcoex_info object will cause
a use-after-free access. The following timeline illustrates this
scenario:

CPU0                            | CPU1
brcmf_btcoex_detach             | brcmf_btcoex_timerfunc
                                |   bt_local->timer_on = false;
  if (cfg->btcoex->timer_on)    |
    ...                         |
  cancel_work_sync();           |
  ...                           |   schedule_work(); // Reschedule
                                |
  kfree(cfg->btcoex); // FREE   |   brcmf_btcoex_handler() // Worker
  /*                            |     btci = container_of(....); // USE
   The kfree() above could      |     ...
   also occur at any point      |     btci-> // USE
   during the worker's execution|
   */                           |

To resolve the race conditions, drop the conditional check and call
timer_shutdown_sync() directly. It can deactivate the timer reliably,
regardless of its current state. Once stopped, the timer_on state is
then set to false.

Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Make the description clearer.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 69ef8cf203d2..67c0c5a92f99 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -393,10 +393,8 @@ void brcmf_btcoex_detach(struct brcmf_cfg80211_info *cfg)
 	if (!cfg->btcoex)
 		return;
 
-	if (cfg->btcoex->timer_on) {
-		cfg->btcoex->timer_on = false;
-		timer_shutdown_sync(&cfg->btcoex->timer);
-	}
+	timer_shutdown_sync(&cfg->btcoex->timer);
+	cfg->btcoex->timer_on = false;
 
 	cancel_work_sync(&cfg->btcoex->work);
 
-- 
2.34.1


