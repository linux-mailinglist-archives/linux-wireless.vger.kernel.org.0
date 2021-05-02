Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197B2370F01
	for <lists+linux-wireless@lfdr.de>; Sun,  2 May 2021 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhEBU0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 May 2021 16:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhEBU0n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 May 2021 16:26:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99324C06138C
        for <linux-wireless@vger.kernel.org>; Sun,  2 May 2021 13:25:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so3445598wrt.12
        for <linux-wireless@vger.kernel.org>; Sun, 02 May 2021 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/eu7kgNtJZe/1oOgUEnuMm1GqJELkQ9s+3GmmlSYH+0=;
        b=tbSES2wRqLuavw6TWwOyV7YmdMPndtIRlYALMCDtKnrEPhCMBx9omsg3ErYwiujQDC
         5CPTM/vQ1bbZYXwC76EGb0AHkNk9zHLEnl+vGFRk2gG2HczE1hsV3SKSNFOmOlbr5oHv
         uGtUXATgCEgdTZZIbZ19MjTv8jfhbivfqKw/meTmLuiQwxsh/EyapG2kKrwh91ZJWv3V
         pKUfS+64CqaITVNp3dLCzoXD5grZOBIw+0MZcgrj2Cg6/EbMpSvZm4ElfkSH90cl+A2s
         xtSO5tP/LsasZy7En3D1uozL7a3aXjl9zFNmSxWOCkrrTHkqjpIt2DK4/Dvorl0X6mPt
         3ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/eu7kgNtJZe/1oOgUEnuMm1GqJELkQ9s+3GmmlSYH+0=;
        b=QoOfBW5JUR8M/+oV3wlSonTqdhASffF+TdTGR5Wj+eA8s4zj87VpmMUYVpCaBBKjRC
         1eZj99+nz/dg5RNiXdq6+MNEWoT/43/ccvblx5AxkCQWqZkzbQMhCvnemnpXc1PVQeHP
         yhIwX4/Vw+DNX6iUn4av00ZfoIQt02AAheTusxlyvsaORp57iaJUj+qcp9vWsfjGaSZ9
         Xh11HJZB6Qgh3KCGdxmGCM2lBTGfslbaEBEeKkbdKCYlri1veEqBMybu6qzuBvQvqDIS
         YRe9rIN9l+RmB3I3vgAYl0UHlatDVKQnwBcJZ0pFEg7OA/C+9EbkamsLPhbtWEdIWdRG
         ovcg==
X-Gm-Message-State: AOAM531mg5jNyQxpZXYDAUO3pPc405sqedqI6Ze2Rp9IDFk1ml4Zno+k
        8A9nkv8x/WQzDznq9kNRxMat0etxT9T9Q9lg
X-Google-Smtp-Source: ABdhPJzXrgxWuq+BZ8rpJinVP45pWN/Y5dpFdZkyEjP3UWtzqfbRFQDxdSqPp2cv21L+DEChpQGUaA==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr19820976wrr.54.1619987149085;
        Sun, 02 May 2021 13:25:49 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id z6sm9402343wmf.9.2021.05.02.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 13:25:48 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     kvalo@codeaurora.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH] ath9k: ath9k_htc_rx_msg: return when sk_buff is too small
Date:   Sun,  2 May 2021 21:25:45 +0100
Message-Id: <20210502202545.1405-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At the start of ath9k_htc_rx_msg, we check to see if the skb pointer is
valid, but what we don't do is check if it is large enough to contain a
valid struct htc_frame_hdr. We should check for this and return, as the
buffer is invalid in this case. Fixes a KMSAN-found uninit-value bug
reported by syzbot at:
https://syzkaller.appspot.com/bug?id=7dccb7d9ad4251df1c49f370607a49e1f09644ee

Reported-by: syzbot+e4534e8c1c382508312c@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 510e61e97dbc..9dbfff7a388e 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -403,7 +403,7 @@ void ath9k_htc_rx_msg(struct htc_target *htc_handle,
 	struct htc_endpoint *endpoint;
 	__be16 *msg_id;
 
-	if (!htc_handle || !skb)
+	if (!htc_handle || !skb || !pskb_may_pull(skb, sizeof(struct htc_frame_hdr)))
 		return;
 
 	htc_hdr = (struct htc_frame_hdr *) skb->data;
-- 
2.30.2

