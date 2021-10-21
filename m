Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209EE436647
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhJUPdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUPdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 11:33:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27318C061764
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=fcOmes8iKrdKRFiD1d+cIFd6FdBSEfJUu/32rN0rTcw=; t=1634830245; x=1636039845; 
        b=r+dl/ncE1wH9s/dfEWlE7Y7MWoyzgMg9CZzbrMp5V2AudRUCfwJq7Kv/IjHJJAVROXvJbHfXadK
        q8F1KISneeZ+kzvg/zSuIbvj9grStjKWskuVnb8Q8VAPILkx1aqPCBH4AJnKgO/I58XM0Jd2pT1OO
        7sU7nZ6NItxjkYsT8iLxQrKTbF30Q9G+cszsiEEdMVj8tzOdG5C7qFsiiBiBou+f2gu/L91kgPJP9
        CsQgdcWKZo/miiDJAWlYW699ydT4shUXAiCHl1+MU53h7tB7V4bk0xdK0e6ALXXojJBkB5fUpAs8p
        2ksKtktzAteHIV+PSkTPn85b7eRdP7zR11cQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mda1h-005K3e-L9;
        Thu, 21 Oct 2021 17:30:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: fix kernel-doc for MBSSID EMA
Date:   Thu, 21 Oct 2021 17:30:39 +0200
Message-Id: <20211021173038.18ec2030c66b.Iac731bb299525940948adad2c41f514b7dd81c47@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The struct member ema_max_profile_periodicity was listed
with the wrong name in the kernel-doc, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 241b29b0796e..7c9d5db4f0e6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5041,7 +5041,7 @@ struct wiphy_iftype_akm_suites {
  * @mbssid_max_interfaces: maximum number of interfaces supported by the driver
  *	in a multiple BSSID set. This field must be set to a non-zero value
  *	by the driver to advertise MBSSID support.
- * @mbssid_max_ema_profile_periodicity: maximum profile periodicity supported by
+ * @ema_max_profile_periodicity: maximum profile periodicity supported by
  *	the driver. Setting this field to a non-zero value indicates that the
  *	driver supports enhanced multi-BSSID advertisements (EMA AP).
  */
-- 
2.31.1

