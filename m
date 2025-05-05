Return-Path: <linux-wireless+bounces-22525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF0AAA698
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DF07A6F44
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D832A6DE;
	Mon,  5 May 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9WnV6Tp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6832A6D4;
	Mon,  5 May 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484499; cv=none; b=BXiiglN0QtNlkVcLrRklZ6HATi2YDFmsoBx2sTGKRqTf5xRox6x7ZxpmHOWKa0XUbXlzD/buosu9Jnhsp0Xah2UIwZ3RbYx3IhYobKIEMp3gTNtbIprI+taeKL9phCcLFDS544k5sNW882UytNNRWDAEJ1aKNnc6aBd88E2FPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484499; c=relaxed/simple;
	bh=zMozRr9Tn4SsmkfzNzCDHW+eCVnr6o1XFS62y69cxCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QV7FOeX+7hDNYd0AVdA4o/VUjklbnXY6uJlufJ/LLxicaFJUITRzZjI395FNnbWEm7gAVFM/74QSzaJ5AriUoGKaHXXvANvGeEqhcthF3VFsWaqWZJ71cGEf0UALtIMRQXpBRJ/qY0PiCZg1x9dl0Y4PpMjuYkD+qFd7ZelUKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9WnV6Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A07BC4CEEE;
	Mon,  5 May 2025 22:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484499;
	bh=zMozRr9Tn4SsmkfzNzCDHW+eCVnr6o1XFS62y69cxCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9WnV6Tp3rsPKCaeHr2MLDx4QQsQfbgKoHbk70BZFN/3ygKiHbA9phC2/tIkALuVN
	 ebHLWrodosjiKDgCAmYIHYqncCatkOkhqnZb9LTvv0Nf7JOf9gbsCUxPMM1tCdaXMj
	 I81vDWIzqrbU784rEM/f3O3MZ/SGhXIX5MyvRuODBhd7EBjzzYyQ0BotUgb+AmwPcr
	 4xBUPsvp7EQBc5Sq+iYkAdggq9rDi+5cEIxKgQPC2EUH0c5RmLI7SU49S7bkyypPj5
	 npigKYAFKyB5ttLyfWmjDe96nTKnb7kdYIi7mEClt5qSs+fclKb4C/tcaFGwENK/7d
	 FpNqJurbp1U6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 503/642] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Mon,  5 May 2025 18:11:59 -0400
Message-Id: <20250505221419.2672473-503-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index d606b9dac145b..39cfb926354a5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9508,7 +9508,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.39.5


