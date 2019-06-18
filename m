Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8690849934
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfFRGrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:47:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFRGrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47837602FE; Tue, 18 Jun 2019 05:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835655;
        bh=5all+4v3xe8x8XDGTOIA6q4p47cOQMRMUu1s+MqNhX0=;
        h=From:To:Cc:Subject:Date:From;
        b=RjTRZnhj1d+l1898eT8YEiP2yHFoQsl6CeMntjpVgM/CebZVRjJnyvfvt5Co4M9Wc
         KOPf/jGLNUzkVJW5flU4pULrxzZxU81OFbShTEDDNUBmDrdmd57rI0Q2Ws3YZTFaAn
         oXIfT7A238+BPXtqpIjSZQWmne9uUWdrg3XLoDak=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1883B602FE;
        Tue, 18 Jun 2019 05:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835654;
        bh=5all+4v3xe8x8XDGTOIA6q4p47cOQMRMUu1s+MqNhX0=;
        h=From:To:Cc:Subject:Date:From;
        b=RFYKcx4p2Xiaudog4bKAq4pz3MwxflDLB/twndPsLGTn7VgRmMOo4aOmvFzRTODAE
         EeblF+/xspw6JUvxUWKCPaGU3r5mHIVe2preZJ3S2Qc203uaKLA3r1r0z1iBDBcVcI
         fb2ndKF8VXgheG4pwXK7uL/Ls2xrBVdMupd6lKqI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1883B602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv6 0/9] cfg80211/mac80211: Add support for TID specific configuration
Date:   Tue, 18 Jun 2019 10:57:03 +0530
Message-Id: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

Tamizh chelvam (9):
  nl80211: New netlink command for TID specific configuration
  nl80211: Add new netlink attribute for TID speicific retry count
  nl80211: Add netlink attribute for AMPDU aggregation enable/disable
  nl80211: Add netlink attribute to enable/disable RTS_CTS
  nl80211: Add netlink attribute to configure TID specific tx rate
  mac80211: Add api to support configuring TID specific configuration
  ath10k: Add wmi command support for station specific TID config
  ath10k: Add new api to support TID specific configuration
  ath10k: Add extended TID configuration support

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

 drivers/net/wireless/ath/ath10k/core.c    |    4 +
 drivers/net/wireless/ath/ath10k/core.h    |    6 +
 drivers/net/wireless/ath/ath10k/mac.c     |  681 +++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/wmi-ops.h |   19 +
 drivers/net/wireless/ath/ath10k/wmi.c     |   35 ++
 drivers/net/wireless/ath/ath10k/wmi.h     |   72 +++
 include/net/cfg80211.h                    |   57 +++
 include/net/mac80211.h                    |   38 ++
 include/uapi/linux/nl80211.h              |  188 ++++++++
 net/mac80211/cfg.c                        |   28 ++
 net/mac80211/driver-ops.h                 |   15 +
 net/wireless/nl80211.c                    |  284 +++++++++++-
 net/wireless/rdev-ops.h                   |   12 +
 net/wireless/trace.h                      |   17 +
 14 files changed, 1371 insertions(+), 85 deletions(-)

-- 
1.7.9.5

