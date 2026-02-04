Return-Path: <linux-wireless+bounces-31535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM7cDyQ4g2nRjwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:14:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE835E5A7B
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A11493004F27
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE13EDACE;
	Wed,  4 Feb 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfpSfAK5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E23EDAC9
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207248; cv=none; b=ZesTFlOeNro5i1BuRThzSUN+lJCKwr/TQawxFvvodfdy2kIR8TQznS7zb600lfV2HdO7BARmJA5RRqyAXnaVGySdZYkvmHRXoNMeBR6OeSX3DzUC6d6zqA7s/MXrBAoGWY0V+ehRqEGXznXBmdzIecyjgF6P49wpoxU05RWg//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207248; c=relaxed/simple;
	bh=XNWUFeTs+Kgl3RtBPh3SL54x5bCFit9tdIFTFeTwjl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=On5DxOu1+qNhkxCIBeplBQwsfA11Imi3Mt1/EVXpbL/hEUjlyK9L/qBAmuWExAmHFNSnUh50koeg1eBBhmWvYgHVLGoB6atJr35rr0vGXQwJStvlE3KeeYyO90WDZ7TV1GKBdzASr5CD/vybpwF1e3fooAgFJW5/CzQGvh/VhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfpSfAK5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso48230315ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 04:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207248; x=1770812048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y20MhP2lBI6MQPIBm3+UQ19S98gAaN1y57Up4ru7wdI=;
        b=ZfpSfAK5tBM29gTuYBiJfiADP+a+3NcfCYpEylClAMZq5XiLXMk+DvceB1l1o6Uq9a
         9nPYAQQu97irAis4IdaIC6aQJQDlquNRNUoe6xZSnNtPrAg3ePIyfAl9Hlp0VSt/01lx
         uhxv+K2eAxZZcaKdC3XagDm/nZ1+aazfQYOz4ZS4KNo2oSR9Fn6pTcMW6faxwcfn1TFw
         kfwzgizAZvOTzqBfN+zTcRMoJNthO2GNeUOq7V3YlioS06pe53j/+FNRYrkjjWkjBw8I
         OFiwWJNTWaW3c4fcYcD4f1FrYb2JR18NNzZFXMAWcvnv66805IxBMrBYZo7jW5mbSY2o
         AfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207248; x=1770812048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y20MhP2lBI6MQPIBm3+UQ19S98gAaN1y57Up4ru7wdI=;
        b=tRADi1wjioxgV6QEVZ56W+ueQSwyldnQyCrIgR3cIjx+SBZggeabVnnvdxjgtrU72B
         26Ppp4JSZErA9RTyh52GGl0KQTkEb1EZH5QiRHs+tGb03a7wZQJ06iLmgod4FIhWK1BR
         Di7oQ18xX1v1Qo7S1yJmqT/royGfVELiz/SmRG1tI5zkEq0KIHcRXm8AlfBhIfycEbp1
         EPAHF5KpCUaKfc/Sr79P2gNxiCPPBQ2kKRhpnPrD1DUDqKCQZa1eVY+G4nrW+Hg12B6g
         nXN8pmPLijDO7XhP4AYqMXsJ6D6j7RH19vLDiuw/D1o0KFMysKDPF0pqPFmZFSpiC1es
         ss+A==
X-Gm-Message-State: AOJu0YxGsAvkF1kEqo6rjhlNsta1WVk8z6UwTbRYzKG2pN2fG2UWeVed
	GkFDicQkVWFRfrB1uPkvXqLlTlPDW8jMkV1VAQlqMaw7wYfU//su36TC
X-Gm-Gg: AZuq6aIYSL3jTNaKU0rl5/B4RicddPyBiioQSQsZlCKYXgP1cySeFAkMdjPzHW/7Rcy
	vqkP5f/6CEruWgWfwOPDCJs+qdsWNWwoR0N6VcutGpdTXuUlA2FzNNkZVvtFxUBKxIFZu5sbKiI
	BIRe/6l1SOJtRQAi0lfxwGFZRM+egbASrppBDprA3Zv5lnmFYpQsnU0ySZfeYJJ3+MtoubCzzxn
	xoDW+mm7uyeqIeepLRYCEceU1Ix3T9aYCWySSuYcegxS67TY/EC8xuJrzY16dVdV9kC7gZR85NE
	xp4Uin1jAPmHcOr4GPeMBjG783rFhCoZ64fjRXr8bf3dvio9G2lyvzMMmXLKq+tPmR3m7o6lp7V
	78621omUwswvgYzRcU7o2xLAQh8k3/HfwHVNxyBCDK0umHqYJugjWwEZYB0SBRgf+hRqk0Mabu4
	h5VCQ21EU6ew==
X-Received: by 2002:a17:902:ef02:b0:2a0:daa7:8a57 with SMTP id d9443c01a7336-2a933e52504mr29231575ad.30.1770207248084;
        Wed, 04 Feb 2026 04:14:08 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:b4e2:d5:4aa9:9038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e37csm21299155ad.62.2026.02.04.04.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:14:07 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH] staging: sm750fb: rename pvMem to pv_mem
Date: Wed,  4 Feb 2026 17:43:37 +0530
Message-ID: <20260204121337.4819-4-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204121337.4819-1-dhyaan19022009@gmail.com>
References: <20260204121337.4819-1-dhyaan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31535-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE835E5A7B
X-Rspamd-Action: no action

Rename the CamelCase variable pvMem to the snake_case pv_mem to
comply with the Linux kernel coding style. This fixes multiple
warnings reported by checkpatch.pl.

Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 18 +++++++++---------
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..9bf3c0a37 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -624,27 +624,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -652,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -660,7 +660,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -771,7 +771,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->pv_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1090,7 +1090,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->pv_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1122,7 +1122,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
 	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->pv_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fcb7d586e..2dc57bbe7 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -98,7 +98,7 @@ struct sm750_dev {
 	__u32 vidmem_size;
 	__u32 vidreg_size;
 	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	unsigned char __iomem *pv_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..de1331c56 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -76,15 +76,15 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->pv_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
+	if (!sm750_dev->pv_mem) {
 		iounmap(sm750_dev->pvReg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+	pr_info("video memory vaddr = %p\n", sm750_dev->pv_mem);
 exit:
 	return ret;
 }
-- 
2.43.0


