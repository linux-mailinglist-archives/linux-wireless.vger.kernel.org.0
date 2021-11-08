Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E623544A24C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 02:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbhKIBRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 20:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242616AbhKIBNz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 20:13:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 073E561ABE;
        Tue,  9 Nov 2021 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636419939;
        bh=X6V4Qew8kHf9yWefeIgnPHxLtvVp9w8pGbYf4pqjqRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eK9PdUvTor7zLOe9FD6lu06tEbjS1ReKoLEgCNI7VxrubMXPK86wsm2OU9Clf7Fsp
         dMqzpORhP/jzUQP/Z/DSDfIEkGnNJ9kOan1ki5hjgDqGMnggloST5k46GNEdlhV70b
         VGhGkrnnt2053rS4EJys2ibC9bzJhvD4dBYdVivuYgvR9sv8cSrDjmg6MwG/NniL+H
         VB423ZfMkyZpxmJBuZq+P+AWMTbbFOUtw1KPn2RG0THlW7IHL/kkx23+f2YGjUXJLl
         u6s/eEhLR8LM7s4SAqwYj/NEUQgiDgltsXMu2xsoq2Ro9qy/oAgfX3eRCSvhhDkQiX
         5nfggtejddMcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/47] mwifiex: Run SET_BSS_MODE when changing from P2P to STATION vif-type
Date:   Mon,  8 Nov 2021 12:49:56 -0500
Message-Id: <20211108175031.1190422-12-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211108175031.1190422-1-sashal@kernel.org>
References: <20211108175031.1190422-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jonas Dreßler <verdre@v0yd.nl>

[ Upstream commit c2e9666cdffd347460a2b17988db4cfaf2a68fb9 ]

We currently handle changing from the P2P to the STATION virtual
interface type slightly different than changing from P2P to ADHOC: When
changing to STATION, we don't send the SET_BSS_MODE command. We do send
that command on all other type-changes though, and it probably makes
sense to send the command since after all we just changed our BSS_MODE.
Looking at prior changes to this part of the code, it seems that this is
simply a leftover from old refactorings.

Since sending the SET_BSS_MODE command is the only difference between
mwifiex_change_vif_to_sta_adhoc() and the current code, we can now use
mwifiex_change_vif_to_sta_adhoc() for both switching to ADHOC and
STATION interface type.

This does not fix any particular bug and just "looked right", so there's
a small chance it might be a regression.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20210914195909.36035-4-verdre@v0yd.nl
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 22 ++++---------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 650191db25cbe..becde7c254de2 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1233,29 +1233,15 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
+		if (mwifiex_cfg80211_deinit_p2p(priv))
+			return -EFAULT;
+
 		switch (type) {
-		case NL80211_IFTYPE_STATION:
-			if (mwifiex_cfg80211_deinit_p2p(priv))
-				return -EFAULT;
-			priv->adapter->curr_iface_comb.p2p_intf--;
-			priv->adapter->curr_iface_comb.sta_intf++;
-			dev->ieee80211_ptr->iftype = type;
-			if (mwifiex_deinit_priv_params(priv))
-				return -1;
-			if (mwifiex_init_new_priv_params(priv, dev, type))
-				return -1;
-			if (mwifiex_sta_init_cmd(priv, false, false))
-				return -1;
-			break;
 		case NL80211_IFTYPE_ADHOC:
-			if (mwifiex_cfg80211_deinit_p2p(priv))
-				return -EFAULT;
+		case NL80211_IFTYPE_STATION:
 			return mwifiex_change_vif_to_sta_adhoc(dev, curr_iftype,
 							       type, params);
-			break;
 		case NL80211_IFTYPE_AP:
-			if (mwifiex_cfg80211_deinit_p2p(priv))
-				return -EFAULT;
 			return mwifiex_change_vif_to_ap(dev, curr_iftype, type,
 							params);
 		case NL80211_IFTYPE_UNSPECIFIED:
-- 
2.33.0

