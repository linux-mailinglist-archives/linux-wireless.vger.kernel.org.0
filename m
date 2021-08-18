Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536CA3EFB07
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 08:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbhHRGIL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 02:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbhHRGHE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 02:07:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB186C0611BC
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q2so1141002pgt.6
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LapL5yxDWiBgMKBil8lhP+Lg9k+myZeJSwfalBUcUx8=;
        b=EyV8N+h5/qyo62GfblZWCLiKR4eLvkF2lwBdydMvJLd79rKTZu8UshzV8ihU7RNjv0
         rctTsHty3W+9m8LDSzHijAG+TC/Ts7wu5ImOI6E+4Ga8+rVEP+XxnN8jyVallKHpp5vX
         +sqLYz4PaKZ6WvHaqEZR3B1UL1j8EZKOZFXvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LapL5yxDWiBgMKBil8lhP+Lg9k+myZeJSwfalBUcUx8=;
        b=hiwF1werD25xkLc1bpjTAHe/NpURZraUC6MMc7QfsVlRP6RVt1urJWH90NSD4ugIdJ
         NJpSdCFhyJQSewI0vavAqA4h+N87HmqZ9ujmm8ZjCsjBNtBGyiBubAr9hHtbSyyeJPEc
         4qcrdv6DMOCatx5mghSsh/s7OZB9rH3iDHGwxhAKddE3j5N8LA9DlNVz+tGT4TlQUMYq
         ihrx6a5Wdq2wBzdsKDenOhWfMK7FluAK8OjyCSY7XBQdNNuZhdxIpmtOOYadsH3rjCSr
         PKRzzJOMxuQCj9dL82zQI0fVsmy/EQmYz7lN8KjS7GC+UuUPcRucLnjK9T4a4DInnZ7c
         0DGQ==
X-Gm-Message-State: AOAM533k92Ml7eGmvuKU2+sekLbmuFSPk524GR/EhLEg0+dz8SrIibJX
        r4+B1zHEq+ogpaezmYADnjLmog==
X-Google-Smtp-Source: ABdhPJzjIn36vE/ZNxQmXbOkL9OlqazGYoiVh/BsuZoov9E3aMeRGON42rz5oMitHJsTT64wX9Kjyg==
X-Received: by 2002:a65:6a09:: with SMTP id m9mr7183122pgu.269.1629266757255;
        Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x12sm4588648pfu.21.2021.08.17.23.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 10/63] libertas: Use struct_group() for memcpy() region
Date:   Tue, 17 Aug 2021 23:04:40 -0700
Message-Id: <20210818060533.3569517-11-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; h=from:subject; bh=G7UVOub35WzvknmEHL7Jl7Jxuvzi8CX0QzWk7fVBrqQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMgWGY2S69iC9ODdZ0M8ZsaWVpql5uriqr4eine F4MboIKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIAAKCRCJcvTf3G3AJteQD/ 4r/L3852/rievd/HCtjIVJUoMOZz6SUoEoguqPYoCiczPpPpeKpJMB8uDD+k8S+pjXMuj6JicBICkI f2K0BDnJV4RbCkdpX2ThRmuC56nyfipIvGvFDigW3cXSGgwsbz+sMvZSBqlf3A1pleXAcEQPpEUoyC RaID84Ddzy1AYdiBi9pz6CgTIdaBUM1LkjP4wcrm0FoXf/cEt0LD4tmk4nHyV6lwvqed6AmtCyY9rU dkA6Dt54qMzRZnzJqBiq7ljl7L68N1be8kdp5LUpxq2Yyn0BE0ppZwnBgQtsTuzQfHJUcpTCLehjQ3 Danq5E5Wyx2wmZ7Dv35hsZ6+k0amIxW5DOQmts0adAHyTFUL3anYRSSQE/rKeQnfiedqVGfcZYGtUG U+uc+d0Zvs3Fa+Fx2t0fK0QcbvU90pwzNkIOW+T5Ohsw9d9Dq/azQaih3qPlTLdjjD8tLTboKMAaq0 hBeX108f8oS+tPAyr9Si5SDMTQ53AQcZXq5mYhf1zvsBBwERro7eooHHOnz7tjbQ/qKu4Si4UdGOjY 2oczS0+eITr2B5b9x+s3d/Ajm+ddM80FRaxskj0xOZ4KqteU578zDbWR6ZKyyOCWHiGHtWU56VNIpE IUv57AbMXBi9rAtXby90zuCBN5nHMWxPrySRevP8u1bKfuHgTRdHaYeaYxZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct txpd around members tx_dest_addr_high
and tx_dest_addr_low so they can be referenced together. This will
allow memcpy() and sizeof() to more easily reason about sizes, improve
readability, and avoid future warnings about writing beyond the end
of queue_id.

"pahole" shows no size nor member offset changes to struct txpd.
"objdump -d" shows no object code changes.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: libertas-dev@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/libertas/host.h | 10 ++++++----
 drivers/net/wireless/marvell/libertas/tx.c   |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/host.h b/drivers/net/wireless/marvell/libertas/host.h
index dfa22468b14a..af96bdba3b2b 100644
--- a/drivers/net/wireless/marvell/libertas/host.h
+++ b/drivers/net/wireless/marvell/libertas/host.h
@@ -308,10 +308,12 @@ struct txpd {
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
diff --git a/drivers/net/wireless/marvell/libertas/tx.c b/drivers/net/wireless/marvell/libertas/tx.c
index aeb481740df6..27304a98787d 100644
--- a/drivers/net/wireless/marvell/libertas/tx.c
+++ b/drivers/net/wireless/marvell/libertas/tx.c
@@ -113,6 +113,7 @@ netdev_tx_t lbs_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	p802x_hdr = skb->data;
 	pkt_len = skb->len;
 
+	BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
 	if (priv->wdev->iftype == NL80211_IFTYPE_MONITOR) {
 		struct tx_radiotap_hdr *rtap_hdr = (void *)skb->data;
 
@@ -124,10 +125,10 @@ netdev_tx_t lbs_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		pkt_len -= sizeof(*rtap_hdr);
 
 		/* copy destination address from 802.11 header */
-		memcpy(txpd->tx_dest_addr_high, p802x_hdr + 4, ETH_ALEN);
+		memcpy(&txpd->tx_dest_addr, p802x_hdr + 4, ETH_ALEN);
 	} else {
 		/* copy destination address from 802.3 header */
-		memcpy(txpd->tx_dest_addr_high, p802x_hdr, ETH_ALEN);
+		memcpy(&txpd->tx_dest_addr, p802x_hdr, ETH_ALEN);
 	}
 
 	txpd->tx_packet_length = cpu_to_le16(pkt_len);
-- 
2.30.2

