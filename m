Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C515BE386
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiITKmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiITKll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80283B84E
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so3568120wrb.6
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PnjrDTxzemBJnWsyxDYZVPeBoVqAcyoRlJUUHSXSZJI=;
        b=R345cX6ZIrrmvoxjRKjJaBoBSJGbY1Io4KC+oj9BeJMLIIFEFqY6SVRTlWQHiyTPxA
         /MukZmRcSyBy4h3tc3c9cLess+bFtxvBxnoQnjhvUKZLGIK67jenYXLl5Z1okQv+NZZO
         eXP1oN9lxWDvxQHCY7yLpAO+9fif+CV1CGSeecHcmRDz2O/QMxBYJm/GS1ORe1SCqyO6
         W8qMyFRtWtyESDL9kzUeASf3FIWbIIlvoaPzS8VB3dHviAJ6Nz4nsERlgsAltBBcsxis
         L/xg5oKxBA/QLTjmg+XUopq7GJtUpo0wqiOO9bXB94e4jd5hd58O4VQV92+sBycQzQ2i
         IOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PnjrDTxzemBJnWsyxDYZVPeBoVqAcyoRlJUUHSXSZJI=;
        b=5XVGumUh+50MUA+wDStF9NNaWXdurAppq/TEWp2uonQ1/Wrs9TYLIj1IWOZYay7SwH
         wrNLA8Lw7C/uhX0AWwbg0czpw43moCfzKjMzKXv8q5IN2mhAhq0nGeGPzeMhun20FjUS
         QJTRWMWMYbArxUUc1KQ9ri4Vw9gXT39jfa4ujDXYmRhXgpLy3b3N/v7iuhbk/kEmo9x/
         djbBomJPVrZy061peE5c9nCPVlHy+54qhOjEaVnJaAvJR6VY1d/3aeFfVyRx90UUfbTw
         Ysh6viOToa8YOJN/St5cTugUX5eU1YIkvbuXPIv+RQOtKXP41kIqGSaSbB0RbiUD+eDY
         392A==
X-Gm-Message-State: ACrzQf2SqR5gafyfNcz00tSMgNaSyXq8iStWpHhUit2/MhKmDd+Jv9IG
        5cdBKTFXOhmtN6u370XapFFzmgrEv0eyAA==
X-Google-Smtp-Source: AMsMyM7BDhRplbJWTl03j4zrIIq8IDmhrVZP4urXwz66OwJX5J5xG8yC+vVdrxZWaaEGppqnTG8PZw==
X-Received: by 2002:a5d:588f:0:b0:22b:5cc:e1d3 with SMTP id n15-20020a5d588f000000b0022b05cce1d3mr4376122wrf.142.1663670450958;
        Tue, 20 Sep 2022 03:40:50 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:50 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC v2 1/6] mac80211: modify tx-power level annotation
Date:   Tue, 20 Sep 2022 12:40:27 +0200
Message-Id: <20220920104032.496697-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920104032.496697-1-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
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

This patch modifies the annotation of supported tx-power levels for a
wifi device in ieee80211_hw. This annotation was introduced with commit
44fa75f207d8a106bc75e6230db61e961fdbf8a8 to be able to operate on power
indices instead of absolute power values, providing better support for
different hardware capabilities.

The former annotation uses a 'const s8' for each power level. The choice
made with the former commit was not the best as this kind of annotation
may require much memory if there is a high number of power levels.
Thus, it is now replaced by a new struct ieee80211_hw_txpower_range. This
struct describes a tx-power range by specifying a start index, the number
of levels, a start power value and the power step width.

A wifi driver should specify valid tx-power ranges when it registers a
device in mac80211 by providing a pointer to a list and a length in the
corresponding ieee80211_hw members.
Drivers can define multiple tx-power ranges with each different scales
depending on the hardware.

Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 include/net/mac80211.h | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2bad57933f..a047fb5fc207 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2661,6 +2661,27 @@ enum ieee80211_hw_flags {
 	NUM_IEEE80211_HW_FLAGS
 };
 
+/**
+ * struct ieee80211_hw_txpower_range - Power range for transmit power
+ *
+ * This struct can be used by drivers to define multiple tx-power ranges with
+ * different scales according to the hardware capabilities. A tx-power range
+ * describe either absolute power levels or power offsets relative to a base
+ * power.
+ *
+ * @start_idx The starting idx of the range. @start_idx is always the lowest
+ * 	idx of the power range.
+ * @start_pwr The power level at idx @start_idx in 0.25 dBm units.
+ * @n_levels How many power levels this range has.
+ * @pwr_step The power step width in 0.25 dBm units.
+ */
+struct ieee80211_hw_txpower_range {
+	u8 start_idx;
+	u8 n_levels;
+	s8 start_pwr;
+	s8 pwr_step;
+};
+
 /**
  * struct ieee80211_hw - hardware information and state
  *
@@ -2783,11 +2804,10 @@ enum ieee80211_hw_flags {
  *
  * @max_mtu: the max mtu could be set.
  *
- * @tx_power_levels: a list of power levels supported by the wifi hardware.
- * 	The power levels can be specified either as integer or fractions.
- * 	The power level at idx 0 shall be the maximum positive power level.
+ * @txpower_ranges: a list of tx-power level ranges supported by the wifi
+ *  hardware. The driver can specify multiple ranges with e.g. different scales.
  *
- * @max_txpwr_levels_idx: the maximum valid idx of 'tx_power_levels' list.
+ * @n_txpower_ranges: the number of power ranges defined by the wifi driver.
  */
 struct ieee80211_hw {
 	struct ieee80211_conf conf;
@@ -2824,8 +2844,8 @@ struct ieee80211_hw {
 	u8 tx_sk_pacing_shift;
 	u8 weight_multiplier;
 	u32 max_mtu;
-	const s8 *tx_power_levels;
-	u8 max_txpwr_levels_idx;
+	struct ieee80211_hw_txpower_range *txpower_ranges;
+	u8 n_txpower_ranges;
 };
 
 static inline bool _ieee80211_hw_check(struct ieee80211_hw *hw,
-- 
2.30.2

