Return-Path: <linux-wireless+bounces-22646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA228AAB538
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C64517D9FE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5903A885F;
	Tue,  6 May 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7q2zsVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF62F5F8C;
	Mon,  5 May 2025 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487050; cv=none; b=Ki9g9U3AmRmZTaYZLmctIYnClQBhSnYFTBMw+NNLYUC3RGOxJpn1b0p1j2WA6Yb9O64It9E2RW6ewsuT3BkFuGs7nHPPH6CDnz25GbhctVi1p4ESRzNCvmiGi0pf1arIy8656vf8g9NkWaD9lLjSd56yv+lI+APUkq7oQ3SRIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487050; c=relaxed/simple;
	bh=T2qmy5ncWhxt5hWVNFScjFQX/mUJeyWHOuGCtBfYFg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfuP16VfjfXUxvNNK6kEsA1xCnff4wOz4m6aGhQ8ez4YwwaElhbR15o+VVV+toGRWvaqwkOlwRMFsZ7k5Rdr+LXb8apAqfKfJ2IyUA5xcI2NmR4WWq4UWxC/cXsXaSwVcCJO1wU9f3W0uBBBwcmaktKb8c3SjiS9ECxqvQiM3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7q2zsVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CEC4CEEE;
	Mon,  5 May 2025 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487049;
	bh=T2qmy5ncWhxt5hWVNFScjFQX/mUJeyWHOuGCtBfYFg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7q2zsVbf8OIe06LqqCcm2geeJAN3nkMVStv1XPNQJ3l2wzjl2BAfNIulHP1cGAjs
	 n5fsP6BX5yeHcC+jnWO5ppFD1JYJ4H1thEEPEApZIP3Yi5Mm+avdXdmgCWNyovwCw/
	 b2pi1RgVD6WYgZ8Vif3+aqiR9i5tsDbwTZJxR+CHerz4gWI0vEIcK+oJzA/ae3VXTI
	 386H9IaOJ74ufDsZsDF+2iiFkg/kPS6OuGSz2Q6E6Y6s/56NQQayRHsUAKNiPXBAXz
	 MC4kBC4+r6OCLNXl/ZklM/TB1L33iHUl91fzPlG7a5XtykMlzVzALeHtLYy1wqSrYX
	 NVrDYIf9CD9Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 127/153] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Mon,  5 May 2025 19:12:54 -0400
Message-Id: <20250505231320.2695319-127-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 11d9bce1a4390..ae379bd9dccca 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5952,7 +5952,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.39.5


