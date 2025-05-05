Return-Path: <linux-wireless+bounces-22587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A11FAAAC6A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71605A1D66
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B8388F2E;
	Mon,  5 May 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGZXE2H9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498803881C5;
	Mon,  5 May 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486740; cv=none; b=TzFaom/n2z1o1vKqegU8xwDttLG0QPIM/yeXqJvQQ9I3v+kZdNEJ5GnhERJXkaEO63WcCOwhMFtNis4wpYNrGTcOyXYoyzDKxKgv6yOkVq8Q9/wGr0tJpeqXLPKxLeQsJq5pQsjEKWvSD2qjD/mL1wksqaucD3NqXFwEu98WH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486740; c=relaxed/simple;
	bh=Ez/jSodbLkn4e8mEWZfdyFweRuhKDIMFaYvLfFdFQvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ul/LhzNq1NqopkkRr4HP0LPzMQau05bpAGEyCOoj7df7tZjxLWKA7LUF9W5AuEz8XrNQPmjjc1pGYNqmMBRqo5pkXVV+9654FYlrezFlolAyvAep80wXdzbT+nQ+ba+XEJ3kxmZj9qvr2ATA+pSDxYiJHdPOTkhNCQtWNZei6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGZXE2H9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4CCC4CEEE;
	Mon,  5 May 2025 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486739;
	bh=Ez/jSodbLkn4e8mEWZfdyFweRuhKDIMFaYvLfFdFQvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGZXE2H9T2UETQacJNWWMi7rour6oj6VJ7GvNeVK3YvYaaEwWwoht+eeD3xShWdPX
	 jThaJyGXduagEup3yRx0T7zNPpW/6RTxH7jmk4J88Yf2kab2jnFMMN793KQmv2ggzT
	 /NfUhLq5Jf3wZDZ/pDNhnBrA4DTU8ECspWxOEKrxkFubQBIabBB92L86ix6Z+5knpp
	 HaZ1D1GWXC8mFIgQnQ9TRjpiRph2cgSe/6dD+lCq8dJ59eUMsVFoS5ONKNqyGrN90U
	 w4ivyjlnrizrLdPKMmT95L9UI9wWWYghssrm9PqeLRUe+Uy4b15CQkvAYjdlZMRYYQ
	 54gauL3yNaFoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 178/212] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Mon,  5 May 2025 19:05:50 -0400
Message-Id: <20250505230624.2692522-178-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 8f0e6d7fe7167..b300972c31500 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7312,7 +7312,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.39.5


