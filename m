Return-Path: <linux-wireless+bounces-21636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C74A91D9D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827F2189C68A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E912459EF;
	Thu, 17 Apr 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuZ3hdlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DJ9y5yUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7823FC55;
	Thu, 17 Apr 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896033; cv=none; b=awrjG2r/OngGkOYx3ViK4eMgVfP869d/KkcCk7qtUmnk7wAjTkgZy5l8Wv4M+zIidoMZ4Bp6jgubb4eXal//f8J8PN2RupeJtCA7qpR+ub8QTsHXgK47s14K6JvZdoFTcIy8vYbQO1cl65aCmJ43K2JVDyaULxHcKvujlzvRAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896033; c=relaxed/simple;
	bh=StrFXkjU61OZ/Br21albUB1TSXKwVdbD6fzzr0lF8cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB+TU2O2FTslAYOM4hi44FezkcanaIcubMHZrnKjD/NeR0k8sTJoAmDmGx3LIX2bxkbjctw7pokstJCUMp9lEmal7hWmJMiegU1Ez4PphxQyWnCuWsvU9MZJu0iiwYXFuhcPaloRNwrWhZwHW2mg9JRnyqasT7BF5xJ1Ndk1tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuZ3hdlS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DJ9y5yUd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1GeXntpnPWyXUESrbciRq82BQz1QlJ7YZ0gk/CUbVc=;
	b=yuZ3hdlS0nUrlUULOiIVbfJkKVbyppqvbHlS2FV4PHE0yPJR7/k9NSZX7NTQosz3hCIxnI
	80m0fcciH2e8yPHCegiCEWDbu4M0DCNHPj1NKb7YFrGysEz2yIq7xihzImhzVL6plVFJB2
	ADcSIASXby4bV0PP8c8FGM7O//J8rfv8WNurYJ6TG+Y42N8JZjtQFFqsr3M9OFdhnPPrx+
	oqXdE4WxuEdkmzFhz2lIHhaPXqTqWJhP++jqkQu9trCPVcsWbc5lG4N4GIFpxc9Kd235nV
	DpUFGdZrJHEtt1ab68b6AO+cqf8UrOI1gL8Djk9Zdj3ha67kHDpp0Yc/yuUIKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1GeXntpnPWyXUESrbciRq82BQz1QlJ7YZ0gk/CUbVc=;
	b=DJ9y5yUdNyJvZAr2C+gTNyK6ZzcIz6wYME/IU6h3n1ld9N+CixdHwFfw0mZCow+IKHwlnQ
	NIAIjsnaIIi1ZXBw==
Date: Thu, 17 Apr 2025 15:19:08 +0200
Subject: [PATCH ath-next 2/4] wifi: ath11k: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-restricted-pointers-ath-v1-2-4e9a04dbe362@linutronix.de>
References: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
In-Reply-To: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, ath10k@lists.infradead.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896028; l=1593;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=StrFXkjU61OZ/Br21albUB1TSXKwVdbD6fzzr0lF8cg=;
 b=qNfUCGEcsX+Nn3t6KcR00t00ASyLvVOQ9TKgoODq6Fiscv21IPuHnZP3h1CZZ+fhT6EfqPdXD
 zojyXNUtyhTBdeQzn4UWhWmDHqDB0JcpZvueCEpIxa0eDWTZKPlTF2u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/wireless/ath/ath11k/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 9be1cd742339c95ffa74c09bee924f4eff15134a..a9751ea2a0b73009bfb600d51c3978200ce99114 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -107,7 +107,7 @@ static int ath11k_tm_process_event(struct ath11k_base *ab, u32 cmd_id,
 	u32 pdev_id;
 
 	ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
-		   "event wmi cmd_id %d ftm event msg %pK datalen %d\n",
+		   "event wmi cmd_id %d ftm event msg %p datalen %d\n",
 		   cmd_id, ftm_msg, length);
 	ath11k_dbg_dump(ab, ATH11K_DBG_TESTMODE, NULL, "", ftm_msg, length);
 	pdev_id = DP_HW2SW_MACID(ftm_msg->seg_hdr.pdev_id);

-- 
2.49.0


