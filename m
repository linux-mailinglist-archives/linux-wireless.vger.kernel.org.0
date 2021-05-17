Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0456B386B33
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhEQUV0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:26 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56754 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhEQUVX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282805; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ISOOlr+OeaWAxjcX1uSyVjyImbajiEK/ItgpI+8j1VM=; b=ow1Qf4JxP/8NahpckpFZHeooMhq4GLSPXoJjV5gRayVj+9LE9BsO5WNM7WwDwI23UFZlMDWX
 cdAYc1VkvaDHe1q6oiAqykvqF8tNq3JB5cVgrNW+UnMTUuUyl8RicfM7b59ba1KEpNLJYjfs
 ha+LaOyNkolsthWJwBOiEEy+y3Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60a2cff4063320cd130fde53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:04
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A031DC433D3; Mon, 17 May 2021 20:20:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05BCCC433D3;
        Mon, 17 May 2021 20:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05BCCC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 0/9] cfg80211/mac80211: Add support for 6GHZ STA for various modes : LPI, SP and VLP
Date:   Mon, 17 May 2021 16:19:23 -0400
Message-Id: <20210517201932.8860-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It introduced some new concept:
power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
power spectral density(psd)

This patchset for cfg80211/mac80211 is to add the definition of new
concept of 6G and add basic parse of IE(transmit power envelope
element) in beacon and save power spectral density(psd) reported
by lower-driver for 6G channel, the info will be passed to lower
driver when connecting to 6G AP.

Wen Gong (9):
  cfg80211: add power type definition for 6G Hz
  mac80211: add definition of regulatory info in 6G Hz operation
    information
  mac80211: add parse regulatory info in 6G Hz operation information
  cfg80211: add definition for 6G power spectral density(psd)
  cfg80211: save power spectral density(psd) of regulatory rule
  mac80211: add definition for transmit power envelope element
  mac80211: add parse transmit power envelope element
  mac80211: add transmit power envelope element and power constraint in
    bss_conf
  mac80211: save transmit power envelope element and power constraint

 include/linux/ieee80211.h    | 35 ++++++++++++++++++++++++++++++++++-
 include/net/cfg80211.h       |  7 +++++++
 include/net/mac80211.h       |  6 ++++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h | 32 ++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  3 +++
 net/mac80211/mlme.c          | 21 +++++++++++++++++++++
 net/mac80211/util.c          | 18 ++++++++++++++++++
 net/wireless/reg.c           | 14 ++++++++++++++
 9 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.31.1

