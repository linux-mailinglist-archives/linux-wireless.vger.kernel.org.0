Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153FC23A974
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgHCPdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 11:33:52 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51543 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgHCPdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 11:33:51 -0400
Received: from legolas.tu-ilmenau.de (unknown [141.24.111.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 96149580061;
        Mon,  3 Aug 2020 17:33:47 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 4/4] iw: handle more mesh station info
Date:   Mon,  3 Aug 2020 17:33:36 +0200
Message-Id: <20200803153336.319773-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803153336.319773-1-markus.theil@tu-ilmenau.de>
References: <20200803153336.319773-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 station.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/station.c b/station.c
index f8600b7..b2c5b9c 100644
--- a/station.c
+++ b/station.c
@@ -328,6 +328,9 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		[NL80211_STA_INFO_TX_DURATION] = { .type = NLA_U64 },
 		[NL80211_STA_INFO_ACK_SIGNAL] = {.type = NLA_U8 },
 		[NL80211_STA_INFO_ACK_SIGNAL_AVG] = { .type = NLA_U8 },
+		[NL80211_STA_INFO_AIRTIME_LINK_METRIC] = { .type = NLA_U32 },
+		[NL80211_STA_INFO_CONNECTED_TO_AS] = { .type = NLA_FLAG },
+		[NL80211_STA_INFO_CONNECTED_TO_GATE] = { .type = NLA_FLAG },
 	};
 	char *chain;
 	struct timeval now;
@@ -497,6 +500,18 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		}
 		printf("\n\tmesh plink:\t%s", state_name);
 	}
+	if (sinfo[NL80211_STA_INFO_AIRTIME_LINK_METRIC])
+		printf("\n\tmesh airtime link metric: %d",
+			nla_get_u32(sinfo[NL80211_STA_INFO_AIRTIME_LINK_METRIC]));
+	if (sinfo[NL80211_STA_INFO_CONNECTED_TO_GATE])
+		printf("\n\tmesh connected to gate:\t%s",
+			nla_get_u8(sinfo[NL80211_STA_INFO_CONNECTED_TO_GATE]) ?
+			"yes" : "no");
+	if (sinfo[NL80211_STA_INFO_CONNECTED_TO_AS])
+		printf("\n\tmesh connected to auth server:\t%s",
+			nla_get_u8(sinfo[NL80211_STA_INFO_CONNECTED_TO_AS]) ?
+			"yes" : "no");
+
 	if (sinfo[NL80211_STA_INFO_LOCAL_PM]) {
 		printf("\n\tmesh local PS mode:\t");
 		print_power_mode(sinfo[NL80211_STA_INFO_LOCAL_PM]);
-- 
2.28.0

