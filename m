Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1099743810F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 02:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhJWAmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 20:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhJWAmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 20:42:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713ABC061766
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:40:19 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y67so7477800iof.10
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7/+pikxNRy4utznLJ1GiAXOsGjI/jsCBsKgU2eHpJE=;
        b=V9pQ1gdA4FbAl8sT3PDEvRomNk9b6LKpNr/J/7h9pEIcwwe+t2HFze1Nojw54bEdWk
         bQ0LNAAwEev520J/K3VX9klbZ5vEJvBSYVfpe65KesoCZtK5PHxXFRRV9SWA2yRu2Rxf
         sNVQ65fqObhh7ajxDBkCNtdSHRKzgM9YamVGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7/+pikxNRy4utznLJ1GiAXOsGjI/jsCBsKgU2eHpJE=;
        b=0eqquPv05tOnQBr1Hj7vRLMSZDzddiKGicX7qISryR3ia6JDAl2yiSZr4w9HmsPYKM
         WORGTjkqKbbsVwBsr7Fho9GOUt5rV61o5a+cUvSPVdEs6lGmy5cgIGSMEV/8cYQpDWZd
         B/5xqqkLOt981vLJZ8N6jTBQtkMZRjlKCJzncXF/qATZTtxGeRJJAibRWPT5et7shI1l
         I4QZo+6cBWmV3xtcva6moB2KuVKBcXEOusLNQrwBk9ZNu6oxISz6BlTa40JUhVLM6oaF
         BNQ/qSffXp0HPyFVfArQYVVZslBeJoMG/JhH7wlNBXyf7JdsShwaR5Eu2T/yFNLb9rM3
         oBWQ==
X-Gm-Message-State: AOAM533bf4kC8QxSXeKVWKKRp1LuA6dKNVNKVFZkrjOc9AsB5j8zrcRp
        I8BnEM3kva6eewxKBoTFYZmEqQ==
X-Google-Smtp-Source: ABdhPJyVUYYhyVPmfRjjW1+I05tdVyKnr5xjcJUeDrdDLnnA0+NSFzvZ2q/DM3SydPRIOwuR0H20Ww==
X-Received: by 2002:a5d:8183:: with SMTP id u3mr1780384ion.67.1634949618829;
        Fri, 22 Oct 2021 17:40:18 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id s10sm5092073ild.78.2021.10.22.17.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 17:40:18 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Joseph Gates <jgates@squareup.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eugene Krasnikov <k.eugene.e@gmail.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] wcn36xx: ensure pairing of init_scan/finish_scan and start_scan/end_scan
Date:   Fri, 22 Oct 2021 17:39:48 -0700
Message-Id: <20211023003949.3082900-4-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023003949.3082900-1-benl@squareup.com>
References: <20211023003949.3082900-1-benl@squareup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

An SMD capture from the downstream prima driver on WCN3680B shows the
following command sequence for connected scans:

- init_scan_req
    - start_scan_req, channel 1
    - end_scan_req, channel 1
    - start_scan_req, channel 2
    - ...
    - end_scan_req, channel 3
- finish_scan_req
- init_scan_req
    - start_scan_req, channel 4
    - ...
    - end_scan_req, channel 6
- finish_scan_req
- ...
    - end_scan_req, channel 165
- finish_scan_req

Upstream currently never calls wcn36xx_smd_end_scan, and in some cases[1]
still sends finish_scan_req twice in a row or before init_scan_req. A
typical connected scan looks like this:

- init_scan_req
    - start_scan_req, channel 1
- finish_scan_req
- init_scan_req
    - start_scan_req, channel 2
- ...
    - start_scan_req, channel 165
- finish_scan_req
- finish_scan_req

This patch cleans up scanning so that init/finish and start/end are always
paired together and correctly nested.

- init_scan_req
    - start_scan_req, channel 1
    - end_scan_req, channel 1
- finish_scan_req
- init_scan_req
    - start_scan_req, channel 2
    - end_scan_req, channel 2
- ...
    - start_scan_req, channel 165
    - end_scan_req, channel 165
- finish_scan_req

Note that upstream will not do batching of 3 active-probe scans before
returning to the operating channel, and this patch does not change that.
To match downstream in this aspect, adjust IEEE80211_PROBE_DELAY and/or
the 125ms max off-channel time in ieee80211_scan_state_decision.

[1]: commit d195d7aac09b ("wcn36xx: Ensure finish scan is not requested
before start scan") addressed one case of finish_scan_req being sent
without a preceding init_scan_req (the case of the operating channel
coinciding with the first scan channel); two other cases are:
1) if SW scan is started and aborted immediately, without scanning any
   channels, we send a finish_scan_req without ever sending init_scan_req,
   and
2) as SW scan logic always returns us to the operating channel before
   calling wcn36xx_sw_scan_complete, finish_scan_req is always sent twice
   at the end of a SW scan

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 34 +++++++++++++++++-----
 drivers/net/wireless/ath/wcn36xx/smd.c     |  4 +++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 24bfb30a30f31..a6f4a22417b36 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -398,6 +398,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct wcn36xx *wcn = hw->priv;
+	int ret;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac config changed 0x%08x\n", changed);
 
@@ -413,17 +414,31 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 			 * want to receive/transmit regular data packets, then
 			 * simply stop the scan session and exit PS mode.
 			 */
-			wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
-						wcn->sw_scan_vif);
-			wcn->sw_scan_channel = 0;
+			if (wcn->sw_scan_channel)
+				wcn36xx_smd_end_scan(wcn, wcn->sw_scan_channel);
+			if (wcn->sw_scan_init) {
+				wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
+							wcn->sw_scan_vif);
+			}
 		} else if (wcn->sw_scan) {
 			/* A scan is ongoing, do not change the operating
 			 * channel, but start a scan session on the channel.
 			 */
-			wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
-					      wcn->sw_scan_vif);
+			if (wcn->sw_scan_channel)
+				wcn36xx_smd_end_scan(wcn, wcn->sw_scan_channel);
+			if (!wcn->sw_scan_init) {
+				/* This can fail if we are unable to notify the
+				 * operating channel.
+				 */
+				ret = wcn36xx_smd_init_scan(wcn,
+							    HAL_SYS_MODE_SCAN,
+							    wcn->sw_scan_vif);
+				if (ret) {
+					mutex_unlock(&wcn->conf_mutex);
+					return -EIO;
+				}
+			}
 			wcn36xx_smd_start_scan(wcn, ch);
-			wcn->sw_scan_channel = ch;
 		} else {
 			wcn36xx_change_opchannel(wcn, ch);
 		}
@@ -730,7 +745,12 @@ static void wcn36xx_sw_scan_complete(struct ieee80211_hw *hw,
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "sw_scan_complete");
 
 	/* ensure that any scan session is finished */
-	wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN, wcn->sw_scan_vif);
+	if (wcn->sw_scan_channel)
+		wcn36xx_smd_end_scan(wcn, wcn->sw_scan_channel);
+	if (wcn->sw_scan_init) {
+		wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
+					wcn->sw_scan_vif);
+	}
 	wcn->sw_scan = false;
 	wcn->sw_scan_opchannel = 0;
 }
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3979171c92dd2..e0de5da31158c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -720,6 +720,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 		wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_init = true;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -750,6 +751,7 @@ int wcn36xx_smd_start_scan(struct wcn36xx *wcn, u8 scan_channel)
 		wcn36xx_err("hal_start_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_channel = scan_channel;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -780,6 +782,7 @@ int wcn36xx_smd_end_scan(struct wcn36xx *wcn, u8 scan_channel)
 		wcn36xx_err("hal_end_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_channel = 0;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -821,6 +824,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
 		wcn36xx_err("hal_finish_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_init = false;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index add6e527e8330..d2a2769673716 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -247,6 +247,7 @@ struct wcn36xx {
 	struct cfg80211_scan_request *scan_req;
 	bool			sw_scan;
 	u8			sw_scan_opchannel;
+	bool			sw_scan_init;
 	u8			sw_scan_channel;
 	struct ieee80211_vif	*sw_scan_vif;
 	struct mutex		scan_lock;
-- 
2.25.1

