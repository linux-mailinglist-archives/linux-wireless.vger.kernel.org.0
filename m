Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D4178FCA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgCDLt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 06:49:56 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36710 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387772AbgCDLt4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 06:49:56 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 164E3580074;
        Wed,  4 Mar 2020 12:49:55 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] nl80211: fix tx_control_port trace point
Date:   Wed,  4 Mar 2020 12:49:52 +0100
Message-Id: <20200304114952.1827-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Endianess conversion should not happen when writing out the string,
instead convert proto endiannes when creating the trace point data,
like its already done for control port rx.

Without this patch, trace looks like:
<...>-53819 [000] 12957.654875: rdev_tx_control_port: [FAILED TO PARSE]
  wiphy_name=phy0 name=wlan0 ifindex=3 dest=ARRAY[dc, 7b, 94, a5, bb, 3e]
  proto=36488 unencrypted=1

After applying this patch:
wpa_supplicant-553   [001]   121.211264: rdev_tx_control_port: phy0,
  netdev:wlan0(3), dc:7b:94:a5:bb:3e, proto: 0x888e, unencrypted: true

Fixes: 2576a9ace47e ("nl80211: Implement TX of control port frames")
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/wireless/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 839df54cee21..8c974245c8e1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1959,13 +1959,13 @@ TRACE_EVENT(rdev_tx_control_port,
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(dest, dest);
-		__entry->proto = proto;
+		__entry->proto = be16_to_cpu(proto);
 		__entry->unencrypted = unencrypted;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ","
 		  " proto: 0x%x, unencrypted: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest),
-		  be16_to_cpu(__entry->proto),
+		  __entry->proto,
 		  BOOL_TO_STR(__entry->unencrypted))
 );
 
-- 
2.25.1

