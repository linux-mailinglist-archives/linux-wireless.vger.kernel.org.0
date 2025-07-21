Return-Path: <linux-wireless+bounces-25757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B673B0CA68
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45667545DD2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2A42E0924;
	Mon, 21 Jul 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6BuENrs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC941FE44B;
	Mon, 21 Jul 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122324; cv=none; b=F5ymIE1P4Auo8lFwnisDjxZEem2cu8mbEsfoFhKTo8gv1o1LEZXQD1358MChqE5ylHZZtB9GsMKp5DqLorNmXwnNSatUJdeR2aEsLfMFrdoCpcf0+knqRK+ZBzryJiF8uUc/dgk+uE3PWyWN9adrx56FtCARR1fezAC06zUIcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122324; c=relaxed/simple;
	bh=wvbMmsVUiDjWvmvcQ0L5sIp428VMYjN3aS1x3uFeWVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7kTjsLF/rSbNEm9N7t3Z5Dj5ZqNhxRzvy8h+9YfIDhe2784kaOt6hiQ412sn+UhiDCAQWUuLjzrr8hDfxgDRnHSd2RdpaYlUf7SPLmVhhcVMQWuHcSUyWqcyauy+64ASZYVV5j77IYQcFQq6SwbnfGaZ9rqtREhNhkEG0ugpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6BuENrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F1C4CEED;
	Mon, 21 Jul 2025 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753122323;
	bh=wvbMmsVUiDjWvmvcQ0L5sIp428VMYjN3aS1x3uFeWVs=;
	h=From:To:Cc:Subject:Date:From;
	b=m6BuENrssSJuBKUSVpGRK7ehyD3IReggC/XX5EJjrAsedhG+GvVl7FvpDOMZtw8aP
	 y8cx2Q/f8JHzMKgBnlYHmlDT9A/U6p0H3dQuNfmhsqKiysljeb3f+LuIe4uK+K8OUJ
	 SY3NpPpeR86bIiI1XWGeEhe9J0DLJUE2oQz3PiX5oti87jCfS+LecbwsvxtPT88H/w
	 29BPCyfbsiU6g1c1+zfF5yajzh2OMktEY0crUf39wOswH+NR4CTYkAqzb+dvc1lmoi
	 YJ5NgiI4MXA6H5pW1u3hXOL/gvVSNV9dNJ5kFccVMtmqR/1O/euEOic9KqnVQ857J3
	 Hqi/d2QZaaXMA==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Write cnt before copying in ieee80211_copy_rnr_beacon()
Date: Mon, 21 Jul 2025 11:25:22 -0700
Message-Id: <20250721182521.work.540-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=kees@kernel.org; h=from:subject:message-id; bh=wvbMmsVUiDjWvmvcQ0L5sIp428VMYjN3aS1x3uFeWVs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl1bYKeLP9YzB6uYZeXlF6xX1GpRLrtoHLiFokVVuwq6 Rr355zqKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BuIgeI8Mco7RfH7V+evDd/F5d Y8wya5WAx4dTAet3zxS1e3S24vlMhn82TUZpe+XKtb6LrPm7WWxxlcnBybdnpNimFweHZeZpTWY GAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While I caught the need for setting cnt early in nl80211_parse_rnr_elems()
in the original annotation of struct cfg80211_rnr_elems with __counted_by,
I missed a similar pattern in ieee80211_copy_rnr_beacon(). Fix this by
moving the cnt assignment to before the loop.

Fixes: 7b6d7087031b ("wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: <linux-wireless@vger.kernel.org>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4f20d57ab913..2ed07fa121ab 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1176,13 +1176,13 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
 {
 	int i, offset = 0;
 
+	dst->cnt = src->cnt;
 	for (i = 0; i < src->cnt; i++) {
 		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
 		dst->elem[i].len = src->elem[i].len;
 		dst->elem[i].data = pos + offset;
 		offset += dst->elem[i].len;
 	}
-	dst->cnt = src->cnt;
 
 	return offset;
 }
-- 
2.34.1


