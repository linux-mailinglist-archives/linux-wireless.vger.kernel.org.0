Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B25F54D6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJENBA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJENAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA21EC7D
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5ymB6A7xS39OjQuLW+i5MLPM3B4tbpT6XSWK7t1XfHs=;
        t=1664974853; x=1666184453; b=SJCWWhqBtmY5m5UNvRUDj4ns+pxbLMpCw6mOVvBqTPC6LOU
        4PfTUXn3RX/QWLbZBK4xQgW+gwMGfKCOxniMqWFqGeytnSIVpxJdMbtC+h0H+Dt+1qWmqIMhcmb9j
        cKNl5v9NSH+W14WzInG/cHlBvX6qXoSg5wR/3JbRCH8d36NlVefVu9SqxybNcxN9sYMFyAhq8fvHp
        jMsorHi87EGZ5weY7v85PHYPAHea5dkyAIXylK9RLFSzg9n09pbGYFnfMAN76h+ZYGYO8sC0a+NAD
        y3qRpTuhi0iId5XptnAzAO63lvgunNbbTuY0brxUGLzvxZW0q7AYwAQixV1Cnkjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og415-00G2RL-0v;
        Wed, 05 Oct 2022 15:00:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 03/28] wifi: mac80211: include link address in debugfs
Date:   Wed,  5 Oct 2022 15:00:23 +0200
Message-Id: <20221005145226.9d247ff3246a.I9685f6eee07aabb880e0b7c50122e1a59031b212@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Add the link address to the per-link information, but only if we are
using MLO.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_sta.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 68c07d4b95a5..0d8ff0303028 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -443,6 +443,19 @@ static const struct file_operations link_sta_ ##name## _ops = {		\
 	.llseek = generic_file_llseek,					\
 }
 
+static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
+				  size_t count, loff_t *ppos)
+{
+	struct link_sta_info *link_sta = file->private_data;
+	u8 mac[3 * ETH_ALEN + 1];
+
+	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
+
+	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+}
+
+LINK_STA_OPS(addr);
+
 static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
 				     size_t count, loff_t *ppos)
 {
@@ -1104,6 +1117,8 @@ void ieee80211_link_sta_debugfs_add(struct link_sta_info *link_sta)
 		link_sta->debugfs_dir =
 			debugfs_create_dir(link_dir_name,
 					   link_sta->sta->debugfs_dir);
+
+		DEBUGFS_ADD(addr);
 	} else {
 		if (WARN_ON(link_sta != &link_sta->sta->deflink))
 			return;
-- 
2.37.3

