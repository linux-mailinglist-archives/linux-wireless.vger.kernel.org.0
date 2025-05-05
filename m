Return-Path: <linux-wireless+bounces-22634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C9AAB34D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7B17A4AC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804F233D8E;
	Tue,  6 May 2025 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTyb2hFb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30284220F30;
	Mon,  5 May 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486283; cv=none; b=OpTTwmG30mywW/T/9mS1uxbtRz2CO+6zX8qDSCoA3eHdzy7lbOyOnE81BmTtZhr4DHugnNDFVgfQmk21CvPZ3EGJ5Ll9chMcyvfLGNJ/wxHpgRtwICLmEu4tTju69LhgAeHJ13x/Dq5TI4V6+DHXXpSA10v4WBlO10UzfYQ+xxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486283; c=relaxed/simple;
	bh=HYmXqjYu3rvNOscRW8nTFJ53wN59Z/5Opd9boYQ/7Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkgdBivUEt+dKJOfAlgh3AZbn32OQ7ByEOj+zmxU8gkRoqzdWWiegwWtblDW31st8DRran0kgptpIwVebbE67ZtsVr2A32yVQyEz3xci4/Egi0rApbj+N3yqA3KHlYnmupRH90ZI6bN+4dnf7ei/Q09VLACMj9jiwnWD7lkz8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTyb2hFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAFCC4CEEF;
	Mon,  5 May 2025 23:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486282;
	bh=HYmXqjYu3rvNOscRW8nTFJ53wN59Z/5Opd9boYQ/7Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTyb2hFbESqqp7fX07CRDw2ZeiBL/bvDSVQFIaXfJ5KWzl5ygdZ/3fTHEj8uB3Bc3
	 U6GQRVthnlxewOaZeT89gxa2jMaFi0qEKfDz4rP9ipLNJayydDxbsrF8tzUKh/wpru
	 W4VJCbxcOOnNgZuJNKYIdnm3lOmf3Pxq06XHGTA5LUuEx/fddcnSCMXgp3ccow/IKk
	 9BgpONmtPhZC0nusam0kfxjYJchnCtfNM/jAlhZqeW3glvPEV6szwuncLhVCTKyOSC
	 yKpMKE9G8GWMV2mjclh7PFADcFRvbtyrUzqst/jVkHvENrNZBfMJawBUv/1Mgbs1mE
	 swpBKof2Az63A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 238/294] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Mon,  5 May 2025 18:55:38 -0400
Message-Id: <20250505225634.2688578-238-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 37163d84104fa..2c7e139efd532 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7822,7 +7822,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.39.5


