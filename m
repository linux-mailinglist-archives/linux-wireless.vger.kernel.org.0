Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBDD7C6B3B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 12:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjJLKe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 06:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjJLKe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 06:34:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE590
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=+Gz8kpGa5nFN5XRNfrT5kQd3hFMtFYbZhJ1sHJ9X4oQ=; t=1697106894; x=1698316494; 
        b=CtRuz+q8lxEzXXgxdtYxeusaJAG3OJosnstSpe+ex72x7LGePOTw7ef3QVNpJwA1XOJnPkQ0v/Q
        m20YpcNREtpoFmvTF34Zsru1vqAVGDHItggSPNHWwe+YzQNIYvlNY0AXe1CxkIlDTecZjSX/tS9qy
        duuNEqrQv8ENz/SMPLnKMY3EUFmlbt8rxtbblAzNV9GMf4dVYxyr+sS404dWNEvJ6l1fvuuziBIVS
        BbdIhQ43+tEig0FMPm9ntaCi7E8uZGdJbkY5hrGceVa2BtALMfHcf3SFaCooJYM069rF5i3jJiiql
        6pvVoZmM9zt/K3D7v7vFUe0mQt9HDWjn/CmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqt1m-00000003FUw-2EH2;
        Thu, 12 Oct 2023 12:34:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+25b3a0b24216651bc2af@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: fix change_address deadlock during unregister
Date:   Thu, 12 Oct 2023 12:34:47 +0200
Message-ID: <20231012123447.9f9d7fd1f237.Ic3a5ef4391b670941a69cec5592aefc79d9c2890@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When using e.g. bonding, and doing a sequence such as

 # iw wlan0 set type __ap
 # ip link add name bond1 type bond
 # ip link set wlan0 master bond1
 # iw wlan0 interface del

we deadlock, since the wlan0 interface removal will cause
bonding to reset the MAC address of wlan0.

The locking would be somewhat difficult to fix, but since
this only happens during removal, we can simply ignore the
MAC address change at this time.

Reported-by: syzbot+25b3a0b24216651bc2af@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 510f8aead4f9..8061119039a3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -298,6 +298,14 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	struct ieee80211_local *local = sdata->local;
 	int ret;
 
+	/*
+	 * This happens during unregistration if there's a bond device
+	 * active (maybe other cases?) and we must get removed from it.
+	 * But we really don't care anymore if it's not registered now.
+	 */
+	if (!dev->ieee80211_ptr->registered)
+		return 0;
+
 	wiphy_lock(local->hw.wiphy);
 	ret = _ieee80211_change_mac(sdata, addr);
 	wiphy_unlock(local->hw.wiphy);
-- 
2.41.0

