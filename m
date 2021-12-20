Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FAE47A7F5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhLTKvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 05:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLTKvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 05:51:54 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E296C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 02:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jvVQWIa1BM9mGG2/NfV2opxw5vIHZnV+OH75FVC/nXg=; b=NjNklhaQ6FLeUMPzxC66AqsC8y
        M8NE/l74HNRZcGKJW4LL2vUGclr+7H5UguTHzgcUPQV68J+mvVF0Iyl0UZjjfMEyAifFmkrM5U1kt
        D6OxROjRrRccnZV8Oc/rE7tbU3pN1wNiO8bVMcWKKaUgb9bf22m5EYwq4odwlLa2wxOU=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mzGGm-0004N2-He; Mon, 20 Dec 2021 11:51:52 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] nl80211: clarify comment for mesh PLINK_BLOCKED state
Date:   Mon, 20 Dec 2021 11:51:47 +0100
Message-Id: <20211220105147.88625-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a mesh link is in blocked state, it is very useful to still allow
auth requests from the peer to re-establish it.
When a remote node is power cycled, the peer state can easily end up
in blocked state if multiple auth attempts are performed. Since this
can lead to several minutes of downtime, we should accept auth attempts
of the peer after it has come back.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
I will also re-send a hostapd patch that changes the behavior accordingly

 include/uapi/linux/nl80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 61cab81e920d..0e703b463fac 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5600,7 +5600,7 @@ enum nl80211_if_combination_attrs {
  * @NL80211_PLINK_ESTAB: mesh peer link is established
  * @NL80211_PLINK_HOLDING: mesh peer link is being closed or cancelled
  * @NL80211_PLINK_BLOCKED: all frames transmitted from this mesh
- *	plink are discarded
+ *	plink are discarded, except for authentication frames
  * @NUM_NL80211_PLINK_STATES: number of peer link states
  * @MAX_NL80211_PLINK_STATES: highest numerical value of plink states
  */
-- 
2.34.1

