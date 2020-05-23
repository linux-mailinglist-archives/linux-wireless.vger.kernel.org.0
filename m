Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6984D1DFB2B
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 23:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbgEWV0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 May 2020 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbgEWV0h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 May 2020 17:26:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86360C061A0E
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 14:26:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y189so13330337ybc.14
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TrTjVo1OcoXHUCoJ8HjrgU12KCu7XFLQYbdnxvd251Y=;
        b=HLAhLxlvXnsfpG/KopUm9p5Je1BoyxhAuZlSqyLMcwVqB04pQDZm1PICjxrts0ozAV
         pEaYPWD7lan8aisHjsHqetSginIqCu17tn204RPBK/wcI3c4S9GzQMD73FujWAg7Uhfx
         e9ZjpVkmbIzmD/nM39awkYguZRJTkiLCxVgLmZDYRNmuCnVO7FfSwLJTs2VAWVzrDFZ3
         C9zvAlKr7rtl2kMHsnFqzrKcc00W1kPCf6TSB6iEeqic5i8br02wB+MW50rirfLpOkgW
         97BkPoG5Zz3Fsa9Mq2NYpwZNby+BqRvmp9QqPzMfteo6uw+9TMechD1BY6K7d7oFAOVx
         0fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TrTjVo1OcoXHUCoJ8HjrgU12KCu7XFLQYbdnxvd251Y=;
        b=s5m+YRe+DEhdCmIfw/mzKLhfeIvqUmp2+VYM0DUniWIM99xQc/KtEjqSur1agEB1Ip
         RiYm4lY5vB+JqzG8Shsx08O5j5Z8R46IXvxi4UEF+m2KmJpV6giHMwyMqxC/oQlg13zI
         gGsjF/IUE7fGUK9l8BeaB11zcTj08I02v5xo2F9pfDW7en6mA+a/QqZ9FEqO/DWfiWyi
         s1Lv3bgy8TRiYin9yvpdfhHY9XtToJX18YZbJSADJab83DozkHAMVrWxoKSEsuhw7Yhg
         q/ukK63PBb34m31AMEu67i6WQ+WRaQjY1UCqO8kVKgF161vvUPaeIxgvGpbzt/ZEqmJr
         3tNQ==
X-Gm-Message-State: AOAM531RObtbBtUEs/259gHbENlxTNCyhnedKooZCoqHGaN//YC+hX+9
        9mb7QF4g4l/6GKlE+221V0KZbAFzMHK4
X-Google-Smtp-Source: ABdhPJxwW3ZnH52iCl4gZeP+CKsgfEGyKLlyuNnzeWwOEkG/Bs9soUUIFZHHEM2v0y3jaM4HUlricKQ4+sC8
X-Received: by 2002:a25:a508:: with SMTP id h8mr14282492ybi.219.1590269195703;
 Sat, 23 May 2020 14:26:35 -0700 (PDT)
Date:   Sat, 23 May 2020 22:26:28 +0100
Message-Id: <20200523212628.31526-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] libertas: Use shared constant for rfc1042 header
From:   Pascal Terjan <pterjan@google.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is one of the 9 drivers redefining rfc1042_header.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/net/wireless/marvell/libertas/rx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/rx.c b/drivers/net/wireless/marvell/libertas/rx.c
index 58a1fc433b73..f28aa09d1f9e 100644
--- a/drivers/net/wireless/marvell/libertas/rx.c
+++ b/drivers/net/wireless/marvell/libertas/rx.c
@@ -62,9 +62,6 @@ int lbs_process_rxed_packet(struct lbs_private *priv, struct sk_buff *skb)
 	struct rxpd *p_rx_pd;
 	int hdrchop;
 	struct ethhdr *p_ethhdr;
-	static const u8 rfc1042_eth_hdr[] = {
-		0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
-	};
 
 	BUG_ON(!skb);
 
@@ -102,7 +99,7 @@ int lbs_process_rxed_packet(struct lbs_private *priv, struct sk_buff *skb)
 		sizeof(p_rx_pkt->eth803_hdr.src_addr));
 
 	if (memcmp(&p_rx_pkt->rfc1042_hdr,
-		   rfc1042_eth_hdr, sizeof(rfc1042_eth_hdr)) == 0) {
+		   rfc1042_header, sizeof(rfc1042_header)) == 0) {
 		/*
 		 *  Replace the 803 header and rfc1042 header (llc/snap) with an
 		 *    EthernetII header, keep the src/dst and snap_type (ethertype)
-- 
2.27.0.rc0.183.gde8f92d652-goog

