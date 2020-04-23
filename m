Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815571B57FA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDWJT5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 05:19:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42761 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgDWJT5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 05:19:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587633597; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=okzeHzsPlBvB+6nY8N1o+e8CEjRSPerRcY0Q6/pgWXg=; b=xH4wrZECTJztq5su0IyJnKfz3RYCCocNlfEFcWFKpogmZUUXbstt2yQjQfg5SeDIFzqME9O6
 t9Uok2HijjtkleAbMAEtKCvdzVny2jkay96pS8m3ENl05ug+/SjNP7/h1aVDWjp2Y2Bno7Ml
 pIi0SGqMJXMCajmoZCJozX70IsQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea15dad.7f46f36a9d18-smtp-out-n04;
 Thu, 23 Apr 2020 09:19:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B081DC432C2; Thu, 23 Apr 2020 09:19:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24F5BC433CB;
        Thu, 23 Apr 2020 09:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24F5BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 0/4] ath10k: sdio: add support for rx/tx bitrate reporting
Date:   Thu, 23 Apr 2020 17:18:52 +0800
Message-Id: <20200423091856.24297-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iw wlan0 link/iw wlan0 station dump show the wrong bitrate for rx/tx.
wrong example:
rx bitrate: 6.0 MBit/s
tx bitrate: 2.8 MBit/s

These patches correct them.
rx bitrate: 234.0 MBit/s VHT-MCS 3 80MHz VHT-NSS 2
rx bitrate: 40.5 MBit/s MCS 2 40MHz
rx bitrate: 72.2 MBit/s MCS 7 short GI
rx bitrate: 54.0 MBit/s
rx bitrate: 48.0 MBit/s

tx bitrate: 54.0 MBit/s

Wen Gong (4):
  ath10k: enable firmware peer stats info for wmi tlv
  ath10k: add rx bitrate report for SDIO
  ath10k: add bitrate parse for peer stats info
  ath10k: correct tx bitrate of iw for SDIO

 drivers/net/wireless/ath/ath10k/core.c    |   2 +
 drivers/net/wireless/ath/ath10k/core.h    |  25 +++
 drivers/net/wireless/ath/ath10k/hw.h      |   3 +
 drivers/net/wireless/ath/ath10k/mac.c     | 216 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi-ops.h |  30 +++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 121 ++++++++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 110 +++++++++++
 drivers/net/wireless/ath/ath10k/wmi.h     |   9 +
 8 files changed, 516 insertions(+)

-- 
2.23.0
