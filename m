Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85B43046
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfFLTfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:35:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:65222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfFLTfb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:35:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 12:35:31 -0700
X-ExtLoop1: 1
Received: from jprestwo-test.jf.intel.com ([10.54.74.49])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2019 12:35:31 -0700
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/3] net: wireless: trace: add trace for tx_mgmt_expired
Date:   Wed, 12 Jun 2019 12:35:08 -0700
Message-Id: <20190612193510.27680-1-james.prestwood@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
---
 net/wireless/trace.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 2abfff925aac..4fbb91a511ae 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2752,6 +2752,24 @@ TRACE_EVENT(cfg80211_ready_on_channel_expired,
 		  WDEV_PR_ARG, __entry->cookie, CHAN_PR_ARG)
 );
 
+TRACE_EVENT(cfg80211_tx_mgmt_expired,
+	TP_PROTO(struct wireless_dev *wdev, u64 cookie,
+		 struct ieee80211_channel *chan),
+	TP_ARGS(wdev, cookie, chan),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		__field(u64, cookie)
+		CHAN_ENTRY
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		__entry->cookie = cookie;
+		CHAN_ASSIGN(chan);
+	),
+	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_PR_FMT,
+		  WDEV_PR_ARG, __entry->cookie, CHAN_PR_ARG)
+);
+
 TRACE_EVENT(cfg80211_new_sta,
 	TP_PROTO(struct net_device *netdev, const u8 *mac_addr,
 		 struct station_info *sinfo),
-- 
2.17.1

