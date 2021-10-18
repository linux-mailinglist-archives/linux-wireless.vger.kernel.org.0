Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67D8431666
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 12:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJRKtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJRKtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 06:49:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6DBC06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 03:46:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so40438458wrv.9
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BaJ5lbXk0aHDbSY/0wo3ZTQDwBqF9Vwclu0gix6RmYQ=;
        b=xn4FIYIEzzSCxgDqLrrb44ivDe/qPvSAiYlg5UwclYfv+9u8zEktek80sUw5xKg+H2
         sE+Bteza3k3y8ESdsw0M94j3ZQxob+XybcMlwBQjCDVvcgdB15JD7AO3aYFFb5Momqrk
         xjmCrekgwtjv70Ud8hDgjLkZ4AW3ocSoIE1M4fMT6Grv2fRIRKnfUwsJZobJCoShExGI
         iqmkGX6dJYi2QESU+4AtiuWttyObJ10TpEE/gtrgZWI+zeyVvsrzl+MdsdZKs5ONfXm1
         F4W6/Ndnroa40dXroSW62XIu66XFnwxJ3ajpoSB89v+dni9p/RFtees18vaFMIV/opHC
         klAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BaJ5lbXk0aHDbSY/0wo3ZTQDwBqF9Vwclu0gix6RmYQ=;
        b=B3Z0K94B2tYmkREs13LADAuRseV2qYtQy2kZgUKjjHoBxeStXORWbdWY/Ia9/kX/YL
         kmUPunmOnl3ZxGJU9nSfq3TWTt+BVtsI5HRqwTyfuYJlYAyzT9mWN/EekhHnBK+Sf/wx
         Uh0bdkQ9cXizXn7odVICsirwv2d5W9fND4/1NH8e344kYL8fxsMq04YlzE/LMiiHpUnh
         XcfIwaqDJeEAzK8D0eQAXhS/vR/Y83t0A0BK8CU5OfuIMubuwJVVqbyzRFyIzYmhf4EH
         JNcpLY/AxUGpPvHKRMq9AkqfXYEK1NE9+RDd+VnNNRFDq0sXyDmabC4CXvSio6iq3oLH
         FGkg==
X-Gm-Message-State: AOAM533GjZds2QrbGRQmINsPTOttg9tNG2UvAYbs017S9/inYeY2bqs/
        G7ULGVL5AvHyHYbgOj53jQ346w==
X-Google-Smtp-Source: ABdhPJyPD524zCJIXTunRMo1CRVyygDS/iTkoIgvE0iorP9VLwnb9jXeTxZPDwDOMuH5aWLaAUh/Cw==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr35718769wrr.386.1634554010787;
        Mon, 18 Oct 2021 03:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:9df5:c752:530b:345b])
        by smtp.gmail.com with ESMTPSA id r4sm15195945wrz.58.2021.10.18.03.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:46:50 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/2] wcn36xx: Enable hardware scan offload for 5Ghz band
Date:   Mon, 18 Oct 2021 12:57:58 +0200
Message-Id: <1634554678-7993-2-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Until now, offload scanning for 5Ghz channels was considered broken.
However it was mostly a driver issue, caused by bad reporting of the
beacons/probe-resp bands and frequencies, which has been fixed.

We can now allow offload scan for 5GHz band, this reduces the scanning
time comparing to software driven scanning.

Note that offloaded scan is limited to 48 channels, check for this.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 263af65..2ac8efa 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -659,19 +659,19 @@ static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
 			   struct ieee80211_scan_request *hw_req)
 {
 	struct wcn36xx *wcn = hw->priv;
-	int i;
 
 	if (!get_feat_caps(wcn->fw_feat_caps, SCAN_OFFLOAD)) {
 		/* fallback to mac80211 software scan */
 		return 1;
 	}
 
-	/* For unknown reason, the hardware offloaded scan only works with
-	 * 2.4Ghz channels, fallback to software scan in other cases.
+	/* Firmware scan offload is limited to 48 channels, fallback to
+	 * software driven scanning otherwise.
 	 */
-	for (i = 0; i < hw_req->req.n_channels; i++) {
-		if (hw_req->req.channels[i]->band != NL80211_BAND_2GHZ)
-			return 1;
+	if (hw_req->req.n_channels > 48) {
+		wcn36xx_warn("Offload scan aborted, n_channels=%u",
+			     hw_req->req.n_channels);
+		return 1;
 	}
 
 	mutex_lock(&wcn->scan_lock);
-- 
2.7.4

