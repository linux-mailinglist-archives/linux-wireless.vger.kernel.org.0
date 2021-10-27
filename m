Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0643CF63
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbhJ0RGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbhJ0RF4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 13:05:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E16C061224
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 10:03:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e144so4568521iof.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KS5UdkZMEdsSS7sRvW29mKpAHVC0RJgUbKs3rC8KkRA=;
        b=QCIATHeZUD0+8iQC0Uryon9qMumrpm3wA9rcxLO6jJcNr8EwP8SFcKLQvQWRrKAnp5
         Ep2FT096SOaoZjHehOaYauW0Fo9oJ9Hm4FFVu6fErFA+lCV/uVKbcjbkOZippz3jslC3
         09Bd38rzX/Od15pNHrdAcjfgL8taebm9/zQcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KS5UdkZMEdsSS7sRvW29mKpAHVC0RJgUbKs3rC8KkRA=;
        b=SGQypdcxSaaA2bzkkhoN5fAryvphmwNn44+IMndG3W+OCYroq3yi6Lexh8ztUPGy/B
         og20VqibdzbOqPnr5JafNLNM3nI4+wh7DfabXJTtM+ok67CA2pBCjmFSngAF5x9ho9hG
         TDK8y1vI5r+mobCSdgtufAkBTnfnmFvQ8lSgwSvAKoIjrZ3DF6wg08OqO950uAdLKKJN
         7qOlF6V6N67S3mTxxGtaGba5uCpb3lp8CIUM/o0TAvVpWQnim05G22T15szuztoNzeG2
         zFSynh/G0zhbiY7slPP1kynFz4qDrXm/QJuXs5zpxfWdEeVDFUHVdiVoWq6dbkBP3qAZ
         XYKA==
X-Gm-Message-State: AOAM532zk9tbfwcPvJ2PxJsN89Nti8AMO5QpOo71dot0hNuyAC0xSRKl
        03CIqXJLrJU0QBiADiHu7wfw/Q==
X-Google-Smtp-Source: ABdhPJwUsvq5sj/2Z+oqiMVE9ZasBnCzDky5j3uv7ukHPYOUHH+q0n7S3L0aoJqvP6zlbvAhOdhn0Q==
X-Received: by 2002:a6b:b5c2:: with SMTP id e185mr7524258iof.127.1635354209659;
        Wed, 27 Oct 2021 10:03:29 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id j22sm280170ila.6.2021.10.27.10.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 10:03:29 -0700 (PDT)
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
Subject: [PATCH v2 3/3] wcn36xx: ensure pairing of init_scan/finish_scan and start_scan/end_scan
Date:   Wed, 27 Oct 2021 10:03:05 -0700
Message-Id: <20211027170306.555535-4-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027170306.555535-1-benl@squareup.com>
References: <20211027170306.555535-1-benl@squareup.com>
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
index 18383d0fc0933..37b4016f020c9 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -400,6 +400,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct wcn36xx *wcn = hw->priv;
+	int ret;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac config changed 0x%08x\n", changed);
 
@@ -415,17 +416,31 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
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
@@ -723,7 +738,12 @@ static void wcn36xx_sw_scan_complete(struct ieee80211_hw *hw,
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
index 3cecc8f9c9647..830341be72673 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -721,6 +721,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 		wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_init = true;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -751,6 +752,7 @@ int wcn36xx_smd_start_scan(struct wcn36xx *wcn, u8 scan_channel)
 		wcn36xx_err("hal_start_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_channel = scan_channel;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -781,6 +783,7 @@ int wcn36xx_smd_end_scan(struct wcn36xx *wcn, u8 scan_channel)
 		wcn36xx_err("hal_end_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_channel = 0;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -822,6 +825,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
 		wcn36xx_err("hal_finish_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->sw_scan_init = false;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 1c8d918137da2..fbd0558c2c196 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -248,6 +248,7 @@ struct wcn36xx {
 	struct cfg80211_scan_request *scan_req;
 	bool			sw_scan;
 	u8			sw_scan_opchannel;
+	bool			sw_scan_init;
 	u8			sw_scan_channel;
 	struct ieee80211_vif	*sw_scan_vif;
 	struct mutex		scan_lock;
-- 
2.25.1

