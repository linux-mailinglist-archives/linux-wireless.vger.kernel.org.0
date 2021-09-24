Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F86416FD2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245423AbhIXKDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:03:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10624 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245370AbhIXKDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:03:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632477708; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Jtm1YlKHDvpeMf3rbeFkR5QNvHJkqFfAZqi3HuZVxnY=; b=Vs7cFT26qeqw4IMn9GcyD+8KSRshsS0E3C9X5NjXCpCAq0/sWt2twSvKzZRC8RIYulVhkl+k
 fz2MX9qzt22CrLtoPYT40pnS3EnueTz8NipaMGf+aIWZkQhFM84H/W+knXyxzcqvxLeHlLwl
 7ZIQa1/ce1o6ocCRQ9LRUp1K2+8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 614da1eb44830700e1cfea4e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 10:01:15
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62970C4360C; Fri, 24 Sep 2021 10:01:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6317C4338F;
        Fri, 24 Sep 2021 10:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A6317C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v4 0/6] cfg80211/mac80211: Add support for 6GHZ STA for various modes : LPI, SP and VLP
Date:   Fri, 24 Sep 2021 06:00:46 -0400
Message-Id: <20210924100052.32029-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v4:
    1. rebased to top commit id 9e263e193af7 kernel/git/jberg/mac80211-next.git
    2. add NULL check for "mac80211: use ieee802_11_parse_elems() to find ies instead of ieee80211_bss_get_ie()"
    3. remove the 3 patches which already upstream:
       "mac80211: parse transmit power envelope element"
       "ieee80211: add definition for transmit power envelope element"
       "ieee80211: add definition of regulatory info in 6 GHz operation information"

v3: change per comments of Johannes.
    1. add patch "mac80211: use ieee802_11_parse_elems() to find ies instead of ieee80211_bss_get_ie()"
    2. move nl80211_ap_reg_power to ieee80211
    3. change some comments, length check, stack big size variable...

v2: change per comments of johannes.
    including code style, code logic, patch merge, commit log...

It introduced some new concept:
power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
power spectral density(psd)

This patchset for cfg80211/mac80211 is to add the definition of new
concept of 6G and add basic parse of IE(transmit power envelope
element) in beacon and save power spectral density(psd) reported
by lower-driver for 6G channel, the info will be passed to lower
driver when connecting to 6G AP.

Wen Gong (6):
  mac80211: add power type definition for 6 GHz
  mac80211: add parse regulatory info in 6 GHz operation information
  cfg80211: add definition for 6 GHz power spectral density(psd)
  cfg80211: save power spectral density(psd) of regulatory rule
  mac80211: use ieee802_11_parse_elems() to find ies instead of
    ieee80211_bss_get_ie()
  mac80211: save transmit power envelope element and power constraint

 include/linux/ieee80211.h    | 34 +++++++++++++++
 include/net/cfg80211.h       |  5 +++
 include/net/mac80211.h       |  8 ++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h |  2 +
 net/mac80211/mlme.c          | 82 +++++++++++++++++++++++++++++-------
 net/mac80211/util.c          | 13 ++++++
 net/wireless/reg.c           | 17 ++++++++
 8 files changed, 146 insertions(+), 16 deletions(-)


base-commit: 9e263e193af73d2509dc3102a680a11130f44e20
-- 
2.31.1

