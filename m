Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11743048
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFLTfd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:35:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:65222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfFLTfc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:35:32 -0400
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
Subject: [PATCH 3/3] mac80211: notify offchannel expire on mgmt_tx
Date:   Wed, 12 Jun 2019 12:35:10 -0700
Message-Id: <20190612193510.27680-3-james.prestwood@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612193510.27680-1-james.prestwood@linux.intel.com>
References: <20190612193510.27680-1-james.prestwood@linux.intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
---
 net/mac80211/offchannel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 8ef4153cd299..b07aec5e7da4 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -202,6 +202,11 @@ static void ieee80211_roc_notify_destroy(struct ieee80211_roc_work *roc)
 		cfg80211_remain_on_channel_expired(&roc->sdata->wdev,
 						   roc->cookie, roc->chan,
 						   GFP_KERNEL);
+	else
+		cfg80211_tx_mgmt_expired(&roc->sdata->wdev,
+						   roc->mgmt_tx_cookie,
+						   roc->chan,
+						   GFP_KERNEL);
 
 	list_del(&roc->list);
 	kfree(roc);
-- 
2.17.1

