Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1640113BA4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 07:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfLEGTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 01:19:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51359 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfLEGTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 01:19:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so2284655wme.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2019 22:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HNLHDibuP2KTpfskWj+zK/A1YenMp0fngAvV6KD1+I=;
        b=NhOdYCsyXrGQMsAoIwYybiLIrQuco7XWyjW6K6mu/P15YlfS10KSIkFjROcz8JVinb
         U5MeG1x88lRfk8KMWZ6ghyqFYVfD55Zo0DbCpN3r1SetVSk5z0ljplu0fapS66y6X2VO
         llWnvikV0KNe7H2hvl53Hy4fPPIF5erW5UAIqfiu7IEGEWFOElarE9VqgyXfYsH+xlPw
         OvJWQjO+ncBBmUtBfXNyRTMVgurZbMVxJTQQ1UXcwjQVhgoeQbMZAysu5JMHziL5Zdst
         unMs1vS+iJXk95VgV0WAJY8rDBYRuKRgZDPjE934e9+S6RY/adqqRUluBiSHIfW4FUwf
         OkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HNLHDibuP2KTpfskWj+zK/A1YenMp0fngAvV6KD1+I=;
        b=IXLDUjhOCfSZg+p4wrwgjaQqxfn+Zgvyp9RsYNwu5TttjU2rtexj766bWi4TMzMFjQ
         U0eqsXbXBmD3w811mVErEp2BjciXxpuno0YXmjVDutPKPBF2RifLJ+sJexPfho5T7FtR
         NvmylFD3PIDGRImPFrA+2oxvWv7MDzU3P7QX9TRJDreF8iXMK88N80EcLMiVrMp5fPoa
         YRoj3vQz+GTo7KAnLPqWabrV31GqRNKsHgoNG+PxYa4FQ8A9X61DkzEaIivRuFbn1bEC
         WBAhOhmEzM6pYkXU2OncNsHRp/cAcPVOA00XFgVXnrLs6blaYMkE3JRAAgc06PTpMJm8
         IpTg==
X-Gm-Message-State: APjAAAXBoG9fbRM7o4SiPP3pc0Qx82LLB2k6fYG4kxyAthx7lyN7i8lt
        9sVv1H9CyUV2yhbM+2W51a8=
X-Google-Smtp-Source: APXvYqw0AOQjgJc9qL5zgC9bUVZE2VCOqjEhrjH8m8as7WAW7fhWD5vAuDXY1OKrsDrsgihkOT1DCw==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr3148712wmj.53.1575526768512;
        Wed, 04 Dec 2019 22:19:28 -0800 (PST)
Received: from localhost.localdomain ([193.27.220.66])
        by smtp.gmail.com with ESMTPSA id w22sm9286413wmk.34.2019.12.04.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 22:19:27 -0800 (PST)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org
Subject: [PATCH] wcn36xx: disconnect timeout
Date:   Thu,  5 Dec 2019 07:19:22 +0100
Message-Id: <20191205061922.1801-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Whenever the signal stregth decays smoothly and physical connnection
is already gone and no deauth has arrived, the qcom soc is not
able to indicate neither WCN36XX_HAL_MISSED_BEACON_IND nor
WCN36XX_HAL_MISSED_BEACON_IND. It was noticed that such situation gets
even more reproducible, when the driver fails to enter bmps mode - which is
highly likely to occur. Thus, in order to provide proper disconnection
of the connected STA, a disconnection timeout based on last time seen
bss beacon is here given.

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 34 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.h    |  2 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index a6902371e89c..98155b2115e0 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -23,11 +23,30 @@ static inline int get_rssi0(struct wcn36xx_rx_bd *bd)
 	return 100 - ((bd->phy_stat0 >> 24) & 0xff);
 }
 
+static inline void rx_check(struct timer_list *t) {
+	struct wcn36xx *wcn = from_timer(wcn, t, rx_timer);
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *tmp;
+
+	list_for_each_entry(tmp, &wcn->vif_list, list) {
+			vif = wcn36xx_priv_to_vif(tmp);
+			if (vif && vif->bss_conf.assoc) {
+				wcn36xx_warn("no beacons seen - disconnect timeout\n");
+
+				ieee80211_connection_loss(vif);
+				del_timer(&wcn->rx_timer);
+				wcn->rx_timer.function = NULL;
+			}
+	}
+}
+
 int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 {
 	struct ieee80211_rx_status status;
 	struct ieee80211_hdr *hdr;
 	struct wcn36xx_rx_bd *bd;
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *tmp;
 	u16 fc, sn;
 
 	/*
@@ -77,6 +96,21 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 			    skb, skb->len, fc, sn);
 		wcn36xx_dbg_dump(WCN36XX_DBG_BEACON_DUMP, "SKB <<< ",
 				 (char *)skb->data, skb->len);
+
+		list_for_each_entry(tmp, &wcn->vif_list, list) {
+			vif = wcn36xx_priv_to_vif(tmp);
+			if (vif && vif->bss_conf.assoc &&
+				ether_addr_equal(hdr->addr2, vif->bss_conf.bssid)) {
+					del_timer(&wcn->rx_timer);
+					wcn->rx_timer.function = NULL;
+
+					wcn->rx_timer.expires = jiffies +
+											msecs_to_jiffies(RX_TIMEOUT);
+					timer_setup(&wcn->rx_timer, rx_check, 0);
+					add_timer(&wcn->rx_timer);
+				}
+		}
+
 	} else {
 		wcn36xx_dbg(WCN36XX_DBG_RX, "rx skb %p len %d fc %04x sn %d\n",
 			    skb, skb->len, fc, sn);
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.h b/drivers/net/wireless/ath/wcn36xx/txrx.h
index 032216e82b2b..f6b07cba165a 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.h
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.h
@@ -32,6 +32,8 @@
 #define WCN36XX_BD_RATE_MGMT 2
 #define WCN36XX_BD_RATE_CTRL 3
 
+#define RX_TIMEOUT 30000
+
 enum wcn36xx_txbd_ssn_type {
 	WCN36XX_TXBD_SSN_FILL_HOST = 0,
 	WCN36XX_TXBD_SSN_FILL_DPU_NON_QOS = 1,
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index a58f313983b9..a9cfb817fab7 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -254,6 +254,8 @@ struct wcn36xx {
 	struct wcn36xx_dfs_entry    dfs;
 #endif /* CONFIG_WCN36XX_DEBUGFS */
 
+	struct timer_list rx_timer;
+
 };
 
 static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
-- 
2.20.1

