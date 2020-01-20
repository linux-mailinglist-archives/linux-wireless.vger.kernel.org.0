Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF430142479
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 08:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgATHvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 02:51:41 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:39738 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgATHvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 02:51:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579506700; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FIEolavvo0sGf4c05NemGJUYyFiUzrKvRwRKakKacOw=; b=QoGpUCcCRUXR+Q1D8B9risx70uqXx/rwrRDLLtnYNW1x2EgcNB5by1CSAB9uAcc2IcGWyjIr
 PoXkpgOhpjYOJUytB/gyjxU1pXT4QoCxsjrhnrpLAVV2CjIJQhDfxrKZjyl2HtJazyHJUz5w
 S7/Cf1N+BR/PouR0VpTB528Ddus=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e255c0b.7fa71bf31c70-smtp-out-n02;
 Mon, 20 Jan 2020 07:51:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7C6EC4479F; Mon, 20 Jan 2020 07:51:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 549FBC433CB;
        Mon, 20 Jan 2020 07:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 549FBC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv10 0/6] cfg80211/mac80211: Add support for TID specific configuration
Date:   Mon, 20 Jan 2020 13:21:21 +0530
Message-Id: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

Add infrastructure to support per TID configurations like noack policy,
retry count, AMPDU control(disable/enable), RTSCTS control(enable/disable)
and TX rate mask configurations.
This will be useful for the driver which can supports data TID
specific configuration rather than phy level configurations.
Here NL80211_CMD_SET_TID_CONFIG added to support this operation by
accepting TID configuration.
This command can accept STA mac addreess to make the configuration
station specific rather than applying to all the connected stations
to the netdev.
And this nested command configuration can accept multiple number of
data TID specific configuration in a single command,
enum ieee80211_tid_conf_mask used to notify the driver that which
configuration got modified for the TID.

Tamizh chelvam (6):
  nl80211: Add NL command to support TID speicific configurations
  nl80211: Add support to configure TID specific retry configuration
  nl80211: Add support to configure TID specific AMPDU configuration
  nl80211: Add support to configure TID specific RTSCTS configuration
  nl80211: Add support to configure TID specific txrate configuration
  mac80211: Add api to support configuring TID specific configuration

 include/net/cfg80211.h       |   65 ++++++++++
 include/net/mac80211.h       |   10 ++
 include/uapi/linux/nl80211.h |  140 +++++++++++++++++++++
 net/mac80211/cfg.c           |   56 +++++++++
 net/mac80211/driver-ops.h    |   27 ++++
 net/wireless/nl80211.c       |  287 +++++++++++++++++++++++++++++++++++++++---
 net/wireless/rdev-ops.h      |   24 ++++
 net/wireless/trace.h         |   37 ++++++
 8 files changed, 629 insertions(+), 17 deletions(-)

v10:
  * Addressed Sergey comments.

v9:
  * Modified to accept multiple TIDs.
  * Splitted retry_short and retry_long as separate parameter
  * Introduced new api to reset tid config

v8:
  * Fixed enum typecast warning.

v7:
  * Fixed compilation error and removed tid config variables from mac80211

v6:
  * Addressed Johannes comments.

v5:
  * Fixed possible memleak of 'tid_conf' in nl80211_set_tid_config.

v4:
  * Fixed kbuild warnings.

v3:
  * Modified "nl80211: Add netlink attribute to configure TID specific tx rate" patch
    to accept multiple TX rate configuration at a time.
  * Modified noack and ampdu variable data type to int in
    "mac80211: Add api to support configuring TID specific configuration" patch to store
    default configuration.
  * Modified "ath10k: Add new api to support TID specific configuration" patch to handle
    default values for noack and ampdu. And added sta pointer sanity check in
    ath10k_mac_tid_bitrate_config function.
  * Fixed "ath10k: Add extended TID configuration support" wmi command parameters
    assigned part.

v2:
  * Added support to accept multiple TID configuration
  * Added support to configure TX rate and RTSCTS control
-- 
1.7.9.5
