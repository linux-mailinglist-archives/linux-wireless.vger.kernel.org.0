Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA74E260045
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgIGQpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbgIGQfd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE9322207;
        Mon,  7 Sep 2020 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496533;
        bh=K2PGk4ztZK2SavoJZdLUu6GbXFrGLphmmGLkD0+uLbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWaJkSrr4Csxlt3mWQPZ77MLXIG4wpmO1RZAVHk65kUQBzeP0VOAOTC+tg3xwADCi
         xotkoLq25IlDEJr7e7bodXZf4Hbu0fj8kIdwxRILQ8vBKWNCMiiNIMm8d5tnyPfGk6
         3zUEh0GWgNF0CKd4NDcwmOAEPbv/w+70Xgp8X81c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+d451401ffd00a60677ee@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 06/13] cfg80211: regulatory: reject invalid hints
Date:   Mon,  7 Sep 2020 12:35:17 -0400
Message-Id: <20200907163524.1281734-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163524.1281734-1-sashal@kernel.org>
References: <20200907163524.1281734-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 47caf685a6854593348f216e0b489b71c10cbe03 ]

Reject invalid hints early in order to not cause a kernel
WARN later if they're restored to or similar.

Reported-by: syzbot+d451401ffd00a60677ee@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d451401ffd00a60677ee
Link: https://lore.kernel.org/r/20200819084648.13956-1-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6d5f3f737207d..a649763b854d5 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2321,6 +2321,9 @@ int regulatory_hint_user(const char *alpha2,
 	if (WARN_ON(!alpha2))
 		return -EINVAL;
 
+	if (!is_world_regdom(alpha2) && !is_an_alpha2(alpha2))
+		return -EINVAL;
+
 	request = kzalloc(sizeof(struct regulatory_request), GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
-- 
2.25.1

