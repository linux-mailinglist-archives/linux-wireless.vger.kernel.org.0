Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B804B5636
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356395AbiBNQa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356387AbiBNQaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100E560D87
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0XNi9kxPkoeOU7UZeaekgRV7N2iN5Il+pQG25O9KCg0=;
        t=1644856214; x=1646065814; b=ro6fk8u7eeqpcE58P2oJ1vlBkaj8W7nUrl60e1bGn8gnorI
        aCZm4u6TKAlrO4T4O0Q40HMs14ZBSlenfrrKjzkTqzQfQKSKn8VnVQsXMkvA+e1sN70NkKD+Eld6n
        bHw50Tts5r7/lf/Kb2Fwz4uSlfTdiltv0hBJL2P/GCQgGGBR+eN4sFGwzJd8J7B5IN2751jXkqy5Z
        WiZfDHuf5j7E4b0Alf7QS3uILQFzLrPCa9udSbiER/Wr8LN+jlJvLNrZBz6XIVtM+pMJBGSRILka8
        L/aSgRkEaja+dWOG6JL0fQ4DV1Z7qgDavRRIYQy1GwsnMUj1GocA+Y/ji26B5bDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEu-0011mw-FQ;
        Mon, 14 Feb 2022 17:30:12 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 16/19] mac80211: Add support for storing station EHT capabilities
Date:   Mon, 14 Feb 2022 17:30:03 +0100
Message-Id: <20220214173004.47213ffb23a8.I15c6c8430e1a0184b1322e40f1727ed4f17b04e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When a station configuration is updated, also update the station
EHT capabilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a208089caf..aa45627a4208 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1716,6 +1716,14 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 						  (void *)params->he_6ghz_capa,
 						  sta);
 
+	if (params->eht_capa)
+		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
+						    (u8 *)params->he_capa,
+						    params->he_capa_len,
+						    params->eht_capa,
+						    params->eht_capa_len,
+						    sta);
+
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
-- 
2.34.1

