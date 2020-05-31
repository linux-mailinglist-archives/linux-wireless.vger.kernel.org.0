Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C91E99F4
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2020 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgEaS42 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 May 2020 14:56:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53805 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgEaS42 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 May 2020 14:56:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590951387; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=trLwZl1zHgsLUiOpsG2i13VC1p0G9lopjGIun3wS0Jk=; b=O4uawwh5cPGfDSDLh37rmhLp4UokhmwErgEU3SXyMi3WbNu4oNCMyh85umMWAdvHp1MurlqM
 JjFbbfPPGxmBpKLe+RseRKpep00mf9A+Ikbbo6m+NkMb4+odiJ1fNbd36uEbzTjI16TExeTz
 sn4+Ptudqxule5cr6jVhG+cL3Mo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ed3fdc7c0031c71c24abb90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 31 May 2020 18:56:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FFD5C43387; Sun, 31 May 2020 18:56:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF6D3C433C9;
        Sun, 31 May 2020 18:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF6D3C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v4 0/8] add 6GHz radio support in ath11k driver
Date:   Sun, 31 May 2020 11:55:52 -0700
Message-Id: <20200531185600.20789-1-pradeepc@codeaurora.org>
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

changes in v4:
 - drop helper function to identify psc channel as different version is
   already merged.

changes in v3:
 - cfg80211: remove PSC channel flag and instead add helper function.
 - Address differences in 6GHZ frequencies between IEEE P802.11ax/D6.0
   and IEEE P802.11ax/D6.1

changes in v2:
 - Fixed ath11k_phymode to be set in 6GHZ band

Pradeep Kumar Chitrapu (8):
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
 6 files changed, 401 insertions(+), 98 deletions(-)

-- 
2.17.1

