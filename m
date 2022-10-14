Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED85FF0B1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJNOzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJNOzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 10:55:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403A2A95F
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 07:55:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a10so7917634wrm.12
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUI7uA+1A0/jzafPzR2AQ0HyfJwoRaEAXXXFFTsZD6A=;
        b=qBuGV247lPD/HWLEWch3vRsT1ze/2gKlnyBJihUqJr2+0x3Y4OQZf+8u+LqUWKwcJA
         d532bVxK6RSKRsi6xtSO+35NLY8nKKveAK+vy+HmeWYmXOoWYXxZfDkgL/cGTXExPkLE
         j3CBmARlXKzW00kc2ZCJennOg3zAC05K98ujFzfkFHsc34N8c7oJdVJZKzE16akWtuwd
         rclFganJSW8WLze4Z0hp2pZAAAYJ7Kvg7lOjhlGd/n6/ODhmMycQgSKZZkC8W5eWNy1T
         MsesDkrgjG5gtgWdz5E4zfsSECmDAkT1Vd5AkziyC6Raas5X3f6RtwF4jpOVCt7JKOeY
         121g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUI7uA+1A0/jzafPzR2AQ0HyfJwoRaEAXXXFFTsZD6A=;
        b=GUlEa+KL1I6Yi+t9tW32dyY4r8te8HH0ZVpQX4OijMxMf09nhY7+Ku/o2AEr1kTE3Y
         ukAWL5aOrwRtIR5TKRrdyffcSJiTueUfNuj7cMMscc9c4jVj8H2nv4UKs+tZ1qO+Jo/5
         10pBh5gOpbyN8jrwJqN2TtjR8NcmPnqgV+E1A+r4REOxWzOxTfktcJKdRigHk9wwCmww
         rA1AfG88R0MXkoWOawlOnVB1NfjcoPT1cHf4Lzc8mgipShR1UNlMEAe9lFFYe+5OyNRo
         Bf0QMLf8Kdsy88xxVwQygIVFcr542sVLoSdKai0VvrfcrOqXs/HTpZJ3u5WByeN+e31E
         XKGw==
X-Gm-Message-State: ACrzQf1eHmbiCtJe0naDFK2owJyBMWRjAb1IH+2JLTggfT08iN8GfS+f
        GVozwQF96+qQySZqMQMyXcD5FI/oubU=
X-Google-Smtp-Source: AMsMyM76RJSpHRk1UpXntNRz7AApZE98ezsLUV7qrxwRAswHK39+mLptMX8458uDP+orJPLsLpo9yw==
X-Received: by 2002:a05:6000:1ac7:b0:232:b68c:9e0 with SMTP id i7-20020a0560001ac700b00232b68c09e0mr3838364wry.54.1665759295619;
        Fri, 14 Oct 2022 07:54:55 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f12af00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f12:af00:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id n10-20020a05600c3b8a00b003c6b7f55673sm7839666wms.2.2022.10.14.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:54:55 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, thomas.huehn@hs-nordhausen.de,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH] mac80211_hwsim: fix debugfs attribute ps with rc table support
Date:   Fri, 14 Oct 2022 16:54:39 +0200
Message-Id: <20221014145439.483419-1-jelonek.jonas@gmail.com>
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

