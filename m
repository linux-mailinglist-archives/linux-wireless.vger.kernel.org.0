Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857A4432A7E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhJRXwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhJRXwl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09509610FB;
        Mon, 18 Oct 2021 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601030;
        bh=RRGS3Z7RNEHcCPZWMqyWim5nDZFB2OyvLivHgEivPwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoMS3iEiHokuGRUfsmAw+Pm064fRjhFz+2OKC9Oo9QMLRX0GM95ShDEF45NMenfsz
         EGUUH+6lI2x7ZNjuM3VnF3tcoPDoS8pK4o4x/wKW94dxLzkqm0PKkJfenb+BXAm/2z
         Eu2hJ0f+2d/qIpVk7TKtHzY+AHqAtgV08eVNNTXQXDorP1LRPDpVn3MCieh/G0f8Vo
         NOIBf92MPEBuWxtGiZmguTjYmg6vZZrPg1RvSuX+l5BJfWiFv3qCudVWEZ8GWmVOgz
         xob83JG8kUS8QuTJE2rkTCtXc+65oBL6Pqcit+iu4CkKGSNSl8mEAkxYw2Q9uYwxFY
         i1WBgKukxOBhQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        stas.yakovlev@gmail.com
Subject: [PATCH 09/15] wireless: ipw2200: prepare for const netdev->dev_addr
Date:   Mon, 18 Oct 2021 16:50:15 -0700
Message-Id: <20211018235021.1279697-10-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018235021.1279697-1-kuba@kernel.org>
References: <20211018235021.1279697-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

netdev->dev_addr will be come const soon, constify the argument
to command send to avoid compiler warnings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: stas.yakovlev@gmail.com
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 0a38d17744a9..23037bfc9e4c 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -199,7 +199,7 @@ static int ipw_queue_tx_reclaim(struct ipw_priv *priv,
 				struct clx2_tx_queue *txq, int qindex);
 static int ipw_queue_reset(struct ipw_priv *priv);
 
-static int ipw_queue_tx_hcmd(struct ipw_priv *priv, int hcmd, void *buf,
+static int ipw_queue_tx_hcmd(struct ipw_priv *priv, int hcmd, const void *buf,
 			     int len, int sync);
 
 static void ipw_tx_queue_free(struct ipw_priv *);
@@ -2264,7 +2264,7 @@ static int ipw_send_cmd_simple(struct ipw_priv *priv, u8 command)
 }
 
 static int ipw_send_cmd_pdu(struct ipw_priv *priv, u8 command, u8 len,
-			    void *data)
+			    const void *data)
 {
 	struct host_cmd cmd = {
 		.cmd = command,
@@ -5033,7 +5033,7 @@ static int ipw_queue_tx_reclaim(struct ipw_priv *priv,
 	return used;
 }
 
-static int ipw_queue_tx_hcmd(struct ipw_priv *priv, int hcmd, void *buf,
+static int ipw_queue_tx_hcmd(struct ipw_priv *priv, int hcmd, const void *buf,
 			     int len, int sync)
 {
 	struct clx2_tx_queue *txq = &priv->txq_cmd;
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 98fe62737888..55cac934f4ee 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1945,7 +1945,7 @@ struct host_cmd {
 	u8 cmd;
 	u8 len;
 	u16 reserved;
-	u32 *param;
+	const u32 *param;
 } __packed;	/* XXX */
 
 struct cmdlog_host_cmd {
-- 
2.31.1

