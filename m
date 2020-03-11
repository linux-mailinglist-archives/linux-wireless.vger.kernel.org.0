Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2811C181E23
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgCKQmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:42:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38108 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgCKQmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:42:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583944971; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=M9SUko/zdnHe/2rCjUpsRL1UCEb+uRO4GxzuHntCfng=;
 b=AZSZ0LVPQTiye6mEoa64wgaP4Rc1SnxAWbM/6ZXAQ+zGUuZG7exRQz5bqDWaUEhu0fBuSYJT
 SFFQ4v10BC8KMgdM1fZWMqqk47wYjAmAAnKJwiQJijLgXAzaLICNdr71Sd6frhmQBUw8h6Bw
 6+OSza4SQjYM0iVOYAWlBAQJtdE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e691502.7f69fa240298-smtp-out-n03;
 Wed, 11 Mar 2020 16:42:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72B41C433CB; Wed, 11 Mar 2020 16:42:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2701CC433D2;
        Wed, 11 Mar 2020 16:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2701CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: fix unsupported chip reset debugs file write
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581670278-5682-1-git-send-email-yintang@codeaurora.org>
References: <1581670278-5682-1-git-send-email-yintang@codeaurora.org>
To:     Yingying Tang <yintang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311164242.72B41C433CB@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:42:42 +0000 (UTC)
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
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

bbdc8c5abbd4 ath10k: fix unsupported chip reset debugs file write

-- 
https://patchwork.kernel.org/patch/11381921/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
