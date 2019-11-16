Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91836FF4AB
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKPSVp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 13:21:45 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:33179 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfKPSVn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 13:21:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 6988D2F02D0;
        Sat, 16 Nov 2019 18:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FRHgYjzuG5Ru; Sat, 16 Nov 2019 10:12:34 -0800 (PST)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id 7DAAD2F0314;
        Sat, 16 Nov 2019 10:12:34 -0800 (PST)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH] mac80211: consider QoS Null frames for STA_NULLFUNC_ACKED
Date:   Sat, 16 Nov 2019 10:12:30 -0800
Message-Id: <20191116181233.1037-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116181233.1037-1-thomas@adapt-ip.com>
References: <20191116181233.1037-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 7b6ddeaf27ec ("mac80211: use QoS NDP for AP probing")
let STAs send QoS Null frames as PS triggers if the AP was
a QoS STA.  However, the mac80211 PS stack relies on an
interface flag IEEE80211_STA_NULLFUNC_ACKED for
determining trigger frame ACK, which was not being set for
acked non-QoS Null frames. The effect is an inability to
trigger hardware sleep via IEEE80211_CONF_PS since the QoS
Null frame was seemingly never acked.

This bug only applies to drivers which set both
IEEE80211_HW_REPORTS_TX_ACK_STATUS and
IEEE80211_HW_PS_NULLFUNC_STACK.

Detect the acked QoS Null frame to restore STA power save.

Fixes: 7b6ddeaf27ec ("mac80211: use QoS NDP for AP probing")
Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..5a3d645fe1bc 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1030,7 +1030,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			I802_DEBUG_INC(local->dot11FailedCount);
 	}
 
-	if (ieee80211_is_nullfunc(fc) && ieee80211_has_pm(fc) &&
+	if ((ieee80211_is_nullfunc(fc) || ieee80211_is_qos_nullfunc(fc)) &&
+	    ieee80211_has_pm(fc) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
 	    !(info->flags & IEEE80211_TX_CTL_INJECTED) &&
 	    local->ps_sdata && !(local->scanning)) {
-- 
2.20.1

