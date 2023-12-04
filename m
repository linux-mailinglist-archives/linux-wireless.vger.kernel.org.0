Return-Path: <linux-wireless+bounces-402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80100804010
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A43D1F21379
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF6321A8;
	Mon,  4 Dec 2023 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DseyW8QA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7A364B1;
	Mon,  4 Dec 2023 20:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36590C433C7;
	Mon,  4 Dec 2023 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722258;
	bh=jQ+D2iihSTK+aKrxjtXFfBlStzbtYXPCbVhBZbnb9bo=;
	h=From:To:Cc:Subject:Date:From;
	b=DseyW8QAj8aBxawwdrp9SofXXecA8Ygo5O4qtDnMWwuRwSEe9rB/ijhcuV7WQjvln
	 xOHvc/2NSucx+ZLy/+tEdSi6CZLZCR1Cck++tsFWO+B1drwszqOYlhUEVAwm172HeI
	 9hTTGHzBD0fBqnFqhni0ZPzwtoNGdOY0gpT2Acy+rKehTuYrqD9YoYp1L/vxcTl1R6
	 +L1wivZ2fmpPuHL6xV2JPSoq3ZlcTu9f7rq96rBbtoP/ghJXZc3HFhL46kYWrJC8WB
	 CWMwNwukU9GQjDhDpZFRT7WROOtHOq9Pjcr0ptGjCnXVnQaiFqAUPMmFtz9kNVhMMh
	 M5olsi8q9zz4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date: Mon,  4 Dec 2023 15:37:34 -0500
Message-ID: <20231204203735.2095033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.331
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8e2f6f2366219b3304b227bdd2f04b64c92e3e12 ]

We want to guarantee the mutex is held for pretty much
all operations, so ensure that here as well.

Reported-by: syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 0e08629b15d1d..abe7912a23760 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -202,7 +202,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
-- 
2.42.0


