Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B152410257E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 14:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfKSNfa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 08:35:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40798 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfKSNf3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 08:35:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so23384916ljg.7
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 05:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ov3ggha6f3Zyc/mh8Jv2das5WxPoHh5lH06ygDEIJcY=;
        b=tnrsShSWVsYcPnxlvsVmmpk7DZ3Oyj12g8s3x8SIgNqnXMgLjKkbcsAZ7KoVSPIQh2
         Eix9eWRkI37wKOp4DMLSjzj9CfeXDP1Mk6Hdvprs43PI+gtyyxq/2kocIy9tlffsNlL8
         2xrr+zZ3ZkOLHIh+9sJffGJYzm2dnbKBOMf1ERSSl8D+6i9sU1sGrQGW+RGqwyCA+qVb
         4J4BltDlQhbwjj0/fqDUXjoXjEOmFc3rYo/trX418DC0aPsPUc4qZLH1gkbMbqN0MeVS
         Fp21qsYmMxBSwAeuoKJlbe1SbfsSY8sKB4wB7AWV5YUWPRa60dZnPAfMvuNAsHbsdNwX
         YkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ov3ggha6f3Zyc/mh8Jv2das5WxPoHh5lH06ygDEIJcY=;
        b=fF9QYCFqnSTgkvS9+JJ5T8Sjk7/bG4WgNy2jQrmUN8cklsF809niok+kHzJzYseEPb
         p1qu+kk699Ru4QaQn4mxri1OcPw0qVP3v9K0QDVgxSHnpaSAMzyMjqE/3NaMMApkw0Pt
         Q+0V2iL4itsY9GDqmD8JLhY8rmjADacA8i7V4Qo/Hsi3RDE3eT7s2MmciTWMpW1duOgb
         TAx+DR96oXHfB17U+wC1cQ7UlRCeU02MywhfWdcj0FPGO0aduxWQQb8eukiXS5EUHtYs
         l2B8UhPIptL2t0udR30e90zNMplu6uOcqxg9EFB2vr9hsUd2QIjtsfadewftQVDjy0xH
         X7og==
X-Gm-Message-State: APjAAAWdM6tBUFuJR1md7hTgqHRUdfpsGrcld8Wfbwa8nneFteVfdeo/
        34MZlu9d1Muhzt1K6qXr75s/iw==
X-Google-Smtp-Source: APXvYqxfoOAvfOZ992vNCLa7Tjp9irnytl8SAhtGEPjZVdFkVYvAmHojBk3kluNdr8M5+ag8X3EWkw==
X-Received: by 2002:a2e:505e:: with SMTP id v30mr3984712ljd.244.1574170524109;
        Tue, 19 Nov 2019 05:35:24 -0800 (PST)
Received: from anpc3.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id z3sm11401560lji.36.2019.11.19.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 05:35:23 -0800 (PST)
From:   Fredrik Olofsson <fredrik.olofsson@anyfinetworks.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Fredrik Olofsson <fredrik.olofsson@anyfinetworks.com>
Subject: [PATCH] mac80211: fix overwriting of qos_ctrl.tid field
Date:   Tue, 19 Nov 2019 14:34:51 +0100
Message-Id: <20191119133451.14711-1-fredrik.olofsson@anyfinetworks.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes overwriting of qos_ctrl.tid field for encrypted frames injected on
monitor interface. qos_ctrl.tid is protected by the encryption, and
cannot be modified after encryption. For injected frames, the encryption
key may not be available.

Before passing the frame to the driver, the qos_ctrl.tid field is
updated from skb->priority. Prior to dbd50a851c50 skb->priority was
updated in ieee80211_select_queue_80211(), but this function is no longer
always called. This patch tries to mimmic the previous behaviour by
updating skb->priority in ieee80211_monitor_start_xmit().

Fixes: dbd50a851c50 ("mac80211: only allocate one queue when using iTXQs")
Signed-off-by: Fredrik Olofsson <fredrik.olofsson@anyfinetworks.com>
---
 net/mac80211/tx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1fa422782905..cbd273c0b275 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2263,6 +2263,15 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 						    payload[7]);
 	}
 
+	/*
+	 * Initialize skb->priority for QoS frames. This is put in the TID field
+	 * of the frame before passing it to the driver.
+	 */
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
+		u8 *p = ieee80211_get_qos_ctl(hdr);
+		skb->priority = *p & IEEE80211_QOS_CTL_TAG1D_MASK;
+	}
+
 	memset(info, 0, sizeof(*info));
 
 	info->flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
-- 
2.20.1

