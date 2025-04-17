Return-Path: <linux-wireless+bounces-21634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D82A91D9A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE2F1897AD1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB96241679;
	Thu, 17 Apr 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dx+USYBa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qaj+PmDO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418782F24;
	Thu, 17 Apr 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896031; cv=none; b=qVaVKQcpKL+WcLOuUEDhWuc3I6tPS8KyBTM6goSezlMW3ISQjc5g5Lox2SHBkymGLNP3gZ9abH4t2EovWxHutq3PeqgEFxVp1p1obVPm1BhGbUZ5mqV2OtwmZUwGkOATp8gB1sKMx8rhmiCHdh7ftUJCeF9CfsDWtyi5rSC9gVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896031; c=relaxed/simple;
	bh=USJc9JCGJMae1BOrGUqYC9Qw2zxqsi9K4Px5b2V9oIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SQCeLqjkRqZ3RKfCFLVSXYNZYhB/w3EOvYehfBvAYO0QZ5b/BzWFiBn6SEFMwkT7gdPlmqcCvN1DJ9Ado3Cbtc5uPHRqPM2rxmpO4ESVhGcppQJeiXJ0gSlqsCxMBS/dsIPOVKqRXIfGHElJ27ANJKKAAaPjbfCscUuuvi/+g/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dx+USYBa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qaj+PmDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ax4rJeZalogOj8wIoY/TFwkI03ahXbhPQLwzXY9UpSs=;
	b=dx+USYBaLx2I8Gdx4jaFGW21JHYSvZVQrMa5rF24bMOqGyQaCRgOzg0x0adtoH5JsOf47v
	2hJnYdYFooJcZxCWeTw2EPrM4awrBlwYJW2xB5R5gYeSnqutuy2HT9AwFj8PqePW5X34C3
	NqLOaNdSQv97cS0V2073siV4AMC/9KiZA1RP5999vF5i99jwHTR0VwpD6HpAolWxL2W4eb
	PPm2n0L+wUt9QO1jEe3nthl4ZXhQyYMLM1sBmPvS+T5q3lcUazqEogUeikY/16l71r+tc4
	nVLZ9cHWKGQqqsO8t4usyVnssXaNuO1fcSf78zFdsP3LUrWJ/Sk27C0zCwyqZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ax4rJeZalogOj8wIoY/TFwkI03ahXbhPQLwzXY9UpSs=;
	b=Qaj+PmDOxeik8no8OOe9lbHhu7DdF7oqPucBcoWuTLQSfomc8hZvaWFmgzLnJx/muwN01O
	PloGeSH7pFB+TZDw==
Subject: [PATCH ath-next 0/4] wifi: ath: Don't use %pK through printk
Date: Thu, 17 Apr 2025 15:19:06 +0200
Message-Id: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMr/AGgC/x2MwQqDQAwFf0VybmDd1Ur7K8WDuM+ayypJKIL47
 932ODAzJxlUYPRsTlJ8xGQrFdpbQ/M6lTdYcmWKIfahawdWmKvMjsz7JsWhxpOv3C1xePQppHT
 PVOtdscjxP7/oJxQcTuN1fQHjFTh/cwAAAA==
X-Change-ID: 20250417-restricted-pointers-ath-4f279530336d
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, ath10k@lists.infradead.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896028; l=2034;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=USJc9JCGJMae1BOrGUqYC9Qw2zxqsi9K4Px5b2V9oIE=;
 b=4aoFpAS7vIBaF9DayfeaPUa3K8Y5PLpmCpvBRYmcVCoc+zcl7IawUrjWZAlS1Ft2aLcp1igtX
 zxE18fWrB/kCfXWYMg4nMCS/vnn8USOet1o2Ez+oHcqdiricl6fnoxv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

These patches were originally part of
https://lore.kernel.org/lkml/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (4):
      wifi: ath10k: Don't use %pK through printk
      wifi: ath11k: Don't use %pK through printk
      wifi: ath12k: Don't use %pK through printk
      wifi: wcn36xx: Don't use %pK through printk

 drivers/net/wireless/ath/ath10k/ahb.c       |  2 +-
 drivers/net/wireless/ath/ath10k/bmi.c       |  6 +++---
 drivers/net/wireless/ath/ath10k/ce.c        |  4 ++--
 drivers/net/wireless/ath/ath10k/core.c      |  4 ++--
 drivers/net/wireless/ath/ath10k/htc.c       |  6 +++---
 drivers/net/wireless/ath/ath10k/htt_rx.c    |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c       | 22 +++++++++++-----------
 drivers/net/wireless/ath/ath10k/pci.c       |  2 +-
 drivers/net/wireless/ath/ath10k/testmode.c  |  4 ++--
 drivers/net/wireless/ath/ath10k/txrx.c      |  2 +-
 drivers/net/wireless/ath/ath10k/usb.c       |  4 ++--
 drivers/net/wireless/ath/ath10k/wmi.c       |  4 ++--
 drivers/net/wireless/ath/ath11k/testmode.c  |  2 +-
 drivers/net/wireless/ath/ath12k/testmode.c  |  4 ++--
 drivers/net/wireless/ath/wcn36xx/testmode.c |  2 +-
 15 files changed, 35 insertions(+), 35 deletions(-)
---
base-commit: cfb2e2c57aef75a414c0f18445c7441df5bc13be
change-id: 20250417-restricted-pointers-ath-4f279530336d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


