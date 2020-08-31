Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E742258319
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgHaU4k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:40 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52356 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728508AbgHaU4h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5BFE64F8AD5;
        Mon, 31 Aug 2020 20:56:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q0pzLiqg7Tef; Mon, 31 Aug 2020 20:56:33 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id EEC784F8E7F;
        Mon, 31 Aug 2020 20:56:11 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 15/22] mac80211: don't calculate duration for S1G
Date:   Mon, 31 Aug 2020 13:55:53 -0700
Message-Id: <20200831205600.21058-16-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For now just skip the duration calculation for frames
transmitted on the S1G band and avoid a warning.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d2136007e2eb..bef19616c5f0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -82,6 +82,10 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 
 	erp = txrate->flags & IEEE80211_RATE_ERP_G;
 
+	/* TODO */
+	if (sband->band == NL80211_BAND_S1GHZ)
+		return 0;
+
 	/*
 	 * data and mgmt (except PS Poll):
 	 * - during CFP: 32768
-- 
2.20.1

