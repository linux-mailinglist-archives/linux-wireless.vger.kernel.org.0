Return-Path: <linux-wireless+bounces-9734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C398D91D4EE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07E91C209FC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A51DDC5;
	Mon,  1 Jul 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDTd3jFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7A1B809;
	Mon,  1 Jul 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792749; cv=none; b=tHyqLYpKQ5dCAcm9NeoqSFQISxE+JCu6CCy3+RJdrNMNytRJ454uCwV8Rdw6zgU+umR+62LcFo4qsPCjWaXPq9i3+aKiuTrbnkJacwHhgUc79gSuUzxXlVZ2TgyJPkagh0BswP5QQNO+pg1LTauKdHNeJ2+/r/3+bEM6N5SucxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792749; c=relaxed/simple;
	bh=qosA47Vhtvnlyiu8rd1aoEb9fKbO77uQ7jx7Tr9FaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ5QZ4ZjD6RaxIdI7Sr+MwJ7XUyEO5VMMFT6h6y/LMpjfROUJ6eLnuQvZHHLn20BWzqQtbYO0JSW/c2s1Z8D7H+hBOmUpw8kkedgFb/3d+RfgW4XMUPOx5sPxNNGzhsneyRVqJyJTXZSnCADTSNzTiHvZWIDALUAdmfRrU7M3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDTd3jFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50742C4AF0A;
	Mon,  1 Jul 2024 00:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792749;
	bh=qosA47Vhtvnlyiu8rd1aoEb9fKbO77uQ7jx7Tr9FaLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDTd3jFY3aqLyobI51R8XW5BkVf7NAKiPOtDFhaU/cwUXN4c07cuZfpYevYTOHuiI
	 pKaUZ1mTzh/RuLJv7zpjDevfBnEOa9lOe7epM1f3jEI1Xy2YWqZz4iXYr4F5doBP8f
	 bx3/aqIDfHqaBkKcYFyVWIAtTEL8Wxc+FD1SykT/av7e3j6IbUiGsCQD3e+0QRE45a
	 NZXXB3y/dye8qBcd6JySSuE3mUPahcDNJ9VNhjHiz4E7UJ15keGbPiTrjBxSsZRFHa
	 ZgZDOhgNyiutKZ5pxTmMyisbhMZIY5XJvdJhDwUY2tP3M6vIZcNEWty6+f6K+QGkHp
	 dkS5gyoi20+wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <keescook@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 07/20] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Sun, 30 Jun 2024 20:11:12 -0400
Message-ID: <20240701001209.2920293-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 3da1c5c450358..a142d18fb6824 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -358,7 +358,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -368,34 +369,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.43.0


