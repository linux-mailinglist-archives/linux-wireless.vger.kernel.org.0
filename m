Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B289777B550
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjHNJWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjHNJWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 05:22:36 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9505CD7
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 02:22:31 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 3FA29600F8;
        Mon, 14 Aug 2023 12:22:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SMa43HsW0uQ0-EMm3AVlM;
        Mon, 14 Aug 2023 12:22:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692004948;
        bh=gsKsd3l5SMWpT7BBmAiDIr5lJKy4P1L92U+IeCrSjBI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=bV0Esw3QIbXJTDXobQXv+BjX63A+HSm/RmcVHQtZ4AQkzg+loxnRXowfFFqLRv9/d
         wO677W5j4Mgv1OznZLYPkdAVPD/MlAb6xwppSK4eKed5JhJ77JxOCKfErS5449/Eb/
         zuzCxeJSBx64O1ugKukTqM1kmBCiSwXUOUmXBMLI=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mac80211_hwsim: do not ignore the value returned by nla_put_u32()
Date:   Mon, 14 Aug 2023 12:21:17 +0300
Message-ID: <20230814092128.14330-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'mac80211_hwsim_vendor_cmd_test()', do not ignore the value
returned by 'nla_put_u32'. This follows commit b970ac68e0c4
("wifi: mac80211_hwsim: check the return value of nla_put_u32").

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f446fd0e8cd0..2a3393a47bf2 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -597,9 +597,9 @@ static int mac80211_hwsim_vendor_cmd_test(struct wiphy *wiphy,
 	/* skb_put() or nla_put() will fill up data within
 	 * NL80211_ATTR_VENDOR_DATA
 	 */
-	nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 2);
+	err = nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 2);
 
-	return cfg80211_vendor_cmd_reply(skb);
+	return err ? err : cfg80211_vendor_cmd_reply(skb);
 }
 
 static struct wiphy_vendor_command mac80211_hwsim_vendor_commands[] = {
-- 
2.41.0

