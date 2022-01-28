Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077A49F965
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbiA1MbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:20 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37826 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348426AbiA1MbT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:19 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPN-0002A0-1h;
        Fri, 28 Jan 2022 14:31:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:54 +0200
Message-Id: <iwlwifi.20220128142706.6d9fcf82691e.I449b1e21c5b5478f2ac218522570479918f49f9d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 5/8] iwlwifi: mei: fix the pskb_may_pull check in ipv4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The check makes sure that we can look at the ip header.
We first need to check that the basic ip header (20 bytes)
can be pulled before we look at the field that will teach
us how long is the ip header. This is why there are two
checks.

The second check was wrong and smatch pointed that
sizeof(ip_hdrlen(skb) - sizeof(*iphdr)) can't be right.

Looking at the code again made me think that we really
need ip_hdrlen(skb) since we want to make sure all the
IP header is in the buffer header. This will allow us
to set the transport offset and from there to look
at the transport header (TCP / UDP).

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/net.c b/drivers/net/wireless/intel/iwlwifi/mei/net.c
index 5f966af69720..468102a95e1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/net.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
@@ -195,8 +195,7 @@ static bool iwl_mei_rx_filter_ipv4(struct sk_buff *skb,
 	bool match;
 
 	if (!pskb_may_pull(skb, skb_network_offset(skb) + sizeof(*iphdr)) ||
-	    !pskb_may_pull(skb, skb_network_offset(skb) +
-			   sizeof(ip_hdrlen(skb) - sizeof(*iphdr))))
+	    !pskb_may_pull(skb, skb_network_offset(skb) + ip_hdrlen(skb)))
 		return false;
 
 	iphdrlen = ip_hdrlen(skb);
-- 
2.34.1

