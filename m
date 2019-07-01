Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73D2DD82
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfE2Mwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:52:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfE2Mwj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:52:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA4CCB00B;
        Wed, 29 May 2019 12:52:37 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, huangwen@venustech.com.cn,
        Solar Designer <solar@openwall.com>,
        Marcus Meissner <meissner@suse.de>
Subject: [PATCH 1/2] mwifiex: Fix possible buffer overflows at parsing bss descriptor
Date:   Wed, 29 May 2019 14:52:19 +0200
Message-Id: <20190529125220.17066-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529125220.17066-1-tiwai@suse.de>
References: <20190529125220.17066-1-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mwifiex_update_bss_desc_with_ie() calls memcpy() unconditionally in
a couple places without checking the destination size.  Since the
source is given from user-space, this may trigger a heap buffer
overflow.

Fix it by putting the length check before performing memcpy().

This fix addresses CVE-2019-3846.

Reported-by: huangwen <huangwen@venustech.com.cn>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 935778ec9a1b..64ab6fe78c0d 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1247,6 +1247,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 		}
 		switch (element_id) {
 		case WLAN_EID_SSID:
+			if (element_len > IEEE80211_MAX_SSID_LEN)
+				return -EINVAL;
 			bss_entry->ssid.ssid_len = element_len;
 			memcpy(bss_entry->ssid.ssid, (current_ptr + 2),
 			       element_len);
@@ -1256,6 +1258,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_SUPP_RATES:
+			if (element_len > MWIFIEX_SUPPORTED_RATES)
+				return -EINVAL;
 			memcpy(bss_entry->data_rates, current_ptr + 2,
 			       element_len);
 			memcpy(bss_entry->supported_rates, current_ptr + 2,
-- 
2.16.4

