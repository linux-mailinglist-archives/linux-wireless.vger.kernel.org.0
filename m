Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5E1A426B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDJGOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 02:14:41 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37984 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgDJGOl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 02:14:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586499281; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=oTFWAQR2IPGC3nW12/06HhfWuA/TM23tAop2dUm7Q20=; b=QsvCSiuruLrFAzlEYYtaZ+4H6IbN99vioQ9aVqCYySTYLD6gRjUmI6RepXZN8fXRpCEY3jS2
 9A0PLZNNb1+hI6PPBL+2u1DUfQxgLg1D1x/fO8G47bGbjAgcNa0TJSHL4wN9hvszB6Fw66IX
 7+tuQeydRdOEJdTlRhK8UL0MU0g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e900ecd.7fae4203ec00-smtp-out-n03;
 Fri, 10 Apr 2020 06:14:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC9DCC432C2; Fri, 10 Apr 2020 06:14:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D94D2C433D2;
        Fri, 10 Apr 2020 06:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D94D2C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v10 0/2] ath10k: improve throughout of TX of sdio 
Date:   Fri, 10 Apr 2020 14:13:58 +0800
Message-Id: <20200410061400.14231-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v10: change ath10k_dbg log format

v9: change ath10k_htt_htc_tx_complete to fix the use-after-free panic

v8: split out patch "change ATH10K_SDIO_BUS_REQUEST_MAX_NUM from 64 to 1024"
from "disable TX complete indication of htt for sdio". merge patch
"ath10k: clean bundle tx queue of htt tx stop for sdio" into
"add htt TX bundle for sdio"

v7: change a few code style to meet ath10k-check script

v6: remove module parameters disable_tx_comp and alt_data
this is 3 patches of the 7 patches from ath10k: improve throughout of tcp/udp TX/RX of sdio

v5: change ath10k_htc_setup_tx_req to add check bundle_tx
to forbidden init 2 times

v4: add macro ATH10K_HTC_MSG_READY_EXT_ALT_DATA_MASK

v3: change some code style

v2: change some code style

The bottleneck of throughout on sdio chip is the bus bandwidth, to the
patches are all to increase the use ratio of sdio bus.

These patches only affect sdio bus chip, explanation is mentioned in each
patch's commit log.

Wen Gong (2):
  ath10k: add htt TX bundle for sdio
  ath10k: enable alt data of TX path for sdio

 drivers/net/wireless/ath/ath10k/core.c   |  22 +-
 drivers/net/wireless/ath/ath10k/core.h   |   4 +-
 drivers/net/wireless/ath/ath10k/htc.c    | 384 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/htc.h    |  37 ++-
 drivers/net/wireless/ath/ath10k/htt.c    |   8 +
 drivers/net/wireless/ath/ath10k/htt.h    |   4 +
 drivers/net/wireless/ath/ath10k/htt_rx.c |   1 +
 drivers/net/wireless/ath/ath10k/htt_tx.c |   8 +-
 8 files changed, 423 insertions(+), 45 deletions(-)

-- 
2.23.0
