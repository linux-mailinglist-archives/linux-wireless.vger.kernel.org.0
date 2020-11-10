Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32E62ADE4B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgKJS3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 13:29:15 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:60841 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJS3P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 13:29:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605032954; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zGua+zGbCqLHdNexk0O9KwPPi/7wEvLDolhrw49C61M=;
 b=UyRx2kEjIEuL7o7TnNC168Uri8S1A36/zDpmNDh2dmLnANNvwKC38krzrfzTCeLVWC/4ZAyL
 CynNN6+6hnMdqmC5jN7X6lQvGHmrrekyQzB40f3VLF6ISUPn5674j8I+sVRx6SnQ4nv6pZHr
 /1vlVa2v0KoLsBjqd0DW7/9dKF8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5faadbc924ba9b3b0216f939 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 18:28:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 00F97C433CB; Tue, 10 Nov 2020 18:28:25 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E2C7C433C8;
        Tue, 10 Nov 2020 18:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E2C7C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: vdev delete synchronization with firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1590067829-26109-2-git-send-email-mkenna@codeaurora.org>
References: <1590067829-26109-2-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201110182825.00F97C433CB@smtp.codeaurora.org>
Date:   Tue, 10 Nov 2020 18:28:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> From: Ritesh Singh <ritesi@codeaurora.org>
> 
> When the interface is added immediately after removing the
> interface, vdev deletion in firmware might not have been
> completed.
> 
> Hence, add vdev_delete_resp_event and wait_event_timeout
> to synchronize with firmware.
> 
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>

Does not apply anymore, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/wmi.c:97
error: drivers/net/wireless/ath/ath11k/wmi.c: patch does not apply
stg import: Diff does not apply cleanly

3 patches set to Changes Requested.

11562969 [1/3] ath11k: vdev delete synchronization with firmware
11562967 [2/3] ath11k: peer delete synchronization with firmware
11562971 [3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1590067829-26109-2-git-send-email-mkenna@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

