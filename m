Return-Path: <linux-wireless+bounces-28447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC174C24C11
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 12:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 010344F4F26
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58C345754;
	Fri, 31 Oct 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDihGp7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38463451BF
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909460; cv=none; b=GAWuWuREok14bEAQLRAn3fwDneSr5L1jTE+tyjGgcrcrn3E5HMUDlSyctEN+qMkKTWlMNp6hdJhKrFfMSJNPy8cjPQpunpDCQYK9ky+0Xbxrid3tiu+Eb5g3KX/7yA2x5Zs+5iM+RsZcHG2f5FP0pKdI4+WC6sNoCrUosngqVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909460; c=relaxed/simple;
	bh=XsaAKu1cdwxrlu436RGnx13iM1mV+nARVNc9oObE86c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqSWEdWT/4EhCmvOY0krEGTS/tSbUNOY21T8zV0er4px5A8nXJg24n41WmaHOory++Gn9oo7a6PsSjRDLEnKs3vgOQJUAD3JizFneqHDNM+m7gB3+2JSQJpAGssGj7NcpvS+BgfbB8U3Rp7qk4lWI9ADS9jLh8LJmmPI8aI6OXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDihGp7A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a2738daea2so2112575b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761909458; x=1762514258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+e+UAk578qZgTiUOAdHLd6XVTShCxhiEWjVV/FznGz0=;
        b=aDihGp7AUrh+t2Xx1G53H0KcJpFC4U8K14VF2JcGY+w/mQl4Bdkx7SMO5fIK6tRjRG
         1pxOGGNQVCh+xfR+odEX8q0AMaFuaFNIlIHV0N1/SSZAwqwETk7S6HAQd8cJXSZpgsMw
         8ICyHMgHnCZ65BYW1RhKbd0YeQ1OAeWRIDUqdTCzJ4tJ3wX16V98+mAgJLrhSm6OQy/S
         u141boo4nuSRlfKOsV0f750uF6oaPyE6527EvDxT1T3Slf0vvC2gOVEu+04aF2cmTJPf
         tIqiO+/xWcaAjj3At/NEYEhMSKQFBecnAAqbRHcafG8pFH2TXB/Ll0r/w8i51mZkbNnX
         PZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909458; x=1762514258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+e+UAk578qZgTiUOAdHLd6XVTShCxhiEWjVV/FznGz0=;
        b=Uaw/drsBCwfYB9LaS3CLYuVux9MJCFGYAw2S0zPif5YIm15+lu6rDVvug1aX423I0W
         SElEw/BW1+U8G+UiUV98b5O5xrWVzwECul+Zp8zgbTo2lyob/GbCl6uAspEiZlHNd3PF
         D8DliRyuhD9rxBueSKETZU+ns+DoUnlhhNUe9jhGhCcs5P6Pa3POzShc7Nct+mwcHc3p
         Avh80oJDfaCVOr7K/zcnSyQrRXRQByAyRb+fHs82dSnIeYa5Xazckjh6FcLijCWptXiz
         aHv/GGKJbNzQbFV83KfoOqzgRSiPsirR+mfS68+6mm8E4d67dAb6nr9znT5aSE+x+LKQ
         7hVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfgPuZTkZJ9HXDTviQ2agIq3iIR3uZt0JwMWl6vL82g7VbZ8rjxp6BcpRsscPKHvMhd5nFmZbEzTkNjEAnhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVRM3hgkKM7rm+xuOCIOscGKcMHw9cEfLWMuwAUCc1PkWW8c/
	Rr8ojBvKtWooyRWm7SErL6xGIj07hgdlHNJTf1P/hwfCrocJ4rqoCfVSJyjbaHcO
X-Gm-Gg: ASbGnctt0qQlIgziXu6QJXnJR6TM2BPRBA5+I6+blonKlNGbTSV1H8hSURkt1JLHDoB
	oRwrMUBqYqj+pjbWd9U37hLU2qYQpjt8dC2ynV7IQeyd2DBjcL37tiaYANFYPdpF35pJYcEvOT0
	p1moY4wCUdGp5hXRP+HSI6Zjf2vrgyt6rkC9BK6UNsqfoen+bmyoqtbK2uMzboGGilRGH0i0mJa
	xv8fXo6Omg/eCM3Gv8I2D10WMGIb3JPFMEef3dhBVCVqaPw77bvRBwk5iNXZ7cu7pJ1PdzW7WSs
	g13tF7lc+Twzar9DOSTGxCNIREOOVtY4EwngJVf2AD3NAXwsvXef5wGr2us+5p3uo0Qh+kkAtFz
	1B1Hf4wvmKb28Xay6s3uyVnkU4kOgNlvvNklHzVOPE/n0quqImOU9X86TXdpenh044UnUkGDdTr
	CRcRkIAC0EUkaYC4+APcuu6QMDfydPcCVsS/2iW0rCz1UE5rsp
X-Google-Smtp-Source: AGHT+IHDqFb6gR3IjGUQRse71p5ISdIE1cA0yF0w/b7oVCBs5q2wxqjLzKdDydo1C/6WO9/1B2HbeQ==
X-Received: by 2002:a17:902:7608:b0:290:a32b:9095 with SMTP id d9443c01a7336-2951a5c201bmr29211485ad.54.1761909458309;
        Fri, 31 Oct 2025 04:17:38 -0700 (PDT)
Received: from NT123328-PC02.ZyXEL.com (114-33-191-187.hinet-ip.hinet.net. [114.33.191.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268a96fdsm20220115ad.31.2025.10.31.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:17:37 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH ath-next] wifi: ath10k: simplify ath10k_htt_tx_mgmt_inc_pending
Date: Fri, 31 Oct 2025 19:16:39 +0800
Message-ID: <20251031111639.406873-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove is_mgmt from ath10k_htt_tx_mgmt_inc_pending and make sure we only
call it when it's a mgmt frame.

Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/wireless/ath/ath10k/htt.h    |  3 +--
 drivers/net/wireless/ath/ath10k/htt_tx.c |  5 ++---
 drivers/net/wireless/ath/ath10k/mac.c    | 20 +++++++++++---------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 603f6de62b0a..d94f63637810 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -2450,8 +2450,7 @@ void ath10k_htt_tx_txq_sync(struct ath10k *ar);
 void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt);
 int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt);
 void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt);
-int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
-				   bool is_presp);
+int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_presp);
 
 int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb);
 void ath10k_htt_tx_free_msdu_id(struct ath10k_htt *htt, u16 msdu_id);
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d6f1d85ba871..0cf30068447b 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -168,14 +168,13 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
 	return 0;
 }
 
-int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
-				   bool is_presp)
+int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_presp)
 {
 	struct ath10k *ar = htt->ar;
 
 	lockdep_assert_held(&htt->tx_lock);
 
-	if (!is_mgmt || !ar->hw_params.max_probe_resp_desc_thres)
+	if (!ar->hw_params.max_probe_resp_desc_thres)
 		return 0;
 
 	if (is_presp &&
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index da6f7957a0ae..6d77d451988a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4442,7 +4442,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		is_presp = ieee80211_is_probe_resp(hdr->frame_control);
 
 		spin_lock_bh(&ar->htt.tx_lock);
-		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
+		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_presp);
 
 		if (ret) {
 			ath10k_htt_tx_dec_pending(htt);
@@ -4728,14 +4728,16 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 			return;
 		}
 
-		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
-		if (ret) {
-			ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
-				   ret);
-			ath10k_htt_tx_dec_pending(htt);
-			spin_unlock_bh(&ar->htt.tx_lock);
-			ieee80211_free_txskb(ar->hw, skb);
-			return;
+		if (is_mgmt) {
+			ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_presp);
+			if (ret) {
+				ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
+					   ret);
+				ath10k_htt_tx_dec_pending(htt);
+				spin_unlock_bh(&ar->htt.tx_lock);
+				ieee80211_free_txskb(ar->hw, skb);
+				return;
+			}
 		}
 		spin_unlock_bh(&ar->htt.tx_lock);
 	}
-- 
2.51.0


