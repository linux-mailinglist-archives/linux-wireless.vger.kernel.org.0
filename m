Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED291EE9FB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 19:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgFDR70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgFDR7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 13:59:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF4C08C5C1
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 10:59:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so3862713pgm.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2020 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qJ1KmR7n31K99rmmaGKTiex9LAFKCkmBxAmhTYhJxo=;
        b=O25wYAeOqYLKutlDyi60xIlbTuDdCOT5e2XYNOsNGhC4B+NaMg3VxpH/LIFlYcKegJ
         T2d7Nsibm7xBSN7jaERDrF77NKlRLBhUJZhYCNyaOF8giEp3RryXOHyVxA+KlQtlUkqU
         MR3J/581kbOBBRQlO36Kq+wpxgAQjeV+sg00s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qJ1KmR7n31K99rmmaGKTiex9LAFKCkmBxAmhTYhJxo=;
        b=Cg3hvNm6NXUyA3MV062svFa6GzU8nz7fLWdciJqPxe5v5Kqi2ogtNpb6yA04VVR73l
         3Y9U+iIqJLmg+0W4OPZJWapxlGrF8Rq3ctFsfpC0ETlsL5Rl5aACYsEgwLR9GTa7mQE6
         Q2xaaPBGAXpe6HjWFQqG6ZMZY/Iwzcn5rYE+wtF1endZmqblo+t3WO0IFWyDXm8F7Rkj
         QKYFTWHch33e4M3+8RQiES/UQ9wN2a7joy/EHPDRt8TsOLhTO6txyVyIj3y/a2K+e4Mf
         C9dJnnfAe3VV1FmQHSt4IONjYSu5KxfupGWfGxy/Lfdpkd8CJMYeR/QYsgEvGEiIg+5b
         nIRg==
X-Gm-Message-State: AOAM5319FmFmaM2nEKUAPaJBKJ3XFR5HGbBdu4lPybwVhGZDSJ2ekL8e
        BOsmWXDvzFoi1hKl/X6jQImxNQ==
X-Google-Smtp-Source: ABdhPJy8aqjpj6isz3vL3kGOUE53Wgd2Jl+2f1JtJGfWBzh0MNQ1ovSw5R16ThJEKXvXpFgxlTMkiA==
X-Received: by 2002:a63:454c:: with SMTP id u12mr5625732pgk.153.1591293563926;
        Thu, 04 Jun 2020 10:59:23 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:1c5a:73fa:6d5a:5a3c])
        by smtp.gmail.com with ESMTPSA id q13sm2568927pfk.8.2020.06.04.10.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jun 2020 10:59:23 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kuabhs@google.com.org, sujitka@chromium.org,
        Evan Green <evgreen@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Govind Singh <govinds@qti.qualcomm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Kazior <michal.kazior@tieto.com>,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] ath10k: Acquire tx_lock in tx error paths
Date:   Thu,  4 Jun 2020 10:59:11 -0700
Message-Id: <20200604105901.1.I5b8b0c7ee0d3e51a73248975a9da61401b8f3900@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_htt_tx_free_msdu_id() has a lockdep assertion that htt->tx_lock
is held. Acquire the lock in a couple of error paths when calling that
function to ensure this condition is met.

Fixes: 6421969f248fd ("ath10k: refactor tx pending management")
Fixes: e62ee5c381c59 ("ath10k: Add support for htt_data_tx_desc_64
descriptor")
Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/net/wireless/ath/ath10k/htt_tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index e9d12ea708b62..e8c00af2cce1d 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1545,7 +1545,9 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 err_unmap_msdu:
 	dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 err_free_msdu_id:
+	spin_lock_bh(&htt->tx_lock);
 	ath10k_htt_tx_free_msdu_id(htt, msdu_id);
+	spin_unlock_bh(&htt->tx_lock);
 err:
 	return res;
 }
@@ -1752,7 +1754,9 @@ static int ath10k_htt_tx_64(struct ath10k_htt *htt,
 err_unmap_msdu:
 	dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 err_free_msdu_id:
+	spin_lock_bh(&htt->tx_lock);
 	ath10k_htt_tx_free_msdu_id(htt, msdu_id);
+	spin_unlock_bh(&htt->tx_lock);
 err:
 	return res;
 }
-- 
2.24.1

