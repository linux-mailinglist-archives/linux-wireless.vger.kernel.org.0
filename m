Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD33D80ED
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhG0VI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhG0VHr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2DC061199
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:07:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so1816253pjv.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wy7ZFa/vlTHtgg8uQMNJ843aX+ZbzQs1i4QUu9cpwyY=;
        b=CFD6/QI1O3EsbKYxaKeMIUYOQlfKd8FXsmJJprXlgdw+7zyXlZPIW5o4azRnTC8YCQ
         mzeyQTg+S62pLX4cDFcNv6/N7XaNBnc5E2uNaV5hs68fYSXMP8/ESaJ0OkQygaJQa7AS
         4F9qh1blRX9PVQ64lesabwlxtHleiGJJDFMls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wy7ZFa/vlTHtgg8uQMNJ843aX+ZbzQs1i4QUu9cpwyY=;
        b=Blq7EBW5nZ6CDuuvxcjqU3xz/JfC7Xj3vf05Amn4jR+2aYaFS3tT4reyHI8IEqoiYf
         QhBkMv9SKWu67aq1i3HUBJDhCzTt1/njWgirLK1kNWiTLepZsemQRLw9Yqf3nT4wsA76
         RzIzqIAXBpZMyQhJLcLmHhpkD67qtl8ga4Jnp//hT8icRBY4QDd+aTdv4fF8nJzoeob6
         iQtJJUWvUh4Ek0wY6aQ+ZL8bsOsFvybtzc/BBHO5D08fnxI6t4OJrRFckEhxbAiO09xB
         MyKrBjpHBF8j7sdk9zRrOHvpHNA1CX8qq1rhkdisLvubBpmoS61V6Dl36boEkGKHYrLi
         xOiA==
X-Gm-Message-State: AOAM531UU0NcCbwhB0TQLfpoyBL8KBvrIWMXGUKCZ2wPTeszpHByk9PN
        663PrxlcUkO2GbPCUuwGS+4DVQ==
X-Google-Smtp-Source: ABdhPJx+2T9X9pdhD3ddcewqGNtueFLcFZVjgp4XV45kz/Mw0ouxkgYoYELpNwYrCF7/43LnQvJqng==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr24025324pjb.166.1627420023668;
        Tue, 27 Jul 2021 14:07:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s193sm4734376pfc.183.2021.07.27.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:07:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 56/64] ethtool: stats: Use struct_group() to clear all stats at once
Date:   Tue, 27 Jul 2021 13:58:47 -0700
Message-Id: <20210727205855.411487-57-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; h=from:subject; bh=nf2hDwlk0YBMeQam31KvtF6X3nn/T4T4psodjHluwA0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOM4ay2vSP0iUDUl/jIVt/Blah8KWXvHVH7Wzv7 NYIRQBeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjAAKCRCJcvTf3G3AJg7ED/ wIYAKrzGS2QdyAzL+zWobbS3KBQXRaEYAJzUBfRITbmMnqRyWiKhqX9YPUQktluLi8FRLF8/tN1uNl Zxa7PntzoeHKtnHdKaUlHK6jf3BDo5jSq4V1v/ebceGUpYXZEmqBaMINS8m6bmB3D2Mg/O+78AphgA 9W427uDE2RA+00IyaPB0SuPpufyTlaLDtD0Zu/sNtuHoxjQv7TLsi7hKzCX9rzcpT6iYxy+r2oHJHR UW5fD3JxKtWaV5YRkxjG6zL1MuLmgkGRIZRM5MeQGsmfy/FLz/XIKFETiqW5DntGZOtXT/0htDnrlk PzvLPT4HEfNLzx+3A9w8dI9o8ascU8vO2ZRk/b8a7pFTT9viBfWhZaSpikWc0hyxZUUez9dR413PZT Ihk7cAMDTlnVhX8R/9y3T0RhUGSPws7B1NsMvvxVseZgEJlROYx8WchI3f/YQofn8x40OI695ZW6eZ E2E0P3MhTIlruLHwghe2WVf/JwGX5pATdgB83WBO7y5tJPfTi3bt4dUNUN3MVJ1huNwC/xqUbDx8As Ckre4MXvBdIoXEXXN2pOr5ObcLIhMYDjjuGdxhjOInFiHku6jxVuO2Gu3Qwlt8hXM3TPFrAZoEl/Cr 5zyQjXfG1x4OBqaHrzFrl/No/XVLDOKeVvR6caucbAbMqbu6m2ziy3mOa3yA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct stats_reply_data that should
be initialized, which can now be done in a single memset() call.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/ethtool/stats.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index ec07f5765e03..a20e0a24ff61 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -14,10 +14,12 @@ struct stats_req_info {
 
 struct stats_reply_data {
 	struct ethnl_reply_data		base;
-	struct ethtool_eth_phy_stats	phy_stats;
-	struct ethtool_eth_mac_stats	mac_stats;
-	struct ethtool_eth_ctrl_stats	ctrl_stats;
-	struct ethtool_rmon_stats	rmon_stats;
+	struct_group(stats,
+		struct ethtool_eth_phy_stats	phy_stats;
+		struct ethtool_eth_mac_stats	mac_stats;
+		struct ethtool_eth_ctrl_stats	ctrl_stats;
+		struct ethtool_rmon_stats	rmon_stats;
+	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
 
@@ -117,10 +119,7 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	/* Mark all stats as unset (see ETHTOOL_STAT_NOT_SET) to prevent them
 	 * from being reported to user space in case driver did not set them.
 	 */
-	memset(&data->phy_stats, 0xff, sizeof(data->phy_stats));
-	memset(&data->mac_stats, 0xff, sizeof(data->mac_stats));
-	memset(&data->ctrl_stats, 0xff, sizeof(data->ctrl_stats));
-	memset(&data->rmon_stats, 0xff, sizeof(data->rmon_stats));
+	memset(&data->stats, 0xff, sizeof(data->stats));
 
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
-- 
2.30.2

