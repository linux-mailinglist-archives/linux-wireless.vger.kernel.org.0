Return-Path: <linux-wireless+bounces-13484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272A98FBB0
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 02:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA94D1F23664
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C811D5ADB;
	Fri,  4 Oct 2024 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EBVjXTmP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07F11C92;
	Fri,  4 Oct 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002578; cv=none; b=kwId8oK8lQoB700aRu/2MEtslLHhX2TnBhw6RF609naypWB7Wu6J6VvtqLvZuJ/7izp7Sb5Pf+MBxaqJzS3i+/YkW73fNDktUNCZw5MnLfV07QEA0PGITyn2tt/HU5MbIHIebrRAagE2l0kkd68ER1PLpn9BQKjmSH/Laj3SRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002578; c=relaxed/simple;
	bh=Tceov/Sz6VOnsY6sK8wHBtiRUJ6SjmEZeQzP7PUKEEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMTr0EGThKIKMeSilxC5Cyf03MfoiwGwMEA3TNBC9sAnlfreEG/E878kf/CnSeMwxXhg+e35ku2+8aoD1jCGW6bxe3kWJwGeg1YnA9s9Z6gSFcT33WZMJ46U6A+7zEYkwgn3VlSS6M3HuNTCFBuVGdiU+5GnOMNiBXllueOerO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EBVjXTmP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=rKdeWm3Oud5zUksSBOao5xNzkkZe3e90MkZhVY5qJIw=; b=EBVjXTmPxXM3ieJO
	hjHgoqysx8poIfxKpln4DL5opyeHbyZHZ53zaxYljfZG/iHfE8a0h+61R1t5Ug7NGbc74z7hjGd+z
	3GhlQaPpw9KUH5nCDrg7FKgSn0sXuhfH8QTcmjFIwnbG0PvPe53L8IP2RC2LEk5l08AhChZeRYCjO
	q0txNg5Wea3gJAXL8O1D1q4+7xY4jJzCn7JCZ83QSnL+L3APStKkNZVWrU0ZSdxAlk+aOJqsyHNxn
	vkNjEEOzekjWHYMcSW3590YovKcVDlz9VKA69f7dYDWzVF0cg1RFgxZasP3+wDwZfpQky3IOCeZQI
	UbfTZtfyBvh6H4yS9A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1swWPF-008lv9-2h;
	Fri, 04 Oct 2024 00:42:53 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] brcmfmac: Remove unused brcmf_cfg80211_get_iftype
Date: Fri,  4 Oct 2024 01:42:52 +0100
Message-ID: <20241004004252.470836-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

brcmf_cfg80211_get_iftype() has been unused since 2013's commit
5cd51c2bad56 ("brcmfmac: Find correct MAC descriptor in case of TDLS.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 -------
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h    | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 349aa3439502..297a7c738c01 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7820,13 +7820,6 @@ s32 brcmf_cfg80211_down(struct net_device *ndev)
 	return err;
 }
 
-enum nl80211_iftype brcmf_cfg80211_get_iftype(struct brcmf_if *ifp)
-{
-	struct wireless_dev *wdev = &ifp->vif->wdev;
-
-	return wdev->iftype;
-}
-
 bool brcmf_get_vif_state_any(struct brcmf_cfg80211_info *cfg,
 			     unsigned long state)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index dc3a6a537507..2abae8894614 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -443,7 +443,6 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg);
 s32 brcmf_cfg80211_up(struct net_device *ndev);
 s32 brcmf_cfg80211_down(struct net_device *ndev);
 struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings);
-enum nl80211_iftype brcmf_cfg80211_get_iftype(struct brcmf_if *ifp);
 
 struct brcmf_cfg80211_vif *brcmf_alloc_vif(struct brcmf_cfg80211_info *cfg,
 					   enum nl80211_iftype type);
-- 
2.46.2


