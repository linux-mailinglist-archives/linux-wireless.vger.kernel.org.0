Return-Path: <linux-wireless+bounces-34816-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBzhIVPZ32lJZgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34816-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 20:30:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C1407183
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58E543053567
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A8372EEE;
	Wed, 15 Apr 2026 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVEzeHIN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048163016E0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277839; cv=none; b=e/6Yvwdgqm5rnipurCGL8H1Y2ZsB8OG5gwe2m4YtS30tbrrsop2mfZtLeoysD7pJ4WN1KsfQf9zH3QgZEmHpBRaM8Q2RqCel5fIrF8UzTB7qZRm9HggOpk2p+E/2yR/zQ2FK4hdGZlkymzHDUB3n8eL/cOFwlUiH8YACkqwU2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277839; c=relaxed/simple;
	bh=Ohbt9ZqD4MIjFq8WvgJfeXsDdndtXr0Y2oCOQ01NELA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ue5zL34t1saN5CMNauAJrF9uvAS+Ul/hRlqH6YwY2daiFi20x7WRxVFxoK4Rh6r4SBtTEcaK1UTOM3/e0lNI1pYcXGX9zut3Jd9cMfwH5iv1Zb8MS91UhRo59EXf0iW+l9kx45T+RmdnTfUnaN9oXTb92lQ7Ajmp+/TdKlqdveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVEzeHIN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82418b0178cso3678705b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277837; x=1776882637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN21C+5PsTyxBA2toqguwwdmaHUEvYgpm7U5rs5TcnM=;
        b=MVEzeHINDPSIqxxFndyRUiY3DjhdWlFpOxjmUclnPufT5HdEu1drjYcuQlqNlLvjsP
         plWB2/WIH/JVhPm6SonMFSanE6SgUchg69Wc8bOyjmPuvmMKCap6Hm1AOJW9R/IA4EHn
         mKVTvfCmEzB8hPcP46ZZRbgr0nwHNPN6us6YunyfXvlX+H5DnNOyNYXLr66jrJ5ytukg
         1jfLrvRGv8Hdz4NKjAkLL3dlzWdECsdNJW1/TGzBegvilf0620R0fXYlYgDVH6xHe3if
         tAVBQG4WelSu9zEITpwxpO2AiePzaLYrZ57bbOX8ttE05j7B5+EKkzzcr819pdtY0Z+Y
         e/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277837; x=1776882637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN21C+5PsTyxBA2toqguwwdmaHUEvYgpm7U5rs5TcnM=;
        b=jgGePQ/hO1hqIej1B3XYeF1Y2qQ+Os50ET92RZH/mV5DExlRfiLBWM18mkv0qaVuzi
         EgsIgUpiLH2tFzL2NAFmSY0BqZ98hv8k9mncfupz1kqFo9acm7dyLDAzCjya3ofjeNFT
         R3MOXtlLLXCtSKgazDGCuqjHWIkK7XjBmuePlS4cqE8ps+DdQ+PtziyNmAWGkd9yl7qD
         mP6Gpb2KRWqHXFImHMoSCmKGye5egpAZnILF80Ikknax3JLXJnizh77Cbebt1BkGSk86
         rs46EIawj6YjV7FWsw1HtuaSUBUTZxewn7r4j8XL3QtGU6T7/8SFfTwg/K4ew6GuNJwa
         AHJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a8c/UIcLm9bsVFuk3zoiL19PhaKAzyEwKekt493T8PUqup4fvCm7RmAT+WYTvPZYRwYVuu7k/c0QlzxRQxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRHtI/6GlF7zatxHaQPN1IYs+L8Vw/uxzM6NKsrQdXOLsLp3b
	lJtzfaPzKpSX7rGxKDxhuBu5zxeozJ5LjX4EjR5jEp9mwUzlR3PWiL0G
X-Gm-Gg: AeBDieuh7rsZeldxCd0grEGrytT3k0apmvb6BAbxc6vu34Wqg+vAa9S2NPpfiQnzbd+
	MtIigRKC6Bkn/tN2X74QUi+db11cayAEs/QNsY0tcyH8WzmPuMJcbJ6qCWBZzgcEfL0r9h1sw47
	dEh/72BCTmgq4B8S3anOUSUENB3k2VdugTHIdHGHDrKHt/a4j5vvsVOXd1DU+e14LomohruI2FR
	Y6GNKGoKPdkGbHxSUbgti7me1Huyb1NZP8LKIesEez9NNswMMFzPjNFagvjhXf1CFdhIotGdFxT
	RyAVtRIS8ffJX1nvmxPhQVpNaB0BUBtfnFdWBzIpzmYpUYiCnVz7zw94pSu1hKNczbTAXifhzJC
	naK2KRNNHb+gCMcS3teQYACL7KcQCn4fd07HFoCyvTguxYkqw5j+fZZiF0fTEFJW0cOvtidi0sZ
	wfJf7VJaznp9CHrK1WFjQxl6Q4emJA3jHTkzMlBLPsFIOmMg==
X-Received: by 2002:a05:6a00:10b:b0:82f:1d38:f68f with SMTP id d2e1a72fcca58-82f1d38fc7bmr14476588b3a.31.1776277837089;
        Wed, 15 Apr 2026 11:30:37 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67449c3asm2843343b3a.53.2026.04.15.11.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:30:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Michael Buesch <m@bues.ch>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ssb: fix reference leaks on failed flash device registration
Date: Thu, 16 Apr 2026 02:30:02 +0800
Message-ID: <20260415183002.3752935-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34816-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[bues.ch,gmail.com,tuxdriver.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C0C1407183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in ssb_devices_register(), the
embedded struct device in ssb_pflash_dev or ssb_sflash_dev has already
been initialized by device_initialize(), but the failure paths only
report the error and do not drop the device reference for the current
platform device:

  ssb_devices_register()
    -> platform_device_register(&ssb_pflash_dev)
       -> device_initialize(&ssb_pflash_dev.dev)
       -> setup_pdev_dma_masks(&ssb_pflash_dev)
       -> platform_device_add(&ssb_pflash_dev)

  ssb_devices_register()
    -> platform_device_register(&ssb_sflash_dev)
       -> device_initialize(&ssb_sflash_dev.dev)
       -> setup_pdev_dma_masks(&ssb_sflash_dev)
       -> platform_device_add(&ssb_sflash_dev)

This leads to reference leaks when platform_device_register() fails.
Fix this by calling platform_device_put() after reporting the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: c7a4a9e3880cc ("ssb: register platform device for parallel flash")
Fixes: 7b5d6043de312 ("ssb: register serial flash as platform device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/ssb/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index b2d339eb57d5..5cdf612a8516 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -535,16 +535,20 @@ static int ssb_devices_register(struct ssb_bus *bus)
 #ifdef CONFIG_SSB_DRIVER_MIPS
 	if (bus->mipscore.pflash.present) {
 		err = platform_device_register(&ssb_pflash_dev);
-		if (err)
+		if (err) {
 			pr_err("Error registering parallel flash\n");
+			platform_device_put(&ssb_pflash_dev);
+		}
 	}
 #endif
 
 #ifdef CONFIG_SSB_SFLASH
 	if (bus->mipscore.sflash.present) {
 		err = platform_device_register(&ssb_sflash_dev);
-		if (err)
+		if (err) {
 			pr_err("Error registering serial flash\n");
+			platform_device_put(&ssb_sflash_dev);
+		}
 	}
 #endif
 
-- 
2.43.0


