Return-Path: <linux-wireless+bounces-934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A38174BD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E3F1F23315
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB6200C0;
	Mon, 18 Dec 2023 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="NWj70zYm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825603D540
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:30a4:0:640:6426:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTP id E2A9A60A95;
	Mon, 18 Dec 2023 18:04:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s4q4qX8PfuQ0-A9zrS1Bi;
	Mon, 18 Dec 2023 18:04:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702911895; bh=9APtOO4AkWSIUPxuEeY1iDf0BKjrWx98wgRgAmiaKUg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=NWj70zYmefUfhIsm1YuRqKhMPAnLfPl0eZp3rAAIWTXToqNfeSoBr+S8M347uASmM
	 wKWDWVtGog9g4OO+kGYE06bcBCpaBqgI+P/PmYx6iVKSRVcagXZBILgi6vDi1UWrg5
	 cZ1Q9Elz5ENnqbC6IxyLD8j7+sThyhxJ8xDIsRaY=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlwifi: dvm: do not set priv_sta of rs_get_rate()
Date: Mon, 18 Dec 2023 18:02:34 +0300
Message-ID: <20231218150245.343691-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 1e87fec9fa52 ("mac80211: call rate_control_send_low()
internally") removes an explicit call to 'rate_control_send_low()'
from 'rs_get_rate()' and 'priv_sta' is no longer used till the end
of the function, there is no need to reset it to NULL. Compile
tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index f4a6f76cf193..ab237cb1d91d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2684,10 +2684,8 @@ static void rs_get_rate(void *priv_r, struct ieee80211_sta *sta, void *priv_sta,
 	}
 
 	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (lq_sta && !lq_sta->drv) {
+	if (lq_sta && !lq_sta->drv)
 		IWL_DEBUG_RATE(priv, "Rate scaling not initialized yet.\n");
-		priv_sta = NULL;
-	}
 
 	rate_idx  = lq_sta->last_txrate_idx;
 
-- 
2.43.0


