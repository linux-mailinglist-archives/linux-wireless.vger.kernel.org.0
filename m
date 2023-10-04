Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59307B839C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjJDPbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjJDPbK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 11:31:10 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C1D93
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 08:31:00 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2991:0:640:f02b:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 5C47D600E9;
        Wed,  4 Oct 2023 18:30:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uUZ92hXDV4Y0-mf8Zybz3;
        Wed, 04 Oct 2023 18:30:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696433457; bh=ZD9We9xupCIrBixLGX9Q3raR/4qdCNn7ToJ4SJNO9to=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=WEzEwmCz6gPox9pey+cTKEBsf2jqK3BEJk0uclADYD8WPv3gQEN3UDgqcoV/wYf6D
         Ww1TceY4ycK7B0NOmgxzWy1okKRlHMHkVnIdPNcUoaJ4cmooeqAyeAHy62nG5HjKI+
         cjt/uGWTMBc1gbhBBq4bFG2PyGbfxIfHDftf24/Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: wext: remove unused argument of ieee80211_get_tdls_action()
Date:   Wed,  4 Oct 2023 18:30:29 +0300
Message-ID: <20231004153032.206134-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused 'hdr_size' argument of 'ieee80211_get_tdls_action()'
and adjust 'ieee80211_report_used_skb()' accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/linux/ieee80211.h | 3 +--
 net/mac80211/status.c     | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 62b4469c6866..045a776ee547 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4490,12 +4490,11 @@ static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
 /**
  * ieee80211_get_tdls_action - get tdls packet action (or -1, if not tdls packet)
  * @skb: the skb containing the frame, length will not be checked
- * @hdr_size: the size of the ieee80211_hdr that starts at skb->data
  *
  * This function assumes the frame is a data frame, and that the network header
  * is in the correct place.
  */
-static inline int ieee80211_get_tdls_action(struct sk_buff *skb, u32 hdr_size)
+static inline int ieee80211_get_tdls_action(struct sk_buff *skb)
 {
 	if (!skb_is_nonlinear(skb) &&
 	    skb->len > (skb_network_offset(skb) + 2)) {
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f67eafada741..807cdab38d5e 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -731,12 +731,9 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 		if (!sdata) {
 			skb->dev = NULL;
 		} else if (!dropped) {
-			unsigned int hdr_size =
-				ieee80211_hdrlen(hdr->frame_control);
-
 			/* Check to see if packet is a TDLS teardown packet */
 			if (ieee80211_is_data(hdr->frame_control) &&
-			    (ieee80211_get_tdls_action(skb, hdr_size) ==
+			    (ieee80211_get_tdls_action(skb) ==
 			     WLAN_TDLS_TEARDOWN)) {
 				ieee80211_tdls_td_tx_handle(local, sdata, skb,
 							    info->flags);
-- 
2.41.0

