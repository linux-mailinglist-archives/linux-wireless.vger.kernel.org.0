Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90255B24C5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiIHRgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIHRgc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 13:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD13E915F
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662658590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GB9xWxS+/dNB7blBCx/W0Z14NcIRuFDQzfOB+6TIMWU=;
        b=NNRNuiprwic2B73lF3YsXcvXA5G1HO/AUL2AlYkCKm9gOj2Ei4Mz7EqpRU2vwCXNwfGVsw
        OFO8f+PgTHuKtk6XGv6kGIntLzcTLhjNCMCR8lHawSfYnCeUW/dplBKE2385gpny6vV+zy
        JWlO6icpTcYQcK51WXVmjCkjTqKFpIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-BsUuiJcYPwOJWUVxszhJ-Q-1; Thu, 08 Sep 2022 13:36:27 -0400
X-MC-Unique: BsUuiJcYPwOJWUVxszhJ-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2509E101A54E;
        Thu,  8 Sep 2022 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56533C15BB3;
        Thu,  8 Sep 2022 17:36:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-wireless@vger.kernel.org
Subject: [PATCH 1/1] wifi: rt2x00: Fix "Error - Attempt to send packet over invalid queue 2"
Date:   Thu,  8 Sep 2022 19:36:18 +0200
Message-Id: <20220908173618.155291-2-hdegoede@redhat.com>
In-Reply-To: <20220908173618.155291-1-hdegoede@redhat.com>
References: <20220908173618.155291-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even though ieee80211_hw.queues is set to 2, the ralink rt2x00 driver
is seeing tx skbs submitted to it with the queue-id set to 2 / set to
IEEE80211_AC_BE on a rt2500 card when associating with an access-point.

This causes rt2x00queue_get_tx_queue() to return NULL and the following
error to be logged: "ieee80211 phy0: rt2x00mac_tx: Error - Attempt to
send packet over invalid queue 2", after which association with the AP
fails.

This patch works around this by mapping QID_AC_BE and QID_AC_BK
to QID_AC_VI when there are only 2 tx_queues.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
The net/mac80211 code has checks for local->hw.queues < IEEE80211_NUM_ACS
in various places and returns queue-id 0 when this condition is true.

So it looks like the rt2x00 driver receiving a queue-id of 2 /
IEEE80211_AC_BE might actually be a bug in the mac80211 core code,
I will send out a separate email about this.
---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 8f5772b98f58..07a6a5a9ce13 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1309,8 +1309,11 @@ void rt2x00queue_unmap_skb(struct queue_entry *entry);
  */
 static inline struct data_queue *
 rt2x00queue_get_tx_queue(struct rt2x00_dev *rt2x00dev,
-			 const enum data_queue_qid queue)
+			 enum data_queue_qid queue)
 {
+	if (queue >= rt2x00dev->ops->tx_queues && queue < IEEE80211_NUM_ACS)
+		queue = rt2x00dev->ops->tx_queues - 1;
+
 	if (queue < rt2x00dev->ops->tx_queues && rt2x00dev->tx)
 		return &rt2x00dev->tx[queue];
 
-- 
2.37.2

