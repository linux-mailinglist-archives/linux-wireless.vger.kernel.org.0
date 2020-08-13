Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD32437DE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMJqx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:46:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19556 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJqw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:46:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597312011; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=aL1/DeCTZpvzS2kZqjaqBxuLWvtYWUCr9HvomvcchzA=; b=KvMoweQUKA9qHBrrejVhx0dmmmvijd+jqzuzpuMpvmE3LtAwFvMLNVpLgEf+HYrT+oX3hvS9
 GnDqYPOX1cbXdVFpkeggx1xcAco224+O5FCgZv7F6kC8XETLV/tvfH/Zyp5DM4CC6kae2OG/
 3ioNXKQ49DSgs0bM+RxSDAy4F3o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f350c021e4d3989d49c27af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:46:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5920C433CA; Thu, 13 Aug 2020 09:46:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8B39C433C9;
        Thu, 13 Aug 2020 09:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8B39C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 0/3] ath10k: correct tx/rx bitrate for QCA6174 PCIe and SDIO
Date:   Thu, 13 Aug 2020 17:47:06 +0800
Message-Id: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iw wlan0 station dump not show the correct tx/rx bitrate of QCA6174
PCIe and SDIO, it is because it has 1 check for WMI_SERVICE_PEER_STATS
and 1 return for empty arsta->txrate, so change to pass the check and
remove the return, then iw wlan0 station dump show correct tx/rx bitrate
for QCA6174 SDIO.

After that, set true for supports_peer_stats_info of QCA6174 PCIe, then
it show same correct tx/rx bitrate.

Wen Gong (3):
  ath10k: add wmi service peer stat info for wmi tlv
  ath10k: remove return for NL80211_STA_INFO_TX_BITRATE
  ath10k: enable supports_peer_stats_info for QCA6174 PCI devices

 drivers/net/wireless/ath/ath10k/core.c    |  1 +
 drivers/net/wireless/ath/ath10k/mac.c     | 21 ++++++++++-----------
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |  2 ++
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.23.0

