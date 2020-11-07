Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903E72AA676
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKGPxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:53:19 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11061 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKGPxT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:53:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604764398; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Uczvi8r4TjIs2oR+61D41ZMMlKVxC34Gs6Sf4hnL6k4=;
 b=vo1CXEgwSizL3NBdKI+pL3pCxcJXkRw/khCHmNsG+/rOSmW9YhtIF+L+6L2V1bZr2D1UVhn3
 BEbdSS/6hZ4n0vdV4YXdZwQfLbsriM8DrUZOXa+YEVmKL41injPkvoyqTut40G7iXBT88Qu/
 SrfqVmannBOt5APutGHpQRsA10o=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fa6c2dbc6df09e2f2a2b971 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:52:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA5B2C433CB; Sat,  7 Nov 2020 15:52:58 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A54AC433C8;
        Sat,  7 Nov 2020 15:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A54AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] orinoco: Remove BUG_ON(in_interrupt/irq())
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201101211536.2966644-2-bigeasy@linutronix.de>
References: <20201101211536.2966644-2-bigeasy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107155258.DA5B2C433CB@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 15:52:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The usage of in_irq()/in_interrupt() in drivers is phased out and the
> BUG_ON()'s based on those are not covering all contexts in which these
> functions cannot be called.
> 
> Aside of that BUG_ON() should only be used as last resort, which is clearly
> not the case here.
> 
> A broad variety of checks in the invoked functions (always enabled or debug
> option dependent) cover these conditions already, so the BUG_ON()'s do not
> really provide additional value.
> 
> Just remove them.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: linux-wireless@vger.kernel.org

8 patches applied to wireless-drivers-next.git, thanks.

ce4dd05cbba6 orinoco: Remove BUG_ON(in_interrupt/irq())
24bf941f2c96 airo: Invoke airo_read_wireless_stats() directly
49eb01995285 airo: Always use JOB_STATS and JOB_EVENT
494e46d08d35 airo: Replace in_atomic() usage.
7534fd5e5834 hostap: Remove in_atomic() check.
abcda807d868 zd1211rw: Remove in_atomic() usage.
317f688b0a54 rtlwifi: Remove in_interrupt() usage in is_any_client_connect_to_ap().
50c61ae15865 rtlwifi: Remove in_interrupt() usage in halbtc_send_bt_mp_operation()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201101211536.2966644-2-bigeasy@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

