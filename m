Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F222515E44F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393527AbgBNQfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 11:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405979AbgBNQYt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50003247A6;
        Fri, 14 Feb 2020 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697488;
        bh=uWRAqrrz8QGRmZbaK0xqB+Wr/NpuVq0kBoEB4W7u2Og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhkDQqHOXKMBPpMgtETTlOl+QWY6rRILOWtGDgOefi6cz+hGQOZTJOR0Rb9vvxhXy
         zCeeqL6+K4OaZzCXop6QvhzjH6mYDG6yuKsTv1OEJftYsWlilXPAKIviiuMub3IGUS
         teIH6018GUVPxJeRjFOhw0519a2dt4mS7XMw+vGk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolai Stange <nstange@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 018/100] libertas: make lbs_ibss_join_existing() return error code on rates overflow
Date:   Fri, 14 Feb 2020 11:23:02 -0500
Message-Id: <20200214162425.21071-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

[ Upstream commit 1754c4f60aaf1e17d886afefee97e94d7f27b4cb ]

Commit e5e884b42639 ("libertas: Fix two buffer overflows at parsing bss
descriptor") introduced a bounds check on the number of supplied rates to
lbs_ibss_join_existing() and made it to return on overflow.

However, the aforementioned commit doesn't set the return value accordingly
and thus, lbs_ibss_join_existing() would return with zero even though it
failed.

Make lbs_ibss_join_existing return -EINVAL in case the bounds check on the
number of supplied rates fails.

Fixes: e5e884b42639 ("libertas: Fix two buffer overflows at parsing bss descriptor")
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/libertas/cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/libertas/cfg.c b/drivers/net/wireless/libertas/cfg.c
index 803684eed142c..7d55de21b1903 100644
--- a/drivers/net/wireless/libertas/cfg.c
+++ b/drivers/net/wireless/libertas/cfg.c
@@ -1854,6 +1854,7 @@ static int lbs_ibss_join_existing(struct lbs_private *priv,
 		if (rates_max > MAX_RATES) {
 			lbs_deb_join("invalid rates");
 			rcu_read_unlock();
+			ret = -EINVAL;
 			goto out;
 		}
 		rates = cmd.bss.rates;
-- 
2.20.1

