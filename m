Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBACAFC4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbfJCUIZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 16:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbfJCUIZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 16:08:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BC3C30BBE87;
        Thu,  3 Oct 2019 20:08:25 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-108.ams2.redhat.com [10.36.116.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67FD319C69;
        Thu,  3 Oct 2019 20:08:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 5.4 regression fix] brcmfmac: Fix brcmf_cfg80211_get_channel returning uninitialized fields
Date:   Thu,  3 Oct 2019 22:08:21 +0200
Message-Id: <20191003200821.819594-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 03 Oct 2019 20:08:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the new edmg support struct cfg80211_chan_def has been extended
with a number of new members. brcmf_cfg80211_get_channel() was not setting
(clearing) these causing the cfg80211_edmg_chandef_valid() check in
cfg80211_chandef_valid() to fail. Triggering a WARN_ON and, worse, causing
brcmfmac based wifi cards to not work.

This commit fixes this by clearing the entire passed struct to 0 before
setting the members used by the brcmfmac code. This solution also makes
sure that this problem will not repeat itself in the future if further
members are added to the struct.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e3ebb7abbdae..480c05f66ebd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5041,10 +5041,10 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
 	}
 
 	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band);
+	memset(chandef, 0, sizeof(*chandef));
 	chandef->chan = ieee80211_get_channel(wiphy, freq);
 	chandef->width = width;
 	chandef->center_freq1 = ieee80211_channel_to_frequency(ch.chnum, band);
-	chandef->center_freq2 = 0;
 
 	return 0;
 }
-- 
2.23.0

