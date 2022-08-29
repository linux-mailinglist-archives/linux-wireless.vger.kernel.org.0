Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9265A4F7E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiH2OmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiH2OmE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:42:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E98901A3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so3798149wrp.11
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sZGs/SfDvoLovLDUPhVU9clLBjBIoiuwVlanjNAHV70=;
        b=jS/sBBSBd0Uq55Ol6jyus2WmwLPRRLqvjj+lHg9FxQMbvHo6xdQ6y+s3E2GlRgOs61
         jOICgTqsGIhcqIsGT5rM7xNyTJEg2Bm/z5gJ14+CoQAVLuyZuhY8MtuOo2zbNWd6pHMG
         bXHAvByaT9T1U+9eCLaDUHr/uvoN6Pb3qq7DgsjlMZzkVftfPPZiSt1MoP8qpWcVRPwg
         vfl8CXEH7VTbSJpUBRsXotSNeHd/7QCeWzVVOfON99kUt813azW5KIHgoUjAHfc/6HUs
         AULz2xJ03IjYlQrjkzG5VZLihaJCgjknCzJWtWFS17O5/KlPbMx4xMu0c1AAvy+012Cs
         AS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sZGs/SfDvoLovLDUPhVU9clLBjBIoiuwVlanjNAHV70=;
        b=069tvaIhvN3IXP8UCOOcrEAfUlQHAdxeF3OSsZgZldxw7t12uMot53HoRsHAMYzoXK
         6ampQgzwsnKy87QfYeZnIvJ4gH0VF9AOC/AQuBk3YfEPE5TBSysD/Dq8ROGU4lOqpFhv
         xoCw1pVZqBhdVE7rY7UX3OgIr6P4IBMPX1ebonH4aicDoEDsJYZmZBB4DW6Jv2y+EQ4f
         4JLAB7JiY2ohbWNl8OnPJ5n1z65cjqcOkwIcHtLkLEuJiiXFGNqzpA1sS+r2GarBpnAt
         zPTmhGhjcwCxJSGTczHTuVVX9pw8c7LshwSvEifTMMcvWPbXn2tHAs22uKbTw7jdTN80
         DY7Q==
X-Gm-Message-State: ACgBeo1JUixHvOKzRZylrRVugQWj9QdtReNQXFRYg69VHHLIQuTr2Ljc
        GqMhVyNWP/bk2A+5m7n7Q/KQBGH6ewg=
X-Google-Smtp-Source: AA6agR6RdhK8cxkTwTuW8evCREcq5Ztb6JCB3jcxnXG2lSeiYkUC7X6dY3mcYCq1ndTN2cG3nNbE+A==
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id r11-20020a5d6c6b000000b002250ddeab40mr6573289wrz.690.1661784121831;
        Mon, 29 Aug 2022 07:42:01 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f18a600880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f18:a600:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9398431wmc.41.2022.08.29.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:42:01 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC 2/4] mac80211: add tx-power annotation in control path
Date:   Mon, 29 Aug 2022 16:41:45 +0200
Message-Id: <20220829144147.484787-3-jelonek.jonas@gmail.com>
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

This patch adds members to ieee80211_tx_info and ieee80211_sta_rates
structures to allow tx-power annotation per packet/per mrr stage.
The added members are always tx-power indices referring to the tx-power
set described by ieee80211_hw->txpower_ranges.

The annotation in ieee80211_tx_info is for probing and compatibility
reasons only, e.g. drivers that only support RC/TPC per packet and do
not yet use ieee80211_sta_rates.

Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 include/net/mac80211.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9612714d715f..659662f8b5dd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1072,6 +1072,8 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
  * @control.use_cts_prot: use RTS/CTS
  * @control.short_preamble: use short preamble (CCK only)
  * @control.skip_table: skip externally configured rate table
+ * @control.txpower_idx: Tx-power level index for whole packet,
+ * 	referring to an idx described by ieee80211_hw->txpower_ranges
  * @control.jiffies: timestamp for expiry on powersave clients
  * @control.vif: virtual interface (may be NULL)
  * @control.hw_key: key to encrypt with (may be NULL)
@@ -1120,7 +1122,8 @@ struct ieee80211_tx_info {
 					u8 use_cts_prot:1;
 					u8 short_preamble:1;
 					u8 skip_table:1;
-					/* 2 bytes free */
+					u8 txpower_idx;
+					/* 1 byte free */
 				};
 				/* only needed before rate control */
 				unsigned long jiffies;
@@ -1181,9 +1184,10 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
  *
  * @rate_idx The actual used rate.
  * @try_count How often the rate was tried.
- * @tx_power_idx An idx into the ieee80211_hw->tx_power_levels list of the
- * 	corresponding wifi hardware. The idx shall point to the power level
- * 	that was used when sending the packet.
+ * @tx_power_idx An idx into the the tx-power set described by
+ * 	ieee80211_hw->txpower_ranges for the corresponding wifi hardware.
+ * 	The idx shall point to the tx-power level that was used when sending
+ * 	the packet.
  */
 struct ieee80211_rate_status {
 	struct rate_info rate_idx;
@@ -2097,6 +2101,8 @@ enum ieee80211_sta_rx_bandwidth {
  * @rcu_head: RCU head used for freeing the table on update
  * @rate: transmit rates/flags to be used by default.
  *	Overriding entries per-packet is possible by using cb tx control.
+ * @rate.txpower_idx: An idx pointing to a tx-power level described by
+ * 	ieee80211_hw->txpower_ranges that should be used for the mrr stage.
  */
 struct ieee80211_sta_rates {
 	struct rcu_head rcu_head;
@@ -2106,6 +2112,7 @@ struct ieee80211_sta_rates {
 		u8 count_cts;
 		u8 count_rts;
 		u16 flags;
+		u8 txpower_idx;
 	} rate[IEEE80211_TX_RATE_TABLE_SIZE];
 };
 
-- 
2.30.2

