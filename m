Return-Path: <linux-wireless+bounces-20122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4EA5A707
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A873A9CF7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ACF1E834D;
	Mon, 10 Mar 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTNJnPVr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8B1E503C;
	Mon, 10 Mar 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645404; cv=none; b=Xl1mHSabPshqmQqSi9FHuYtETIDay06Yf9MXDtCr+O89rzsJtQmL9s3mWQcw2JE7d7/igOwNVcOftNbYZz352/kBgQMaIgP7IH4FoCdHmLxbdxIXcmuRFszet8QjruLxlP7+XPxLm0YkXdV0GiWXFeGvTt3hUrBlqfwRvhUXIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645404; c=relaxed/simple;
	bh=UNmm9RS/yfYAKBLQP50xWexf9GUOonoXsXhHuSApK34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RT/X3YuNJ1LWcUgIhfOtX6ABV8fiUxVnUwmJb80HDkWrAfsXEGFzlVDbrT2UG41d3+8XRbY3f+sBcgDdYnjiRsTdcBlvM7UZtMgTKFZ6gOjeQ1hOwlKV/Iq6UcmkDiFSj0cUoi2FyqiwGdEbR226k4AX1XSkUkfbyu0vvhxVFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTNJnPVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15F8C4CEE5;
	Mon, 10 Mar 2025 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645403;
	bh=UNmm9RS/yfYAKBLQP50xWexf9GUOonoXsXhHuSApK34=;
	h=From:To:Cc:Subject:Date:From;
	b=cTNJnPVrag8vikQ/xd4lwwXe42aQ7c4ptKLo9D+JnoJE6J+g4XwJqIyNho/ISmOqZ
	 i4b8qrCHTWWe/zhRfJc8ZBQa5cPaSRtbgvP82UuL6Cqr27OEHLVQgRgDkiEpk3sfHU
	 QvuUDgX2rZxNwPFgniPGAdGpBxgqDxLctXGxPQofXG3yMFUrZBDDQGdkOYBj5ra10q
	 bEzjf3Bz5VeGcM9ntYhCICtMpxTVGw9Eaka0W3gQKxz0yDeeTUXPVv3i/l+Uul+SIq
	 ATfhnqxxwz5zLM9ipN+2gsnjbE/UdGoQQxIAu+z5VcaeoRYjl23W5QD6uPKNNxzCg1
	 WU9wtjd5Ejt3w==
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	En-Wei Wu <en-wei.wu@canonical.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Alexander Wetzel <alexander@wetzel-home.de>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-kernel@vger.kernel.org,
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:23:19 -0700
Message-Id: <20250310222318.work.395-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=kees@kernel.org; h=from:subject:message-id; bh=UNmm9RS/yfYAKBLQP50xWexf9GUOonoXsXhHuSApK34=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn08Jm5Mbv7ZnbFtIbYnLy2ur4AxyLPTm1JdyVI9ZEX 1t9dEFvRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQETzEyvFCy8jum1xtvVu8m rR10a8JCFi6FmIfnlO9tCNbN//osn5Hhu2Pfe6UXPn0mnd4fape8bqw/Kf1OWvH0if3ixusTk3k YAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: En-Wei Wu <en-wei.wu@canonical.com>
Cc: Shaul Triebitz <shaul.triebitz@intel.com>
Cc: Alexander Wetzel <alexander@wetzel-home.de>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/wireless/virtual/virt_wifi.c     | 2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..fc122b79301a 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -146,7 +146,7 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 	static const struct {
 		u8 tag;
 		u8 len;
-		u8 ssid[8];
+		u8 ssid[8] __nonstring;
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
 		.len = VIRT_WIFI_SSID_LEN,
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index f90c33d19b39..9653dbaac3c0 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -21,7 +21,7 @@
 
 struct zd_reg_alpha2_map {
 	u32 reg;
-	char alpha2[2];
+	char alpha2[2] __nonstring;
 };
 
 static struct zd_reg_alpha2_map reg_alpha2_map[] = {
-- 
2.34.1


