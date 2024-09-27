Return-Path: <linux-wireless+bounces-13255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794CF9880E3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 10:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AF228233D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A4189F39;
	Fri, 27 Sep 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="H01EDKnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA697189B97
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427100; cv=none; b=NDs5mH69wqAXNJHhv1OiK5ZBxAkIcDIpvVNmaj8gwgXzysyXf0sG7B2haW+4D2fo9zjYToGolW1+/+MZaKC4/S6k1I2QRq9kAgVURf02dDX9Zt8GwSQHzzoGKJSMl/L4PwrFoxf7QjOj3nceE+xiXl1pJSM6kn2x7wFsXoXLIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427100; c=relaxed/simple;
	bh=jsIoMqVZNXghxRYkbEue9X4iBMVyjdL8fuqxnQH4S8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8mVNNd9bw2Gq1V5UVxRqtx3wHeCwI+qbfKILqUi+MXZBsLZOJSxf5zGQUrz3tEjV/W1U3IdWMYpSAWxnD74jAdWeO/iR/riwUL35HVWl9WtFeuVmlk9vlsPFMZYpZkTk/hbNm4mSVmUglxNd5lESihUCxc6KpXgeU2c1puSfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=H01EDKnv; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id D1FD26700D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 11:45:03 +0300 (MSK)
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id B0B9A6C546
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 11:44:33 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6a2:0:640:8042:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 392D946D42;
	Fri, 27 Sep 2024 11:44:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PiRcldGOpCg0-ENSd26W7;
	Fri, 27 Sep 2024 11:44:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727426665; bh=dAfmTrmIcRUjXPrdO8VUtes0BhwlZeA5e3w5xX0/uME=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=H01EDKnvvoMt4ikhDew8IIgIHaOQovto80ecTUWuiJrCs8srXqJwj885ygk5k+gFW
	 7ZSaT7dyOQhJSjdj96ctxD+7WcRqEk3Upn+KglbR9rksCaVWxJIj8DnyXcwxFwqKhq
	 DqsCTx4p6Pyd47lkKAPDGEe8p9+ciXk29Feg65GI=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: mwifiex: cleanup struct mwifiex_auto_tdls_peer
Date: Fri, 27 Sep 2024 11:43:16 +0300
Message-ID: <20240927084317.96687-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Remove set but otherwise unused 'do_setup' member of
'struct mwifiex_auto_tdls_peer'. Compile tested only.

Fixes: 9927baa3c724 ("mwifiex: add auto TDLS support")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 1 -
 drivers/net/wireless/marvell/mwifiex/tdls.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 566adce3413c..92a1cab6e750 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -802,7 +802,6 @@ struct mwifiex_auto_tdls_peer {
 	unsigned long rssi_jiffies;
 	u8 failure_count;
 	u8 do_discover;
-	u8 do_setup;
 };
 
 #define MWIFIEX_TYPE_AGGR_DATA_V2 11
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 7823e67694e8..0a5f340876c3 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -1306,7 +1306,6 @@ int mwifiex_tdls_check_tx(struct mwifiex_private *priv, struct sk_buff *skb)
 							   peer->mac_addr,
 							   NL80211_TDLS_SETUP,
 							   0, GFP_ATOMIC);
-				peer->do_setup = false;
 				priv->check_tdls_tx = false;
 			} else if (peer->failure_count <
 				   MWIFIEX_TDLS_MAX_FAIL_COUNT &&
@@ -1465,7 +1464,6 @@ void mwifiex_check_auto_tdls(struct timer_list *t)
 			   tdls_peer->failure_count <
 			   MWIFIEX_TDLS_MAX_FAIL_COUNT) {
 				priv->check_tdls_tx = true;
-				tdls_peer->do_setup = true;
 				mwifiex_dbg(priv->adapter, INFO,
 					    "check TDLS with peer=%pM\t"
 					    "rssi=%d\n", tdls_peer->mac_addr,
-- 
2.46.1


