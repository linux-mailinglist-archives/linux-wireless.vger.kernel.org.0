Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A606F7602
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjEDUDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 16:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjEDUCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 16:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81FD1434C;
        Thu,  4 May 2023 12:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B58AE63843;
        Thu,  4 May 2023 19:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6C6C433EF;
        Thu,  4 May 2023 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229832;
        bh=aWg0MrSqN3fZHgK2fvKz1vlPi4O0knk9kHdGB6Eg4DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOeYunQSi5WQwr9SUOuiXkpkVLFdn26daFonlVGn72ZV+hMVjxPkSgMUVDbGDsCDl
         erX1LOhTlGcvJelqdRJRxF9dq2Fuy9BljBgrc+r3C5DPfT8cB4pX7hmlbouA6E3CF3
         vbG7btL+EtDOgtYwffvj+KvRBHUvzZojt4dO9m0X3FKBr7dyR7lAnvvCf0kpJrxkpX
         /lkgbl5wc7O/S8UqwL+n53UEEG9vqs0iLtGGWtFtEuTuEFKL/2MNgAQvyKBAwXAIg6
         H0aj5GBdivBnFOXS4J8FvCBrlTJnwgX/4QJlEvIuG7I9K23orO6ThRn108YvuEcVh8
         JmPhelFvGOUKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, gregory.greenman@intel.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, benjamin.berg@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/24] wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace
Date:   Thu,  4 May 2023 15:49:33 -0400
Message-Id: <20230504194937.3808414-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194937.3808414-1-sashal@kernel.org>
References: <20230504194937.3808414-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ef16799640865f937719f0771c93be5dca18adc6 ]

A received TKIP key may be up to 32 bytes because it may contain
MIC rx/tx keys too. These are not used by iwl and copying these
over overflows the iwl_keyinfo.key field.

Add a check to not copy more data to iwl_keyinfo.key then will fit.

This fixes backtraces like this one:

 memcpy: detected field-spanning write (size 32) of single field "sta_cmd.key.key" at drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103 (size 16)
 WARNING: CPU: 1 PID: 946 at drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103 iwlagn_send_sta_key+0x375/0x390 [iwldvm]
 <snip>
 Hardware name: Dell Inc. Latitude E6430/0H3MT5, BIOS A21 05/08/2017
 RIP: 0010:iwlagn_send_sta_key+0x375/0x390 [iwldvm]
 <snip>
 Call Trace:
  <TASK>
  iwl_set_dynamic_key+0x1f0/0x220 [iwldvm]
  iwlagn_mac_set_key+0x1e4/0x280 [iwldvm]
  drv_set_key+0xa4/0x1b0 [mac80211]
  ieee80211_key_enable_hw_accel+0xa8/0x2d0 [mac80211]
  ieee80211_key_replace+0x22d/0x8e0 [mac80211]
 <snip>

Link: https://www.alionet.org/index.php?topic=1469.0
Link: https://lore.kernel.org/linux-wireless/20230218191056.never.374-kees@kernel.org/
Link: https://lore.kernel.org/linux-wireless/68760035-7f75-1b23-e355-bfb758a87d83@redhat.com/
Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index e622948661fa8..b307f0e527779 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -1086,6 +1086,7 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 {
 	__le16 key_flags;
 	struct iwl_addsta_cmd sta_cmd;
+	size_t to_copy;
 	int i;
 
 	spin_lock_bh(&priv->sta_lock);
@@ -1105,7 +1106,9 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 		sta_cmd.key.tkip_rx_tsc_byte2 = tkip_iv32;
 		for (i = 0; i < 5; i++)
 			sta_cmd.key.tkip_rx_ttak[i] = cpu_to_le16(tkip_p1k[i]);
-		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
+		/* keyconf may contain MIC rx/tx keys which iwl does not use */
+		to_copy = min_t(size_t, sizeof(sta_cmd.key.key), keyconf->keylen);
+		memcpy(sta_cmd.key.key, keyconf->key, to_copy);
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
 		key_flags |= STA_KEY_FLG_KEY_SIZE_MSK;
-- 
2.39.2

