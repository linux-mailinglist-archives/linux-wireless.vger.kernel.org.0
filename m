Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304FF23A972
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHCPdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 11:33:49 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51538 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgHCPdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 11:33:49 -0400
Received: from legolas.tu-ilmenau.de (unknown [141.24.111.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 8D5B458005E;
        Mon,  3 Aug 2020 17:33:47 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/4] iw: handle all chan width cases
Date:   Mon,  3 Aug 2020 17:33:34 +0200
Message-Id: <20200803153336.319773-2-markus.theil@tu-ilmenau.de>
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
 measurements.c | 5 +++++
 util.c         | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/measurements.c b/measurements.c
index 385143f..49ef946 100644
--- a/measurements.c
+++ b/measurements.c
@@ -153,8 +153,13 @@ static int parse_ftm_target(struct nl_msg *msg, char *str, int peer_index)
 
 		switch (str_to_bw(bw)) {
 		case NL80211_CHAN_WIDTH_20_NOHT:
+		case NL80211_CHAN_WIDTH_1:
+		case NL80211_CHAN_WIDTH_2:
+		case NL80211_CHAN_WIDTH_4:
 		case NL80211_CHAN_WIDTH_5:
+		case NL80211_CHAN_WIDTH_8:
 		case NL80211_CHAN_WIDTH_10:
+		case NL80211_CHAN_WIDTH_16:
 			preamble = NL80211_PREAMBLE_LEGACY;
 			break;
 		case NL80211_CHAN_WIDTH_20:
diff --git a/util.c b/util.c
index ac6a96d..ebb2de8 100644
--- a/util.c
+++ b/util.c
@@ -492,8 +492,13 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
 		/* First argument was not understood, give up gracefully. */
 		return 0;
 	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
 	case NL80211_CHAN_WIDTH_5:
+	case NL80211_CHAN_WIDTH_8:
 	case NL80211_CHAN_WIDTH_10:
+	case NL80211_CHAN_WIDTH_16:
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		need_cf2 = true;
-- 
2.28.0

