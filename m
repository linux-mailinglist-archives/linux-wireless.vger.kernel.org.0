Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FCEFD61
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfKEMlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 07:41:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbfKEMlx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 07:41:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A5CF6146F; Tue,  5 Nov 2019 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957712;
        bh=8l7x99DpzqsO9Y8NmX36D894/uYYifRdmE8zXdxAbKo=;
        h=From:To:Cc:Subject:Date:From;
        b=jKS0A6IkYiAjjfSiac/CUOicJH9bUTR1jgMSSz0srnrV0wM3NMFIEo2ZghqMRtFJF
         YzlmQLcf1RHfso9x6r9P7vnK+gkZO4GIuImiSSTPq9+XFSdoLO5sGeiqDVfHnie/R1
         TG4bywtqks6u/XFb345RpVChHY5TB4ohbaJpINWI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20E3A61411;
        Tue,  5 Nov 2019 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957711;
        bh=8l7x99DpzqsO9Y8NmX36D894/uYYifRdmE8zXdxAbKo=;
        h=From:To:Cc:Subject:Date:From;
        b=Igd1ktpiNY/pTRrhHozL89VBBbjyPVT+zDgyxpwwqbynV7qsukn8MBZTpC9ILaHl/
         VYmPmLDfEpHO7fJvsPuM1DTAFch2ltegJlSxypWCnhMhxGss5ve1IzFOBcUiYAWyqY
         3LvTeQTnPQGW+OBpI9A4M11LSKtyKVYHc2dA9I+I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E3A61411
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific configuration
Date:   Tue,  5 Nov 2019 18:11:48 +0530
Message-Id: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
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

Tamizh chelvam (6):
  nl80211: New netlink command for TID specific configuration
  nl80211: Add new netlink attribute for TID speicific retry count
  nl80211: Add netlink attribute for AMPDU aggregation enable/disable
  nl80211: Add netlink attribute to enable/disable RTS_CTS
  nl80211: Add netlink attribute to configure TID specific tx rate
  mac80211: Add api to support configuring TID specific configuration

 include/net/cfg80211.h       |   55 +++++++++
 include/net/mac80211.h       |    8 ++
 include/uapi/linux/nl80211.h |  190 +++++++++++++++++++++++++++++
 net/mac80211/cfg.c           |   28 +++++
 net/mac80211/driver-ops.h    |   15 +++
 net/wireless/nl80211.c       |  276 +++++++++++++++++++++++++++++++++++++++---
 net/wireless/rdev-ops.h      |   12 ++
 net/wireless/trace.h         |   17 +++
 8 files changed, 584 insertions(+), 17 deletions(-)

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

