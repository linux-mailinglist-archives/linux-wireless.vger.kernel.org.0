Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6520F20B7C1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFZSBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 14:01:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30409 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgFZSBy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 14:01:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593194513; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3jBIQeSeWIXTNigOUBSApAntBRRgxn7gCDEW1Xz+o8A=; b=oGrjQhyB3DPr6UmnF8nIhqyJU4l27m5b9AlRyRxY5nmI32Yoyfv/oiynv6egaOw2djas6+Xn
 YpWYnEe2QWzhDXxWPI8+HH0gnqBL+KK/VN3OdbxtZNEeECK1sFAVgA7RzimyN9kbcDbJKx/l
 pwiwI5T+nXYnph+nfenVlzWqC18=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ef6380e4c9690533a604e26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:01:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 015E2C433CA; Fri, 26 Jun 2020 18:01:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09E3BC433C8;
        Fri, 26 Jun 2020 18:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09E3BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH 0/2] ath10k: Add chain-1 voltage regulator voting
Date:   Fri, 26 Jun 2020 23:31:40 +0530
Message-Id: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the support to vote for the chain-1
voltage regulator for WCN3990. This is
added as an optional property.

Rakesh Pillai (2):
  dt: bindings: Add new regulator as optional property for WCN3990
  ath10k: Add support for chain1 regulator supply voting

 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
 drivers/net/wireless/ath/ath10k/snoc.c                         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4

