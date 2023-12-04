Return-Path: <linux-wireless+bounces-401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43ED804009
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328CFB2031C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9D35EF5;
	Mon,  4 Dec 2023 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ5MawFn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC033306F;
	Mon,  4 Dec 2023 20:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B237C433C8;
	Mon,  4 Dec 2023 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722254;
	bh=nhCeI26hcpW5/oosaG+qmXvejiJHo+d668SX+e0y/Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJ5MawFn7OpPe6Bs/F5pvgicEeGq+oEm4sStLCRAyatiaUoqe1vybgvUhuuHpiPaH
	 1pEWC66UgVTrEklBjbxl4BzRRT0jdPoAHgtPfgH8BcMOGqLZ80xpQJFIdNEiMKN9Eg
	 0YMzQSswnli195lWGRLR4kraE+jfOICzkD4Dl9XsTokCAVPWd5CNWtZGlSHV8a/dJk
	 iOJnColMBcCNczi82dbEKN7sk4/HxwJRWNB4Berqt7u3tvqpWEDT8S2KFJktVWblYd
	 D+QqFpGdo9Bbxumee/GiCqw/e934BUqiI8YJyyD5vmgf3XfQIO/oemYWqBck1WH11t
	 r4+DLQp/JhZ4g==
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
Subject: [PATCH AUTOSEL 5.4 3/3] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date: Mon,  4 Dec 2023 15:37:20 -0500
Message-ID: <20231204203723.2094942-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203723.2094942-1-sashal@kernel.org>
References: <20231204203723.2094942-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.262
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
index f7228afd81ebd..0be87b46c1b33 100644
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


