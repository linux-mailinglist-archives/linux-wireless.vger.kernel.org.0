Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7639A26C66C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgIPRs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIPRsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:35 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A409AC0086BA
        for <linux-wireless@vger.kernel.org>; Wed, 16 Sep 2020 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DGVMZM9Xz1KDLSN38I6p7qDeFLqeK7wWrZlMdW99DO0=; b=V1BJ7uafYcya5kTjJnSF7ZxM6w
        f80KKmlEN0uZ187e/407OhLmRQogIUYh9J2qrjxGqhNu8Qm9LbXrKE2/c+r1nHGFe36MVxj7uYfkj
        gOFPl2DJETCdc2go3DC4lq7eTP48MOz/Wm58De1BSUWnepMB8ODAi7hqs3jxoXwMJCCQ=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kIaZQ-0004If-Is; Wed, 16 Sep 2020 18:46:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: allow bigger A-MSDU sizes in VHT, even if HT is limited
Date:   Wed, 16 Sep 2020 18:46:11 +0200
Message-Id: <20200916164611.8022-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some APs (e.g. Asus RT-AC88U) have been observed to report an HT MSDU size
limit of 3839 and a VHT limit of 7991. These APs can handle bigger frames
than 3839 bytes just fine, so we should remove the VHT limit based on the
HT capabilities. This improves tx throughput.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/vht.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 9c6045f9c24d..7e601d067d53 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -315,10 +315,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 
 	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
 
-	/* If HT IE reported 3839 bytes only, stay with that size. */
-	if (sta->sta.max_amsdu_len == IEEE80211_MAX_MPDU_LEN_HT_3839)
-		return;
-
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
 		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
-- 
2.28.0

