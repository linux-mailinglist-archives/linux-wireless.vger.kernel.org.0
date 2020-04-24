Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA51B821C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgDXWmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 18:42:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50737 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgDXWmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 18:42:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587768137; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GGE2frBgkpIRrrkHXl/XBXNSGUUe62IHDOp9Cht337c=; b=SoaWbZIHlf2V4bawgYZaUKc3w1wVRNPylJ+aXW2otaSVeNU6PTfzCtk9leszEIc96AtAoz2t
 Oz/Y6hBQEtIShN6upMoSXxubJkHa7kTMilP8Nk87z0s0hjENYDVN60gYRUs012gJDvzbX9iV
 S3//RCK+WeikBVyfTaqYPSZydBA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea36b3b.7f9c70b1b6f8-smtp-out-n01;
 Fri, 24 Apr 2020 22:42:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81EE4C433F2; Fri, 24 Apr 2020 22:42:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC26AC433CB;
        Fri, 24 Apr 2020 22:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC26AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 00/10] mac80211: add 6 GHz IEs support
Date:   Fri, 24 Apr 2020 15:41:38 -0700
Message-Id: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series includes following changes.

* Add 6 GHz band capability element (IEEE 802.11ax/D6.0, 9.4.2.261)
  in mesh beacon and assoc. request.
* Add 6 GHz operation information in HE operation.
* Parse 6 GHz  information elements.
* Decouple HT/VHT capability and do not allow HT/VHT overrides in 6 GHz.
* Determine channel information from HE information.

-Rajkumar

Rajkumar Manoharan (10):
  mac80211: fix memory overlap due to variable length param
  cfg80211: validate 6 GHz chandef
  nl80211: add HE 6 GHz Band Capability support
  mac80211: add HE 6 GHz Band Capabilities into parse extension
  mac80211: handle HE 6 GHz Capability in HE STA processing
  mac80211: add HE 6 GHz Band Capability IE in assoc. request
  mac80211: build HE operation with 6 GHz oper information
  mac80211: do not allow HT/VHT IEs in 6 GHz mesh mode
  mac80211: determine chantype from HE operation in 6 GHz
  ath11k: build HE 6 GHz capability

 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  33 ++++++-
 include/linux/ieee80211.h              |  58 +++++++++++
 include/net/cfg80211.h                 |  24 +++++
 include/net/mac80211.h                 |   7 +-
 include/uapi/linux/nl80211.h           |   6 ++
 net/mac80211/cfg.c                     |   3 +-
 net/mac80211/he.c                      |  65 ++++++++++--
 net/mac80211/ieee80211_i.h             |   8 +-
 net/mac80211/mesh.c                    |  62 +++++++++++-
 net/mac80211/mesh.h                    |   2 +
 net/mac80211/mesh_plink.c              |   7 +-
 net/mac80211/mlme.c                    |  25 ++++-
 net/mac80211/util.c                    | 174 ++++++++++++++++++++++++++++++++-
 net/wireless/chan.c                    |  46 +++++++++
 net/wireless/nl80211.c                 |  14 +++
 16 files changed, 510 insertions(+), 25 deletions(-)

-- 
2.7.4
