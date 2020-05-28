Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433771E5B6E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgE1JID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:08:03 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:32969 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgE1JIC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:08:02 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 10F68580065;
        Thu, 28 May 2020 11:08:01 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] nl80211: add missing comment on beacon prot
Date:   Thu, 28 May 2020 11:07:57 +0200
Message-Id: <20200528090757.11623-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/uapi/linux/nl80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14666b75e57..f6b5bff49b6f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5753,6 +5753,10 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS: management frame registrations
  *	are possible for multicast frames and those will be reported properly.
  *
+ * @NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT: driver can verify that
+ *	received Beacon frames have a valid MME in station mode when a
+ *	BIGTK is configured
+ *
  * @NL80211_EXT_FEATURE_SCAN_FREQ_KHZ: This driver supports receiving and
  *	reporting scan request with %NL80211_ATTR_SCAN_FREQ_KHZ. In order to
  *	report %NL80211_ATTR_SCAN_FREQ_KHZ, %NL80211_SCAN_FLAG_FREQ_KHZ must be
-- 
2.26.2

