Return-Path: <linux-wireless+bounces-16798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D629FC541
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 13:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FF0163BDB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F68189F20;
	Wed, 25 Dec 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nrl5HMnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41017993
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735131312; cv=none; b=I5lx/ORmdRGtWfC/AAF0+gPdNNY5Rbip306BkpX66ZVUHWper+osj8kyzSWf0IMzfpisKVSV9Y/p15U7KfQwDkUU3T6NgIB+nlmbKTpHvMrRGyPGUxOnOrE78KCes5LcxHIjs5L4xJjAmQaCY5DHcAJePYwWM+gBTdcg1UBGriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735131312; c=relaxed/simple;
	bh=tEqNqGqJQbdqTEGpddM96waesNUChP1tq4jxqn+CEpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NY+lgfUfblKFp32B+++Nc1EjVS+nce7TDhf1XFf++24x5TC2uo0k44HzX1fdGWZ+3Ca2yXpSqOqG+feGRm7socJW4s1IZ4BTjDQSdWjOPqhWUpM0vEu6D0aU5D437KlP0UdtvmzSC0O6gQLLwJLiomwAsSVN+LIkYvaxhWT0POA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nrl5HMnj; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id AB1726E02A
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 15:47:43 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a21:0:640:b775:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 4C3D760D2F;
	Wed, 25 Dec 2024 15:47:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WlXntRBOo0U0-gnGvls54;
	Wed, 25 Dec 2024 15:47:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1735130853; bh=K2a3GbEb6oBv8J7QQLRTLLSj7uUQXXB81isHiEXLrV0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nrl5HMnjKilCGtmd9GDubT6iyMAjl6jzi0XXcxWkhL5Vv5WUeIghbFopWHIC1AZq6
	 Ck05X9twxlTXANbGcmmBGQEDrFYcFGSoskGnRZ02Me/Obj6iwUwJ2/6tZ34rsKKKFZ
	 /B89ZxRMzjItM3FLhIXLQq+GKD+RjNYR3Tm1Du1k=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: perform buffer size check in ath10k_wow_convert_8023_to_80211()
Date: Wed, 25 Dec 2024 15:47:10 +0300
Message-ID: <20241225124710.91238-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking through the following:

-> ath10k_vif_wow_set_wakeups()
   -> ath10k_wow_convert_8023_to_80211()
      ...
      memcpy(..., ..., pattern_len);                    [1]
      ...
   <- ...
   if (WARN_ON(...packet_len > WOW_MAX_PATTERN_SIZE))   [2]
      ...

I've found that [2] makes no sense after [1]. I.e. check for possible
buffer overflow should be performed prior to touching both 'pattern' and
'mask' buffers with 'memcpy()' in 'ath10k_wow_convert_8023_to_80211()'.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/wow.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wow.c b/drivers/net/wireless/ath/ath10k/wow.c
index aa7b2e703f3d..40adb51211d0 100644
--- a/drivers/net/wireless/ath/ath10k/wow.c
+++ b/drivers/net/wireless/ath/ath10k/wow.c
@@ -78,8 +78,8 @@ static int ath10k_wow_cleanup(struct ath10k *ar)
  * 802.11: |4B|dest mac(6B)| 6B |src mac(6B)|  8B  |type(2B)|  body...  |
  *         +--+------------+----+-----------+---------------+-----------+
  */
-static void ath10k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
-					     const struct cfg80211_pkt_pattern *old)
+static int ath10k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
+					    const struct cfg80211_pkt_pattern *old)
 {
 	u8 hdr_8023_pattern[ETH_HLEN] = {};
 	u8 hdr_8023_bit_mask[ETH_HLEN] = {};
@@ -149,6 +149,9 @@ static void ath10k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
 
 	new->pattern_len = hdr_80211_end_offset - new->pkt_offset;
 
+	if (WARN_ON(new->pattern_len > WOW_MAX_PATTERN_SIZE))
+		return -EINVAL;
+
 	memcpy((u8 *)new->pattern,
 	       hdr_80211_pattern + new->pkt_offset,
 	       new->pattern_len);
@@ -167,6 +170,8 @@ static void ath10k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
 
 		new->pattern_len += total_len - ETH_HLEN;
 	}
+
+	return 0;
 }
 
 static int ath10k_wmi_pno_check(struct ath10k *ar, u32 vdev_id,
@@ -341,16 +346,16 @@ static int ath10k_vif_wow_set_wakeups(struct ath10k_vif *arvif,
 
 		if (ar->wmi.rx_decap_mode == ATH10K_HW_TXRX_NATIVE_WIFI) {
 			if (patterns[i].pkt_offset < ETH_HLEN) {
-				ath10k_wow_convert_8023_to_80211(&new_pattern,
-								 &old_pattern);
+				ret = ath10k_wow_convert_8023_to_80211(&new_pattern,
+								       &old_pattern);
 			} else {
 				new_pattern = old_pattern;
 				new_pattern.pkt_offset += WOW_HDR_LEN - ETH_HLEN;
 			}
 		}
 
-		if (WARN_ON(new_pattern.pattern_len > WOW_MAX_PATTERN_SIZE))
-			return -EINVAL;
+		if (ret)
+			return ret;
 
 		ret = ath10k_wmi_wow_add_pattern(ar, arvif->vdev_id,
 						 pattern_id,
-- 
2.47.1


