Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2F464B45
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 11:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348527AbhLAKMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 05:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348516AbhLAKMw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 05:12:52 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621AC061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=xO/dX92dbVuUV4Ei7lwtxqIvB+xYbA9p0vfkVhgdsJM=; t=1638353372; x=1639562972; 
        b=Kk3GCYNQfKrhe1Nxozj8q0VkWRc7VqH39ZsR4tzyxAGi3vd7ivABjDmMSIFrPf+dTSpnpfw5JWu
        0KUpt5syPiCoNuOk54Auo15TkFmj/8WDhIg6mkZvV6RH+xJAGGaENJr6tUTxEMfRshEBA1QFNlNLa
        H+2jNGnDw41gld3JFVdJuwDw0kbXPdOHHOhv64p6KrAFQxrB/aSIR2dsn9vOa7pU+cGryAlqLSi2w
        EOjxxvueInpTyaSusUO7NOw487AD1hMHIGy2b1ZfUb5wbTi94N4h/nDbOC70m8Ep6/YtGgBQhs7IE
        BvLtH+pXATKHWE3nZCUNmHEZE4iipQmcp8yQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1msMYK-005KzG-9e;
        Wed, 01 Dec 2021 11:09:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl82011: clarify interface combinations wrt. channels
Date:   Wed,  1 Dec 2021 11:09:25 +0100
Message-Id: <20211201110924.2816d91b6862.I2d997abd525574529f88e941d90aeb640dbb1abf@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Thinking about MLD (Draft 802.11be) now, it's clear that
we'll have new limitations where different stations (or
links) must be on _different_ channels (or in different
frequency ranges even.) Clarify that the current limit of
multiple channels is a maximum and the same one is OK.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 61cab81e920d..c12c55623f9a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5555,7 +5555,7 @@ enum nl80211_iface_limit_attrs {
  *	=> allows 8 of AP/GO that can have BI gcd >= min gcd
  *
  *	numbers = [ #{STA} <= 2 ], channels = 2, max = 2
- *	=> allows two STAs on different channels
+ *	=> allows two STAs on the same or on different channels
  *
  *	numbers = [ #{STA} <= 1, #{P2P-client,P2P-GO} <= 3 ], max = 4
  *	=> allows a STA plus three P2P interfaces
-- 
2.33.1

