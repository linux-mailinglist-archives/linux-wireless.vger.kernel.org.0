Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6035381B
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Apr 2021 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhDDMws (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Apr 2021 08:52:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46249 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhDDMws (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Apr 2021 08:52:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617540763; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NaRqf3XrCBEz23u1+TzxxvWRJTKesb8d2wYZUZNP3aU=; b=g1/C8vlofLiMRbKU8gjtE/Q24GQU6E9i0tGlIKXb7azzc1OdBE1971Pk0wpbHx0MwHNwt/8M
 Vurg/h1hd5xNjm3qcF2guXY9BhCy7ZrdbId3gzzi2HuBAePz4tuo8MQS3Bk35W6J7nx9Caei
 F8JhzNuBkrFj7MnMgJrhjIehwPQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6069b69bf34440a9d4cbfa0b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 04 Apr 2021 12:52:43
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0804EC43462; Sun,  4 Apr 2021 12:52:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2720EC433CA;
        Sun,  4 Apr 2021 12:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2720EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v9 0/3] ath11k: add HE radiotap header support
Date:   Sun,  4 Apr 2021 05:52:32 -0700
Message-Id: <20210404125235.5589-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series address review comments from previous revision:
https://patchwork.kernel.org/project/linux-wireless/list/?series=328291&state=%2A&archive=both

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

changes in v9:
 - maintain rate_info in local

changes in v8:
 - move ieee80211_tx_status_ext out of spin lock

changes in v7:
 - use generic radiotap HE fields from
	include/net/ieee80211_radiotap.h
 - fix converting gi and ltf enums to match nl80211 enums when
	updating radiotap headers.
 - fix sparse warnings

Pradeep Kumar Chitrapu (3):
  ath11k: switch to using ieee80211_tx_status_ext()
  ath11k: decode HE status tlv
  ath11k: translate HE status to radiotap format

 drivers/net/wireless/ath/ath11k/dp_rx.c    | 114 ++++-
 drivers/net/wireless/ath/ath11k/dp_tx.c    |  31 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 470 ++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal_rx.h   | 135 +++++-
 5 files changed, 669 insertions(+), 82 deletions(-)

-- 
2.17.1

