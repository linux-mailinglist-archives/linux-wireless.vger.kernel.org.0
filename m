Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF725A4F7D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiH2OmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiH2OmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:42:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546E90815
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e13so9558128wrm.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6NWu/Ly1g+WIRpG9O2aLNsUaVepWWRiAR79qGrRwoK4=;
        b=Ejkd48vds+obWrnOewXqR7ewC9ijc2S5+IoWfqr6ras/wDshuJnKjIAhSUaJ3Q0oCh
         R9VXcp3f3vcWhL8jLK1UvLig83zns5AAs5OkSjih33d5MqYUxNmWLwIhWoIph+4NKiY2
         KhfNPkXT52WnQ2bCONXzzIDZZ5GBWnq+j34IUOwQV04oCIkP/liHgm1qrCTiFMMu7a+z
         PxbqJkPgB9mt/sAEEMGwE59ah4PYfKgb4i6ESLOHIvbDEOTtXvDY8Z+HxjEwP3DalNg8
         XhNOwWKEJjaWfwzrcqpw/pjO7jotmFRJP6Ol/67SYtHxNAg1A6/FmB+ZX1+yCDrOVKDE
         ErPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6NWu/Ly1g+WIRpG9O2aLNsUaVepWWRiAR79qGrRwoK4=;
        b=XHmWHBENAf13HuVH5E7tUbg4vqvf463w2eNBhvmEpC71BrdW6Rj0w6PmeDJM7EuHal
         JRvTar8vz9lA5tSJFgvExSeyoXC0Q6ZmAtu8qLdLk2tLyNheErcBUooXVRWFj7UEtgNm
         oK9b8vWYmPFEan4+J/QDuMXqQ4QYJ/uhIp2wEiJ2mlGSRrINv7ggr+jgzbmUG7NBClY2
         FsRhTsKA7MspgwT3+V3HM7KovSCzGOCl8YgC5XwAW+AMDfv3D6ENS506bEnTUvU2sDNh
         IlwmbvLYEy6MsnVnPg+YXRHXNuYx2pYPy+atnJE1xTwjcVV8hTu7rvedQyxhMVG+/XcN
         xW1g==
X-Gm-Message-State: ACgBeo2n/pJcFOpEyZwdW9QUE2FkZCcdRVhkQiRReLLvAAFa4t/11EF2
        5Lz0rjLimy/jR/jQ/oSsRSsnJbgXMZE=
X-Google-Smtp-Source: AA6agR7vX5IUfcH4kaJmKhdYogJSUrTNwNErVxWjMLMYqDQ94fG38orXorDKKvhAqhvWHi5Ie/6VZQ==
X-Received: by 2002:adf:f085:0:b0:226:d6e4:58f5 with SMTP id n5-20020adff085000000b00226d6e458f5mr4294059wro.50.1661784120933;
        Mon, 29 Aug 2022 07:42:00 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f18a600880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f18:a600:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9398431wmc.41.2022.08.29.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:42:00 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC 1/4] mac80211: modify tx-power level annotation
Date:   Mon, 29 Aug 2022 16:41:44 +0200
Message-Id: <20220829144147.484787-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829144147.484787-1-jelonek.jonas@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ffd0ebbff294..9612714d715f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2619,6 +2619,27 @@ enum ieee80211_hw_flags {
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
+ * @start_pwr The power level at idx @start_idx.
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
@@ -2741,11 +2762,10 @@ enum ieee80211_hw_flags {
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
@@ -2782,8 +2802,8 @@ struct ieee80211_hw {
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

