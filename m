Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40E22E6D92
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 04:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgL2DYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 22:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgL2DYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 22:24:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F0C0613D6;
        Mon, 28 Dec 2020 19:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dezo73rP7nIDR3FlycJPSv87VABYoNgs4MDYbOjeNAw=; b=lyrGmh2xrriItbi00TkalkZq48
        u4B+LYEF7jVeG4759ehvKikpvFjYt2LgqXwaobO9EqnI33htSdy1vkX6KXGCZH5RmY6CSj/yF4WPw
        +12X1esbuGxy79kbGPuKd5vNtQ8cpjBKAoxfBlhR2q8qUpuUED+HzwS+vPzY5qTGGDgitZYWE+GHT
        G6tK2Py1GsysamKpldhNoK91myYaQR2khyYGVORtTQgSaSwKAc0oS/DxKPzBJUc0hBUqJQ74rYcMF
        nYHJ3wNrhIIsitnOwX6wCAV3oCeobqER6a8pm7A6mvhp20pJlyUPDmZzGBaArq40OQSNaypcPHE3v
        l/1buqwA==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ku5c9-0007Z2-Te; Tue, 29 Dec 2020 03:24:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Carl Huang <cjhuang@codeaurora.org>
Subject: [PATCH] wireless/cfg80211: fix multiple kernel-doc build warnings
Date:   Mon, 28 Dec 2020 19:23:55 -0800
Message-Id: <20201229032355.29060-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix 19 warnings like this:

../include/net/cfg80211.h:1759: warning: Cannot understand  * @struct cfg80211_sar_chan_ranges - sar frequency ranges

Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limitations")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Carl Huang <cjhuang@codeaurora.org>
---
 include/net/cfg80211.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-511-rc1.orig/include/net/cfg80211.h
+++ lnx-511-rc1/include/net/cfg80211.h
@@ -1756,7 +1756,7 @@ struct cfg80211_sar_specs {
 
 
 /**
- * @struct cfg80211_sar_chan_ranges - sar frequency ranges
+ * struct cfg80211_sar_chan_ranges - sar frequency ranges
  * @start_freq:  start range edge frequency
  * @end_freq:    end range edge frequency
  */
