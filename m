Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AFF1EB310
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 03:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgFBBi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 21:38:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62132 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgFBBi5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 21:38:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591061936; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ggwDG6qU0dO0mlaf+51bPkESzr/Tjoda1hC53SyhqFQ=; b=EDVlo+MclOsy4jkecmt1uaCRWa1U6HvZsyUdut1sBAOeJdUCorRMfont6tNHtPSm13nnHEcT
 uMmoKtnb5C9esbXO9UPG1+CHJX2zYWlklOcPWaaV0L1Odg3PvEY+87WufL88LMubZVnZ+umO
 8sAt/tXbGmm4IFWcUfrY8f8Tbeo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ed5adacb65440fdbae6f537 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 01:38:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95038C433C6; Tue,  2 Jun 2020 01:38:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D54BC433C9;
        Tue,  2 Jun 2020 01:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D54BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v3 0/2] Add FILS discovery support
Date:   Mon,  1 Jun 2020 18:38:42 -0700
Message-Id: <20200602013844.26275-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for FILS discovery transmission as per
IEEE Std 802.11ai-2016.

This is the next version in the series given below:
FILS discovery and bcast probe resp support.
Unsolicited broadcast probe response support is now split into
a separate patchset.

Aloka Dixit (2):
  nl80211: Add FILS discovery support
  mac80211: Add FILS discovery transmission support

 include/net/cfg80211.h       | 25 ++++++++++++++++
 include/net/mac80211.h       | 31 ++++++++++++++++++++
 include/uapi/linux/nl80211.h | 46 +++++++++++++++++++++++++++++
 net/mac80211/cfg.c           | 46 +++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  7 +++++
 net/mac80211/tx.c            | 25 ++++++++++++++++
 net/wireless/nl80211.c       | 57 ++++++++++++++++++++++++++++++++++++
 7 files changed, 237 insertions(+)

-- 
2.25.0

