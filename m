Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE21B9953
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgD0IE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 04:04:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36818 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgD0IE6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 04:04:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587974698; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=4b60l1MUjp9xJN8j79bRKCVIS9m5DNzok1wW7MqY8CQ=; b=V60oobrkwJYj4YVzdLTFhyioBHYOBB6XSg8l6/A7JBj0pu96AKxVXlDUAa0FAhIZMmwAYL2v
 AKKgtp9S7KF7u+0dbAjTs+XrRkKBACUEZwCQadrUL6uPko1RBbP18YGSzp1fFKDXe3WuquET
 hWyl8EhnmZQN4vNl7e8QytC6GvM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6921f.7f006a1d5340-smtp-out-n02;
 Mon, 27 Apr 2020 08:04:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F33B9C433CB; Mon, 27 Apr 2020 08:04:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B489C433D2;
        Mon, 27 Apr 2020 08:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B489C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 0/4] ath10k: sdio: add support for rx/tx bitrate reporting
Date:   Mon, 27 Apr 2020 16:04:12 +0800
Message-Id: <20200427080416.8265-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: rebased to ath-next of 04/27

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
