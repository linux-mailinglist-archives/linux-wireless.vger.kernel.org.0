Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4547B095
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhLTPsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43262 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhLTPsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F6360F50
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51839C36AE7;
        Mon, 20 Dec 2021 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015317;
        bh=Y4HF46EPFagsxHCUZX5N/6V5TZAyUpwfWvGAsXBz3c0=;
        h=From:To:Cc:Subject:Date:From;
        b=MC/10Fnl78RtmSLt85/7ZjRZJ+O8ys90dqLyboN/6+mUhnpcFlmoLyflqZDW9APTk
         cHrNjhfCyK2YnJdiQ1k/UFiLSquLUkHLwsIUhjDJp7yypYy2xszQ2237JQtVtQTH3s
         eg15SUSAUIzr6ZFl0bQDPQZO1yGQ1MYBKv4sGqLqbh5/4CZnJOHiC4hEIeZd8FDy42
         in3MzgcRNlQS3SaDdn7jSF8+5erIy93RMeziHEdj5vFQT/ck2qAXvbbco37SNIq0pq
         fbYDD9Xa+ZfDfYsekR8lWknbA7PxRjzeKI0bkoW0gMDwJGaNs4AYtjFegHkxVp+cRt
         mBpHa8cAF69kA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/9] introduce background radar detection support
Date:   Mon, 20 Dec 2021 16:48:15 +0100
Message-Id: <cover.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce background radar/CAC detection through a dedicated off-channel
chain available on some hw (e.g. mt7915).
Background radar/CAC detection allows to avoid the CAC downtime
switching on a different channel during CAC detection on the selected
radar channel.

Lorenzo Bianconi (9):
  Sync include/uapi/linux/nl80211.h with mac80211-next.git
  DFS: introduce dfs_set_valid_channel utility routine
  DFS: add capability select radar-only channels
  nl80211: report background radar/cac detection capability
  DFS: configure background radar/cac detection.
  DFS: introduce hostapd_dfs_request_channel_switch routine
  DFS: enable CSA for background radar detection
  DFS: switch to background radar channel if available
  DFS: introduce radar_background parameter to config file

 hostapd/config_file.c              |   2 +
 hostapd/hostapd.conf               |   7 +
 src/ap/ap_config.h                 |   1 +
 src/ap/ap_drv_ops.c                |   9 +-
 src/ap/ap_drv_ops.h                |   3 +-
 src/ap/dfs.c                       | 447 +++++++++++++++++++++--------
 src/ap/hostapd.h                   |  15 +
 src/drivers/driver.h               |   7 +
 src/drivers/driver_nl80211.c       |   5 +
 src/drivers/driver_nl80211_capa.c  |   4 +
 src/drivers/driver_nl80211_event.c |   7 +
 src/drivers/nl80211_copy.h         | 228 ++++++++++++++-
 12 files changed, 610 insertions(+), 125 deletions(-)

-- 
2.33.1

