Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB96B3CA1CB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbhGOQFe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhGOQFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 12:05:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCDC06175F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=hDDGwCDioZtgGRkIt7/A0y9XUW6Pv5lRrYrHOTCn2Io=; t=1626364960; x=1627574560; 
        b=nE/TGvJLKxrN47PPyOo+awFkEipKa8xaY7ejS1o9zth85dOr9OlnJ8rFq5v0suDlfQjc5Kp/Ik+
        XJ4nqQgjhbDR4CHeZ0LAuW8VqizJUOPN2a1JL5oSnct+m2/DxBgh7NHnlY8DIcoy0GtDtqx3GwMtR
        Njy8Q8yb8Cg5r+cutnOPR/5CocMsl0qhL9uj8Z3gCmTjliExEEQ2ScLgTAGUancstSj1fUejVvxeq
        jD0as6WmVUNnaTc54qYjN4jbyT5J5inOgSu5h0wox/WfCiwVw4Og4+pYL8+yaeKj8QjaznOtk/Yr6
        z7Kb4filwZOZMbntpXX436PSMckQI83JjUoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m43os-002iCe-Ij; Thu, 15 Jul 2021 18:02:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: include <linux/rbtree.h>
Date:   Thu, 15 Jul 2021 18:02:35 +0200
Message-Id: <20210715180234.512d64dee655.Ia51c29a9fb1e651e06bc00eabec90974103d333e@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is needed for the rbtree, and we shouldn't just rely
on it getting included somewhere implicitly. Include it
explicitly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 22549b95d1aa..1c14cecf9813 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -25,6 +25,7 @@
 #include <linux/leds.h>
 #include <linux/idr.h>
 #include <linux/rhashtable.h>
+#include <linux/rbtree.h>
 #include <net/ieee80211_radiotap.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
-- 
2.31.1

