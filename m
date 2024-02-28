Return-Path: <linux-wireless+bounces-4157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB32D86AA90
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0046F1C2257F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736E2E859;
	Wed, 28 Feb 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nh7PY4HV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66C2D634
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110647; cv=none; b=RozK9vIUAC/3jwOK+FbqK4MYuAAdfz6BPd77h1wM9PQFD+whimmkOVMIWEFdInEdlt4R/RoO2b+HMt0GIjpWJAlzGt6LX/xNmMFlEtdUSVey5ScT5MxS82c/NMwBS16FlIjUOCYI7ko50sRvyuTMArrJ0wHfueKvmp2z6GY+PwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110647; c=relaxed/simple;
	bh=9p/8R5xpQME0ahLYJWI7Np6q91vKG2DNwPpnX1RNd4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZz9UrJs3SAnJyiPJDouF3MQOGbdF0xfd74IQFDpU4ZWo8IKyLPGCC7hyrmG5GCvS9y0cItSFRJ+v6pr1IzH8SRY/dFk5zS+NEH/CPpjfNtWscWCKgN8rwRPqf1sCnB/YhrQtm86l2DUiKzLkAmdxMvFnL9IL3rBtxWHtZyEIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nh7PY4HV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=THwLqqAS9RcFEanJ/N3PZCprSmFGuglzQTg5dGb2gs4=;
	t=1709110645; x=1710320245; b=nh7PY4HVNksfSSOnlmoWgrTOhtdHvkcv6RUMoUm5eZQ+5TT
	RFMfDOOeIFvt8QfsbQRMegva5KhrBlwi2CIbVAQNV2BJChs7b9OiPL2jPy3hBjS+q6hjF9XMSAvvE
	KVmRpwCytbu+s3U54YuJ8o87naeI60giebAUT+Fg5/4rY9DBdsyxUerNDY6xkxLkLHHQAm8wp2d4l
	02zmwMYPRzNluzR5yPeH8au6WsA7g/p2GLjUeBlUFKj6tpsXwBK4h/yY+hu1xza1v5sdauepe5Gkj
	RvqrCdBoPZ+n3C0/eLXwfxScchSq93RtB0jc7ZF4w4K7frXFYKmWpiFsPkRpljhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkg-0000000C0hJ-32dZ;
	Wed, 28 Feb 2024 09:57:22 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/8] wifi: cfg80211: allow cfg80211_defragment_element() without output
Date: Wed, 28 Feb 2024 09:55:42 +0100
Message-ID: <20240228095718.6d6565b9e3f2.Ib441903f4b8644ba04b1c766f90580ee6f54fc66@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we just want to determine the length of the fragmented
data, we basically need the same logic, and really we want
it to be _literally_ the same logic, so it cannot be out
of sync in any way.

Allow calling cfg80211_defragment_element() without an output
buffer, where it then just returns the required output size.

Also add this to the tests, just to exercise it, using the
pre-calculated length to really do the defragmentation, which
checks that this is sufficient.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h             |  4 ++--
 net/wireless/scan.c                | 27 ++++++++++++++++++---------
 net/wireless/tests/fragmentation.c | 30 +++++++++++++++++++++++++-----
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 53653d234d39..2e2be4fd2bb6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6908,8 +6908,8 @@ bool cfg80211_iter_rnr(const u8 *elems, size_t elems_len,
  * @elem: the element to defragment
  * @ies: elements where @elem is contained
  * @ieslen: length of @ies
- * @data: buffer to store element data
- * @data_len: length of @data
+ * @data: buffer to store element data, or %NULL to just determine size
+ * @data_len: length of @data, or 0
  * @frag_id: the element ID of fragments
  *
  * Return: length of @data, or -EINVAL on error
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 9377a43aa5f7..5a5dd3ce497f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2504,16 +2504,22 @@ ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
 
 	if (elem->id == WLAN_EID_EXTENSION) {
 		copied = elem->datalen - 1;
-		if (copied > data_len)
-			return -ENOSPC;
 
-		memmove(data, elem->data + 1, copied);
+		if (data) {
+			if (copied > data_len)
+				return -ENOSPC;
+
+			memmove(data, elem->data + 1, copied);
+		}
 	} else {
 		copied = elem->datalen;
-		if (copied > data_len)
-			return -ENOSPC;
 
-		memmove(data, elem->data, copied);
+		if (data) {
+			if (copied > data_len)
+				return -ENOSPC;
+
+			memmove(data, elem->data, copied);
+		}
 	}
 
 	/* Fragmented elements must have 255 bytes */
@@ -2532,10 +2538,13 @@ ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
 
 		elem_datalen = elem->datalen;
 
-		if (copied + elem_datalen > data_len)
-			return -ENOSPC;
+		if (data) {
+			if (copied + elem_datalen > data_len)
+				return -ENOSPC;
+
+			memmove(data + copied, elem->data, elem_datalen);
+		}
 
-		memmove(data + copied, elem->data, elem_datalen);
 		copied += elem_datalen;
 
 		/* Only the last fragment may be short */
diff --git a/net/wireless/tests/fragmentation.c b/net/wireless/tests/fragmentation.c
index 49a339ca8880..411fae18cd88 100644
--- a/net/wireless/tests/fragmentation.c
+++ b/net/wireless/tests/fragmentation.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for element fragmentation
  *
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
@@ -27,7 +27,12 @@ static void defragment_0(struct kunit *test)
 
 	ret = cfg80211_defragment_element((void *)input,
 					  input, sizeof(input),
-					  data, sizeof(input),
+					  NULL, 0,
+					  WLAN_EID_FRAGMENT);
+	KUNIT_EXPECT_EQ(test, ret, 253);
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, ret,
 					  WLAN_EID_FRAGMENT);
 	KUNIT_EXPECT_EQ(test, ret, 253);
 	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 253);
@@ -63,7 +68,12 @@ static void defragment_1(struct kunit *test)
 
 	ret = cfg80211_defragment_element((void *)input,
 					  input, sizeof(input),
-					  data, sizeof(input),
+					  NULL, 0,
+					  WLAN_EID_FRAGMENT);
+	KUNIT_EXPECT_EQ(test, ret, 254 + 7);
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, ret,
 					  WLAN_EID_FRAGMENT);
 	/* this means the last fragment was not used */
 	KUNIT_EXPECT_EQ(test, ret, 254 + 7);
@@ -106,10 +116,15 @@ static void defragment_2(struct kunit *test)
 
 	ret = cfg80211_defragment_element((void *)input,
 					  input, sizeof(input),
-					  data, sizeof(input),
+					  NULL, 0,
 					  WLAN_EID_FRAGMENT);
 	/* this means the last fragment was not used */
 	KUNIT_EXPECT_EQ(test, ret, 254 + 255 + 1);
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, ret,
+					  WLAN_EID_FRAGMENT);
+	KUNIT_EXPECT_EQ(test, ret, 254 + 255 + 1);
 	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 254);
 	KUNIT_EXPECT_MEMEQ(test, data + 254, input + 257 + 2, 255);
 	KUNIT_EXPECT_MEMEQ(test, data + 254 + 255, input + 2 * 257 + 2, 1);
@@ -134,7 +149,12 @@ static void defragment_at_end(struct kunit *test)
 
 	ret = cfg80211_defragment_element((void *)input,
 					  input, sizeof(input),
-					  data, sizeof(input),
+					  NULL, 0,
+					  WLAN_EID_FRAGMENT);
+	KUNIT_EXPECT_EQ(test, ret, 254 + 7);
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, ret,
 					  WLAN_EID_FRAGMENT);
 	KUNIT_EXPECT_EQ(test, ret, 254 + 7);
 	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 254);
-- 
2.43.2


