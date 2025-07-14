Return-Path: <linux-wireless+bounces-25380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760D9B03E86
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 14:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEABC166531
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB881C3C1F;
	Mon, 14 Jul 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b3ninPoV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73731225771
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495698; cv=none; b=FcuQjrOjyTyucb8/sz3Ppz+bgwHi/DgwYJJ9b86xvyMbYKnQKU0H8U9+n1I8M5zUwEBD6PRqJcXPYF1Tm7AMC5x8Ugu500AJ4UIm860f9EAamQctGvc3s5S5T84/k/OZIYzUI68bTBdc7J9XULYVUT5OovDtBEVUCzufgyF38mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495698; c=relaxed/simple;
	bh=YkoOzzWplZWh5SS3psE0kchoGCdvKNOmrbAg+68nmAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s13I/Wf/VQQwN127XvKo4XDXQsGdtbVwyzLYDAIXDKWTFbkXcvRipRdQ0Ru1kdQsgQ4nwnxwQAT+YvlgQ9hqSAr09Xz6YDo4lytrRLzS8/RVaESQKTxjRf6f4pJnPA8mVNb/cbofecXQ31Bdk0JwMuLTFY4xhMx06dzbhc6GqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b3ninPoV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=J4YNLS6nVkp4q9l7NvCxK9hFBtIsGX2jIXFD7Bw7Kyo=; t=1752495696; x=1753705296; 
	b=b3ninPoV+0+PGoBknx0dXTpXlo9hDBlT49gpsUDtg2Gfgf5IVHUf38SX+PZI2715MOisemgvUbS
	XJ39fCU9yk8CVI29LBqCwWB4LF8DgJlX2hI//IyTQyrj1bnlG0wxuErdVJiWFNHKjc38UhcwNWGSz
	x8YTxZQtjJQpm/XXTHm8DKS33jcAUGKyCY176u+fFqqE+N7LQ0DI8JshCUUk2Cy9i2x+JzJrDpnZB
	UJybnOJYm+S8iPmSYlFo+mPqKvhfp/eYf4XLl2jx7HOUjVPT/TyuNG4XKS1cuQC6jt8ln3XqldfJH
	CaIXmXWboJdAdrG1Xea/l0YPoa07beWCPE8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubIBY-000000043Lb-45LQ;
	Mon, 14 Jul 2025 14:21:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Haoyu Li <lihaoyu499@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: cfg80211: remove scan request n_channels counted_by
Date: Mon, 14 Jul 2025 14:21:30 +0200
Message-ID: <20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
cfg80211_scan_request with __counted_by").

This really has been a completely failed experiment. There were
no actual bugs found, and yet at this point we already have four
"fixes" to it, with nothing to show for but code churn, and it
never even made the code any safer.

In all of the cases that ended up getting "fixed", the structure
is also internally inconsistent after the n_channels setting as
the channel list isn't actually filled yet. You cannot scan with
such a structure, that's just wrong. In mac80211, the struct is
also reused multiple times, so initializing it once is no good.

Some previous "fixes" (e.g. one in brcm80211) are also just setting
n_channels before accessing the array, under the assumption that the
code is correct and the array can be accessed, further showing that
the whole thing is just pointless when the allocation count and use
count are not separate.

If we really wanted to fix it, we'd need to separately track the
number of channels allocated and the number of channels currently
used, but given that no bugs were found despite the numerous syzbot
reports, that'd just be a waste of time.

Remove the __counted_by() annotation. We really should also remove
a number of the n_channels settings that are setting up a structure
that's inconsistent, but that can wait.

Reported-by: syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e834e757bd9b3d3e1251
Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..10248d527616 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2690,7 +2690,7 @@ struct cfg80211_scan_request {
 	s8 tsf_report_link_id;
 
 	/* keep last */
-	struct ieee80211_channel *channels[] __counted_by(n_channels);
+	struct ieee80211_channel *channels[];
 };
 
 static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
-- 
2.50.1


