Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8223A13A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgHCIpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 04:45:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0EC06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 01:45:45 -0700 (PDT)
Received: from [134.101.163.132] (helo=bertha9.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k2W6I-00022u-DK; Mon, 03 Aug 2020 10:45:42 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH] mac8211: fix struct initialisation
Date:   Mon,  3 Aug 2020 10:45:40 +0200
Message-Id: <20200803084540.179908-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse showed up with the following error.
net/mac80211/agg-rx.c:480:43: warning: Using plain integer as NULL pointer

Fixes: 2ab45876756f (mac80211: add support for the ADDBA extension element)
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 7f245e9f114c..313ba97acae3 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -477,7 +477,7 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     size_t len)
 {
 	u16 capab, tid, timeout, ba_policy, buf_size, start_seq_num;
-	struct ieee802_11_elems elems = { 0 };
+	struct ieee802_11_elems elems = { };
 	u8 dialog_token;
 	int ies_len;
 
-- 
2.25.1

