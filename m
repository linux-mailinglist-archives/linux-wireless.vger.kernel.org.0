Return-Path: <linux-wireless+bounces-34318-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMItM1ZdzmnvnAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34318-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 14:13:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0D388E57
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59659308B25E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E41A9FA4;
	Thu,  2 Apr 2026 12:10:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAE3D3332
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131832; cv=none; b=a6KxJ6Uu7OfX8z85KvDahkbEG3xYyiH49KP47Mj/YEexa/2BgtRR6EFVDB+qC47qYr/eS1f3GZKsa+wK99XCKZrexwSzzKfRzMNxglUm6wVmlht6sP3QpQfD7/ZpkoBMhf5RgvA7Ml/aDUMIHO6AUx+iNCXAsLVZqnjRfUsZG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131832; c=relaxed/simple;
	bh=clu2N2eW9N8i4tlthOzczgk1VDLmgxLp0nI92lesy6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2hCT9cXJYda3Tb9XKDyJXYmr7BOGhvM6DDwMfEAxfPaQlxbsMxeZxdZ7+FmD1TdOyKF3kWr0wv9NLS/2eirsYapGgQG3/4j2ifAdIXGa8SbCC5wAGYTZSq6ZRPZELIYIa5Mv7oXaydV/nLDNe+JaxUMcE4uyOodXabuMdaBQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAAnoACgXM5pbc2gAA--.222S3;
	Thu, 02 Apr 2026 20:10:13 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linville@tuxdriver.com,
	kilroyd@googlemail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	xuyuqiabc@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] wifi: cfg80211: wext: prevent encoding_size overflow in giwrange
Date: Thu,  2 Apr 2026 20:10:06 +0800
Message-ID: <20260402121007.339835-2-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402121007.339835-1-n05ec@lzu.edu.cn>
References: <20260402121007.339835-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAAnoACgXM5pbc2gAA--.222S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43ZF15Jr4kWr45Jw17Awb_yoW8uw47pF
	43C3sIqr97Wr12k348JFW8ZryxtaykuFn7W390k3s7uan7KF4Fqr9FgFy5uF4DZa97Gr4r
	AFnFgF1xGw1kCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQUFCWnNP3wVcQAAsL
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,tuxdriver.com,googlemail.com,gmail.com,lzu.edu.cn];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-34318-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71C0D388E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyuqiabc@gmail.com>

cfg80211_wext_giwrange() appends one encoding_size entry for each
WLAN_CIPHER_SUITE_WEP40 and WLAN_CIPHER_SUITE_WEP104 value advertised by
the wiphy. struct iw_range only provides IW_MAX_ENCODING_SIZES slots in
encoding_size[], so duplicated WEP entries can advance num_encoding_sizes
past the end of the array and corrupt the iw_range buffer returned by
SIOCGIWRANGE.

This can happen when the wiphy cipher list contains duplicated WEP entries.

Only append encoding sizes while there is still room in the fixed-size
array. This keeps the current behaviour for normal cipher lists and
truncates oversized WEP capability lists instead of writing past the end of
the buffer.

Fixes: 2ab658f9ce21 ("cfg80211: set WE encoding size based on available ciphers")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/wireless/wext-compat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 5a70a0120343..9c5ac7da774c 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -170,13 +170,15 @@ int cfg80211_wext_giwrange(struct net_device *dev,
 			break;
 
 		case WLAN_CIPHER_SUITE_WEP40:
-			range->encoding_size[range->num_encoding_sizes++] =
-				WLAN_KEY_LEN_WEP40;
+			if (range->num_encoding_sizes < IW_MAX_ENCODING_SIZES)
+				range->encoding_size[range->num_encoding_sizes++] =
+					WLAN_KEY_LEN_WEP40;
 			break;
 
 		case WLAN_CIPHER_SUITE_WEP104:
-			range->encoding_size[range->num_encoding_sizes++] =
-				WLAN_KEY_LEN_WEP104;
+			if (range->num_encoding_sizes < IW_MAX_ENCODING_SIZES)
+				range->encoding_size[range->num_encoding_sizes++] =
+					WLAN_KEY_LEN_WEP104;
 			break;
 		}
 	}
-- 
2.52.0


