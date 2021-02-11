Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C58318588
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 08:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhBKHId (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 02:08:33 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:40543 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhBKHId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 02:08:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613027287; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bTWpo1acmuHQQrJMGxIYPKewbdbOilh/v6Xg0ZUSLcw=; b=emScDqWJcx5RB0650U5VKSGOAOhHY0VFX34XBXPgDLOiQ9Tl5pLPWzhnam545+zv62Pts8kr
 ifFcLIVkhaymFhRRecokm2ujdfR1+ihWTfTjZVHfNcjN78mVVNZArn9DzRlwJq5MBW8/wEdZ
 qBey0bBpnNzcqXcZ0Dqf9e5H8dE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6024d7bd3919dfb4552a8469 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 07:07:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35D7AC433ED; Thu, 11 Feb 2021 07:07:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7EA6C433CA;
        Thu, 11 Feb 2021 07:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7EA6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/6] ath11k: support one MSI vector
References: <20201223030225.2345-1-cjhuang@codeaurora.org>
Date:   Thu, 11 Feb 2021 09:07:35 +0200
In-Reply-To: <20201223030225.2345-1-cjhuang@codeaurora.org> (Carl Huang's
        message of "Tue, 22 Dec 2020 22:02:19 -0500")
Message-ID: <87czx7t748.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> This patch set is to support one MSI vector for QCA6390.
>
> Carl Huang (6):
>   ath11k: get msi_data again after request_irq is called
>   ath11k: add ce and ext irq flag to indicate irq_handler
>   ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for dp irqx
>   ath11k: refactor mulitple msi vector implementation
>   ath11k: supports one MSI vector
>   ath11k: do not restore ASPM in case of single MSI vector

I did some cleanup and before submitting v2 I noticed the patchset (both
v1 and v2) is crashing during suspend on my Dell XPS 13 9310. We are
investigating the reason for that and will submit v2 once those are
fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
