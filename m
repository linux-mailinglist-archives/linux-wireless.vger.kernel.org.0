Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D86573370
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiGMJqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiGMJpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97BF78A6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ncV9gzq2EgtStUiFGkdmLUV8CiMOh3rqv0GcKjryYIo=;
        t=1657705529; x=1658915129; b=Yu/vXS8eFpVb73K5mwJ0bAbtY3lXhUHi5lqYkqICdRuD/Rv
        DJJnTss1NaGjfCIw8FmyFh3GwNatGi1+DP46pkRY6jzCbYejKNOo7sZ9IAv3DJ/aYduXhfvQbr58y
        ATFT9HSGXLCvhMMYzT8oR+grhU1j4zZ32GamRVs2nNh7wkGTsxFXBS7qrZYCaBZr5JrH59VpADORZ
        9Bm8ffNQl5+njlATrl5kz2UJpmeh2vD+kaHGlffllMTwCB9cRtJIRTHyhq07Jg8sYlNGyEy5iyboO
        na+RdmH/3xFXCg3PudjdsvUVFSnhhkaoCvCKndRSOzDgx6GM17w5S94VdjeN1BPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvu-00EgvB-Vq;
        Wed, 13 Jul 2022 11:45:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 64/76] wifi: mac80211: add a helper to fragment an element
Date:   Wed, 13 Jul 2022 11:44:50 +0200
Message-Id: <20220713114426.30970ab0d08a.Ia4ea941696b9861b58d961dcdca5807a248df75d@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The way this works is that you add all the element data,
keeping a pointer to the length field of the element.
Then call this helper function, which will fragment the
element if there was more than 255 bytes in the element,
memmove()ing the data back if needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/util.c        | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 74d5fc5889bb..d17d73e8d19f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2193,6 +2193,7 @@ ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
 	return ieee802_11_parse_elems_crc(start, len, action, 0, 0, bss);
 }
 
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos);
 
 extern const int ieee802_1d_to_ac[8];
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 86b6ee7e8156..4b11cf57f4fe 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4777,3 +4777,31 @@ u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 
 	return pos;
 }
+
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
+{
+	unsigned int elem_len;
+
+	if (!len_pos)
+		return;
+
+	elem_len = skb->data + skb->len - len_pos - 1;
+
+	while (elem_len > 255) {
+		/* this one is 255 */
+		*len_pos = 255;
+		/* remaining data gets smaller */
+		elem_len -= 255;
+		/* make space for the fragment ID/len in SKB */
+		skb_put(skb, 2);
+		/* shift back the remaining data to place fragment ID/len */
+		memmove(len_pos + 255 + 3, len_pos + 255 + 1, elem_len);
+		/* place the fragment ID */
+		len_pos += 255 + 1;
+		*len_pos = WLAN_EID_FRAGMENT;
+		/* and point to fragment length to update later */
+		len_pos++;
+	}
+
+	*len_pos = elem_len;
+}
-- 
2.36.1

