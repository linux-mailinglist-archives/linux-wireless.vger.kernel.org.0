Return-Path: <linux-wireless+bounces-22620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F552AAB1D6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920E84C15FA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FD379947;
	Tue,  6 May 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPeIGBk/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6B2D47A9;
	Mon,  5 May 2025 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485621; cv=none; b=UIOxIDY63wD+mw9duUbkNdANMNrzQh9xxBJWfjM4msbOgTJrZrQUGMhvQEG9iq/R215kfIld9/hkUq2Xrf25LbM5FcIDfrHWoOa6HtN30wi6y64NwDDumHZZQvMozh0N0A/4Cqi35i5D+DW5YiWqUxSZVr44ySu6P4RrwIg3jeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485621; c=relaxed/simple;
	bh=KUHtUFlOo+j8SD1SAnnT4iadnOMevvLSx+1L2WkbeHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4fQdKMm2D96YPog3e1cYOyyVLMPiZoQOb4nS569BnR/ue6qKlaPxSiDZFFCoqcdK4s3JUHld4W4DQurcVhUcKCnbP0kuk871QEFaXbhUFSFa5qoSlrlfjOhY973y5KACu8FbfWh1Jg600KTk1uVlbQw1lsXUd5kDjPZQcLloog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPeIGBk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F898C4CEE4;
	Mon,  5 May 2025 22:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485620;
	bh=KUHtUFlOo+j8SD1SAnnT4iadnOMevvLSx+1L2WkbeHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPeIGBk/fuhcrUFILlZ0WNLuwsHC69Vx6zL4Kyt3GMsuvIEPmgWA56Fl0OxIbcrA5
	 RBRTNUHSOkka0wXl+riVK5PCfSzm8dwTTIwfydQcUvIzQ2zYWSxn4y1dRX6rwADMrI
	 IlrNz/N+6MjDjoTRYtcacKxSlT0sHV7a5O9LmTGCv00SADpzQfDUNy7gFNfmK+/cDg
	 RxAl8DV0d4166q5qQIR1aGkWdLTtJVHMMlRGPegW01H9KTEgk6vQo0E5u9s54ubPmx
	 CE1MYQLOsJgwSaDg8+xP2gTJV1vSu36EA0YwJC7DZd7+YGkn9MkizzkfnBi2Lbgo1V
	 FvWJ8MPmkX22A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 391/486] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Mon,  5 May 2025 18:37:47 -0400
Message-Id: <20250505223922.2682012-391-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f4995cdc4d02d0abc8e9fcccad5c71ce676c1e3f ]

In the original commit 15fae3410f1d ("mac80211: notify driver on
mgd TX completion") I evidently made a mistake and placed the
call in the "associated" if, rather than the "assoc_data". Later
I noticed the missing call and placed it in commit c042600c17d8
("wifi: mac80211: adding missing drv_mgd_complete_tx() call"),
but didn't remove the wrong one. Remove it now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.6ed954179bbf.Id8ef8835b7e6da3bf913c76f77d201017dc8a3c9@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ba0af3018cf58..7d76bbcfdf48c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9220,7 +9220,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.39.5


