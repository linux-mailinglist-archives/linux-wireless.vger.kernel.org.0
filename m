Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85F51DF1BA
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgEVWTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 18:19:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45962 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731062AbgEVWTp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 18:19:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590185985; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=KnfkVdLSAZER72eWdYzElUxF7qo8hWRpEmFhznWtjUU=; b=ql//TxFawyZYQssAOmvnQun+Hui/i8jjyVIZTw1icp1XG8D10JDUViQ39QRx0uPPRE/69YJz
 DUGjoYwcPi1BM/SkzSBcVML7Td+zXbYoWU2dxJifZ0ofEp/BhruQ01GlW8VNmJaKw8Olyb/J
 fqtvZNksjGJLMGtvwnMkumk9hFA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec84fef4110e147180ca4a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 22:19:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF57FC433C8; Fri, 22 May 2020 22:19:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E5B2C433C6;
        Fri, 22 May 2020 22:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E5B2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 0/2] FILS discovery and bcast probe resp support
Date:   Fri, 22 May 2020 15:19:19 -0700
Message-Id: <20200522221921.19347-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for FILS discovery and broadcast
unsolicited probe response transmission in 6GHz for in-band
discovery.

Aloka Dixit (2):
  nl80211: FILS discovery/bcast probe resp support
  mac80211: FILS disc/bcast probe resp config

 include/net/cfg80211.h       | 26 ++++++++++++++++
 include/net/mac80211.h       | 17 +++++++++++
 include/uapi/linux/nl80211.h | 27 +++++++++++++++++
 net/mac80211/cfg.c           | 57 +++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  8 +++++
 net/mac80211/tx.c            | 30 +++++++++++++++++++
 net/wireless/nl80211.c       | 58 ++++++++++++++++++++++++++++++++++++
 7 files changed, 223 insertions(+)

-- 
2.25.0

