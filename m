Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5462C471588
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Dec 2021 20:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhLKTKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Dec 2021 14:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLKTKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Dec 2021 14:10:34 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B920C061714
        for <linux-wireless@vger.kernel.org>; Sat, 11 Dec 2021 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=W2nz3ICbS6C34sTAaBEDxICfgIVjXgPO6P+j7o2yX6A=; t=1639249834; x=1640459434; 
        b=l0hqlQyoFpHLPGjDCtnsCCaeSf8XYwj3Z2lYV31dT081KxaIS5lzHmBiBwTYp01bPCkljzQ8aiH
        f8qZQrdHLmYQ7xsrtDCEtBMExzyxwwOlZrWMoztUi0WFvF8WL7SGsQ6brBmLpdetiDUioeXMyOERH
        SFQoo7ucQLyp6BVOlC7IEKAxxxOOvhn5aYsu2VPopM4Mg9AQepZUUTXEDo7CrLl8SNXYHId2gGp4v
        PhQlcYw67PIVwXMy875DxeSELs9MhhDBS9LaFOXKdaQkwtDZDs6Pm9+aUt2+dzXN/TgoPHYSAGjil
        XdaIIeVvbysLvGjjmpxruSfTbdo1X4ilYgsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mw7lO-00A0lz-AR;
        Sat, 11 Dec 2021 20:10:30 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+59bdff68edce82e393b6@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: validate extended element ID is present
Date:   Sat, 11 Dec 2021 20:10:24 +0100
Message-Id: <20211211201023.f30a1b128c07.I5cacc176da94ba316877c6e10fe3ceec8b4dbd7d@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Before attempting to parse an extended element, verify that
the extended element ID is present.

Fixes: 41cbb0f5a295 ("mac80211: add support for HE")
Reported-by: syzbot+59bdff68edce82e393b6@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 43df2f0c5db9..6c2934854d3c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -943,7 +943,12 @@ static void ieee80211_parse_extension_element(u32 *crc,
 					      struct ieee802_11_elems *elems)
 {
 	const void *data = elem->data + 1;
-	u8 len = elem->datalen - 1;
+	u8 len;
+
+	if (!elem->datalen)
+		return;
+
+	len = elem->datalen - 1;
 
 	switch (elem->data[0]) {
 	case WLAN_EID_EXT_HE_MU_EDCA:
-- 
2.33.1

