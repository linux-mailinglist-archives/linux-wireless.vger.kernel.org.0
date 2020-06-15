Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DEE1F9ADF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgFOOvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 10:51:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64150 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730670AbgFOOvd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 10:51:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592232692; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=T704JSESpRyoVW9jvYH5GgVhIJT6xztX8hZwE7462RU=; b=RIg0+306yTHIqlEMdo1zAPHmTTCOxPo040c2j2g9TwOB9zk5RQe/PMjCVrM56mevKcwUcE84
 qIkCi9TlHpAgntRKENTe3q8jub9Q0L3WHJEIvl7mqejy7xkkFXq5/f0pFsAk0pXh4sWMCeSV
 80U+ECPb2/f1YmtT4Gyx8yeqKdA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ee78af4c4bb4f886db8a542 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 14:51:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4DE0CC433A0; Mon, 15 Jun 2020 14:51:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D15D3C433CA;
        Mon, 15 Jun 2020 14:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D15D3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, sven@narfation.org,
        24601deerej@gmail.com, markus.theil@tu-ilmenau.de
Subject: [PATCH v6] ath10k: provide survey info as accumulated data
Date:   Mon, 15 Jun 2020 17:51:26 +0300
Message-Id: <1592232686-28712-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

It is expected that the returned counters by .get_survey are monotonic
increasing. But the data from ath10k gets reset to zero regularly. Channel
active/busy time are then showing incorrect values (less than previous or
sometimes zero) for the currently active channel during successive survey
dump commands.

example:

  $ iw dev wlan0 survey dump
  Survey data from wlan0
  	frequency:                      5180 MHz [in use]
  	channel active time:            54995 ms
  	channel busy time:              432 ms
  	channel receive time:           0 ms
  	channel transmit time:          59 ms
  ...

  $ iw dev wlan0 survey dump
  Survey data from wlan0
  	frequency:                      5180 MHz [in use]
  	channel active time:            32592 ms
  	channel busy time:              254 ms
  	channel receive time:           0 ms
  	channel transmit time:          0 ms
  ...

The correct way to handle this is to use the non-clearing
WMI_BSS_SURVEY_REQ_TYPE_READ wmi_bss_survey_req_type. The firmware will
then accumulate the survey data and handle wrap arounds.

Tested on:

* QCA9984 hw1.0 firmware 10.4-3.5.3-00057
* QCA988X hw2.0 firmware 10.2.4-1.0-00047
* QCA9888 hw2.0 firmware 10.4-3.9.0.2-00024
* QCA4019 hw1.0 firmware 10.4-3.6-00140

Fixes: fa7937e3d5c2 ("ath10k: update bss channel survey information")
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Tested-by: Markus Theil <markus.theil@tu-ilmenau.de>
Tested-by: John Deere <24601deerej@gmail.com>
[sven@narfation.org: adjust commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---

v6:

* cc linux-wireless so patchwork sees this

v5:
* add additional tested devices
* restructure commit message

v4:
 * updated signed-off-by

v3:
 * Rebased on TOT and added Tested-by

Everything expect QCA9984 hw1.0 firmware 10.4-3.5.3-00057 was also tested
by Sven.

 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 919d15584d4a..77daca67a8e1 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7283,7 +7283,7 @@ ath10k_mac_update_bss_chan_survey(struct ath10k *ar,
 				  struct ieee80211_channel *channel)
 {
 	int ret;
-	enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR;
+	enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-- 
2.7.4

