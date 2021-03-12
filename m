Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7831333938D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Mar 2021 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhCLQhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Mar 2021 11:37:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232198AbhCLQhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Mar 2021 11:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615567045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FnVUzFvzsl3Bp0QFRDBlIHeV43tl8slTgFSG/RNrL70=;
        b=UdxRWwsvBgtrZ56feaDtqTWoDv35uNfgMy90MWuIZpWlb/EtkdMrUo6BgSLaydcL9YF+bL
        YpJY6cvIW225smoHLXgx94ajK7P4W/70m4N4Knndvf58yFRSPfuL7F4Eqt76YDH9xYhOIo
        r3gB4Eavm0WsJv0386YCMFWDVPw8uCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-kF_I14VGMT-R9-CJQ8RLzQ-1; Fri, 12 Mar 2021 11:37:23 -0500
X-MC-Unique: kF_I14VGMT-R9-CJQ8RLzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF9E192D786;
        Fri, 12 Mar 2021 16:37:22 +0000 (UTC)
Received: from f33vm.wilsonet.com.wilsonet.com (dhcp-17-185.bos.redhat.com [10.18.17.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 077E8610A8;
        Fri, 12 Mar 2021 16:37:15 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] wireless/nl80211: fix wdev_id may be used uninitialized
Date:   Fri, 12 Mar 2021 11:36:51 -0500
Message-Id: <20210312163651.1398207-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Build currently fails with -Werror=maybe-uninitialized set:

net/wireless/nl80211.c: In function '__cfg80211_wdev_from_attrs':
net/wireless/nl80211.c:124:44: error: 'wdev_id' may be used
uninitialized in this function [-Werror=maybe-uninitialized]

Easy fix is to just initialize wdev_id to 0, since it's value doesn't
otherwise matter unless have_wdev_id is true.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
CC: Johannes Berg <johannes@sipsolutions.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jakub Kicinski <kuba@kernel.org>
CC: linux-wireless@vger.kernel.org
CC: netdev@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 521d36bb0803..a157783760c7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -70,7 +70,7 @@ __cfg80211_wdev_from_attrs(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *result = NULL;
 	bool have_ifidx = attrs[NL80211_ATTR_IFINDEX];
 	bool have_wdev_id = attrs[NL80211_ATTR_WDEV];
-	u64 wdev_id;
+	u64 wdev_id = 0;
 	int wiphy_idx = -1;
 	int ifidx = -1;
 
-- 
2.29.2

