Return-Path: <linux-wireless+bounces-29753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D86CBD623
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 11:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B938300DA7A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53338227599;
	Mon, 15 Dec 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiqTQDtZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381E287516
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795113; cv=none; b=kLEIVV1aMIX6Hh1c5WuwfFS8uP3rtnuEy/sjsMItCTjYod+TlFO/XCpwEV9aYxn1A9qzDkqDfgyDxsyMG0gq4mxx6a06fyjMxlFyj8d/zjUDoVmey8QneCfz47lup0zbL9DUFrBpbzaxVfxReFacdw7c3rOyywm5Z5xg8742NwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795113; c=relaxed/simple;
	bh=zMGvzUoo5Bn0KmMQfTuF6AAZJfcgkULR7Y3JFpKuYzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tWhKVHVGYI5yFV8ijYAxh5V+mM8KZ3loNsZ5s0hiG5IGBLtGVSmc/hG9ZggKnk6M4B+i3RotXalPNrWtBDXfcp40+HJFotVcr8Y+hOT7bIG9+q64jVF9VlnyxXUd25m4z0dGv4/JAxqdbQGtN0SdmBpU5UWxIIJXkFmzuy2Y1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiqTQDtZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b728a43e410so527653466b.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765795110; x=1766399910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkVNILE1twK6/ovsJ6T9ryNNhv5sOBklW/SMHDSmqFQ=;
        b=PiqTQDtZigMe6+0jygzEhh0OBtfW9PHg0DOihAICmWwaTB2VTdZ5Sa37Qf6OfryP5+
         3vXhZlHqTfxG0maRyLa+aG37Qx7W0sKWPDHgkVUM5inO6Bk0XyAkvo0RXUmrTHpI4+cT
         cIgUUMEoeDzSZRi8bs9IkBnhj4TU7v45nripR9w4Xh5kpn2TdgF9mhmntBZ7g15IMRUy
         IZae6jPmdzmimdw/UoHFoHgiiwQ3Biljew8hak4D4JEFegZw6xXvXQQz/lTPLNMAo1kZ
         7VYCN+e3DyxaggenZLwLve9gW6S4T+nRtuwavDJQg9q2LhYdQyyaIpBXOhupIj1yHlmT
         JqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765795110; x=1766399910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkVNILE1twK6/ovsJ6T9ryNNhv5sOBklW/SMHDSmqFQ=;
        b=iNbfhH8kg0c3sjJiCibwOCP5pk45eDHtUOgQGeGJb9YdCd+axmMIRs52I38iz3reLx
         PlyOyM8U4Lf/hAnEjRjI8pA6+c9vB6m7IFmHPyiLpepWovBS4NFUEUOAG7KgllcFm05i
         8o0QtlA1STy7ZSt3YDeDc/529LtaqMkJiBYt2aY9MeHh7O9q9ZVReqVFt37Zhyj7wsmN
         j6nPfBWV8Ocgk/SPUi13Nozv+mDn2us2gSoIxTw6kgE7ogAKu0UX8uXmLgnHk5cvnJiW
         ZoFUX/kz/eQYh1SUwBIV3VlZOmBYl9+ZsdKBCK6ztqt9qo7JmQlV2F8SSkbdBVutXD1j
         FHZw==
X-Forwarded-Encrypted: i=1; AJvYcCUuzwB1tFxCUQODZb89luuIwHHjm/laBLhcD6gidbfdagZht3KX2XV46aob3AODXV56y+A7PCjafEXPe0yzhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TKnn9Ft1LwFe7ieuBdScb7Y9365HxQqKKr04y4wACaoyxLy2
	/Dv+N+pkTJIWPuvIJn9LmprEGyRC5P8BxskeVkffADx1vSOvZ38VeBgB
X-Gm-Gg: AY/fxX4D355WY7uM3YPJ4xtc0kE/09pDzPRmTih72SNVe+MEErjM1xIJ+Yjju/LbS0v
	+/fo1zf0wSYxpwqNzqAAr+aPDKcz/t2ksq/k9MOSc76sR2ZbPVQTOW0Gm9AdcCpicA7pmUDsd5A
	bVa4ixce5CASm7i8M7A4PmCl3+Ec8slnzclBlK7Fk9MpWO10a7bY8K31+w3tMInNZ43gtdPW+67
	IVcS1wHgmlTe1r8BaWI0kbE+xtn3lZ2xZecKjyk4N1xztdv63z9wmHAVCa8MozeiR2HKV2k0nC2
	Nnt5Cu8oXinf+KHZckUbLGg4MaV2/JuyEJuQEdBFEQ8fwESJDebPCEJP5vAbBuXJJBbEMD1h6zD
	tri+5MVKyStZtdkJ8c2mvn+tZGG12GJS2AmJQOh33yN8IyCtrUfHDJyz/U10W+B1tukEJyOvjTu
	EcvPYnnOVRthNMagB7bPJ5
X-Google-Smtp-Source: AGHT+IF9KlvlgaGfO6yM+8uE1EgcX4/5Lr9MP+SD3ltl4f/PPm+KO8gXV2ylgqQge9Zel7YoPSeBqg==
X-Received: by 2002:a17:907:7f27:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b7d23a47753mr1031258566b.19.1765795109498;
        Mon, 15 Dec 2025 02:38:29 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ed80dsm1363738666b.16.2025.12.15.02.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:38:28 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Ting-Ying Li <tingying.li@cypress.com>,
	Chi-hsien Lin <chi-hsien.lin@cypress.com>,
	Ingo Molnar <mingo@kernel.org>,
	Wright Feng <wright.feng@cypress.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Ian Lin <ian.lin@infineon.com>,
	Kalle Valo <kvalo@kernel.org>,
	Alex Shumsky <alexthreed@gmail.com>,
	Marcel Hamer <marcel.hamer@windriver.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] wifi: brcmfmac: rename function that frees vif
Date: Mon, 15 Dec 2025 11:38:17 +0100
Message-ID: <20251215103817.29598-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Since the commit cf124db566e6 ("net: Fix inconsistent teardown and
release of private netdev state.") netdev isn't freed anymore in the
brcmf_cfg80211_free_netdev(). Adjust this function name to match what it
actually does (freeing vif).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index bb96b87b2a6e..61f7e620cab3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -932,7 +932,7 @@ static struct wireless_dev *brcmf_mon_add_vif(struct wiphy *wiphy,
 	ndev->type = ARPHRD_IEEE80211_RADIOTAP;
 	ndev->ieee80211_ptr = &vif->wdev;
 	ndev->needs_free_netdev = true;
-	ndev->priv_destructor = brcmf_cfg80211_free_netdev;
+	ndev->priv_destructor = brcmf_cfg80211_free_vif;
 	SET_NETDEV_DEV(ndev, wiphy_dev(cfg->wiphy));
 
 	ifp = netdev_priv(ndev);
@@ -6082,7 +6082,7 @@ void brcmf_free_vif(struct brcmf_cfg80211_vif *vif)
 	kfree(vif);
 }
 
-void brcmf_cfg80211_free_netdev(struct net_device *ndev)
+void brcmf_cfg80211_free_vif(struct net_device *ndev)
 {
 	struct brcmf_cfg80211_vif *vif;
 	struct brcmf_if *ifp;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 273c80f2d483..350286db5f0a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -489,7 +489,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
 bool brcmf_is_apmode_operating(struct wiphy *wiphy);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
-void brcmf_cfg80211_free_netdev(struct net_device *ndev);
+void brcmf_cfg80211_free_vif(struct net_device *ndev);
 
 int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags);
 int brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 862a0336a0b5..616885d6db3f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -674,7 +674,7 @@ int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
 
 	netif_carrier_off(ndev);
 
-	ndev->priv_destructor = brcmf_cfg80211_free_netdev;
+	ndev->priv_destructor = brcmf_cfg80211_free_vif;
 	brcmf_dbg(INFO, "%s: Broadcom Dongle Host Driver\n", ndev->name);
 	return 0;
 
@@ -692,7 +692,7 @@ void brcmf_net_detach(struct net_device *ndev, bool locked)
 		else
 			unregister_netdev(ndev);
 	} else {
-		brcmf_cfg80211_free_netdev(ndev);
+		brcmf_cfg80211_free_vif(ndev);
 		free_netdev(ndev);
 	}
 }
-- 
2.51.0


