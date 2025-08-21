Return-Path: <linux-wireless+bounces-26489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A108DB2ED0C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 06:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1576016C062
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 04:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AE2BE650;
	Thu, 21 Aug 2025 04:32:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FA25392D;
	Thu, 21 Aug 2025 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750771; cv=none; b=O5rmcsqrifvxhCwy5PRUec4Xd4dS9nVTLHfchBi5+soBNs/KZWY+2vhI4xY7GsIdzALMFcVmll7JN5VDdADvEc0U3hzuGSfCi/DG3IdnfEp+TIK8T1GV8wEz9MtJp81+h1MmJByO26upV9pj4sgP6L062VwisDmFIXQklYABtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750771; c=relaxed/simple;
	bh=wudxfahAkG91oksJkB2hKaFuZIUSOFCQvcfN5AMdmsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIWAyZlNO2Vfko/p5x7YYBWLfFPOCcXuyNLt0BBTtUIazVGb1dNwotRGdctHm4zAItFywAC7CzUHW4oKHvEQl0tsQuTXaqWXrH8oge0zvtqr8jyqKQTkiMQa6phGL8lHBm9j3P4XHatB+tR0Ne5E8mjxQSighT+erhpbcY937Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.46])
	by mtasvr (Coremail) with SMTP id _____wD34GpMoaZoH5xwAQ--.19131S3;
	Thu, 21 Aug 2025 12:32:13 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.18.46])
	by mail-app2 (Coremail) with SMTP id zC_KCgB3RDZFoaZo+ldfAQ--.29576S2;
	Thu, 21 Aug 2025 12:32:11 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	arend.vanspriel@broadcom.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] brcmfmac: btcoex: Fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Thu, 21 Aug 2025 12:32:02 +0800
Message-Id: <20250821043202.21263-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgB3RDZFoaZo+ldfAQ--.29576S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwAFAWimJPgB2QBGsL
X-CM-DELIVERINFO: =?B?DtiifAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1x+P/0SGdmHLgiraX9IMEJhemD36L/3z5dEROEpufn5xEJEOZxQeXyfLvW+ICf4T82FG
	GVC4lAYirsvrmktc4zr5u/MkoErypH07V0iWcVNZJhzhoKg0FpbtyDr9+TYt3w==
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1fAr48CrWkAF4kGw4rWFX_yoW8Kr1Dpa
	93G34ayryjvw43KrWDJF1kXFyrKa9rG3Wqyr48AFZxuFn2qr1IqF48KFyagFW7CF4Ivay2
	yF4Fqrn8JrnxtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
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
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU7xwIDUUUU

The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
runs as timer handler, sets timer_on to false. This creates a critical
race condition:

1.If brcmf_btcoex_detach() is called while brcmf_btcoex_timerfunc()
is executing, it may observe timer_on as false and skip the call to
timer_shutdown_sync().

2.The brcmf_btcoex_timerfunc() may then reschedule the brcmf_btcoex_info
worker after the cancel_work_sync() has been executed.

3.Subsequently, the brcmf_btcoex_info structure is freed.

4.Finally, the rescheduled worker attempts to execute, leading to
use-after-free bugs by accessing the freed brcmf_btcoex_info object.

The following diagram illustrates this sequence of events:

cpu0                            cpu1
brcmf_btcoex_detach          |  brcmf_btcoex_timerfunc
                             |    bt_local->timer_on = false;
  if (cfg->btcoex->timer_on) |
    ...                      |
  cancel_work_sync();        |
  ...                        |    schedule_work() //reschedule
  kfree(cfg->btcoex);//free  |
                             |    brcmf_btcoex_handler() //worker
                             |    btci-> //use

To resolve this race condition, drop the conditional check and call
timer_shutdown_sync() directly. It can deactivate the timer reliably,
regardless of its current state. Once stopped, the timer_on state is
then set to false.

Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
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


