Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB6615E3B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKBIr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKBIrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 04:47:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3A27CDB
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=WtzuflQzpAaUGRSeebqLu+Ce5AotuenfQLU6EhNgbwQ=; t=1667378874; x=1668588474; 
        b=N7s2WxgiNCKXLF1G7cqXywKce77sc3fXgDsXJ4Hp1Afb0Ud8HrJ1P6DJhEgfz6GKo/m6t7b3RSQ
        rzEyFFKL7OZNi/g557qZc7nwgFhmdmxlr2qSwI5wdQ04ZLYJppgFxKkXjOMSwjI7VFevLaHBz5/K2
        MWDaNhnhsN9KAZn+fAgs075Xb31KrEUW5DZo7wmMjdj9xMY/dZJznY/aGObc18ifCt+bsULHJ8aXJ
        W1vOUOW/WSAxhRe+Uif5UgQXTCFlnxtnW94dzOjLPm/5P7g99X6NXMrJpP9qZ+Am2l3JdCONaW7qp
        gMj9qDryks40oCbf7HQ5jvxrn7UNnsndNEIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oq9PZ-006ykr-1G;
        Wed, 02 Nov 2022 09:47:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: remove unnecessary synchronize_net()
Date:   Wed,  2 Nov 2022 09:47:47 +0100
Message-Id: <20221102094746.a4247dff6312.Idef07809e46e74dfd5e82e2951ee16b5a8978db1@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The call to ieee80211_do_stop() right after will also do
synchronize_rcu() to ensure the SDATA_STATE_RUNNING bit
is cleared, so we don't need to synchronize_net() here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dd9ac1f7d2ea..02b71b4e094b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1898,8 +1898,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_stop_vif_queues(local, sdata,
 				  IEEE80211_QUEUE_STOP_REASON_IFTYPE_CHANGE);
-	synchronize_net();
-
+	/* do_stop will synchronize_rcu() first thing */
 	ieee80211_do_stop(sdata, false);
 
 	ieee80211_teardown_sdata(sdata);
-- 
2.38.1

