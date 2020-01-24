Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39FF1487E7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 15:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbgAXOZZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 09:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392233AbgAXOVu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08C8222C2;
        Fri, 24 Jan 2020 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875709;
        bh=w0CFkfqbG6EaSlOzx/NhcXmF5pjsbQME2xrR3kTJoPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhWUXTnm12u4BdxACy9CMo8J7EmmKTO1DZ/4sS5eLu/a0BCdK6dss+bnMmb5qd6bi
         IS4P7t/6B0Ao9E0mcYkmbJuBLL/oDBagT+fNfnIuFemFhlUC/j5pgk+CEIXgr9faIH
         0FhgtNG6aIrmE0frL20dP745WNx83Q0JmS2wEEnQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com,
        syzbot+34b582cf32c1db008f8e@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/32] cfg80211: check for set_wiphy_params
Date:   Fri, 24 Jan 2020 09:21:12 -0500
Message-Id: <20200124142119.30484-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 24953de0a5e31dcca7e82c8a3c79abc2dfe8fb6e ]

Check if set_wiphy_params is assigned and return an error if not,
some drivers (e.g. virt_wifi where syzbot reported it) don't have
it.

Reported-by: syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com
Reported-by: syzbot+34b582cf32c1db008f8e@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20200113125358.ac07f276efff.Ibd85ee1b12e47b9efb00a2adc5cd3fac50da791a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/rdev-ops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 96849357dd907..4077bb3af440c 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -537,6 +537,10 @@ static inline int
 rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
 {
 	int ret;
+
+	if (!rdev->ops->set_wiphy_params)
+		return -EOPNOTSUPP;
+
 	trace_rdev_set_wiphy_params(&rdev->wiphy, changed);
 	ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
 	trace_rdev_return_int(&rdev->wiphy, ret);
-- 
2.20.1

