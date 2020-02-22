Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235E7168F1C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBVN1i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:38 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:44903 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgBVN1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378057; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gpgxqUEW5KPKGD1LbYkvIyamrDmG18X4JPqKfkw/c2I=; b=N7vNLN5N8X25hjxZvrg7VxQK/tQ54tIih99qAKrs88OP8AlATtUt7y8HXicI2M4lWL2h/iuS
 9W3YcMSfagWxiLXVA8iXErB78B9MS0/dLibFHFoRIxqu8HUlPIynBUX0dty6yVKnQk4LOODS
 /uV6XdD4TXOIkVupPx/m6bOwQvU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c37.7fb777e7b928-smtp-out-n03;
 Sat, 22 Feb 2020 13:27:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 888CBC433A2; Sat, 22 Feb 2020 13:27:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF0F0C4479C;
        Sat, 22 Feb 2020 13:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF0F0C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 5/7] mac80211: Beacon protection using the new BIGTK (AP)
Date:   Sat, 22 Feb 2020 15:25:46 +0200
Message-Id: <20200222132548.20835-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds support for mac80211 to add an MME into Beacon frames in AP
mode when a BIGTK is configured.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/tx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8dd93072f6e6..484918a331fc 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4664,6 +4664,28 @@ bool ieee80211_csa_is_complete(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL(ieee80211_csa_is_complete);
 
+static int ieee80211_beacon_protect(struct sk_buff *skb,
+				    struct ieee80211_local *local,
+				    struct ieee80211_sub_if_data *sdata)
+{
+	ieee80211_tx_result res;
+	struct ieee80211_tx_data tx;
+
+	memset(&tx, 0, sizeof(tx));
+	tx.key = rcu_dereference(sdata->default_beacon_key);
+	if (!tx.key)
+		return 0;
+	tx.local = local;
+	tx.sdata = sdata;
+	__skb_queue_head_init(&tx.skbs);
+	__skb_queue_tail(&tx.skbs, skb);
+	res = ieee80211_tx_h_encrypt(&tx);
+	if (WARN_ON_ONCE(res != TX_CONTINUE))
+		return -1;
+
+	return 0;
+}
+
 static struct sk_buff *
 __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
@@ -4731,6 +4753,9 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			if (beacon->tail)
 				skb_put_data(skb, beacon->tail,
 					     beacon->tail_len);
+
+			if (ieee80211_beacon_protect(skb, local, sdata) < 0)
+				goto out;
 		} else
 			goto out;
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
-- 
2.20.1
