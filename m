Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04C62B107
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 03:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiKPCIs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 21:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKPCIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 21:08:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A60355B5
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k7so15108539pll.6
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8fLhB7N3J1r4mUp3lzjhF1u0CrSA6Q2JXjotTecwRE=;
        b=iR0ZfpRdFmaJE6Rq4KR0N+DduXQkRNkuIFqS2Nyu6e6xqRd4Dqtpdx/sAN7hV16for
         VSVJ9htQ/zvdBu8YQ2g/58OHac0hVTzrDWeBMIsoYqewcHZrklt7JbKJ51NmAKdYkmR5
         2wTH6qoOhZ5Bu7yLgsiHtyME5+s03NATVMF4ZPmT9CpAPQu+KdZIdVHQqzjEA8Np0xBs
         msiT8Ekb0sEabGchX4DbCKyAo2B3rP1S3tyiZ4iUXp9j0luqDtz29MMKjoF33GO2TJQJ
         /KsuylJ9QYKi+w/nYW1NzLaKLfYYo2tH2KPnvFUvAuYhPPTZ/tcSBM6BKj2VOLYbT+Fo
         gxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8fLhB7N3J1r4mUp3lzjhF1u0CrSA6Q2JXjotTecwRE=;
        b=t2QWAu0L+8MyZrkxmFqxHGKlkV4M1SfHgNapeR8o98KMHhu905mVVIGNkCzVwgQjkU
         mq4XiUEex2ippsDiOy4+kCpRtfmEY2Y+2tv7EIdxnvRFKUcxvtYVUUOcpmnsibam6cPA
         DeJv1iT4k5XWdrx/gFD0PJOM2E64BnIT8HwmBq0ZhTVceJvx5bz6vFwVx9YRuNh8sw44
         t30QXgiJeiXXW0Qa7iiwPMPdJ2gKSVei2hb5IB23xtVLJEUMZBeynA7+KhM6rGm2iKnZ
         UXEGwcwaDHETWnFB3x6Cag8hjNU1aTLceZU++908eQw0BRhbYo5UAZNllZQC9c9OEie+
         Ddiw==
X-Gm-Message-State: ANoB5pmLVU1tOifqm/vj8F0zfE+NqYG8T0MWt9tj6pNQpUjn/l7ZRMO0
        qg3u/kyJGBL1ddsSo50LPK5Q5g==
X-Google-Smtp-Source: AA0mqf5uQ2+DuWefWGY2WkUwRq87qsy5xwV6Gty+Qmzrp/n0SEhv5U7er+VjjbvkU7nH/WnrJ2eKmw==
X-Received: by 2002:a17:902:ebc3:b0:188:6baf:1ffe with SMTP id p3-20020a170902ebc300b001886baf1ffemr6906100plg.113.1668564526048;
        Tue, 15 Nov 2022 18:08:46 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b0056bbd286cf4sm9379231pfg.167.2022.11.15.18.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:08:45 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v3 2/4] wifi: mac80211: S1G beacon/short beacon support
Date:   Wed, 16 Nov 2022 15:06:58 +1300
Message-Id: <20221116020700.3907453-2-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

If configured, use the S1G short beacon format. The S1G short beacon
format includes a limited set of information elements.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         |  1 +
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tx.c          | 14 +++++++++++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 721c450a9ccd..39faafde109a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -674,6 +674,7 @@ struct ieee80211_bss_conf {
 	bool enable_beacon;
 	u8 dtim_period;
 	u16 beacon_int;
+	u8 short_beacon_period;
 	u16 assoc_capability;
 	u64 sync_tsf;
 	u32 sync_device_ts;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c848fe04dd44..a42abaa25273 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1308,6 +1308,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..2e1d829c548a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -268,6 +268,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	u8 long_beacon_count;
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bb2e54610101..a12b32544a3a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5116,6 +5116,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	struct sk_buff *skb = NULL;
 	u16 csa_off_base = 0;
 	int mbssid_len;
+	bool is_short = false;
+
+	if (vif->cfg.s1g) {
+		if (beacon->long_beacon_count == 0) {
+			is_short = false;
+			beacon->long_beacon_count =
+				vif->bss_conf.short_beacon_period - 1;
+		} else {
+			is_short = true;
+			beacon->long_beacon_count--;
+		}
+	}
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
@@ -5153,7 +5165,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.34.1

