Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAF2CD98A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 15:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLCOqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 09:46:46 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:42048 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgLCOqq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 09:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bdpg5
        ptMCOQSO9IP2u3k3DCfs5LhwbZD+ct4VFOn97k=; b=dubJOdokMSUxby+mOeaqg
        NZyeDoM4mtsUv/sJBvVN71Nuo5veRHbp7XtRFnnXSZZISIxHYfIR0QA0EWFi/JVQ
        oKHdO9M6rxPvG7Xm3rSJQfqTcRyRnFc2VakNWB1uFWXcZAk2g3FmslmGyt1bse6R
        SEU1c8c3mRVy52zJmsHpMc=
Received: from localhost.localdomain (unknown [140.207.81.18])
        by smtp8 (Coremail) with SMTP id NORpCgBX1mZ7XchfRfkdOQ--.19890S3;
        Thu, 03 Dec 2020 11:37:38 +0800 (CST)
From:   zhouliangya@126.com
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, lzhou <zhouliangya@126.com>
Subject: [PATCH 1/1] ath10k_pci_wait_for_target_init() should relax cpu for other task instead of calling medelay() so that cpu can run other tasks. Signed-off-by: lzhou <lzhou@sonicwall.com> ---
Date:   Thu,  3 Dec 2020 11:37:29 +0800
Message-Id: <20201203033729.382088-2-zhouliangya@126.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203033729.382088-1-zhouliangya@126.com>
References: <20201203033729.382088-1-zhouliangya@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBX1mZ7XchfRfkdOQ--.19890S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4kWry8ury3Zw1rKr1kGrg_yoW3XFc_WF
        4fXFs3urW7uwnxtr42ka1FyFyIk3ZxWF1kAa1IqrWfJw47A398Cr90v3W7uryUGry8AFy3
        ur9FqF18AwnIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRitku3UUUUU==
X-Originating-IP: [140.207.81.18]
X-CM-SenderInfo: p2kr3z5ldqw5bd6rjloofrz/1tbicgLvsVpEBpvZVwAAsj
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: lzhou <zhouliangya@126.com>

---
 drivers/net/wireless/ath/ath10k/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 8ab262931dce..2941fbb6a412 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3309,7 +3309,7 @@ int ath10k_pci_wait_for_target_init(struct ath10k *ar)
 			/* Fix potential race by repeating CORE_BASE writes */
 			ath10k_pci_enable_legacy_irq(ar);
 
-		mdelay(10);
+		schedule_timeout_interruptible(msecs_to_jiffies(10));
 	} while (time_before(jiffies, timeout));
 
 	ath10k_pci_disable_and_clear_legacy_irq(ar);
-- 
2.17.1

