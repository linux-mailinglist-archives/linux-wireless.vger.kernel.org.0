Return-Path: <linux-wireless+bounces-400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE01803FE5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A837228132F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A50033CC6;
	Mon,  4 Dec 2023 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De1QKLSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEE35F18;
	Mon,  4 Dec 2023 20:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ED3C4166B;
	Mon,  4 Dec 2023 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722196;
	bh=Dnz0KDFlHACgl4AtC628feqGeN/W7wv8UYPFPprIxaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=De1QKLSSKTUnEGmSm7TEMY5tGSpN1DVyZay6KXd83SzxodIQE5Gd84lZRuMDG4Fa8
	 F4ap+7GJpME3Xf8LhONctm7nxIxnbptBzgwT9C03DgsPpfLT0/qW48KPGOjOKr/UVJ
	 2Dbzd5eGwuqOMriRiqNJp6llQAt5slq4KGFdt1LInQXEHYdS/jnL6evDWjNPBRY/r5
	 doNSqC5KRy+FeEJyZ9lQeXSlR1SZdDyil3POxuCQJmkNkl5qOecMzhLXsjpc9jjqR3
	 aHRs1IusILSX9axjHRu2aGbWCII0MayM5mMhSkP+XRwp38Y/oKP456gIoAeHoDitWg
	 Wo/gBZSL5jgLQ==
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
Subject: [PATCH AUTOSEL 5.15 05/10] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date: Mon,  4 Dec 2023 15:36:02 -0500
Message-ID: <20231204203616.2094529-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
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
index d10686f4bf153..d51d27ff3729d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -216,7 +216,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
-- 
2.42.0


