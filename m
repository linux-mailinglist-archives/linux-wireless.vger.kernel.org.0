Return-Path: <linux-wireless+bounces-17564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9633A12998
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 18:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6320E3A7184
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8A158536;
	Wed, 15 Jan 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DY+V/mn7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BB3C47B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961493; cv=none; b=VDTRGrrnj0pHQWg5AtIUSZxtA8RNn/u2gznSo7qK9NP3dxq2nme6gosJEk642R5BSWvwPCCRQQjWx+6oMADwY8Krq+kse1sMvGUegIVg8zl+uOW3erfqLsdq4W6tZFqEKizpQgAF7kWUUEjBQ+gZy8INXeqEBMDojxlhgVDTWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961493; c=relaxed/simple;
	bh=FmSLBYjaZJQWFfTP0n5FDOf/H3NEOazG5MZorU41l6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI7XD4utMmxgOKIBdH0EwtFihdhTYBNeD4yFB7OeaIBTJ8uzaQ3cvYB3k4StAF0SMAnKNt31+zFxGN9iF/kPPqE1rkQRV7F/OXsdmIG+LLfdvit+6k3hJDJ8kRvABGpytABrdudQy5TbASFvv5ceC5bI3qfnpSP3gm6sNPVC3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DY+V/mn7; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:171e:0:640:d7a4:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 48D7F46C5D;
	Wed, 15 Jan 2025 20:18:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0IUVK7BOjmI0-ZgDXOlln;
	Wed, 15 Jan 2025 20:18:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1736961481; bh=qZRhmIsrehHWA3U2yNn2uH0uObZYRRnW7zUK4qmCK7Y=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=DY+V/mn7pWkd/ldTa/dMrsy1ikuCoHSdV5H7CT4mZfrFE/5x4rNF4PyBfixO0Ermm
	 wjJWFds3Lgh2ChomWtncVY0wLh13pV8SXRD1V/pLAL4HmEW4Br0b6Ti+sn0c52HDLF
	 LmXGWyes4gKJrBGdb8K8kCy2aukMgWRp9YC/XqrY=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: ath9k: use unsigned long for activity check timestamp
Date: Wed, 15 Jan 2025 20:17:50 +0300
Message-ID: <20250115171750.259917-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115171750.259917-1-dmantipov@yandex.ru>
References: <20250115171750.259917-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'rx_active_check_time' of 'struct ath_softc' is in jiffies,
prefer 'unsigned long' over 'u32' to avoid possible truncation in
'ath_hw_rx_inactive_check()'. Found with clang's -Wshorten-64-to-32,
compile tested only.

Fixes: b5f871ab4913 ("wifi: ath9k: Add RX inactivity detection and reset chip when it occurs")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/ath9k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 65c2250db33d..62442be6dd56 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1017,7 +1017,7 @@ struct ath_softc {
 
 	u8 gtt_cnt;
 	u32 intrstatus;
-	u32 rx_active_check_time;
+	unsigned long rx_active_check_time;
 	u32 rx_active_count;
 	u16 ps_flags; /* PS_* */
 	bool ps_enabled;
-- 
2.48.0


