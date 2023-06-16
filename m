Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5776E732801
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbjFPGzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbjFPGzB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:55:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6F1FE8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898500; x=1718434500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmp5EIRQzTCqKBhpTa9jvpn+OZ84Sr4hexgAlaGRKvk=;
  b=hkt0CFKzb+9TECVXW4dy7clgdH+vcsETGi6p8eYrcFmHXZ9Y/5tOfDeT
   L1yQLv040v9KLSf4Y45gnaR7NAtEZ9ouJaRRghrh1QA1dEzISdpoUBoH4
   lrfR0ZTUGuikdvWEi0bZzvGbYmnleWBNaTcw3pTJ0v2UJIXEDhJ+CKxS/
   moDR6LixOiBlFKxL5VxvCxMKo0Xx0VKmr4uhh9fJdQXD/2MEh9oSt/Uq7
   ThOFGcocLHjZV1p+tDXRcjjX0/Vk9lyrOCW+sZ8hFUvle6pSNCk/DMMpU
   tczNFKsUtAvR6VRHhbnaVtT2JYzJfSwe2/P+5vk/j2Uxg2KD1lTnC2n+W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078910"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078910"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720186"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720186"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/20] wifi: cfg80211: add element defragmentation helper
Date:   Fri, 16 Jun 2023 09:54:05 +0300
Message-Id: <20230616094949.29c3ebeed10d.I009c049289dd0162c2e858ed8b68d2875a672ed6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

This is already needed within mac80211 and support is also needed by
cfg80211 to parse ML elements.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h | 22 ++++++++++++++++
 net/wireless/scan.c    | 60 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 94ca5cb340f6..cf14a93e61eb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6664,6 +6664,28 @@ cfg80211_find_vendor_ie(unsigned int oui, int oui_type,
 	return (const void *)cfg80211_find_vendor_elem(oui, oui_type, ies, len);
 }
 
+/**
+ * cfg80211_defragment_element - Defrag the given element data into a buffer
+ *
+ * @elem: the element to defragment
+ * @ies: elements where @elem is contained
+ * @ieslen: length of @ies
+ * @data: buffer to store element data
+ * @data_len: length of @data
+ * @frag_id: the element ID of fragments
+ *
+ * Return: length of @data, or -EINVAL on error
+ *
+ * Copy out all data from an element that may be fragmented into @data, while
+ * skipping all headers.
+ *
+ * The function uses memmove() internally. It is acceptable to defragment an
+ * element in-place.
+ */
+ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
+				    size_t ieslen, u8 *data, size_t data_len,
+				    u8 frag_id);
+
 /**
  * cfg80211_send_layer2_update - send layer 2 update frame
  *
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 75e6e032bb3a..dc71c6ac5bf5 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2288,6 +2288,66 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 	kfree(profile);
 }
 
+ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
+				    size_t ieslen, u8 *data, size_t data_len,
+				    u8 frag_id)
+{
+	const struct element *next;
+	ssize_t copied;
+	u8 elem_datalen;
+
+	if (!elem)
+		return -EINVAL;
+
+	/* elem might be invalid after the memmove */
+	next = (void *)(elem->data + elem->datalen);
+
+	elem_datalen = elem->datalen;
+	if (elem->id == WLAN_EID_EXTENSION) {
+		copied = elem->datalen - 1;
+		if (copied > data_len)
+			return -ENOSPC;
+
+		memmove(data, elem->data + 1, copied);
+	} else {
+		copied = elem->datalen;
+		if (copied > data_len)
+			return -ENOSPC;
+
+		memmove(data, elem->data, copied);
+	}
+
+	/* Fragmented elements must have 255 bytes */
+	if (elem_datalen < 255)
+		return copied;
+
+	for (elem = next;
+	     elem->data < ies + ieslen &&
+		elem->data + elem->datalen < ies + ieslen;
+	     elem = next) {
+		/* elem might be invalid after the memmove */
+		next = (void *)(elem->data + elem->datalen);
+
+		if (elem->id != frag_id)
+			break;
+
+		elem_datalen = elem->datalen;
+
+		if (copied + elem_datalen > data_len)
+			return -ENOSPC;
+
+		memmove(data + copied, elem->data, elem_datalen);
+		copied += elem_datalen;
+
+		/* Only the last fragment may be short */
+		if (elem_datalen != 255)
+			break;
+	}
+
+	return copied;
+}
+EXPORT_SYMBOL(cfg80211_defragment_element);
+
 struct cfg80211_bss *
 cfg80211_inform_bss_data(struct wiphy *wiphy,
 			 struct cfg80211_inform_bss *data,
-- 
2.38.1

