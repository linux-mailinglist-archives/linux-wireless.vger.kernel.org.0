Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9C291EC7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Oct 2020 21:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbgJRTzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Oct 2020 15:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgJRTUD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Oct 2020 15:20:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0D4222C8;
        Sun, 18 Oct 2020 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048802;
        bh=dXX67ugBaay3YEwWMjuBSOIs7iMiA2XdkQBHJ0q0d94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZJRVK7SQ56Nzt0d/peWIA1CmVVUlyWcXFNxzAyJ96bu+O66ftTsDnQeWF9IMV9gG
         N7v/WGJNg/1e1dJMY6ZEXCKFAQx0Vjs3mipWNj6ps+Ue76K/+SC9oJxyrEdqwIWgIj
         BV32PiXzlJe51RDMosckQGm3tgtAD1DnY3oKnACE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 095/111] mwifiex: don't call del_timer_sync() on uninitialized timer
Date:   Sun, 18 Oct 2020 15:17:51 -0400
Message-Id: <20201018191807.4052726-95-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018191807.4052726-1-sashal@kernel.org>
References: <20201018191807.4052726-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 621a3a8b1c0ecf16e1e5667ea5756a76a082b738 ]

syzbot is reporting that del_timer_sync() is called from
mwifiex_usb_cleanup_tx_aggr() from mwifiex_unregister_dev() without
checking timer_setup() from mwifiex_usb_tx_init() was called [1].

Ganapathi Bhat proposed a possibly cleaner fix, but it seems that
that fix was forgotten [2].

"grep -FrB1 'del_timer' drivers/ | grep -FA1 '.function)'" says that
currently there are 28 locations which call del_timer[_sync]() only if
that timer's function field was initialized (because timer_setup() sets
that timer's function field). Therefore, let's use same approach here.

[1] https://syzkaller.appspot.com/bug?id=26525f643f454dd7be0078423e3cdb0d57744959
[2] https://lkml.kernel.org/r/CA+ASDXMHt2gq9Hy+iP_BYkWXsSreWdp3_bAfMkNcuqJ3K+-jbQ@mail.gmail.com

Reported-by: syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200821082720.7716-1-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 6f3cfde4654cc..426e39d4ccf0f 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -1353,7 +1353,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
 				skb_dequeue(&port->tx_aggr.aggr_list)))
 				mwifiex_write_data_complete(adapter, skb_tmp,
 							    0, -1);
-		del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
+		if (port->tx_aggr.timer_cnxt.hold_timer.function)
+			del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
 		port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
 		port->tx_aggr.timer_cnxt.hold_tmo_msecs = 0;
 	}
-- 
2.25.1

