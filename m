Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F024CEEF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHUHTw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgHUHSY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A8C0612F3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w13so694204wrk.5
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GcXWK42EOat9gpnv8yfBhBVK1TNbXyjHRD+03gi2Dk=;
        b=zKIGuyNS9dEpgui3o1oAewVdt7OZLZGMe4NfJiyTtqzGaBaiFU/KqDyDWUPAMxtUhT
         hrmQQAQAe/ON2srwrzflXkvaBBAP6AFcaSY7svkz+oazdd3o+xdVZlPXvR6m+rkYZzli
         BVV1p+m6HBVNJxlCnSdqYwVKv70l5WkNoDiR4grhO1LqVYLv1IIDOtwwwVXREwTLfSQj
         jfO0aeuOLn3k0QTp8Ei+/ntORcg/UHjP3uHxFS6Zn3mN4vaKZQ7yw1l+MStMtNokpFfB
         FrjyH9aNTzZJCdnU0MwBvVq61+OnYAYpibR1NvR36gN5AlkjOGiguVkkqeVRcjqYnWIn
         KiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GcXWK42EOat9gpnv8yfBhBVK1TNbXyjHRD+03gi2Dk=;
        b=AxzKRbOGp9u84ywYiTMjKhQ9JtGX+XQQ/bYFkhawN8vTWktWWCn4Sjoob8gFHaadEM
         xhQYcZTh2vl+PgpNs3PM575ecsm+Y3xBEaptvqYV6jUDttZ5xBO55BrYCEVGZEQ5p6iv
         q14JgzuVruTjITtarWzeUq8s7F6v2G83ujJcrgHJzJ330UsvnlK/EV6LNLYneQhxWuQI
         CVPI7JC+297GqDVnl3xNaZ2JfOcuGZp0q+f4/8LYz+vFcc+2GWmt7+iSBe+cxTi1MRuW
         KrNBn+8j5R2FINR4u3Mi3RWB5D2FEuQ0AfFyXLTgN+io6E8fVOC9ESBaWStK37f13IgT
         tGCg==
X-Gm-Message-State: AOAM532AXpN4wAhPq4BO+ZNga3rttLCt5zjxHVMRIPj9ScB3wU7vAoV7
        A5YXf5yzD2ODhncbzCbP+JwLtA==
X-Google-Smtp-Source: ABdhPJyno6qESJCJyD/bb2OUFMm5wB39EeK0xwRj1yRHwjS8+ZfoYNIIYaKpFzBo/7N0ZNP3x9pv1Q==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr1424734wrg.100.1597994243109;
        Fri, 21 Aug 2020 00:17:23 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 28/32] wireless: ath: wil6210: txrx_edma: Demote comments which are clearly not kernel-doc
Date:   Fri, 21 Aug 2020 08:16:40 +0100
Message-Id: <20200821071644.109970-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/txrx_edma.c:155: warning: Function parameter or member 'wil' not described in 'wil_ring_alloc_skb_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:155: warning: Function parameter or member 'ring' not described in 'wil_ring_alloc_skb_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:155: warning: Function parameter or member 'i' not described in 'wil_ring_alloc_skb_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1161: warning: Function parameter or member 'wil' not described in 'wil_tx_sring_handler'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1161: warning: Function parameter or member 'sring' not described in 'wil_tx_sring_handler'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'd' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'tso_desc_type' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'is_ipv4' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'tcp_hdr_len' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'skb_net_hdr_len' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'mss' not described in 'wil_tx_desc_offload_setup_tso_edma'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 7bfe867c7509e..1eb1a309a0264 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -147,7 +147,7 @@ static int wil_tx_init_edma(struct wil6210_priv *wil)
 	return rc;
 }
 
-/**
+/*
  * Allocate one skb for Rx descriptor RING
  */
 static int wil_ring_alloc_skb_edma(struct wil6210_priv *wil,
@@ -1152,7 +1152,7 @@ wil_get_next_tx_status_msg(struct wil_status_ring *sring, u8 *dr_bit,
 	*msg = *_msg;
 }
 
-/**
+/*
  * Clean up transmitted skb's from the Tx descriptor RING.
  * Return number of descriptors cleared.
  */
@@ -1314,7 +1314,7 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 	return desc_cnt;
 }
 
-/**
+/*
  * Sets the descriptor @d up for csum and/or TSO offloading. The corresponding
  * @skb is used to obtain the protocol and headers length.
  * @tso_desc_type is a descriptor type for TSO: 0 - a header, 1 - first data,
-- 
2.25.1

