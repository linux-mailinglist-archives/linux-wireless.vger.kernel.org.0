Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464922E4AF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jul 2020 06:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgG0ER6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jul 2020 00:17:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17987 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbgG0ER5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jul 2020 00:17:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595823477; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RiTEnWRZugWLOg2aooXMs0bt8cnigrezInuTltSwzWk=; b=Vwwg4WEy0s0WSD8LzIqgazqFecV4RPkoJmjPWuu8pq3Q3XHpMSvSx2455mo+Rx2ZiewfY0cH
 UwE/m3GmIdNHFNEhRk4Qf5mYKKrOoqtaMTTKLrl64agauT2xJElk7A/4Tj69kfUI8egQXnua
 i8MrqLlNMRwDE7x2mwYz3ro4fNQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f1e555ebd0c3f02965191d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 04:17:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD38FC433CA; Mon, 27 Jul 2020 04:17:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7906BC433C6;
        Mon, 27 Jul 2020 04:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7906BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 0/2] ath10k: SAR power limit vendor command
Date:   Mon, 27 Jul 2020 12:17:36 +0800
Message-Id: <1595823458-3926-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: change description of "nl80211: vendor-cmd: qca: add dynamic SAR power limits"
remove ATH10K_WMI_SAR_*G_0_MASK of wmi.h

here's a patchset adding dynamic SAR power limit vendor command to
ath10k. This follows the new process documented in the wiki:

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

Wen Gong (2):
  nl80211: vendor-cmd: qca: add dynamic SAR power limits
  ath10k: allow dynamic SAR power limits to be configured

 drivers/net/wireless/ath/ath10k/Makefile |   1 +
 drivers/net/wireless/ath/ath10k/core.c   |   2 +
 drivers/net/wireless/ath/ath10k/core.h   |   2 +
 drivers/net/wireless/ath/ath10k/hw.h     |   3 +
 drivers/net/wireless/ath/ath10k/mac.c    |  64 +++++++++++++
 drivers/net/wireless/ath/ath10k/mac.h    |   2 +-
 drivers/net/wireless/ath/ath10k/vendor.c | 114 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/vendor.h |  13 +++
 include/uapi/nl80211-vnd-qca.h           |  68 ++++++++++++++
 9 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath10k/vendor.c
 create mode 100644 drivers/net/wireless/ath/ath10k/vendor.h
 create mode 100644 include/uapi/nl80211-vnd-qca.h

-- 
2.23.0

