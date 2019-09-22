Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7335EBA50D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Sep 2019 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393714AbfIVSyL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Sep 2019 14:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393701AbfIVSyJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Sep 2019 14:54:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3882121479;
        Sun, 22 Sep 2019 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178449;
        bh=GSS11zVS5sAZCAm/t7b3x4fHnf3ZmTKbpHI1jMi/XZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXlMrOI6CGXh7DhAxkY3+SHYsvMcB3j67BbZ2uBP3IwO9qubeODNMUhroVdNLyN8J
         bSPS82kr+1YYc8nhg9V8koEIQplDmUizIIjNaLtbk67Zxu+TCmtZVX5/gIjKpQwuHq
         G8FeRDzgV+a0xwBQtbZcbBByD+BokKPMX0WTG8SY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+74c65761783d66a9c97c@syzkaller.appspotmail.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 180/185] zd1211rw: remove false assertion from zd_mac_clear()
Date:   Sun, 22 Sep 2019 14:49:18 -0400
Message-Id: <20190922184924.32534-180-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 7a2eb7367fdea72e448d1a847aa857f6caf8ea2f ]

The function is called before the lock which is asserted was ever used.
Just remove it.

Reported-by: syzbot+74c65761783d66a9c97c@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index da7e63fca9f57..a9999d10ae81f 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -223,7 +223,6 @@ void zd_mac_clear(struct zd_mac *mac)
 {
 	flush_workqueue(zd_workqueue);
 	zd_chip_clear(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 	ZD_MEMCLEAR(mac, sizeof(struct zd_mac));
 }
 
-- 
2.20.1

