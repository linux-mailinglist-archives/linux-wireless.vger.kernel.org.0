Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6771F395E6
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfFGTkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 15:40:06 -0400
Received: from gateway30.websitewelcome.com ([192.185.160.12]:28463 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729809AbfFGTkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 15:40:06 -0400
X-Greylist: delayed 1336 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 15:40:05 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 3200A10295
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2019 14:17:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZKN3hJcKj4FKpZKN3hd8lT; Fri, 07 Jun 2019 14:17:49 -0500
X-Authority-Reason: nr=8
Received: from [189.250.134.24] (port=48016 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hZKN1-002mT3-Kl; Fri, 07 Jun 2019 14:17:48 -0500
Date:   Fri, 7 Jun 2019 14:17:45 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] qtnfmac: Use struct_size() in kzalloc()
Message-ID: <20190607191745.GA19120@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.134.24
X-Source-L: No
X-Exim-ID: 1hZKN1-002mT3-Kl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.134.24]:48016
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct ieee80211_regdomain {
	...
        struct ieee80211_reg_rule reg_rules[];
};

instance = kzalloc(sizeof(*mac->rd) +
                          sizeof(struct ieee80211_reg_rule) *
                          count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, reg_rules, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 459f6b81d2eb..dc0c7244b60e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1011,9 +1011,8 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 	if (WARN_ON(resp->n_reg_rules > NL80211_MAX_SUPP_REG_RULES))
 		return -E2BIG;
 
-	mac->rd = kzalloc(sizeof(*mac->rd) +
-			  sizeof(struct ieee80211_reg_rule) *
-			  resp->n_reg_rules, GFP_KERNEL);
+	mac->rd = kzalloc(struct_size(mac->rd, reg_rules, resp->n_reg_rules),
+			  GFP_KERNEL);
 	if (!mac->rd)
 		return -ENOMEM;
 
-- 
2.21.0

