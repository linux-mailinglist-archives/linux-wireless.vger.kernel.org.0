Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7695E8019
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 07:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbfJ2GM0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 02:12:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfJ2GM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 02:12:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3B4660D7C; Tue, 29 Oct 2019 06:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572329546;
        bh=2ORAqQGNkhzSfKv/lvYtprmI8CrPEWdo6MCV7KCcFHY=;
        h=From:To:Cc:Subject:Date:From;
        b=WmBINUH59ym91m0NB7HBM80ibk39UGQqpvwCi7MKjk/bO8XkJ+FbwiUyW87x6yDif
         pF09h6rOYbLQo5IeIS2ilWsJIB01bYG9q8vpqkTIpCSjqQAJFnUulD+j3BYlfSllIr
         wvZ8FQdMg5kC5QhifDhJ3lHeyo+9Bh4t4wNR2zFo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4695C607C3;
        Tue, 29 Oct 2019 06:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572329545;
        bh=2ORAqQGNkhzSfKv/lvYtprmI8CrPEWdo6MCV7KCcFHY=;
        h=From:To:Cc:Subject:Date:From;
        b=OiEOL4UJZtHt0pmTX5Ub99vakOwObI1HMmEN1CLLApgKuBLvbZGWfGQ/hTf0u6Agq
         +TIgOdLXzwwnxOJ+viOX2U8Xp3m43irsp3tjyemarS+1w9k6tzCOjWRCjAMnOeg4kA
         a+myYcO31RAJH497MTnGpSEbJAVKvJYpk7/lOzbw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4695C607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Tue, 29 Oct 2019 14:12:19 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        Hou Bao Hou <houbao@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath10k: fix get invalid tx rate for Mesh metric
Date:   Tue, 29 Oct 2019 14:12:17 +0800
Message-Id: <1572329537-27728-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k does not provide transmit rate info per MSDU
in tx completion, mark that as -1 so mac80211
will ignore the rates. This fixes mac80211 update Mesh
link metric with invalid transmit rate info.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00035

Signed-off-by: Hou Bao Hou <houbao@codeaurora.org>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 4102df0..39abf8b 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -95,6 +95,8 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
+	info->status.rates[0].idx = -1;
+
 	trace_ath10k_txrx_tx_unref(ar, tx_done->msdu_id);
 
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
-- 
1.9.1

