Return-Path: <linux-wireless+bounces-399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE66803FC3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8302812FF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE935EE9;
	Mon,  4 Dec 2023 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT9UkkpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFD364C2;
	Mon,  4 Dec 2023 20:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85967C433CC;
	Mon,  4 Dec 2023 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722136;
	bh=sb94vGji52NuT8tbvozdWSvvBLunX3rybx4F6h+mUsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UT9UkkpKj0cpY+MrFKdb3D717ZyfB20OfK365o0u4J2mfBh2HRE3Jk4NdRaHD6zZE
	 gV1fuC+wCyYmhnWoAA7bxvN/j0L6x3Kiv1cSpli+qTYjkXfVlPTnbTGR9p3JXNeax0
	 NKAXGFqVE2nEltXPloKvNgAHusvMKpcE4rDx70Svmq8N+JtsabdXDYHR0xZEFqD4Yv
	 hiJ1wWL478IEt0s7j9ewW6GuN1MOZge/GC/0qH7+9kWrkgRon/gfoYaOJxMBMB1IPk
	 CA7O+4dUuVp5KFvHLSJPK7RyqxdY1dz7Zr9Lv6tOUrpStF5EDPyLBYj82dK2sXqztL
	 RwoY8/QSmQ5Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/17] wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap
Date: Mon,  4 Dec 2023 15:34:52 -0500
Message-ID: <20231204203514.2093855-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 00f7d153f3358a7c7e35aef66fcd9ceb95d90430 ]

The new 320 MHz channel width wasn't handled, so connecting
a station to a 320 MHz AP would limit the station to 20 MHz
(on HT) after a warning, handle 320 MHz to fix that.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Link: https://lore.kernel.org/r/20231109182201.495381-1-greearb@candelatech.com
[write a proper commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ht.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index ae42e956eff5a..9bfe128ada47d 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -271,6 +271,7 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	case NL80211_CHAN_WIDTH_80:
 	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_320:
 		bw = ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 		break;
-- 
2.42.0


