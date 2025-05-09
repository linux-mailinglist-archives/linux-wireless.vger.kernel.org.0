Return-Path: <linux-wireless+bounces-22802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0973AB1C93
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A253B9AB7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7C23A9BB;
	Fri,  9 May 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8GPCl+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626222D9E3;
	Fri,  9 May 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816410; cv=none; b=khxEvTLjNjH0xbXNCS4nLaV5qk/JeR5kH7NQmqZKX4vUSX5KzcxyGxoMsZCsrhnYXiB+ETxMhW9ypE7YCwjIQoJcW6PN+nUWUZgj2tAiZmhgHQ9LFv3O0OGIyMcWEQC+c3eZQnvh0tGpB0XBhJ+Fak2qgVFHiJG2rFkU/PGb1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816410; c=relaxed/simple;
	bh=0IYSJZP+vopsl32QzxWaoWc4qSlTuODcE7niYwOvhOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8HTBArHNG+oI5LdJwMPbuyM6pZhrVM16RWs6ju19imQyijH784JOGA5NtvkkREXpPfBql7S9zo17GH0MK7VPfz5fKVF8SVQ5aminuPyqMjEqHOKwSTAJOLMoIhP+1n7WdoRO7ODSmD5G5BkoRKECwLsRqeOnvzkixtaxXM4mMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8GPCl+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF5C4CEE4;
	Fri,  9 May 2025 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746816409;
	bh=0IYSJZP+vopsl32QzxWaoWc4qSlTuODcE7niYwOvhOo=;
	h=From:To:Cc:Subject:Date:From;
	b=G8GPCl+Q3sgiAMDhd3tWe0A8LycYxWsh2q1C2WpY8OGgIuufqCRhtLy0Dtw+Lhqhm
	 th6OXOHYPF13Blt1VSlVzXRHPnw3JDM4v92tMWIOMLSEMjui5HG+hNmCC5eT/e/49p
	 S42Jz2on+vEnkheol2VrO/suB+JPJOO1KWcyMhPgQlDtC4ysmo8ll8wG+p9VtRzqUe
	 onnqW31yjswAhU8nIzZwRrL1UV91kutDiFq/psBxsRZMiHg8Plmlq+KPo8uXG+V3jh
	 lQO/9eIivT/m49zSza47xhL4WvxeSYU6bf1fFn/WSQlQaj0KMsbC/2Cw13HafOvcHe
	 9voL87X0tsMJg==
From: Kees Cook <kees@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: Kees Cook <kees@kernel.org>,
	syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request
Date: Fri,  9 May 2025 11:46:45 -0700
Message-Id: <20250509184641.work.542-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=kees@kernel.org; h=from:subject:message-id; bh=0IYSJZP+vopsl32QzxWaoWc4qSlTuODcE7niYwOvhOo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlyvlNLTmRsD+08cH+pk1j7qvjzFQEGp846yvwXNJqf8 4ObOelhRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESOfGL4nzXvAP/Ju49F5VR+ 5eUwyaze1nrtNWP9uXW90ge3p/4KCWdkOM/Ac/3f9weuT9mi4iqELvyfG2lWrJPKbVNgIRcyM6K HAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Make sure that n_channels is set after allocating the
struct cfg80211_registered_device::int_scan_req member. Seen with
syzkaller:

UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:1208:5
index 0 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')

This was missed in the initial conversions because I failed to locate
the allocation likely due to the "sizeof(void *)" not matching the
"channels" array type.

Reported-by: syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/680fd171.050a0220.2b69d1.045e.GAE@google.com/
Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: <linux-wireless@vger.kernel.org>
---
 net/mac80211/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 741e6c7edcb7..6b6de43d9420 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1354,10 +1354,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_MONITOR);
 
 
-	local->int_scan_req = kzalloc(sizeof(*local->int_scan_req) +
-				      sizeof(void *) * channels, GFP_KERNEL);
+	local->int_scan_req = kzalloc(struct_size(local->int_scan_req,
+						  channels, channels),
+				      GFP_KERNEL);
 	if (!local->int_scan_req)
 		return -ENOMEM;
+	local->int_scan_req->n_channels = channels;
 
 	eth_broadcast_addr(local->int_scan_req->bssid);
 
-- 
2.34.1


