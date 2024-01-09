Return-Path: <linux-wireless+bounces-1629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E101E82843A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 11:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924401F23869
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2551364CA;
	Tue,  9 Jan 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lwI/lGlm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258C364C7
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4081:0:640:557:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTP id 2441C608FD;
	Tue,  9 Jan 2024 13:48:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZmevPaKOlqM0-JvwanXXG;
	Tue, 09 Jan 2024 13:48:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1704797317; bh=WRJhJyHBayq7JZW9+ih9H6eWmLt5AHnd9IcIaEE6ozo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=lwI/lGlmo4H0NeTIgKx0uje39q4TXFpuFO0CbjS8AJgLORm839q5NNJzul23yvIXT
	 iPKrXNYIHrlI5oDsYXKaW0xFmenzINbAeO3ipDdPuWUhPWhImFlS2gl/SlDbXcPg6S
	 Ebt0AhAUlRtM7xv9xMp0ENyHHi9ZI0eh9A6AJ68g=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: cleanup few rtlxxx_tx_fill_desc() routines
Date: Tue,  9 Jan 2024 13:47:32 +0300
Message-ID: <20240109104735.140550-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unreachable branches in 'rtl92ce_tx_fill_desc()',
'rtl92cu_tx_fill_desc()' and 'rtl8723e_tx_fill_desc()'.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c | 6 +-----
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 50e139186a93..ed151754fc6e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -350,7 +350,6 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	bool defaultadapter = true;
 	__le32 *pdesc = (__le32 *)pdesc8;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
@@ -503,9 +502,6 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 	if ((!ieee80211_is_data_qos(fc)) && ppsc->fwctrl_lps) {
 		set_tx_desc_hwseq_en(pdesc, 1);
 		set_tx_desc_pkt_id(pdesc, 8);
-
-		if (!defaultadapter)
-			set_tx_desc_qos(pdesc, 1);
 	}
 
 	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index 2f44c8aa6066..e5c81c1c63c0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -475,7 +475,6 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	bool defaultadapter = true;
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u16 seq_number;
@@ -587,8 +586,6 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	      ppsc->fwctrl_lps) {
 		set_tx_desc_hwseq_en(txdesc, 1);
 		set_tx_desc_pkt_id(txdesc, 8);
-		if (!defaultadapter)
-			set_tx_desc_qos(txdesc, 1);
 	}
 	if (ieee80211_has_morefrags(fc))
 		set_tx_desc_more_frag(txdesc, 1);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index d9823ddab7be..65bfc14702f4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -349,7 +349,6 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	bool b_defaultadapter = true;
 	/* bool b_trigger_ac = false; */
 	u8 *pdesc8 = (u8 *)pdesc_tx;
 	__le32 *pdesc = (__le32 *)pdesc8;
@@ -503,10 +502,7 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_hwseq_en_8723(pdesc, 1);
 		/* set_tx_desc_hwseq_en(pdesc, 1); */
 		/* set_tx_desc_pkt_id(pdesc, 8); */
-
-		if (!b_defaultadapter)
-			set_tx_desc_hwseq_sel_8723(pdesc, 1);
-	/* set_tx_desc_qos(pdesc, 1); */
+		/* set_tx_desc_qos(pdesc, 1); */
 	}
 
 	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
-- 
2.43.0


