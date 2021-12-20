Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84E47B09C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhLTPs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhLTPsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30ADC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 07:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524BE60F67
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA4BC36AEA;
        Mon, 20 Dec 2021 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015334;
        bh=LwdAuQbSKe6A3WrxVwTcfT3T238rDbAFW7qWlAVLzyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/Nva28trJ9OXUYwt/8U9+hETm/boTH7NcDYtASf+3d/QxFPm22RruHYeJ4WIWfKz
         9Q2dpQqI5V2UDpNHMtj+aKG6ZHhUX9RSDJuaI+f2ffK1BhhW+XjwRiALY374qsnfdN
         6KXGno7iLWSwO7sX3r+ctGXBBOcYA3wZSreuvmqMdEllLJ3T9khr/p2Dxrb6Wuki2a
         JyTdd4qv6c2BG8bWX8CSIHt68ykjwChcHJa9T1okOJ2jl5UWykCZzEHglTmBKGx83+
         7l+fqLYPg2p+oghbQ21zXfKi130jmC3SbLV2hJjvpPzHF/W5eVMfKxYnYRii15Rd54
         IJLdZMoQ4ggjQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 7/9] DFS: enable CSA for background radar detection
Date:   Mon, 20 Dec 2021 16:48:22 +0100
Message-Id: <5532ca04d32660a28aff1846b96436c13d1c1a8b.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on hostapd_dfs_request_channel_switch in order to enable CSA for
background radar detection switching back to selected channel.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/ap/dfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index bd8a2484d..30be7e349 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -1086,10 +1086,11 @@ hostapd_dfs_start_channel_switch_background(struct hostapd_iface *iface)
 			iface->radar_background.centr_freq_seg1_idx);
 
 	hostpad_dfs_update_background_chain(iface);
-	hostapd_disable_iface(iface);
-	hostapd_enable_iface(iface);
 
-	return 0;
+	return hostapd_dfs_request_channel_switch(iface, iface->conf->channel,
+						  iface->freq, iface->conf->secondary_channel,
+						  hostapd_get_oper_centr_freq_seg0_idx(iface->conf),
+						  hostapd_get_oper_centr_freq_seg1_idx(iface->conf));
 }
 
 int hostapd_dfs_complete_cac(struct hostapd_iface *iface, int success, int freq,
-- 
2.33.1

