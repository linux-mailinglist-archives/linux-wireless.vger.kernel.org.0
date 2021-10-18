Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F63432A7C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhJRXwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233236AbhJRXwl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 243956127B;
        Mon, 18 Oct 2021 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601029;
        bh=xKtnU/YSjFfwcbqPxqi4YidSRh0HkLrNGsdlECBJNps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4SQpqYU+Daj2gBpnLkQjuo6RiTkP7gSm3QyGzlS94RVBmj8T6pdIYlqvFkafuD9g
         4ATTxElxU3mJM5/St2dm0LQySMueaJh+j7gNgL4wOg/6m1ymR7syoF76xhuuBVs+PC
         36dek9ld9862j0puOMtcFy6hoezleUjv20BnT6lGhAg5L48kHB3riftYks8+xELTRH
         GqTbYNCLGXIS0EuXXpxZZdSs+uw/ivM/5YHgd7SS8JI+r+rfljqf6n2PHQHHgs9rCH
         Rd313vvr8QZT+3kOe8PCrPDTP+F/xUHiqPLBxALQvshFcizsSf1N8IZZm1PwamC5Nf
         K9s6QlPEoF+Iw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        johannes.berg@intel.com, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH 07/15] wireless: brcmfmac: prepare for const netdev->dev_addr
Date:   Mon, 18 Oct 2021 16:50:13 -0700
Message-Id: <20211018235021.1279697-8-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018235021.1279697-1-kuba@kernel.org>
References: <20211018235021.1279697-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

netdev->dev_addr will become const soon. Make sure local
variables maintain that qualifier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: aspriel@gmail.com
CC: franky.lin@broadcom.com
CC: hante.meuleman@broadcom.com
CC: chi-hsien.lin@infineon.com
CC: wright.feng@infineon.com
CC: chung-hsien.hsu@infineon.com
CC: kvalo@codeaurora.org
CC: johannes.berg@intel.com
CC: linux-wireless@vger.kernel.org
CC: brcm80211-dev-list.pdl@broadcom.com
CC: SHA-cyfmac-dev-list@infineon.com
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 9ac0d8c73d5a..4735063e4c03 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2125,7 +2125,7 @@ static int brcmf_p2p_disable_p2p_if(struct brcmf_cfg80211_vif *vif)
 	struct brcmf_cfg80211_info *cfg = wdev_to_cfg(&vif->wdev);
 	struct net_device *pri_ndev = cfg_to_ndev(cfg);
 	struct brcmf_if *ifp = netdev_priv(pri_ndev);
-	u8 *addr = vif->wdev.netdev->dev_addr;
+	const u8 *addr = vif->wdev.netdev->dev_addr;
 
 	return brcmf_fil_iovar_data_set(ifp, "p2p_ifdis", addr, ETH_ALEN);
 }
@@ -2135,7 +2135,7 @@ static int brcmf_p2p_release_p2p_if(struct brcmf_cfg80211_vif *vif)
 	struct brcmf_cfg80211_info *cfg = wdev_to_cfg(&vif->wdev);
 	struct net_device *pri_ndev = cfg_to_ndev(cfg);
 	struct brcmf_if *ifp = netdev_priv(pri_ndev);
-	u8 *addr = vif->wdev.netdev->dev_addr;
+	const u8 *addr = vif->wdev.netdev->dev_addr;
 
 	return brcmf_fil_iovar_data_set(ifp, "p2p_ifdel", addr, ETH_ALEN);
 }
-- 
2.31.1

