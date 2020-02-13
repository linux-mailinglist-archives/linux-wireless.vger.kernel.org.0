Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2111715C039
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 15:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgBMOVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 09:21:51 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:63792 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730157AbgBMOVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 09:21:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581603710; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3ChKMBjWuhy0UyOMKIb2CHcEO65hmfD5x5PGNNh0WGA=;
 b=H/9zcXgZosZMgE8ZgBAs+l7vVM9mMW/ZogFtsRT1omi4vFREhWYJvO4a20pHnKQLk1V9CgaM
 ZREeOVHkLlu0BtQVCBONtyOHWmDL68VBhpqRSxXbNxQWYhfU++UE82qKxgVNqovZpwAydr9n
 7O7sVpzRh7SrLfwB6tepErQQvDE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e455b7a.7efb901267d8-smtp-out-n02;
 Thu, 13 Feb 2020 14:21:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48CCCC4479F; Thu, 13 Feb 2020 14:21:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEE6EC43383;
        Thu, 13 Feb 2020 14:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEE6EC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix unsupported chip reset debugs file write
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1580887644-21061-1-git-send-email-yintang@codeaurora.org>
References: <1580887644-21061-1-git-send-email-yintang@codeaurora.org>
To:     Yingying Tang <yintang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200213142146.48CCCC4479F@smtp.codeaurora.org>
Date:   Thu, 13 Feb 2020 14:21:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yingying Tang <yintang@codeaurora.org> wrote:

> Before this change, after writing "warm_hw_reset" debugfs file, host
> will send chip reset command to FW even though FW do not support this
> service getting a warning print.
> 
> Though there is no FW impact before this change, this patch restricts
> chip reset command sent to FW only if FW advertises the support via WMI
> service bit.
> 
> Removed the redundant check and ath10k_warn() print as well.
> 
> New version FW will report chip reset service bit to host. Host allow user
> to trigger WLAN chip reset only when fw report this service bit.
> 
> For older NON-TLV FW, since it do not report chip reset service bit, host
> will not send chip reset command. For older TLV FW, since it report chip
> reset service bit, host will send chip reset command.
> 
> Tested HW:  QCA9984, WCN3990
> 
> QCA9984 FW version: WLAN.BL.3.9.0.2-00042-S-1
> 
> Signed-off-by: Yingying Tang <yintang@codeaurora.org>

Fails to apply:

error: patch failed: drivers/net/wireless/ath/ath10k/wmi.h:367
error: drivers/net/wireless/ath/ath10k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11365857/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
