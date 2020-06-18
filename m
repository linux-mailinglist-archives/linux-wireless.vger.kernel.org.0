Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6251FEB6A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFRGWH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 02:22:07 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32669 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726945AbgFRGWH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 02:22:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592461326; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=h3Qx6ZQ59PfwWl+bBj0rLuAkH/hEtjG+ALNKBq4olNU=; b=lWXknQefc/UIwfV4AAIW9SBn1DS5EelFOhfV4nYyhq8yWeLRJVxySNBK8PkREm6zsileqVEs
 6PmiKzWrm+TiRM/VwU70Em7iteLivVFhZnAr63WSWX7TSFr98xNcDXdU8FdUhfb2OxcG/JI8
 0we4W07pSa4H5DOobzLH6PxC76Q=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5eeb0803e144dd51152623d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 06:21:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18186C433CB; Thu, 18 Jun 2020 06:21:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1914C433C9;
        Thu, 18 Jun 2020 06:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1914C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v2 0/2] Unsolicited broadcast probe resp support
Date:   Wed, 17 Jun 2020 23:21:48 -0700
Message-Id: <20200618062150.21130-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unsolicited broadcast probe response tranmission is used for in-band
discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
fast passive scanning).

v2: Removed flag 'enabled' and changed 6GHz frequency range as per
    IEEE P802.11ax/D6.1.

Aloka Dixit (2):
  nl80211: Unsolicited bcast probe resp support
  mac80211: 20TU unsolicited bcast probe resp support

 include/net/cfg80211.h       | 18 +++++++++++++
 include/net/mac80211.h       | 21 +++++++++++++++
 include/uapi/linux/nl80211.h | 32 ++++++++++++++++++++++
 net/mac80211/cfg.c           | 42 +++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  7 +++++
 net/mac80211/tx.c            | 26 ++++++++++++++++++
 net/wireless/nl80211.c       | 51 ++++++++++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+)

-- 
2.25.0

