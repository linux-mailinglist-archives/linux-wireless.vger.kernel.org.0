Return-Path: <linux-wireless+bounces-14271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC69A6C16
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0BB282487
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1981F708A;
	Mon, 21 Oct 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Wurkv7Yy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBE1E0B96;
	Mon, 21 Oct 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520882; cv=none; b=DNyym2Z2bZN7bkH28vYNIW+oSVFiOU1wiVu2L5phr6XGiXN8XUtmSz1k1QEICrNpnd//olvYsKt4L1YUlGHgKrI/3amRW81iD17sfZpE2eR1ZHpe/0rkJT5ct3r0kFMNe2k4vu8o4m/9gp3Ad+xExR9wzDtSmRHkxjeildrUFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520882; c=relaxed/simple;
	bh=gG7Gb9EtRA3/IL6w124GoeryzwxF46nAfxADUAv7nLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQEQjJCMrdhN0YtdpX7pnVyckI/RtnILWqjfGHYABM+3f1zTtxnmGZ56UIymKlqTgq3+3WfZ/yAQk6qgo/dI3AaJVHVxJiF5ZEh9+kd6njoW5zSVRlWOosATGrm81DZ3JZY9yAUgPUBpTUmOKkvR9vADb9MkTCSmebUPe2WZqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Wurkv7Yy; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:1c1:0:640:adc:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 1DEF460B4B;
	Mon, 21 Oct 2024 17:27:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lRSmp10RnW20-TEZCJ34u;
	Mon, 21 Oct 2024 17:27:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729520870; bh=6faOcTS6mFHEY4gygamW7D4tB4w3vk9ae3heHZMowuY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Wurkv7Yy5/Fo3n0sL1KEWmqIUsdsciCY3IDm5W5SviLt+HhWWklyljHexVF27rFPg
	 YUwH9vakAwtpsfGsqolA+5iRjE8ofs+akT0MbwCd2PPB16FxaIE+1RoFBuyy8D6Zwz
	 YkcrRHaZMHfSktjcE6XRS7EMzZ/xlNT2qJV/Igxo=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: ath11k: annotate skb of struct ath11k_ce_ring with __counted_by
Date: Mon, 21 Oct 2024 17:27:44 +0300
Message-ID: <20241021142745.585308-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to 'ath11k_ce_alloc_ring()', annotate flexible array
member 'skb' of 'struct ath11k_ce_ring' with '__counted_by()'
to improve runtime bounds checking when CONFIG_UBSAN_BOUNDS is
enabled. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/ce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index bcde2fcf02cf..9c54244970ce 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -162,7 +162,7 @@ struct ath11k_ce_ring {
 	u32 hal_ring_id;
 
 	/* keep last */
-	struct sk_buff *skb[];
+	struct sk_buff *skb[] __counted_by(nentries);
 };
 
 struct ath11k_ce_pipe {
-- 
2.47.0


