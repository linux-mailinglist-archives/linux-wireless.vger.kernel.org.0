Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAE35795F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 03:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhDHBM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 21:12:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21469 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDHBM7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 21:12:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617844369; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=/ryLYc5AIShsRk8hMrIqltLYag4JM6pSKotZcptS1wI=; b=xLxR5QLPcVBVXLLWHV1agiKeBEU1ow41jvMysAgAtyheNW0qzaEd88WsZaV6lDydlrDxgWZ4
 qvjmk1+V8YJyYh9O8RRlE+jyE7GquUFLKBRrgpBwJBHumV4RzSm1Sh1Sh7Eq4dRqlUxTybpa
 mndkKHvw725+h6H11HDbvL2gKTI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 606e58808166b7eff7f75131 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 01:12:32
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D783C433ED; Thu,  8 Apr 2021 01:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46578C433C6;
        Thu,  8 Apr 2021 01:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46578C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V6 0/2] WMI and debugfs calls for TWT dialogs
Date:   Wed,  7 Apr 2021 18:12:23 -0700
Message-Id: <20210408011225.1989-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for TWT dialogs using debugfs.
Patch files show changes in V6 compared to V5.

John Crispin (2):
  ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
  ath11k: add debugfs for TWT debug calls

 drivers/net/wireless/ath/ath11k/core.h    |   4 +
 drivers/net/wireless/ath/ath11k/debugfs.c | 222 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |  14 +-
 drivers/net/wireless/ath/ath11k/mac.c     |   6 +
 drivers/net/wireless/ath/ath11k/wmi.c     | 247 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h     | 114 ++++++++++
 6 files changed, 602 insertions(+), 5 deletions(-)


base-commit: 1924a31a1d7c49a87dad0c6df7a3bff3d68cc462
-- 
2.25.0

