Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59FD4562A3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 19:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhKRSoY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 13:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhKRSoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 13:44:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0CC061758
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 10:41:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u17so6025173plg.9
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RbUTIPyfuQU3KvEwbLJbeU9iwD29PEErUjBhpe3f1nk=;
        b=Co+TIeRJL09Rq3VPI76nMtEKLH/eE+0ZvB8aRWw0Yi+6DgAd9bRSPauVUzKvqEeMK1
         hT1e0mHlV6mDk225eu1z8Lo9YAC9bcPXiC7i39eZ5PAvNdOPGhiaHeh64Q1FqeJM60zz
         KzPl31m9ey7qhQdqvq8xeaHux2ki+1q97tYd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RbUTIPyfuQU3KvEwbLJbeU9iwD29PEErUjBhpe3f1nk=;
        b=Li4KXdU7f5oxgsQkIvzRXeb9xcbOrgvNG4eqgm7YAaQYnPK/dMt9fTqfKV0lo+IY5Q
         TkzMCWjK2DDb1dxqWLjQfi7Dbf2qbvvG0BI6Vv4ROUsApJN8nE6e3s0O2B/OvWSKBhtc
         PIzJSiLvABxhPPYix4WCmtZa03488e+gqZCmNZpMBg+aoFxBXJOA24O0z3k5AvUI5ws9
         CCJw9gQozn5WmCmPEHXIe3XhZIDL5FK0emqrds0YqDwoFgyxE6R/WJ11xN8JvtWzz2QM
         nCnEDjmWlWsGJ7t1RXA5bGH1RNwSyRrZBDYtueCRkTZCe/7MWEmIUozcRFv5EHAkb/HH
         a4CQ==
X-Gm-Message-State: AOAM531J3ECKyp223bI4I8kizPK3IZshfbnSRRgFTVzoXJ7tGBF3Qk9a
        NhopDCLR9z5uchqUSxxGQHW4HA==
X-Google-Smtp-Source: ABdhPJzodK/I+eeNuN3Xk06+n5zhrWUoOkx/5chP0/yt93UK8GaJ8Jr/gwEyIDSs3RSJwJEYECbGVw==
X-Received: by 2002:a17:902:e804:b0:142:1c0b:c2a6 with SMTP id u4-20020a170902e80400b001421c0bc2a6mr67605456plg.23.1637260882951;
        Thu, 18 Nov 2021 10:41:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm343200pfc.8.2021.11.18.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:41:22 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] libertas_tf: Use struct_group() for memcpy() region
Date:   Thu, 18 Nov 2021 10:41:21 -0800
Message-Id: <20211118184121.1283821-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; h=from:subject; bh=aN5SRWSO0jhRLPZQ+xEXk4KxeSHDMCg25qp77Fv8hh8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlp5Qeg0TURmPLYxq0mwE2hFWy/0AYNHuIKbeAQlp DWoEAlmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZaeUAAKCRCJcvTf3G3AJuSiD/ 4wcpmRD5px9n6yd6xWv+gt3hCr1H9791Cboykwo0Lpp/SHFjH4FZFXODl+Yk+h1qKLUNAVhyaeHdD5 ADLhR1hGYi57Gv7cSAZI9hjopIS2JhOKy8SseJvoBH9XV+zEvzMxVRyIJHkaPpMjvA8Rw8VHba+0wD qBVapKp9KITa6HKnH/imrMShxTcyssHL8gq7t4yipfOjliNPO4LikA2ppq8Z11+vyhvi2BKm9VNl8m LAnFs3PVt1PVVsGYYMBO5TNmu6kZWu9HeDnikMMc4NOBKNWusiT/fPonzIeYVmgzRAGeHQnsQcQ84h qyfKFYGtvKXCn2YSM/TNcxk0h1b5fG1TaLmNtKtuImNhbZylnnK6tq3kgBrTTIq7MjdwvVDT3/24pO zTYInji5mjFrii4gSkR119Ov/UFizJsDhaOrkbDX+b3kNW9xt8DvboOv7WNaKXUg/jZGuBsfhHsWOg uuZPI6u5uYPndGRgLsAfIxMuPQHyi+1w9L/EKxOOZ6NsEn2LjfzmGTYs/ZdFr07sW/YYyaXIWQTrCk UXpaSTtRRrfX+R5NUiIVO1r+Q6qcTtLAHfNeQToQct7l4M12U+Esi6lwI8XmDpPMmuupWueu9v3q1s PL+z3lUwp41eD44PcKvy0a7/bHVNO04v5GifSaKwueC/Yo6IR64WA/+8I85g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field array bounds checking for memcpy(), memmove(), and memset(),
avoid intentionally writing across neighboring fields.

Use struct_group() in struct txpd around members tx_dest_addr_high
and tx_dest_addr_low so they can be referenced together. This will
allow memcpy() and sizeof() to more easily reason about sizes, improve
readability, and avoid future warnings about writing beyond the end
of tx_dest_addr_high.

"pahole" shows no size nor member offset changes to struct txpd.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/libertas_tf/libertas_tf.h | 10 ++++++----
 drivers/net/wireless/marvell/libertas_tf/main.c        |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
index 5d726545d987..b2af2ddb6bc4 100644
--- a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
+++ b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
@@ -268,10 +268,12 @@ struct txpd {
 	__le32 tx_packet_location;
 	/* Tx packet length */
 	__le16 tx_packet_length;
-	/* First 2 byte of destination MAC address */
-	u8 tx_dest_addr_high[2];
-	/* Last 4 byte of destination MAC address */
-	u8 tx_dest_addr_low[4];
+	struct_group(tx_dest_addr,
+		/* First 2 byte of destination MAC address */
+		u8 tx_dest_addr_high[2];
+		/* Last 4 byte of destination MAC address */
+		u8 tx_dest_addr_low[4];
+	);
 	/* Pkt Priority */
 	u8 priority;
 	/* Pkt Trasnit Power control */
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 71492211904b..02a1e1f547d8 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -232,7 +232,8 @@ static void lbtf_tx_work(struct work_struct *work)
 			     ieee80211_get_tx_rate(priv->hw, info)->hw_value);
 
 	/* copy destination address from 802.11 header */
-	memcpy(txpd->tx_dest_addr_high, skb->data + sizeof(struct txpd) + 4,
+	BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
+	memcpy(&txpd->tx_dest_addr, skb->data + sizeof(struct txpd) + 4,
 		ETH_ALEN);
 	txpd->tx_packet_length = cpu_to_le16(len);
 	txpd->tx_packet_location = cpu_to_le32(sizeof(struct txpd));
-- 
2.30.2

