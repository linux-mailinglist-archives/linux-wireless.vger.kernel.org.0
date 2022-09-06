Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3A5ADEA0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiIFEs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIFEs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:48:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37B5F981
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:48:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x1so5807300plv.5
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A3efkcxMqCbaa7PDe+x91aoe1xznbgpM9T9i+RQwS/c=;
        b=FPUc1a/ZLi8lk0q0FsUZTnn0ZPJVmPVFJpIAWD78/o61WUvuz05MgdKxREWRiMCNpK
         XJlCmn5feJTXmemsNmwIVlBol1P5BCHayVqtnbalQsx7kZyocMwlub/pYMKAY0t2ek2e
         NnQ//ieuJ/9DikjOL2KYo0HF8ltgrLo3iT9OeQXxNIetBsNlMCnZr1Q1K+l53D9cKFFn
         A+IxDoJPLytRqdRlIULhi2y40nX7G83dEzqN8ouYWmcagQj/6Gzg3B4dKoX41AAxDwTi
         0n2WxxoNSTJ2sS322BvmJMsUZlUKeYWBtkpqFHriDFPJ5W9CvT/ZD2muh3OPx+MBz9/G
         vtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A3efkcxMqCbaa7PDe+x91aoe1xznbgpM9T9i+RQwS/c=;
        b=oCv8aYhZd5Cqir1z3qE9Ri3n3arSPbi8DGdPvMx54aqTX3dHwl13mg3dr8flE0Y4de
         s31DBsMj2EfyWs1OUqVovGOcbcLaKBHGgyKMS7wA2tmW+NmrK39Q5PhQb9i6itnvOu1B
         Hua7B+CQ392oJGtNWz8ed8VHPzVQ604FdR3e+KNVwf9cLIzr+ilb9LbdhGV0H9YR6RPy
         fGkwPCJAILT6Q6ltD5pv8rx/Rq1kFzPPjUe0i3oVUbFe8HArfN6v5fjPs5oDJQ2V7C1b
         +GMbCVP+pAHjowGpKYm69t+p8632xpbJyZGsFO2fvLYqGQuqF73zeTQkx5RWnPT5ZU4v
         fUrw==
X-Gm-Message-State: ACgBeo3fiq7dGO+Uu/SMah2qevtJXO5nN9oAa5mwNDIYII3yYJuR2fLK
        67SIROOZqRLm7O5WpOU5VMBXJE+PCgrxJ2Wg
X-Google-Smtp-Source: AA6agR5xYZbe+CQ2cxrzh+LmwdcaHoE/qcmVXpR2vtmEiqNrpKoFELUYPeueXECwsn8ZiU6xQGcziQ==
X-Received: by 2002:a17:90b:2712:b0:1fa:fe17:16db with SMTP id px18-20020a17090b271200b001fafe1716dbmr23228649pjb.165.1662439732033;
        Mon, 05 Sep 2022 21:48:52 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:51 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 03/12] mac80211: S1G beacon/short beacon support
Date:   Tue,  6 Sep 2022 16:48:03 +1200
Message-Id: <20220906044812.7609-4-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If configured, use the S1G short beacon format. The S1G short beacon
format includes a limited set of information elements.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 include/net/cfg80211.h     |  2 +-
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         |  1 +
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tx.c          | 14 +++++++++++++-
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 945e7700de66..b750b2ad246b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1328,7 +1328,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f198af600b5e..359edfa9ec1c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -672,6 +672,7 @@ struct ieee80211_bss_conf {
 	bool enable_beacon;
 	u8 dtim_period;
 	u16 beacon_int;
+	u8 short_beacon_period;
 	u16 assoc_capability;
 	u64 sync_tsf;
 	u32 sync_device_ts;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a4f6971b7a19..03ed90ce9a84 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1236,6 +1236,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e192e1ec0261..cd8879998739 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -267,6 +267,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	u8 long_beacon_count;
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bf85a01fcf9d..48c737aeb3f7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5099,6 +5099,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
@@ -5136,7 +5148,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.34.1

