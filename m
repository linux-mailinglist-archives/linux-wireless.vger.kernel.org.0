Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45051FEA96
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 07:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFRFEq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 01:04:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28292 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgFRFEp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 01:04:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592456684; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8RvHqxkOEZMTU0XEPKz5Z2/Yn94G4iiWsJD5PrkwSTk=; b=ZshgKfBtuuNn5bpoU2cH0gx5v0x3dZzxdlMX2Iu6p9mr/lFbn6VFDEvi3QQAVEIgpxw2BABN
 NHvAN4v33vR3la/87khDgjPIaajLpai4AsMM8QVqvDKv3VsMkdX1H+HnKRvp1ePs87LovPph
 ZOWGVTE2bD6eOr7H0Mh/vzp/s5k=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5eeaf5e14c9690533a630754 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 05:04:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9500FC433CB; Thu, 18 Jun 2020 05:04:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 323D7C433C9;
        Thu, 18 Jun 2020 05:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 323D7C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v4 0/2] Add FILS discovery support
Date:   Wed, 17 Jun 2020 22:04:25 -0700
Message-Id: <20200618050427.5891-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for FILS discovery transmission as per
IEEE Std 802.11ai-2016.

v4: Removed separate flag 'enabled' and data related to beacon
response window and omit replicated probe response features.

Aloka Dixit (2):
  nl80211: Add FILS discovery support
  mac80211: Add FILS discovery support

 include/net/cfg80211.h       | 19 +++++++++++++++
 include/net/mac80211.h       | 27 +++++++++++++++++++++
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++
 net/mac80211/cfg.c           | 41 ++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  7 ++++++
 net/mac80211/tx.c            | 25 ++++++++++++++++++++
 net/wireless/nl80211.c       | 46 ++++++++++++++++++++++++++++++++++++
 7 files changed, 201 insertions(+)

-- 
2.25.0

