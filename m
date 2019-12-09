Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A51E116B01
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLIK2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:28:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLIK2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:28:53 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MMoT4-1iLdTB0m6G-00Ii7g; Mon, 09 Dec 2019 11:28:49 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: [RFC PATCH v1 3/4] mwifiex: Do not allow deleting station in IBSS mode.
Date:   Mon,  9 Dec 2019 11:28:08 +0100
Message-Id: <20191209102808.12014-4-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <m34l02mh71.fsf@t19.piap.pl>
References: <m34l02mh71.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WtLVDy6lCBGKrcXQRP5BsZitH8ttNG6uNOaehXYGA394tggpcHi
 U+2R57f4fT1/Sq86ECjvsSXnkXuMIfb9WmV1yKxgDhpour1KX0IBPNbu9cN5zeyFhn7bmiM
 1X6g4Rc6lGvJI230pzQhpY57B53KkGNXfrN4MuPGRIWNIsNDezqK7hCCF5rg4X+ZICfKObz
 1x4rrR6OSvMHGYHWkIVkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:30NEgQLZr9Q=:kr5PCpUtHZip8R9LEZQhDv
 x44JIa9OxOIPYzlipXl4bAytvsRgB/gC18NzxUpeV6ArufuDUMI/DYdpvE37yLuaF5l4HhW5X
 NoYZYE1vUg9sL/uKTUUsIeulqMnL4hXX3pJyJXd0TfndKTweOrmhhvvfRPlVz0gDzQ7AQUq5B
 aRtnlptnKCKZ8AjaV+778zxDrvI0FwFaJnx21f/5rbutdK0+N/qfc01JhtMgWx+RTFSwnaQGc
 ydFORU2PXXLqUz01OUbWV82j1a2BPnWB3nLb9l+BaXe/gmRNW4SqJj76nFOcC5SdfWYvScdaM
 tnDa33+/OwnQnVVDC093g4DyVISU9LR+SRqSDi65UxdcXMF1/VUfKccd8M/1ODpgxEHxLrIDX
 9hZLbAS++CVvmRl7CtHiTLujtFmMLIHNMvanrAF8HzzeEdn1ib3RJruMnOVTJL0V9SV3Lr3Wh
 E2DgRm8X5BlW7cTfBzffh0BUXNjifamBTZifCAtXQjKJED2vv9QQKNYX+E04WuRx9iGMfKDAf
 +7FLmAfMyHvY3dRnJfr01zlF1fBOcKhZGP7MEnUwGxbfFXRjm3HO/+cVrboNnuvB1is80ylmT
 7c8HQF6ydfMa6fdM6TefFW09KdmNSlYKemeu5Xmf6pi/QdMcJGyqt7HrsbU5OcX9MVc3ccsm5
 GL9Y+Q6t/uAnhq/0aTKLUihYa9h+oLHU0xuMzA3BDF1YdNQ9cWZ91+MoNscLbkjz1PV/VmYNv
 PgMtnE9e9BXl3VTU/W2XHqLA2saPHRDOE0IHi0GqykOk0ZWzCSVsg0gaSwbWYEW7bYSBdoYLH
 CFJ98X0GXwxcQaPHHFTj1bk/TT3SM9F0ENrxkgU+Ch5pxYrMIJu2wxCIlgM5iCCDC3KDH0D20
 w85aOZS5HJfqpQS8+pdG8pjhKUjyjF7YMxZBtADukQetTx//jPXxDSGZLT50/6
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation of allowing userspace to explicitly reset station state
in IBSS mode, reject attempts to delete stations in IBSS mode with error
ENOTSUPP.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
--
I do not know if the driver could possibly support this, so take the
safe route and reject it.
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d89684168500..9135fc6d5a70 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1828,6 +1828,10 @@ mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 	struct mwifiex_sta_node *sta_node;
 	u8 deauth_mac[ETH_ALEN];
 
+	if (priv->bss_mode != NL80211_IFTYPE_AP &&
+	    priv->bss_mode != NL80211_IFTYPE_P2P_GO)
+		return -ENOTSUPP;
+
 	if (!priv->bss_started && priv->wdev.cac_started) {
 		mwifiex_dbg(priv->adapter, INFO, "%s: abort CAC!\n", __func__);
 		mwifiex_abort_cac(priv);
-- 
2.24.0

