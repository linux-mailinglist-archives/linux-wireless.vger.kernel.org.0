Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC63FFF67
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbhICLuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:50:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40650 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbhICLtz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669736; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8J3XuegD4iyKDqBo+ZnOhIoK9/VlPL5UQ/Otmdr5d8o=; b=NIyrxI2EvIrmfxMJ3I9KhZp0QWr1RgFWe0kmpFnsSUjSLInTgk1DjQeUVYn06lSzwVXqeQBu
 BH6G0P2m2k75aNLTBdH4Wy4BhQXCijoz2MpygDcxeofZWiEhCGaL3JIfBEtIHcBxjcqjLcDs
 O6Nldbcmw+D6/15uS0zRXt8z3eU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61320b8d6fc2cf7ad9a2286b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:29
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC925C4360C; Fri,  3 Sep 2021 11:48:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14805C4338F;
        Fri,  3 Sep 2021 11:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 14805C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 0/9] cfg80211/mac80211: Add support for 6GHZ STA for various modes : LPI, SP and VLP
Date:   Fri,  3 Sep 2021 07:48:12 -0400
Message-Id: <20210903114821.23346-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@qti-qualcomm.corp-partner.google.com>

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


Wen Gong (9):
  mac80211: add power type definition for 6 GHz
  ieee80211: add definition of regulatory info in 6 GHz operation
    information
  mac80211: add parse regulatory info in 6 GHz operation information
  cfg80211: add definition for 6 GHz power spectral density(psd)
  cfg80211: save power spectral density(psd) of regulatory rule
  ieee80211: add definition for transmit power envelope element
  mac80211: add parse transmit power envelope element
  mac80211: use ieee802_11_parse_elems() to find ies instead of
    ieee80211_bss_get_ie()
  mac80211: save transmit power envelope element and power constraint

 include/linux/ieee80211.h    | 80 +++++++++++++++++++++++++++++++++++-
 include/net/cfg80211.h       |  5 +++
 include/net/mac80211.h       |  8 ++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h |  2 +
 net/mac80211/ieee80211_i.h   |  3 ++
 net/mac80211/mlme.c          | 70 +++++++++++++++++++++++--------
 net/mac80211/util.c          | 23 +++++++++++
 net/wireless/reg.c           | 17 ++++++++
 9 files changed, 192 insertions(+), 17 deletions(-)

-- 
2.31.1

