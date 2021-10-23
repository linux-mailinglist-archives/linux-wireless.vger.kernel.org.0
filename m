Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63E94380E9
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJWAR5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 20:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhJWAR4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 20:17:56 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C730C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:15:38 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y17so6008617ilb.9
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9ORmS1dO8SuldvD0/ZRIyUsib3Tewtp8ApJ782fc1U=;
        b=absZNuSavcRd9hFcevT6emaDKSG8wtfLFMerRKOKla/zVc6v/J4qxigjZluSQ3ynU4
         kDv5UsLiSYDy2uVXTqesHTKuw6CgZGkG2tQGRq28mDV7UBz1+11TtVlD4k+jCnCiq9Mg
         hDcB8S61yzFnB+rIKwNpeHv/EzZxlD+q7uaE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9ORmS1dO8SuldvD0/ZRIyUsib3Tewtp8ApJ782fc1U=;
        b=niYbLM03TVA+gQgyue/Pd+8meXP2OzADYyn+MxWihfFd6SOEu4e+chW+TxSWXjKeXO
         w7OsPbBTIuF2zJqR/zPAmFsoQl/H2O2VrolqgO6gVIRFfDX1TkDlzQYBS5pAtAsTqptu
         RE+uKwL4U1mSn4TRTX/4umG8m/90ucKaXo1wZ42w1ONm7JVENFVfjEKSN05G4P/YvF+l
         Ze2n148rqacrVLlpzYCNAVPmPfhxsOCs+X7vfJBa0V4jc/6Wpq3qBoG7VYbun0GoKUrL
         cpU+lc4NrgGmv3d9/7NLAOzkDBOJSTA4+ChPmRo4UBsr4/iSMqNcrCpQumlOeQPlbILe
         2sRQ==
X-Gm-Message-State: AOAM531bpCjdHrOOLB9rJcPAf0NGP+0DszsVh6eX5FZ21pzuCjQN9N0l
        sb8dpTVIYHEVreYYbBbHO7ixig==
X-Google-Smtp-Source: ABdhPJzm6lmLwjNE7zydTOwh4obyR6RBh+o4bvDiFHSJIzfmjyCiF7J9Ljc3+t9fqZntit/pR0C4qQ==
X-Received: by 2002:a05:6e02:148d:: with SMTP id n13mr1879199ilk.238.1634948136232;
        Fri, 22 Oct 2021 17:15:36 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id e14sm5223287ioe.37.2021.10.22.17.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 17:15:35 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Eugene Krasnikov <k.eugene.e@gmail.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wcn36xx: add proper DMA memory barriers in rx path
Date:   Fri, 22 Oct 2021 17:15:28 -0700
Message-Id: <20211023001528.3077822-1-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is essentially exactly following the dma_wmb()/dma_rmb() usage
instructions in Documentation/memory-barriers.txt.

The theoretical races here are:

1. DXE (the DMA Transfer Engine in the Wi-Fi subsystem) seeing the
dxe->ctrl & WCN36xx_DXE_CTRL_VLD write before the dxe->dst_addr_l
write, thus performing DMA into the wrong address.

2. CPU reading dxe->dst_addr_l before DXE unsets dxe->ctrl &
WCN36xx_DXE_CTRL_VLD. This should generally be harmless since DXE
doesn't write dxe->dst_addr_l (no risk of freeing the wrong skb).

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 8e1dbfda6538..93994b2e8e03 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -613,6 +613,10 @@ static int wcn36xx_rx_handle_packets(struct wcn36xx *wcn,
 	dxe = ctl->desc;
 
 	while (!(READ_ONCE(dxe->ctrl) & WCN36xx_DXE_CTRL_VLD)) {
+		/* do not read until we own DMA descriptor */
+		dma_rmb();
+
+		/* read/modify DMA descriptor */
 		skb = ctl->skb;
 		dma_addr = dxe->dst_addr_l;
 		ret = wcn36xx_dxe_fill_skb(wcn->dev, ctl, GFP_ATOMIC);
@@ -623,9 +627,15 @@ static int wcn36xx_rx_handle_packets(struct wcn36xx *wcn,
 			dma_unmap_single(wcn->dev, dma_addr, WCN36XX_PKT_SIZE,
 					DMA_FROM_DEVICE);
 			wcn36xx_rx_skb(wcn, skb);
-		} /* else keep old skb not submitted and use it for rx DMA */
+		}
+		/* else keep old skb not submitted and reuse it for rx DMA
+		 * (dropping the packet that it contained)
+		 */
 
+		/* flush descriptor changes before re-marking as valid */
+		dma_wmb();
 		dxe->ctrl = ctrl;
+
 		ctl = ctl->next;
 		dxe = ctl->desc;
 	}
-- 
2.25.1

