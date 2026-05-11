Return-Path: <linux-wireless+bounces-36189-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AsmQJQNbAWrlWAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36189-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:28:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D59507D42
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 658CE30062DE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343BD351C06;
	Mon, 11 May 2026 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJrff5Qr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FC1E98FF
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473728; cv=none; b=MINg3ctvnw6xsLR3KXXRqxQjmmCAkTluokxi7JRJS7QeTPk8y2rFiKBucgMORKsPE2EpChwfhbr0htJ3TZ/Hwr0/IOoE1mZSaAd+N9X5uJycwasaMdSib7A+Oj5jIsGUjsrnRv+tw7YWUrvLKzabd5X+WVlnqlEWam3Dqm/+JjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473728; c=relaxed/simple;
	bh=ANYTj5FKK8fZ407SEAKLB8j5DfQii61HUCj0j8WodM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrfTOhqn2IVjZblQZaLLa/2TLmg/T2S1NJbDwlXVnkZpN93dIN0IbPmFxWNogQ/PZivn9djQwsS50nsa0ytZhRbqaLpjeB2WSJIFycwe2J0EqAmRGKF40WI8NFck4p8jP/YwJc8iIJXXRR82krJmfbyX9hKhZg96zJICk75YMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJrff5Qr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2baef9f5ecdso19566715ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473726; x=1779078526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGc1sHXGI9jk1rFS6hqXBE05iQZt/kMXUpe8P2KJtOE=;
        b=nJrff5QraQMjlzEFRP26OmN9jNrrHCfwqY2gJJ7I+zqdWxoMtZpFiPFtmBEbM1vN9U
         byEP+09tcinqMsd+TXNOBMqBQlPqKQvY0z/WOw9vKBJ0ZtFmgmaiTaKQ2LctwjtR3izp
         fkBykP+NBH0VdBJjmk8xdcyZlfPqfBSvgxHqj/pC5nLQWorxK4ayb+Pe+fya5sll9NZs
         hDJAP5P+Y4UqmLD0BlDzhhbYSmpTaYW9CDC63qR0ROe7YM79wFCpAxyq15PPfIqT871w
         6VWvHivs5R96vkdYuh0TXK6N3QpXRd9btOudk/N83b1JsXfQNyf3T98XHLF1dPPny5LX
         LMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473726; x=1779078526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGc1sHXGI9jk1rFS6hqXBE05iQZt/kMXUpe8P2KJtOE=;
        b=E3Wq6IPc3kZI765gSvMAqbwSR2eSBk3VB2V/koysYjMfLL/o1dCe66DxFnbRW1Hj3E
         R75+EIYCvWKUeFowD2TzDIr7MUMxpuZMMgfiRUt+M16dNVbvQbmmtL/PDqq7OhDf6sNM
         FUjO4sC71nRjhWe4+eDLmfVIPmP9GyPiiJ9v98bP6LKzEF44O7y97WtIMOVNKP/7jN4b
         7eY2DMvt82sPA2pfe7fzEQBMIb7ae2oTkhzoE1S7Ik9sGYwN8bivpjdH8WKEU8Tuej6v
         lLxVoquR8GbGtDXyWqLm/RE96RgCIklx7LL0QGI9mNv9nTcG7hz2RdqnwLKhoMa5Ssnt
         fBJA==
X-Forwarded-Encrypted: i=1; AFNElJ93erf9af2gkqq+KMmQQyhD/ekxoT04vpQscVGIxlasIZO+7fHHVkN5I30nZ8MTw7GuDgFr/WfSCILzQvH8fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlXR0XoiF+AkY29SM4P2vLUFULsXl4y6A1hOa1sx6ikPf11mt
	sTl/CUFjHEdAWuH98JNGBnH6H/e8bvSunKbYtwjzwFDePnsop059e/hK
X-Gm-Gg: Acq92OGijZNQBrCJXbAtg0igSuCIw7WO0xWgHohgwT44jpVsiGNwxairH6qxx0z0E+d
	psam4z3LxzMUOuh18T3m7IuZkh17GDXxqLuZdX3eFvaKArFvBxs21WYb9G+nZA63x/wkIaXO4qC
	iLZpZydvR7PUEPvQkKWaE7AdMrEbOhxqWVLPuVQ8JJojkIKCFM9QfF7awAnYkCqim9QjV5rNn6J
	FVr4lXrnUXJzRWukuA9luoRbFt6hMjkaZ60h7HaBcHwdepCzwx4BvwQ9CzgyIyqrKL9iCOVnBdo
	B6bP5oJBGVW5GhshsJxRzTTFMGO2tEZ6ojWcKXlCMSUSSeH37xJ+rnnDBKxaepg1mAp90aqyWVk
	EJB3xRQqem6FtZWAEd5dQDyxf25naS4gVvoiKr2b4UIOJ7WYbUAffLNKSqugQSzKV94epRPytBW
	uKyDnOv19+4gDM0/hRexj3PLrYI4JSegnwfmDj84AXEpZUt6xH6CUHK41CKqIBQA==
X-Received: by 2002:a17:903:1aae:b0:2b7:88f9:9c3d with SMTP id d9443c01a7336-2bc7a9a0d0emr87611055ad.12.1778473726160;
        Sun, 10 May 2026 21:28:46 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27062sm88740375ad.3.2026.05.10.21.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:28:45 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH v2 v2] wifi: wilc1000: fix dma_buffer leak on bus acquire failure
Date: Mon, 11 May 2026 09:57:32 +0530
Message-Id: <20260511042732.998311-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02D59507D42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36189-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
Changes since v1:
  - Corrected From: and Signed-off-by: to author's real identity
    (Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>).
    v1 was sent with incorrect author attribution due to a local
    git config mistake. No code changes.

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


