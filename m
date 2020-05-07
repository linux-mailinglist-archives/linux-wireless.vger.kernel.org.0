Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD291C8004
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 04:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgEGCay (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 22:30:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42019 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgEGCax (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 22:30:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588818652; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HNg0pbQFUOtmhNwlDL7Xthqpz6JyL7S4j3faozymgnY=; b=ds/1HXTeLES9QZf38vpg6x8gOp55ldZ2ps8jkijldzgXlfe/Sx5xP3i8snCCcs0av+W9PMsq
 TIC4CULKcspRIIno+0x9hWamWPJ+GWIHR/DAb9l0BM4EUt/ARagOuVSJv4R8BUJoWxNKUEkn
 suu9GlnX1VB2PCAsnK32RY+TS9U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D8BBC432C2; Thu,  7 May 2020 02:30:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF7CBC433BA;
        Thu,  7 May 2020 02:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF7CBC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCHv3] ath10k : Fix channel survey dump
Date:   Thu,  7 May 2020 08:00:34 +0530
Message-Id: <1588818634-10624-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Channel active/busy time are showing incorrect(less than previous or
sometimes zero) for successive survey dump command.

example:
Survey data from wlan0
	frequency:                      5180 MHz [in use]
	channel active time:            54995 ms
	channel busy time:              432 ms
	channel receive time:           0 ms
	channel transmit time:          59 ms
Survey data from wlan0
	frequency:                      5180 MHz [in use]
	channel active time:            32592 ms
	channel busy time:              254 ms
	channel receive time:           0 ms
	channel transmit time:          0 ms

This patch fix this issue by assigning 'wmi_bss_survey_req_type'
as 'WMI_BSS_SURVEY_REQ_TYPE_READ' which accumulate survey data in
FW and send survey data to driver upon the driver request. Wrap around
is taken care by FW.

hardware used : QCA9984
firmware ver  : ver 10.4-3.5.3-00057

hardware used : QCA988X
firmware ver  : 10.2.4-1.0-00047

Tested-by: Markus Theil <markus.theil@tu-ilmenau.de>
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
v3:
 * Rebased on TOT and added Tested-by

 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a1147cc..9330b52 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7275,7 +7275,7 @@ ath10k_mac_update_bss_chan_survey(struct ath10k *ar,
 				  struct ieee80211_channel *channel)
 {
 	int ret;
-	enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR;
+	enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-- 
2.7.4

