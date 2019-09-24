Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C57BC299
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfIXH2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:28:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfIXH2P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:28:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2302602A8; Tue, 24 Sep 2019 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569310093;
        bh=m4oh2sKaBrS+R7ssC+0OwiRzrOWe1INnGLzyH2Ljuss=;
        h=From:To:Cc:Subject:Date:From;
        b=pMIcusaQDPRtspI9UF+HwdKIDzAwp1vJPXrfPWkVfNm9TT2y71QHVfyyDcQmMVnjp
         hcmeEsgg8pylILxxb6t6X5MfFYl6YEwVEZzTHOrYFa2grUNE0Dx7Z/JA38exAHGFaQ
         5H1dFt++xNKgcQJ68d3xWon1X+lUtB97n+qFw+XY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B04060397;
        Tue, 24 Sep 2019 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569310092;
        bh=m4oh2sKaBrS+R7ssC+0OwiRzrOWe1INnGLzyH2Ljuss=;
        h=From:To:Cc:Subject:Date:From;
        b=LJQBi6BBiiSV91JtObxlbPBnx74ClJhQRAGZ8xBCsrvlWntXdhpRufEAxY6yTJTEO
         GtvTvDSFx5JY3tmq6nVw5sGthas6mvSH21kDUKUYCF5EjVzqnkQHzPyE6tp5XgzMEK
         jzzaQ82xfJQlFyIQ1x5yq8qJMiWs4V88/3mCOUV4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B04060397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4 0/2] add fw coredump for sdio when firmware assert
Date:   Tue, 24 Sep 2019 15:27:08 +0800
Message-Id: <1569310030-834-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

add fw coredump for sdio when firmware assert

v2: change code style

v3: split bus type to another patch, 
remove ATH10K_BUS_ANY, 
add bus type for each layout

v4: rebase to latest commit

Wen Gong (2):
  ath10k: add bus type for each layout of coredump
  ath10k: add fw coredump for sdio when firmware assert

 drivers/net/wireless/ath/ath10k/bmi.c       |   1 +
 drivers/net/wireless/ath/ath10k/core.c      |  10 +
 drivers/net/wireless/ath/ath10k/coredump.c  | 349 +++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/coredump.h  |   1 +
 drivers/net/wireless/ath/ath10k/sdio.c      | 338 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/targaddrs.h |  10 +
 6 files changed, 704 insertions(+), 5 deletions(-)

-- 
1.9.1

