Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A769212635E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSNYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:24:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37603 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:24:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so4864577edb.4
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WcPY2DOnYcilQeR9udjKYbcsm2SYeFm9eHViqPb53Zw=;
        b=Zd+QfflrbWOQrYRJjFg/z6bsfmD77k5rL3ZvM0YgaDvYRLS5DxLLLVh4UKFHFtWRRL
         vs2qOnVa276iQ6wezrdEWkCuso8BRVMtvhJbi0iBQhuUvHroYXAX4TmHENTp77DHIjXQ
         l8SE1yv80yIETnXD4PJhCEdOrttC6tBfJ92O+9oSxtVPYptWbr7rckseN1duEwCdtGvC
         JY8poG+HbUP/8qehMlgxzh67ghpl8qm6LujOb6xEgYhdeovZz8bwJfj7JVDSuZJPFBq7
         91wEbZWLCF+xQl4wj510/bNs5I7x76vadsaQGrqvYnguT0tJgHvKag5ciCeO4c+VWUvb
         ROcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WcPY2DOnYcilQeR9udjKYbcsm2SYeFm9eHViqPb53Zw=;
        b=WbW7VYtfBvaatFzAAsBbdIdEThfG005ebEoikZe6RJaD5k12CqWOtIki1Ed36HOLRS
         2PatErDCSqLcQGiGN3ttFffA7kWn9sGHQDYOf+KVKwoIvR4rrmyNiDR+8NxzlVrGa43Q
         vl/O2SwTbJ4xawIq268q0iVkUUuMJV0VuayF6dlzzONSXIqRx3qIk9/iP9IW7LA3xV/b
         PUD4pAFsYKmwrmtD2n69eTGWP/UL3LH3U42axVumpiQqzcmprLvcUokE2wFZKHbxcCji
         xv+oUHBCbYMVzldefcRZCj/f0uNS1L2z7V1jJB0zpF2JvqS+KZVEULi9bbswbDiadkyv
         Wesw==
X-Gm-Message-State: APjAAAX/zIlOvi3+/AFc4DvgURA/kMkkXsEQDFTCf939o2d0Cm+FJkVr
        w/kH8xQM/8BMa8rbL7nCHEI87UhfkK0=
X-Google-Smtp-Source: APXvYqw2s6q/NPfbe/cw73hwaCHBRODtJnwzmB3wMsgxBRGt63lzJh2FMbaaOA+cvBquVXHeAyrMiw==
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr9197382ejf.150.1576761862623;
        Thu, 19 Dec 2019 05:24:22 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id cw15sm410286edb.44.2019.12.19.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:24:22 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, akolli@codeaurora.org,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/2] ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG when safe
Date:   Thu, 19 Dec 2019 13:15:38 +0000
Message-Id: <20191219131539.1003793-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
References: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_pci_dump_memory_reg() will try to access memory of type
ATH10K_MEM_REGION_TYPE_IOREG however, if a hardware restart is in progress
this can crash a system.

Individual ioread32() time has been observed to jump from 15-20 ticks to >
80k ticks followed by a secure-watchdog bite and a system reset.

Work around this corner case by only issuing the read transaction when the
driver state is ATH10K_STATE_ON.

Fixes: 219cc084c6706 ("ath10k: add memory dump support QCA9984")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/ath10k/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index bb44f5a0941b..4822a65f6f3c 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1604,11 +1604,22 @@ static int ath10k_pci_dump_memory_reg(struct ath10k *ar,
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	u32 i;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH10K_STATE_ON) {
+		ath10k_warn(ar, "Skipping pci_dump_memory_reg invalid state\n");
+		ret = -EIO;
+		goto done;
+	}
 
 	for (i = 0; i < region->len; i += 4)
 		*(u32 *)(buf + i) = ioread32(ar_pci->mem + region->start + i);
 
-	return region->len;
+	ret = region->len;
+done:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
 }
 
 /* if an error happened returns < 0, otherwise the length */
@@ -1704,7 +1715,11 @@ static void ath10k_pci_dump_memory(struct ath10k *ar,
 			count = ath10k_pci_dump_memory_sram(ar, current_region, buf);
 			break;
 		case ATH10K_MEM_REGION_TYPE_IOREG:
-			count = ath10k_pci_dump_memory_reg(ar, current_region, buf);
+			ret = ath10k_pci_dump_memory_reg(ar, current_region, buf);
+			if (ret < 0)
+				break;
+
+			count = ret;
 			break;
 		default:
 			ret = ath10k_pci_dump_memory_generic(ar, current_region, buf);
-- 
2.24.0

