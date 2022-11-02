Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3ED61690F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 17:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiKBQcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiKBQaq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338B2E9F4
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 09:27:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so25340671wrq.6
        for <linux-wireless@vger.kernel.org>; Wed, 02 Nov 2022 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UTt9gjdfFKUb3tYFtUNmq+ZzfuODkAHvZc8oqQBImm4=;
        b=o+tQIpBlcn/BgM7AW9eF59ltiOezooVq07QNj9xKH/ioPML2RgpH8uooY9b9BB0ELE
         YhkQq8RP1x6I2NxvRuv0w4sexbxJ65i8sb982VP+jprW0l9JY4iS3qNSj6LIdZNWjP7O
         7pfnvpQDJd4w4xKkaDMjgVriORLq74LYmePvXysdQTyh8hRMY/LCSlgxgBML6/YfoPui
         nTxWJ0HPzLRLTkt6Lfv0p4A20OmEompL+FVjoTjPWqbHmk7T1EOdB5cqkJZmuoAOWVW+
         8PlWHdOeeuj/OieHt714DNlSt2gB40vP3tPU3XbmeEF6DiVku5IqmDpEk3KpzLOHcycp
         jnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTt9gjdfFKUb3tYFtUNmq+ZzfuODkAHvZc8oqQBImm4=;
        b=LDkHoQrafDV1e3SFiiidmqnCjUinFuSWuQIpA8xudkoGh0E09k+2oP5aLJ++RLQ1kE
         GInPaceJ94FPCFJh5fKs0/kZNc89T9dknn4uDQWRIE+MS3+GLe+hf50/V5cy5urlqhb8
         93zRvEqaOsukTfB9osXj0a2lH/L1oN0E7BRMDXJT95xS+o3aE0VN2R3fltQ40ONqbmVs
         9+aTCh0L8tBtq+DL8I6Q4nPn2FzkixLF7a+xrtZYET9evWh6/8zZGL3OPAkn/W6CORAH
         3oggoghEm43Q0QVScUFHVjy/agthGh8tViyPZZFKF8FXLoEYemGXVkuu9yJTN4NJnG67
         qw5w==
X-Gm-Message-State: ACrzQf0r8KedB8n8hXNYvMFbNYzo3iAqlU80mGDxcp8xyDxtSH0N7ZhH
        w+l/rqrXPC9jrEun6S5DjENRrvCt3RI=
X-Google-Smtp-Source: AMsMyM6Cwak/PZkfRjQvv42XMk0dRiTTjswR//QyVdpy/XSXUiZKdGP2o9arShy/+kQ1pyIi1r4OCA==
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr15331382wrp.180.1667406471870;
        Wed, 02 Nov 2022 09:27:51 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f15ba00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f15:ba00:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id y9-20020adffa49000000b002345cb2723esm13056001wrr.17.2022.11.02.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:27:51 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, thomas.huehn@hs-nordhausen.de,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2] mac80211_hwsim: fix debugfs attribute ps with rc table support
Date:   Wed,  2 Nov 2022 17:27:35 +0100
Message-Id: <20221102162735.718-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes a warning that occurs when rc table support is enabled
(IEEE80211_HW_SUPPORTS_RC_TABLE) in mac80211_hwsim and the PS mode
is changed via the exported debugfs attribute.

When the PS mode is changed, a packet is broadcasted via
hwsim_send_nullfunc by creating and transmitting a plain skb with only
header initialized. The ieee80211 rate array in the control buffer is
zero-initialized. When ratetbl support is enabled, ieee80211_get_tx_rates
is called for the skb with sta parameter set to NULL and thus no
ratetbl can be used. The final rate array then looks like
[-1,0; 0,0; 0,0; 0,0] which causes the warning in ieee80211_get_tx_rate.

The issue is fixed by setting the count of the first rate with idx '0'
to 1 and hence ieee80211_get_tx_rates won't overwrite it with idx '-1'.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/r/202209261514.98322e99-oliver.sang@intel.com

---
v2:
- added kernel test robot fix reference
- fixed a typo
---

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index e0d5bafaa3a7..56e220ff0e76 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -924,6 +924,7 @@ static void hwsim_send_nullfunc(struct mac80211_hwsim_data *data, u8 *mac,
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct sk_buff *skb;
 	struct ieee80211_hdr *hdr;
+	struct ieee80211_tx_info *cb;
 
 	if (!vp->assoc)
 		return;
@@ -945,6 +946,10 @@ static void hwsim_send_nullfunc(struct mac80211_hwsim_data *data, u8 *mac,
 	memcpy(hdr->addr2, mac, ETH_ALEN);
 	memcpy(hdr->addr3, vp->bssid, ETH_ALEN);
 
+	cb = IEEE80211_SKB_CB(skb);
+	cb->control.rates[0].count = 1;
+	cb->control.rates[1].idx = -1;
+
 	rcu_read_lock();
 	mac80211_hwsim_tx_frame(data->hw, skb,
 				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan);
-- 
2.30.2

