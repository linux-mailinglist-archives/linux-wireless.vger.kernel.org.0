Return-Path: <linux-wireless+bounces-8410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4288D7E40
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B0F280E20
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6F7E77B;
	Mon,  3 Jun 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BvW8w++s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7576F17
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406151; cv=none; b=QO58rHc9rYO9hvy2VXDwHdu+2uMqhWOspZOChU2/pji0h3hxHqrK1EQP0zaBcaTaYu4TyQsWY1Na1CL8AfLUcOwI/Ev2Em65/ErnyXOzFj+RYJT4Wwhx6t6Hvp9vm6kUUoB07Tb7XF+NGafTWWHY0YDmUEUEYNQFBg1fKwmiy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406151; c=relaxed/simple;
	bh=RHq9CxtOVmMB6cXfYKhVGEaZuC37DAckfGOXb1IADxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+5/CpZkvXS5l0fs17Wkkv1XsalZY7az/zaPOJWOIHlAknZrydJBASYp3aWpjs8lgXG7KMohQXG/9DRUo93b2292xRoh5opf5DOncYOovTDsccTqJPc5iMz5k54olNP3jwUfaoq5O+mwNXJLfcYuY0v5zAtM73CqOh78RSZboqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BvW8w++s; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=svASrHdCfX+q8u+/r9OQxM2ON1s7lrnJCs82vuq+Nu4=; b=BvW8w+
	+sq17SSRw1A5hu3WKiAisuguJ/pteC4BYJt8khpG/uXA2vrX6Ao9CWdMt7/SEzLV
	sVLDYqGWhfKHH8fJGB6Tb50im3D3shTRrAclQ0SOtl/cgRt1ze4oQvVfSURKijKH
	jV5hmqNIXjQaVsrF3RKSkDqh7IWWMBpJ8HlmVqD2c9Mnfu1WCATNLnPelGDa0S0q
	bNx4KJZ57YaDYdfHPjrWR3Ucg/W3HHo+mMg2KkEAb0AYh4ZO1KHpOg4Zs1HiVhdl
	d6fz4hCkgI66lq6XT3rS9beMT/4W68VjwnNAOBl8u9J/7t6Cmae67jRDJqkFoUth
	/skn3/OXJcumo+Kw==
Received: (qmail 1899305 invoked from network); 3 Jun 2024 11:15:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:46 +0200
X-UD-Smtp-Session: l3s3148p1@o5xMx/gZBIYgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 2/6] wifi: brcmfmac: use 'time_left' variable with wait_event_timeout()
Date: Mon,  3 Jun 2024 11:15:35 +0200
Message-ID: <20240603091541.8367-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_event_timeout() causing patterns like:

	timeout = wait_event_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5fe0e671ecb3..1585a5653ee4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4071,7 +4071,7 @@ static void brcmf_report_wowl_wakeind(struct wiphy *wiphy, struct brcmf_if *ifp)
 	struct cfg80211_wowlan_wakeup *wakeup;
 	u32 wakeind;
 	s32 err;
-	int timeout;
+	long time_left;
 
 	err = brcmf_fil_iovar_data_get(ifp, "wowl_wakeind", &wake_ind_le,
 				       sizeof(wake_ind_le));
@@ -4113,10 +4113,10 @@ static void brcmf_report_wowl_wakeind(struct wiphy *wiphy, struct brcmf_if *ifp)
 		}
 		if (wakeind & BRCMF_WOWL_PFN_FOUND) {
 			brcmf_dbg(INFO, "WOWL Wake indicator: BRCMF_WOWL_PFN_FOUND\n");
-			timeout = wait_event_timeout(cfg->wowl.nd_data_wait,
-				cfg->wowl.nd_data_completed,
-				BRCMF_ND_INFO_TIMEOUT);
-			if (!timeout)
+			time_left = wait_event_timeout(cfg->wowl.nd_data_wait,
+						       cfg->wowl.nd_data_completed,
+						       BRCMF_ND_INFO_TIMEOUT);
+			if (!time_left)
 				bphy_err(drvr, "No result for wowl net detect\n");
 			else
 				wakeup_data.net_detect = cfg->wowl.nd_info;
-- 
2.43.0


