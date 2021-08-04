Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581A73E074B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbhHDSMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 14:12:55 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:35387 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbhHDSMw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 14:12:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628100759; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=BWdiYkAiGSM6BDwi0I+lmrjBqe8ZGMPFNU7wGl8me9A=; b=ZsuokH3JRpWjrKkZbeVnvVFuZs+FlfgEVFiZ+q9MO6H3M5x5hKUEf4TtOqM26BuuHYi8PMgp
 QQPYwDl6gchom93reHqevy+aWUti8b7CW9RuBk2zSLh/By3ka6hLG4tnv97kTzsRWvSZ5VaL
 EkuO4Cr39xOG7bC6dlXQEARVOCI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 610ad88b8c78eaf808e9a980 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 18:12:27
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8B85C43217; Wed,  4 Aug 2021 18:12:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-77-199-nat.elisa-mobile.fi [85.76.77.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B954C433D3;
        Wed,  4 Aug 2021 18:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B954C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>
Subject: [PATCH 0/3] ath11k: enable support of 6G band for WCN6855
Date:   Wed,  4 Aug 2021 21:12:14 +0300
Message-Id: <20210804181217.88751-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

This depends on the following patches:

Pradeep Kumar Chitrapu:
ath11k: add channel 2 into 6 GHz channel list
ath11k: fix packet drops due to incorrect 6 GHz freq value in rx status

Wen Gong (3):
  ath11k: re-enable ht_cap/vht_cap for 5G band for WCN6855
  ath11k: enable 6G channels for WCN6855
  ath11k: copy cap info of 6G band under WMI_HOST_WLAN_5G_CAP for WCN6855

 drivers/net/wireless/ath/ath11k/mac.c |   29 +++++++++++++++++++----------
 drivers/net/wireless/ath/ath11k/wmi.c |   22 +++++++++++-----------
 2 files changed, 30 insertions(+), 21 deletions(-)

-- 
2.31.1

