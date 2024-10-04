Return-Path: <linux-wireless+bounces-13497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8C990056
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467BC1F24925
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E11465B1;
	Fri,  4 Oct 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbS5LmLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB106145B0C;
	Fri,  4 Oct 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035666; cv=none; b=byyDz/mU+51Ty3BmDI5a74MPfxXYU+KhI4urpjt+RO6mRFZKlIqGzrY+yelMYIUDxXq2V0RSgyu/nhxFhC2cvGU0XbwRz/QSu06JNxGIqfuw3ep/VILmtiVMFnq0lk66eucFpwWoY14eFgchqlCDgqmg7T+dn8RjP40ExrxlJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035666; c=relaxed/simple;
	bh=GIekdLf920VjYQWuOHpXecODWknJgd0TvVRyo6zOyWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NUKasyffnB+Wpkm2oXApI+H4kDwg8i9FEGLl8LYOV5bvcas2mBSosbXN2NMueGI9juE9D7PPlzd61dHKCbTx+bnT/dJkMYbjKXul5cewUdqi1BsE6po0dsWU8xH9K6u+cqcyrkajhcZDbKxI17jdr9YYrfUZKdjdD16+WICDveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbS5LmLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E3BC4CEC6;
	Fri,  4 Oct 2024 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728035666;
	bh=GIekdLf920VjYQWuOHpXecODWknJgd0TvVRyo6zOyWg=;
	h=From:To:Cc:Subject:Date:From;
	b=pbS5LmLayz5YFv3aDX7vOrXQyUBdS7od4SGqy6tjKZ8S+S0jXLM+Gswg2DiB1IGIj
	 G0XybEDl9mWsXkTS86ZIQgZq3tU4ydLowy3nR9ZpGd03HT5uUap6mqnvpgk2+8Z+nS
	 tZbj77btt5Qu4x4x91TJJlUFlt+snn56vaNaSaHLSN0opWQ2JEcw1mAvS+zVQsZ2bA
	 kGmv3Qn73t7/mODTJe5Yo9KyDWHIntnvtDY2IYXM3RSlzJqrRr34O6Z+vNCYbh3sBW
	 gGsrpc5ocZeBwnM+XHE9EFpDnVSFMA6rLXMOKCeXrUebvHwRo4d89saTIyF6mobC9O
	 zyFaBbbZbpj3w==
From: Arnd Bergmann <arnd@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix one more memcpy size error
Date: Fri,  4 Oct 2024 09:54:13 +0000
Message-Id: <20241004095420.637091-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous patch addressed a fortified-memcpy warning on older compilers,
but there is still a warning on gcc-14 in some configurations:

In file included from include/linux/string.h:390,
                 from drivers/net/wireless/ath/ath12k/wow.c:7:
drivers/net/wireless/ath/ath12k/wow.c: In function 'ath12k_wow_convert_8023_to_80211.isra':
include/linux/fortify-string.h:114:33: error: '__builtin_memcpy' accessing 18446744073709551610 or more bytes at offsets 0 and 0 overlaps 9223372036854775797 bytes at offset -9223372036854775803 [-Werror=restrict]
include/linux/fortify-string.h:679:26: note: in expansion of macro '__fortify_memcpy_chk'
  679 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wow.c:199:25: note: in expansion of macro 'memcpy'
  199 |                         memcpy(pat + a3_ofs - pkt_ofs,
      |                         ^~~~~~

Address this the same way as the other two, using size_add().

Fixes: b49991d83bba ("wifi: ath12k: fix build vs old compiler")
Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath12k/wow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 9b8684abbe40..3624180b25b9 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -191,7 +191,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
 			memcpy(bytemask, eth_bytemask, eth_pat_len);
 
 			pat_len = eth_pat_len;
-		} else if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
+		} else if (size_add(eth_pkt_ofs, eth_pat_len) < prot_ofs) {
 			memcpy(pat, eth_pat, ETH_ALEN - eth_pkt_ofs);
 			memcpy(bytemask, eth_bytemask, ETH_ALEN - eth_pkt_ofs);
 
-- 
2.39.2


