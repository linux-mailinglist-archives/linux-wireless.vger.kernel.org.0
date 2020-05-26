Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5617B1E32E4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 00:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbgEZWrr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 18:47:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12951 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389755AbgEZWrr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 18:47:47 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 18:47:38 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590533266; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8S2VdWieQob0PY0PYRozuafzJX6VnUnTHoYs6lhSUkc=; b=TCSvhRUFTIwlKigRO0JJNbC2oiWYCouqCJN5O12X2o9JoaHAu+LvKw49A3fDP/gRvsCEPObv
 /5S8PjvQRP8n2LeclhwmUteE6ZqWjGZe3IM+l3oqcRzH1q/VimieFlVI87YsWuVmFZQYCECn
 CMhl6xfOv96wP807JDtO3+ThfbM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecd9b5d2738686126ff38d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 22:42:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1A80C43387; Tue, 26 May 2020 22:42:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FECFC433C6;
        Tue, 26 May 2020 22:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FECFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v3 0/9] add 6GHz radio support in ath11k driver
Date:   Tue, 26 May 2020 15:42:08 -0700
Message-Id: <20200526224217.11119-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds 6GHz frequency listing in ath11k driver and mac80211
registration for the 6GHz band. Also, extends some of wmi command tlvs for
supporting 6GHz.

In cfg80211, a helper function is added for identifying Preferred Scanning
Channels (PSC) in 6GHz band.

changes in v3:
 - cfg80211: remove PSC channel flag and instead add helper function.
 - Address differences in 6GHZ frequencies between IEEE P802.11ax/D6.0
   and IEEE P802.11ax/D6.1

changes in v2:
 - Fixed ath11k_phymode to be set in 6GHZ band

Pradeep Kumar Chitrapu (9):
  cfg80211: Add helper function to identify 6GHz PSC channel
  ath11k: add 6G frequency list supported by driver
  ath11k: add support for 6GHz radio in driver
  ath11k: Use freq instead of channel number in rx path
  ath11k: extend peer_assoc_cmd for 6GHz band
  ath11k: set psc channel flag when sending channel list to firmware.
  ath11k: Add 6G scan dwell time parameter in scan request command
  ath11k: Send multiple scan_chan_list messages if required
  ath11k: Add support for 6g scan hint

 drivers/net/wireless/ath/ath11k/core.h  |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c |   6 +-
 drivers/net/wireless/ath/ath11k/mac.c   | 174 +++++++++++++--
 drivers/net/wireless/ath/ath11k/reg.c   |   4 +
 drivers/net/wireless/ath/ath11k/wmi.c   | 269 +++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/wmi.h   |  40 +++-
 include/net/cfg80211.h                  |  24 +++
 7 files changed, 425 insertions(+), 98 deletions(-)

-- 
2.17.1

