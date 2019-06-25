Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109CB524F8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfFYHil (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 03:38:41 -0400
Received: from muru.com ([72.249.23.125]:53482 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfFYHik (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 03:38:40 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B7C0180C8;
        Tue, 25 Jun 2019 07:39:02 +0000 (UTC)
Date:   Tue, 25 Jun 2019 00:38:37 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: nl80211 wlcore regression in next
Message-ID: <20190625073837.GG5447@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Looks like at least drivers/net/wireless/ti wlcore driver has stopped
working in Linux next with commit 901bb9891855 ("nl80211: require and
validate vendor command policy"). Reverting the commit above makes it
work again.

It fails with the warning below, any ideas what goes wrong?

Regards,

Tony

8< ----------------
WARNING: CPU: 0 PID: 21 at net/wireless/core.c:868 wiphy_register+0x85c/0xbd4 [cfg80211]
...
[<bf05f570>] (wiphy_register [cfg80211]) from [<bf121e08>] (ieee80211_register_hw+0x4e4/0xcd8 [mac80211])
[<bf121e08>] (ieee80211_register_hw [mac80211]) from [<bf33135c>] (wlcore_nvs_cb+0x758/0xabc [wlcore])
[<bf33135c>] (wlcore_nvs_cb [wlcore]) from [<c05c3770>] (request_firmware_work_func+0x50/0x8c)
[<c05c3770>] (request_firmware_work_func) from [<c0154bb8>] (process_one_work+0x20c/0x504)
...
