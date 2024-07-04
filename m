Return-Path: <linux-wireless+bounces-9991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7167927912
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 16:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC3F283755
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F41AEFF6;
	Thu,  4 Jul 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t01v59JH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88001AEFDD
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104224; cv=none; b=q12LZu1fE2hxMbdNl19eCDlkpYJbRkymkDLQhavVIw44T6JQuD+zNwhgd3a1IwwSnMWHkGJFxUjoR/yUSyXUa4OXhSerVUqgb0NmZvYfGTSmSUY4iRG23qPm5gpMrjMBFEW0ol6u27NLwwY3MTJke0pCwCQv5H7GL6ngJPXY1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104224; c=relaxed/simple;
	bh=N4s8/6qi1oS7xwW+tUh9JmEIMhJuYSSvDJCC4R27pZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o7zWTrsI/QlVbklDzLhx+UlLJSjuVfn9721NY3q7YZ4fpN9i0PRBNoYOJmYKnQlnb51ZtU9fo/szWx824XKA5YiDZMlxRwTrQj/R1Oq5fBM0qwb+V/YXF9S450s0TVSgirbmcDU9/ZaxEe+wXtDbt+5bq4Tr+46N87d8t+arYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t01v59JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71342C3277B;
	Thu,  4 Jul 2024 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104224;
	bh=N4s8/6qi1oS7xwW+tUh9JmEIMhJuYSSvDJCC4R27pZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=t01v59JHn7anfObFn/MYPWZJI/OI5dDIqXq1kKUjFGvIckN34GoV9ksB4mYJYDdIk
	 9Zq1XrD9dI9k9DtWgic9hdmiiH6DdM6z9+chSMkUEWXZT7Ij/FW/jFQMOXdUddcGmI
	 s/u991P6GWjquaJNslbS8NdwdJ9P8fI9n7yHgJB2isTuCN5iw4GIVzTvzkddh9dc1e
	 5hSPQVFqCS+MNiXUklVd4a1XrjaUfmMlI0w5Dm+7KCY5OqlZArBX53V2GwMwIEoqDR
	 ZIjik7e+W8fJkhZWT6fLnywmEPH2nMJCDhH+AY51dg8v1hxPEzFZh5F7R85CEQgM7r
	 Z1sHuVHrUQU5w==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kees@kernel.org
Subject: [PATCH RFC] wifi: ath12k: workaround fortify warnings in ath12k_wow_convert_8023_to_80211()
Date: Thu,  4 Jul 2024 17:43:41 +0300
Message-Id: <20240704144341.207317-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Johannes reported with GCC 11.4 there's a fortify warning below. The warning is
not seen with GCC 12.1 nor 13.2. Weirdly moving the other operand of sum to the
other side the warning goes away. This is safe to do as the value of the
operand is check earlier. But the code looks worse with this so I'm not sure
what to do.

In file included from ./include/linux/string.h:374,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:13,
                 from ./include/linux/sched.h:16,
                 from ./include/linux/delay.h:23,
                 from drivers/net/wireless/ath/ath12k/wow.c:7:
drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
  637 |         __underlying_##op(p, q, __fortify_size);                              |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                        |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
  190 |                         memcpy(pat, eth_pat, eth_pat_len);
      |                         ^~~~~~
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
  637 |         __underlying_##op(p, q, __fortify_size);                              |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                        |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
  232 |                         memcpy(pat, eth_pat, eth_pat_len);
      |                         ^~~~~~

Compile tested only.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index c5cba825a84a..e9588bb7561c 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
 	if (eth_pkt_ofs < ETH_ALEN) {
 		pkt_ofs = eth_pkt_ofs + a1_ofs;
 
-		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
+		if (eth_pat_len < ETH_ALEN - eth_pkt_ofs) {
 			memcpy(pat, eth_pat, eth_pat_len);
 			memcpy(bytemask, eth_bytemask, eth_pat_len);
 
@@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
 	} else if (eth_pkt_ofs < prot_ofs) {
 		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
 
-		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
+		if (eth_pat_len < prot_ofs - eth_pkt_ofs) {
 			memcpy(pat, eth_pat, eth_pat_len);
 			memcpy(bytemask, eth_bytemask, eth_pat_len);
 

base-commit: c1cacb01f35589bd41360cdb7535afc792c08a7c
-- 
2.39.2


