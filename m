Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB357765
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 02:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfF0Ai0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 20:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbfF0AiY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 20:38:24 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D37205ED;
        Thu, 27 Jun 2019 00:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595903;
        bh=YQHShSlqS7BC96IHn2F3eM9jawqX04lfhmqMHMWWv/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAyHzpk4YYS/J+FZ6JMFAwGWX3ZCXB2o2Oxn+2mGEycqhvmkTfI7HB8rJBJUquvaV
         E+uYPplWbICPUSfMLJMXiffgg15tAx+KZoGVlPfCG8KBn9KPW4N09MfTFT9Ww/sg6c
         goT8l/cVAua2CO5LEGqevJxSwOXkJvaL8YSPf+fU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yibo Zhao <yiboz@codeaurora.org>,
        Zhi Chen <zhichen@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/60] mac80211: only warn once on chanctx_conf being NULL
Date:   Wed, 26 Jun 2019 20:35:55 -0400
Message-Id: <20190627003616.20767-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yibo Zhao <yiboz@codeaurora.org>

[ Upstream commit 563572340173865a9a356e6bb02579e6998a876d ]

In multiple SSID cases, it takes time to prepare every AP interface
to be ready in initializing phase. If a sta already knows everything it
needs to join one of the APs and sends authentication to the AP which
is not fully prepared at this point of time, AP's channel context
could be NULL. As a result, warning message occurs.

Even worse, if the AP is under attack via tools such as MDK3 and massive
authentication requests are received in a very short time, console will
be hung due to kernel warning messages.

WARN_ON_ONCE() could be a better way for indicating warning messages
without duplicate messages to flood the console.

Johannes: We still need to address the underlying problem, but we
          don't really have a good handle on it yet. Suppress the
          worst side-effects for now.

Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
[johannes: add note, change subject]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 172aeae21ae9..6ea64cadad00 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1410,7 +1410,7 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 	rcu_read_lock();
 	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 
-	if (WARN_ON(!chanctx_conf)) {
+	if (WARN_ON_ONCE(!chanctx_conf)) {
 		rcu_read_unlock();
 		return NULL;
 	}
-- 
2.20.1

