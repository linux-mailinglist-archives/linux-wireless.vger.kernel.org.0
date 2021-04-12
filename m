Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD635CE07
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbhDLQlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 12:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244861AbhDLQdZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 12:33:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D17D3613A0;
        Mon, 12 Apr 2021 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244789;
        bh=XmCEre1kvvN7vGtm74bd0GsZhcgfBHLDP5wchb7qFzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBe/QiHgHdHh7Ru9YTbmr3mTwDU5Ry2bpQhVDQpShn+F1k3JKsWvJOskaqyU+AB6O
         OgQ1JdLKo9hguO2pgXGlk78Kmw7Jjuge6OUGVNIi554pbgPRRhS4Iu+m7hgWd5Umzx
         pS5ygMjSXBGJRdwBpz1lfsS9QviDV23PlHERPp46YhG+DI/eCu6na6KbQnI0DVWa1y
         oGInTeNqpjBSjMKKI72TjjLRymrrnvSmlaIvVsZAvoELimDiHOyEkG8fZS3B1/Y3mu
         FParOQt3BnNh6XzqDFHMSL/q8UBDxquS1ivo6ZIj2ftK1hVtfcaOPKCDqGg2ylYljk
         hb+Nom2KoZMWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Du Cheng <ducheng2@gmail.com>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/28] cfg80211: remove WARN_ON() in cfg80211_sme_connect
Date:   Mon, 12 Apr 2021 12:25:53 -0400
Message-Id: <20210412162553.315227-28-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162553.315227-1-sashal@kernel.org>
References: <20210412162553.315227-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Du Cheng <ducheng2@gmail.com>

[ Upstream commit 1b5ab825d9acc0f27d2f25c6252f3526832a9626 ]

A WARN_ON(wdev->conn) would trigger in cfg80211_sme_connect(), if multiple
send_msg(NL80211_CMD_CONNECT) system calls are made from the userland, which
should be anticipated and handled by the wireless driver. Remove this WARN_ON()
to prevent kernel panic if kernel is configured to "panic_on_warn".

Bug reported by syzbot.

Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
Link: https://lore.kernel.org/r/20210407162756.6101-1-ducheng2@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/sme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index f455b9af6815..9d8b106deb0b 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -530,7 +530,7 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 		cfg80211_sme_free(wdev);
 	}
 
-	if (WARN_ON(wdev->conn))
+	if (wdev->conn)
 		return -EINPROGRESS;
 
 	wdev->conn = kzalloc(sizeof(*wdev->conn), GFP_KERNEL);
-- 
2.30.2

