Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D39F57334A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiGMJpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiGMJpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C28BFAEB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Lt+L31Kj4RX4J9kHtgURR8BbV/oGA32uM4CwwB73vo0=;
        t=1657705514; x=1658915114; b=jVkRv7vnmn8EXim59fOJ9jLI4YvQc4uO7+h9D9VslwEmQ26
        LtPxtl9X032bLackOgUXIPAcB8JCDTR0yL9a+d+Yqf09khpX2JkEdgUeTA8KjHIgmJlBtKmQqpAcf
        WMEXLvIwUWuXLezWXT4bx/l7hl9TvULmHzzYuPUzW0MLVl+v9kat5Ht1vBWyjzPWvVYD8WmdLva1x
        N6xsPzK62GyhsZP/VJevxHRqmtCm+deNJwab0Egwe+7oBAkdrwSkJ/BbsDbEiaaTJoigt/ZVXfphE
        LCVL4utWJFXbWUWNpucENuz/QO+6NnmfXMwwFW8h7jZGYOqcjGnt1CuvcQJn6Rfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvg-00EgvB-58;
        Wed, 13 Jul 2022 11:45:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 26/76] wifi: mac80211: provide link ID in link_conf
Date:   Wed, 13 Jul 2022 11:44:12 +0200
Message-Id: <20220713114425.c73100af607d.I3dafc8b7f419554606def70dfcf8f1c047a9758c@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Johannes Berg <johannes.berg@intel.com>

It might be useful to drivers to be able to pass only the
link_conf pointer, rather than both the pointer and the
link_id; add the link_id to the link_conf to facility that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/iface.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6c77e12f94a..f917f7d7614e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -516,6 +516,7 @@ struct ieee80211_fils_discovery {
  * to that BSS) that can change during the lifetime of the BSS.
  *
  * @addr: (link) address used locally
+ * @link_id: link ID, or 0 for non-MLO
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
  * @uora_exists: is the UORA element advertised by AP
  * @ack_enabled: indicates support to receive a multi-TID that solicits either
@@ -639,6 +640,7 @@ struct ieee80211_fils_discovery {
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
+	unsigned int link_id;
 	u8 addr[ETH_ALEN] __aligned(2);
 	u8 htc_trig_based_pkt_ext;
 	bool uora_exists;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3e1d46119f7a..28fe0735b9a8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -390,6 +390,7 @@ static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link->sdata = sdata;
 	link->link_id = link_id;
 	link->conf = link_conf;
+	link_conf->link_id = link_id;
 
 	INIT_WORK(&link->csa_finalize_work,
 		  ieee80211_csa_finalize_work);
-- 
2.36.1

