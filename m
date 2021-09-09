Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7D4059A5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhIIOtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbhIIOtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 10:49:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD16C0613C1
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 07:42:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s24so1531315wmh.4
        for <linux-wireless@vger.kernel.org>; Thu, 09 Sep 2021 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdQxDk1iBotMAEMT0YZyzMXJd33U25RYM7qDuPyiwec=;
        b=oNvmUs2wFhrcARSXxoegbGdq8fJSKF/gCMtg/N8fLbYM4ub3m3RH/Sj/oPrl7WBqLw
         MqSI6ZwX17F/E+sWzpHV7iXpiFFtTbDqYB283nSa1HjKStoKzWq2eUKwHkZ97rXeYMVK
         HpHWxMptN/k9typ6CYAOC+yLDAfakArQfeEfvLJ1nVQuNrprxeCgZ+teE3+W8fPcnl3h
         rXzGyQaq8TCBkU4OZyS+yDIsclfEI780JMzKMsQKdz51ggKFqgtDWreza7jt0zmxsCDd
         zRZGgxDG5ywCWvW9sT+vKKYp+cGdcqqLKoH+9Z2zcZLIyy5wD6t5Artbjq4FPBT+e8X1
         T7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdQxDk1iBotMAEMT0YZyzMXJd33U25RYM7qDuPyiwec=;
        b=LNDrkERXsN7WF4T4BETmtHm7vqH1xfTWxDk8K104SMFODtI56n/IJToZtw24yxVeQ9
         HAUUtiKPI32njmmvfHkIlkSTe98qRxtZzrfgqXqXkZm+DuJbW0HNpjxt0WSMfSqw/zzU
         JagsfhaeJYgkHMNPRaZOQLNWG+vvD4ROdIwXtGV8XF/SQ2TpTAwZAX+/ySYxSSWdoO/i
         WN3qOCKjc2ekLKTpLcv0FrjnOuvoXJ6v7uf9yqxKRXHpuD2YMLZL78B0GUluB+PFvfuH
         mOy3yPo8XkXWvMp3yG1CvG10VXC0MlZ4vYd6hyPm7rHYSLblw/zaLyIAOmDVsB7v4kla
         fyKA==
X-Gm-Message-State: AOAM530wj/q0qEVyNqYKkGzBeZWOPk6tPeiEVYobk8Wo5WriIPy20vSn
        vsglcNC323k0V+wEadxC+3FYuQ==
X-Google-Smtp-Source: ABdhPJx2Toq6xFrdDG6htXAI/wpbaJnaHiI6V0CYO7+leBKqZmOVahF4rNsZdbuwqEWdGLc2LhJlUQ==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr3419613wmh.186.1631198555611;
        Thu, 09 Sep 2021 07:42:35 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k29sm1160712wms.24.2021.09.09.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:42:35 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/2] wcn36xx: Fix Antenna Diversity Switching
Date:   Thu,  9 Sep 2021 15:44:27 +0100
Message-Id: <20210909144428.2564650-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909144428.2564650-1-bryan.odonoghue@linaro.org>
References: <20210909144428.2564650-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have been tracking a strange bug with Antenna Diversity Switching (ADS)
on wcn3680b for a while.

ADS is configured like this:
   A. Via a firmware configuration table baked into the NV area.
       1. Defines if ADS is enabled.
       2. Defines which GPIOs are connected to which antenna enable pin.
       3. Defines which antenna/GPIO is primary and which is secondary.

   B. WCN36XX_CFG_VAL(ANTENNA_DIVERSITY, N)
      N is a bitmask of available antenna.

      Setting N to 3 indicates a bitmask of enabled antenna (1 | 2).

      Obviously then we can set N to 1 or N to 2 to fix to a particular
      antenna and disable antenna diversity.

   C. WCN36XX_CFG_VAL(ASD_PROBE_INTERVAL, XX)
      XX is the number of beacons between each antenna RSSI check.
      Setting this value to 50 means, every 50 received beacons, run the
      ADS algorithm.

   D. WCN36XX_CFG_VAL(ASD_TRIGGER_THRESHOLD, YY)
      YY is a two's complement integer which specifies the RSSI decibel
      threshold below which ADS will run.
      We default to -60db here, meaning a measured RSSI <= -60db will
      trigger an ADS probe.

   E. WCN36XX_CFG_VAL(ASD_RTT_RSSI_HYST_THRESHOLD, Z)
      Z is a hysteresis value, indicating a delta which the RSSI must
      exceed for the antenna switch to be valid.

      For example if HYST_THRESHOLD == 3 AntennaId1-RSSI == -60db and
      AntennaId-2-RSSI == -58db then firmware will not switch antenna.
      The threshold needs to be -57db or better to satisfy the criteria.

   F. A firmware feature bit also exists ANTENNA_DIVERSITY_SELECTION.
      This feature bit is used by the firmware to report if
      ANTENNA_DIVERSITY_SELECTION is supported. The host is not required to
      toggle this bit to enable or disable ADS.

ADS works like this:

    A. Every XX beacons the firmware switches to or remains on the primary
       antenna.

    B. The firmware then sends a Request-To-Send (RTS) packet to the AP.

    C. The firmware waits for a Clear-To-Send (CTS) response from the AP.

    D. The firmware then notes the received RSSI on the CTS packet.

    E. The firmware then repeats steps A-D on the secondary antenna.

    F. Subsequently if the RSSI on the measured antenna is better than
       ASD_TRIGGER_THRESHOLD + the active antenna's RSSI then the
       measured antenna becomes the active antenna.

    G. If RSSI rises past ASD_TRIGGER_THRESHOLD then ADS doesn't run at
       all even if there is a substantially better RSSI on the alternative
       antenna.

What we have been observing is that the RTS packet is being sent but the
MAC address is a byte-swapped version of the target MAC. The ADS/RTS MAC is
corrupted only when the link is encrypted, if the AP is open the RTS MAC is
correct. Similarly if we configure the firmware to an RTS/CTS sequence for
regular data - the transmitted RTS MAC is correctly formatted.

Internally the wcn36xx firmware uses the indexes in the SMD commands to
populate and extract data from specific entries in an STA lookup table. The
AP's MAC appears a number of times in different indexes within this lookup
table, so the MAC address extracted for the data-transmit RTS and the MAC
address extracted for the ADS/RTS packet are not the same STA table index.

Our analysis indicates the relevant firmware STA table index is
"bssSelfStaIdx".

There is an STA populate function responsible for formatting the MAC
address of the bssSelfStaIdx including byte-swapping the MAC address.

Its clear then that the required STA populate command did not run for
bssSelfStaIdx.

So taking a look at the sequence of SMD commands sent to the firmware we
see the following downstream when moving from an unencrypted to encrypted
BSS setup.

- WLAN_HAL_CONFIG_BSS_REQ
- WLAN_HAL_CONFIG_STA_REQ
- WLAN_HAL_SET_STAKEY_REQ

Upstream in wcn36xx we have

- WLAN_HAL_CONFIG_BSS_REQ
- WLAN_HAL_SET_STAKEY_REQ

The solution then is to add the missing WLAN_HAL_CONFIG_STA_REQ between
WLAN_HAL_CONFIG_BSS_REQ and WLAN_HAL_SET_STAKEY_REQ.

No surprise WLAN_HAL_CONFIG_STA_REQ is the routine responsible for
populating the STA lookup table in the firmware and once done the MAC sent
by the ADS routine is in the correct byte-order.

This bug is apparent with ADS but it is also the case that any other
firmware routine that depends on the "bssSelfStaIdx" would retrieve
malformed data on an encrypted link.

Fixes: 3e977c5c523d ("wcn36xx: Define wcn3680 specific firmware parameters")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 9e4fa55d8118..65b4e618d61e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -580,12 +580,14 @@ static int wcn36xx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		if (IEEE80211_KEY_FLAG_PAIRWISE & key_conf->flags) {
 			sta_priv->is_data_encrypted = true;
 			/* Reconfigure bss with encrypt_type */
-			if (NL80211_IFTYPE_STATION == vif->type)
+			if (NL80211_IFTYPE_STATION == vif->type) {
 				wcn36xx_smd_config_bss(wcn,
 						       vif,
 						       sta,
 						       sta->addr,
 						       true);
+				wcn36xx_smd_config_sta(wcn, vif, sta);
+			}
 
 			wcn36xx_smd_set_stakey(wcn,
 				vif_priv->encrypt_type,
-- 
2.33.0

