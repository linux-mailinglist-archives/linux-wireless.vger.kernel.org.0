Return-Path: <linux-wireless+bounces-36144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APFhOVprAGoyIwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 13:26:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B623503CB0
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52560300EF45
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA63806D9;
	Sun, 10 May 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ0viJyT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB92B2D7
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778412364; cv=none; b=iML0biGLWKYepOK7YI80AOhQijemQVCwpUPTspyM6pl8qNDhbQhOaSBRSVlsS/LN0luXb7j10U3q2d16VQA7ES81Nk6eFiSe5gpWUzUQGQ9KV12ol/K3zrgt6A4jGWPWJdAZC4K6sSqXwpsAaczDIuuX0MT0OeTNJaZZmSFdDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778412364; c=relaxed/simple;
	bh=kWundYsSA1TJvK+/u1cdL3QMlOTJF3BVADcVgUgb70Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hhzh/86aeDw70T2VJaZVjW3F61A3oxHg0jGUiFWPxz2LgU+++K4JgblNJLrVJw6hC8Ho7/wdNlR62u0mpdD3nzq/FHc5NThCab6ihEiZpRTKEH+nqZMw5Tx+oUEbl733CEn042JRHt2szu1OgUflagQkKy14X87Dzp3GK2Vj02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ0viJyT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b941cd869cso19900355ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778412362; x=1779017162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIl8H8lFysWE5ij7aLpKADHwKQH42nKkHoFfcSIfoNA=;
        b=WZ0viJyTyb6lN55EJyZH7Tt8pt8NYNK1xhzGFuX4kHsGA7zh7RkM2hMjqsXYItFxDE
         oom2IYBmg7S103oObghhJvVFu9oRDnO8LgFueWf4f3/qN3XtrFzgVZEyMt5wNqRCajNu
         q1l9E4Jpw8EHv/3xQYdkagEUqm9lkWnitfPBu4tZXI8jHZkDuaJkmXmI6tS+q4Mz0qyj
         N5EFqZNpjE8aul0wnGGikpG9jhr/Qli3BCgTU5FG0QJrm37CTjs37shglgEQMc+75r0J
         BcRCp9eWXxutE7sakTNWBt8xuMssumdqgEXKB6FDkXPsdy12cYl75di6QWV6mEEN3gEW
         vRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778412362; x=1779017162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIl8H8lFysWE5ij7aLpKADHwKQH42nKkHoFfcSIfoNA=;
        b=pXTPNRLirNnSdtDpuhywqzLA5cjJrjGWKoJ0+AovMK/V2ZM92RA28Spzzp3ZXAghUC
         lG01nmiYW8Ie/zLOIy4Uul+ITIuABNVBS+W3NZjNkLn9HL+gdJ1RK31A/TY3WgzElSqt
         sgivOvOLvAbMerCo8TJ/jq8olKgcCm3DZHGBeTP2YYUBzzyVDvg6+1k5uDK8Z29gV/2U
         9T9vW0+zlUYV1fVgE1qCJ+RTvCDUxAP8qDrJGE1OCIPPu6juDpMiYy2PouuCvK/j5HWx
         KOgWILZ6y+gTr/Jlz61LedJYTGFziH6monywm0ERvkoq454BB9/Jvmf1qHvLM88PImKq
         Wpeg==
X-Forwarded-Encrypted: i=1; AFNElJ8qmKuQ4QVuHWm9bikXqiZZH+5w5BhNdhmMi+lEivmA7NvJrwTAgMj+OF3lkIA65UCCVVhFH/kG0Y3e9iQxuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxdsSUt5KsOGP55uhG/aa/Nnk3lPnAMF1HS1a2hJVfNHmdVYz
	jA44UO8h/aLx3BWLqulXOeFnY/bQ/Aksfr76JX7o8wxaBHC5PCBbANmG
X-Gm-Gg: Acq92OGUWdzMdM1TEpkG0nfUFcazY8ulFjbuLl+zQ9TuCOjZPVPt5kkbxKdO8YbUfP3
	Vv5D4u0nSBwxa94A8wQlX94k1T7ForkYmkPz8AVUupJ+4Oxqazuh30ly7wwWhFZjdgE1Wg6mh5j
	W+qe2NTOheo657cI6wcEIfcEUi+GmTH/BZm8jMmoqD84sznPVHRo9kzPAONZkIX1MWZID0RdBYo
	PdiCUkoqR1gn/2XB7Mi2QHaCC3AbA+ISZalUGTKlhxmzP0t8/GNnswZRaU05KGhTAhSiNxjp0p2
	XN6O6oxdzTlnZcvL3inQrpIlAKAjh0+TOUlWEJBAbpWP3AgDJaSVtyxFl0g0/+xqVlFtQj7PWn+
	HJYz8zGGNtr4xqcpIpwW4rpG149ECnaOIIgSmRe/xrqmyznot9udcpwb9z/+CyNlVJKgIiNVMAx
	EOQEVyJvTPFvLM+2VveyeGlJUleDPr29E3n/5wi1qj64RrZOs3DJp0VCkKJvWVx+0GUzyaL5Ky
X-Received: by 2002:a17:902:f78d:b0:2ba:ba5c:2524 with SMTP id d9443c01a7336-2baba5c26d4mr142806315ad.11.1778412361580;
        Sun, 10 May 2026 04:26:01 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35e9dsm75362185ad.39.2026.05.10.04.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 04:26:01 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Patil <shital@cambiumnetworks.com>
Subject: [PATCH] wifi: wilc1000: fix dma_buffer leak on bus acquire failure
Date: Sun, 10 May 2026 16:55:20 +0530
Message-Id: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B623503CB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36144-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shitalkumar Patil <shital@cambiumnetworks.com>

wilc_wlan_firmware_download() allocates dma_buffer with kmalloc() at
the top of the function and uses a 'fail:' label to free it via
kfree(dma_buffer) on error.

All later error paths correctly use 'goto fail' to route through this
cleanup. However, the early failure path after the first acquire_bus()
call uses a bare 'return ret;', which leaks dma_buffer whenever the bus
acquire fails.

Replace the early return with goto fail so the existing cleanup path
runs.

Found via a custom Coccinelle semantic patch hunting for kmalloc'd
locals leaked on early-return error paths in driver firmware-download
code.

Fixes: 1241c5650ff7 ("wifi: wilc1000: Fill in missing error handling")
Signed-off-by: Shitalkumar Patil <shital@cambiumnetworks.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 3fa8592eb250..4b116fe6f9ea 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1265,7 +1265,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	if (ret)
-		return ret;
+		goto fail;
 
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	reg &= ~BIT(10);
-- 
2.25.1


