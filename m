Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36D72C2C43
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 17:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390110AbgKXQFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 11:05:17 -0500
Received: from z5.mailgun.us ([104.130.96.5]:54991 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgKXQFR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 11:05:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606233916; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=uGMxKC7z5aO9TLWhv6X4g9jfyA2jYvaFro08phjZLNA=;
 b=sEw+ZGanjLxfEpY/Tna1yrB5oZH2iIJZ7rwVex71n59fUBjnfXGxypL+6iydA2XT/4E3w4FI
 rm+D9eqeD1+NV4BJNZ4cqgBe4g81HpybGKxEEVaL+craW0ofKCTMNbdyPiboQ5B9T+0dKdQg
 VCFWBs/HxQybsT3xj9rKWSMcodk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fbd2f35c6fdb18c639c17bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 16:05:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6492C43465; Tue, 24 Nov 2020 16:05:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10CA6C43460;
        Tue, 24 Nov 2020 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10CA6C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] ath11k: vdev delete synchronization with firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1605514143-17652-2-git-send-email-mkenna@codeaurora.org>
References: <1605514143-17652-2-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124160508.D6492C43465@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 16:05:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> When the interface is added immediately after removing the
> interface, vdev deletion in firmware might not have been
> completed.
> 
> Hence, add vdev_delete_resp_event and wait_event_timeout
> to synchronize with firmware.
> 
> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

3cbbdfbed140 ath11k: vdev delete synchronization with firmware
690ace20ff79 ath11k: peer delete synchronization with firmware
fae0385b2967 ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1605514143-17652-2-git-send-email-mkenna@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

