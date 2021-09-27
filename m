Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDA4191D5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhI0JxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhI0JxJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 05:53:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A65C061740
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=/T1Aj2N0xKr8OOg9lsn9+kkb8pPApE0XkEhMFlzksGE=; t=1632736289; x=1633945889; 
        b=BVG9LWSA9/hQEvSuHmU/HGUABaIW6wsAB+iyfwkpLZ8oSbFvR/mpa+43TqLbD95+IoML2c6jRbo
        Zz5vfNYB2IB1ozZVVFDb9kFO4w30RZXNSuXRb67oeA6/8+vL9qA+c4S8a6iCcICxBUbtWNn+CaDz1
        1gwd+SvQaFdIdA8r7jGg4Si3WSl6ZlIZd4D7kuAVPXjaonsxK6EPS/HzPLgAPiSfBP1WurFPJ5q3O
        XePPUvBCZfTjnmYdyDdHHWcdhTAGEoD19TAhCTh5IrktWR9IwMqnFuhk5P6P5YrN/HnsxLrUtG+VE
        Dh2oGbx1CcqXBRxdj6CQyTkGgI7gFmG3XHoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUnIF-00CMw6-0k;
        Mon, 27 Sep 2021 11:51:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mac80211: twt: don't use potentially unaligned pointer
Date:   Mon, 27 Sep 2021 11:51:24 +0200
Message-Id: <20210927115124.e1208694f37b.Ie3de9bcc5dde5a79e3ac81f3185beafe4d214e57@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we're pointing into a frame, the pointer to the
twt_agrt->req_type struct member is potentially not
aligned properly. Open-code le16p_replace_bits() to
avoid passing an unaligned pointer.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f5a4c24e689f ("mac80211: introduce individual TWT support in AP mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/s1g.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 7e35ab5b6166..4141bc80cdfd 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -104,9 +104,11 @@ ieee80211_s1g_rx_twt_setup(struct ieee80211_sub_if_data *sdata,
 
 	/* broadcast TWT not supported yet */
 	if (twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST) {
-		le16p_replace_bits(&twt_agrt->req_type,
-				   TWT_SETUP_CMD_REJECT,
-				   IEEE80211_TWT_REQTYPE_SETUP_CMD);
+		twt_agrt->req_type &=
+			~cpu_to_le16(IEEE80211_TWT_REQTYPE_SETUP_CMD);
+		twt_agrt->req_type |=
+			le16_encode_bits(TWT_SETUP_CMD_REJECT,
+					 IEEE80211_TWT_REQTYPE_SETUP_CMD);
 		goto out;
 	}
 
-- 
2.31.1

