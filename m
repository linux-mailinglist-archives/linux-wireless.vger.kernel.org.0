Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F5419385
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 13:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhI0LqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 07:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhI0Lpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 07:45:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA7C06176C
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=BvXqYNr3n/jfnoo1/STlMiLzIV5p3PTjgZz5kdZQMMs=; t=1632743048; x=1633952648; 
        b=mb7wOlBdMOLrrMOKtAQrF3gWnuQFpAVgzG4mtg7JYyw2ab/fUd/F71cIUThvJ0F5MzPJyIEXeqT
        1x5q/7Kdyl/5o9eGOPF/qu6RtS8Au/+EDND73lwgGNN4PWz/u9YrMEZYI0Va8beZNyY9LUEyhqoGX
        osSisp+HK/pjvBRON8c1Ai/hbBkD/3iQUiwQ60uiwyaGVrdEHxeGX5aFNiv+h79jHvVEpcoh6Lhsc
        EeQLWHjd/zrcFYOalKpnNXJ9wMMj4uH8YgY78hO4SIlO8fhw2FIm5Mkn4GjlhKaNaBwhZxO0RuuAK
        EbJwPpmp4coIcs+/kEU5rLFs16f16ReUWoAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUp3F-00CP2n-SM;
        Mon, 27 Sep 2021 13:44:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: don't kfree() ERR_PTR() value
Date:   Mon, 27 Sep 2021 13:44:03 +0200
Message-Id: <20210927134402.86c5ae06c952.Ic51e234d998b9045665e5ff8b6db7e29f25d70c0@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When parse_acl_data() fails, we get an ERR_PTR() value and
then "goto out;", in this case we'd attempt to kfree() it.
Fix that.

Fixes: 9e263e193af7 ("nl80211: don't put struct cfg80211_ap_settings on stack")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7c03f6145f0..0f728de36f33 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5507,6 +5507,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params->acl = parse_acl_data(&rdev->wiphy, info);
 		if (IS_ERR(params->acl)) {
 			err = PTR_ERR(params->acl);
+			params->acl = NULL;
 			goto out;
 		}
 	}
-- 
2.31.1

