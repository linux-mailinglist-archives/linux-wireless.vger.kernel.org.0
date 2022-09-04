Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A875AC625
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiIDT3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiIDT32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D58E5E
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dbRmkAzkUxubCRqZSj12TlW1QQJBHreXUsd+ZDfikec=;
        t=1662319762; x=1663529362; b=q7B31tv/A+ZX4gUGEhRvFVINyXj7CTwOKMk1jYLGp75iXn5
        lYsD10un4dzMfVYEDfZW6eOwripAOqsxWyzbUvQFvJjBBOckdtYA0Bb/c/RsYBNDsGwjRxTDeWJTa
        B+QkRI8X47g2BglA0xH2Yu5+UtLaFVmSj/QBD21zzG1HZsz6k1asT3ytoH5luS5iLIF7Tko+QyCON
        69lmkX0NGkzBuLrsDhJUdMtF5glY39AagKqVIIQrGCM5EYtk6bWMQDJWeko6Qr8FlYSe9y9gHqkAm
        WixCXv/AoumhY1EhwIqFi2gNn4fPAq2DhAdNJpFVdTcNeyBBR0HzOdfOfss+NIbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ1-007pTZ-08;
        Sun, 04 Sep 2022 21:29:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/12] wifi: mwifiex: fix array of flexible structures warnings
Date:   Sun,  4 Sep 2022 21:29:07 +0200
Message-Id: <20220904212910.2c885310ebee.If7177ea588b56c405eee6e6df595e9efccdfb99a@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
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

There are two, just change them to have a "u8 data[]" type
member, and add casts where needed. No binary changes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/mwifiex/fw.h      | 4 ++--
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 26a48d8f49be..b4f945a549f7 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -2104,7 +2104,7 @@ struct mwifiex_fw_mef_entry {
 struct host_cmd_ds_mef_cfg {
 	__le32 criteria;
 	__le16 num_entries;
-	struct mwifiex_fw_mef_entry mef_entry[];
+	u8 mef_entry_data[];
 } __packed;
 
 #define CONNECTION_TYPE_INFRA   0
@@ -2254,7 +2254,7 @@ struct coalesce_receive_filt_rule {
 struct host_cmd_ds_coalesce_cfg {
 	__le16 action;
 	__le16 num_of_rules;
-	struct coalesce_receive_filt_rule rule[];
+	u8 rule_data[];
 } __packed;
 
 struct host_cmd_ds_multi_chan_policy {
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 512b5bb9cf6f..e2800a831c8e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1435,7 +1435,7 @@ mwifiex_cmd_mef_cfg(struct mwifiex_private *priv,
 		mef_entry = (struct mwifiex_fw_mef_entry *)pos;
 		mef_entry->mode = mef->mef_entry[i].mode;
 		mef_entry->action = mef->mef_entry[i].action;
-		pos += sizeof(*mef_cfg->mef_entry);
+		pos += sizeof(*mef_entry);
 
 		if (mwifiex_cmd_append_rpn_expression(priv,
 						      &mef->mef_entry[i], &pos))
@@ -1631,7 +1631,7 @@ mwifiex_cmd_coalesce_cfg(struct mwifiex_private *priv,
 
 	coalesce_cfg->action = cpu_to_le16(cmd_action);
 	coalesce_cfg->num_of_rules = cpu_to_le16(cfg->num_of_rules);
-	rule = coalesce_cfg->rule;
+	rule = (void *)coalesce_cfg->rule_data;
 
 	for (cnt = 0; cnt < cfg->num_of_rules; cnt++) {
 		rule->header.type = cpu_to_le16(TLV_TYPE_COALESCE_RULE);
-- 
2.37.2

