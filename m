Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC425D49A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgIDJVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 05:21:00 -0400
Received: from sitav-80046.hsr.ch ([152.96.80.46]:40582 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgIDJVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 05:21:00 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 05:20:59 EDT
Received: from think.wlp.is (unknown [185.12.128.225])
        by mail.strongswan.org (Postfix) with ESMTPSA id D9ED74011D;
        Fri,  4 Sep 2020 11:12:42 +0200 (CEST)
From:   Martin Willi <martin@strongswan.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: Include supported RX/TX frames in split phy dumps only
Date:   Fri,  4 Sep 2020 11:12:35 +0200
Message-Id: <20200904091235.11342-1-martin@strongswan.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the recent additions of new features, non-split phy dumps exceed the
maximum Netlink size of 4096 bytes. Depending on their feature set, not all
radios are affected, but for example hwsim is.

While userspace dumping phys can request a split dump as a work around,
legacy tools without split support may get oversized dumps. Much more
problematic are phy new/del notifications, which are always limited to
a page size: Generating these messages fails, and Netlink notifications
are silently dropped. This breaks userspace relying on these events.

There is no single commit that broke these events, as their size highly
depends on the phy feature set. Finding attributes to strip is challenging:
The largest attributes are the frequency lists, but they are already
reduced to the minimum and have rather useful information. HE information
probably could be stripped, but the saving is about 200 bytes, not enough
to fix dumps for many cases. The next larger attributes are usually the
RX/TX frame attributes. Removing these attributes can reduce a hwsim phy
dump from 4576 to 3288 bytes, and it seems to be the most reasonable
approach.

This fixes Netlink phy notifications, but obviously removes supported
RX/TX frames from these events and non-split phy dumps. Userspace is
required to use split dumps to receive supported RX/TX frame information.

Signed-off-by: Martin Willi <martin@strongswan.org>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 201d029687cc..9362fa407933 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2304,7 +2304,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		    nla_put_flag(msg, NL80211_ATTR_OFFCHANNEL_TX_OK))
 			goto nla_put_failure;
 
-		if (nl80211_send_mgmt_stypes(msg, mgmt_stypes))
+		if (state->split && nl80211_send_mgmt_stypes(msg, mgmt_stypes))
 			goto nla_put_failure;
 		state->split_start++;
 		if (state->split)
-- 
2.25.1

