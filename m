Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9695BE38E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiITKmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiITKll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C8EF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y5so3602091wrh.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q9ipJl82sYuTVeTpx8NBZFl7eAiA+ccE9GP6oi8s+I8=;
        b=BbBDN0/HSMBVVelo7hMXIVPPw/XOmLtdq9sbbAHGC4MEZYs/HD4rkXM2/uza2u/SYQ
         yL5aqTWJo0nBHGcjdgR+/GMxVuxxRwVoJHEPMAezsWdAIWLvF2jisWErGjNVbVDszj1n
         p0IA6Fx9trja1AV9f3PHA+amDsJDRxDQ84Gi646fqt6d7GrK7/LdXjiysACtmi1RTfmI
         FLebSLc2v2n0ghPgBKWzGUTw01wSCJyHx4jGAmr9wGtBp3ZN07rbum9/Q+HyVw0/TOma
         HnRm5hdcRucZKDcZL9u0h1Cs+rwKoTKO8srEPInii3dPCAT4w+s48yIUxh1+ljS9RP44
         10mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q9ipJl82sYuTVeTpx8NBZFl7eAiA+ccE9GP6oi8s+I8=;
        b=TRDdl0YpEQacQRBpWeufV91QTNaq8xfHioheZ0rgGb9l3zL6wltSFWC2NvMb35J+/x
         pnNKq1IW8ldKiQzIfPwJFEJeo4G7wtdGSwy2BMj1qwEAAtqJD+JGdLA+/7vvqEgCS05Q
         62e+czGKbwAm7WI+74iFZPLCWop9Jb4H4cZKz2hz7MyPfVNlDhWLvwt6G4Sco7B6Cq3E
         H3nIs5Ou0zGujM+xX8aLlsw/sJAeF7xCaakodjksOLbIVozZlXoc5hbVauuFFSXWGZ/9
         SZNNiv6s49kVfnyvVmaoRi1Cx+mw4KCWT+V/3r0bqLwsU6A/cJ3zrp9bX3WMzHY10hz+
         qPHA==
X-Gm-Message-State: ACrzQf3sQlk/jo9vgoPvT6G4yrMxsTUiTHIbFOKlN4ehx/ZiQ+Vo4O6l
        oXzxcsE0W2esJwFedH81G/KhXMFofRrEXQ==
X-Google-Smtp-Source: AMsMyM7aZ9xkYhzbwASk2G1IVS4mIqoa1sbhVNl9Puq68aHU9CwEL3Fheap201jbdRhpz9+eaxKG3Q==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr13131126wrb.466.1663670451842;
        Tue, 20 Sep 2022 03:40:51 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:51 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC v2 2/6] mac80211: add tx-power annotation in control path
Date:   Tue, 20 Sep 2022 12:40:28 +0200
Message-Id: <20220920104032.496697-3-jelonek.jonas@gmail.com>
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
 include/net/mac80211.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a047fb5fc207..67d9087e031f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1073,6 +1073,10 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
  * @control.use_cts_prot: use RTS/CTS
  * @control.short_preamble: use short preamble (CCK only)
  * @control.skip_table: skip externally configured rate table
+ * @control.txpower_idx: Tx-power level index for whole packet,
+ * 	referring to an idx described by ieee80211_hw->txpower_ranges. A
+ * 	negative idx means 'invalid', 'unset' or 'default'. Behavior in this
+ * 	case is driver-specific.
  * @control.jiffies: timestamp for expiry on powersave clients
  * @control.vif: virtual interface (may be NULL)
  * @control.hw_key: key to encrypt with (may be NULL)
@@ -1121,7 +1125,7 @@ struct ieee80211_tx_info {
 					u8 use_cts_prot:1;
 					u8 short_preamble:1;
 					u8 skip_table:1;
-					/* 2 bytes free */
+					s16 txpower_idx;
 				};
 				/* only needed before rate control */
 				unsigned long jiffies;
@@ -1182,14 +1186,16 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
  *
  * @rate_idx The actual used rate.
  * @try_count How often the rate was tried.
- * @tx_power_idx An idx into the ieee80211_hw->tx_power_levels list of the
- * 	corresponding wifi hardware. The idx shall point to the power level
- * 	that was used when sending the packet.
+ * @tx_power_idx An idx into the the tx-power set described by
+ * 	ieee80211_hw->txpower_ranges for the corresponding wifi hardware.
+ * 	The idx shall point to the tx-power level that was used when sending
+ * 	the packet at this rate. A negative value is considered as 'invalid'
+ * 	or 'no power level reported by the driver'.
  */
 struct ieee80211_rate_status {
 	struct rate_info rate_idx;
 	u8 try_count;
-	u8 tx_power_idx;
+	s16 tx_power_idx;
 };
 
 /**
@@ -2113,6 +2119,10 @@ enum ieee80211_sta_rx_bandwidth {
  * @rcu_head: RCU head used for freeing the table on update
  * @rate: transmit rates/flags to be used by default.
  *	Overriding entries per-packet is possible by using cb tx control.
+ * @rate.txpower_idx: An idx pointing to a tx-power level described by
+ * 	ieee80211_hw->txpower_ranges that should be used for the mrr stage.
+ * 	A negative value means 'invalid', 'unset' or 'default' power level,
+ * 	actual behavior is driver-specific.
  */
 struct ieee80211_sta_rates {
 	struct rcu_head rcu_head;
@@ -2122,6 +2132,7 @@ struct ieee80211_sta_rates {
 		u8 count_cts;
 		u8 count_rts;
 		u16 flags;
+		s16 txpower_idx;
 	} rate[IEEE80211_TX_RATE_TABLE_SIZE];
 };
 
-- 
2.30.2

