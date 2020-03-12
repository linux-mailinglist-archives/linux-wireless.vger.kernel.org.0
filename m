Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489FF183149
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLNZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:25:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64842 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLNZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:25:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584019538; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Ey8hIESwrwRJPS6HNXUiiUhi0I4cCkZG41dW7i3wiPM=; b=oJ6ihVEAjisCN64fI0vqx0i/KWvdkOz2FQI1msU6E7fUhsatRupR97U8ZlMQL8Tfep9f5L7q
 +PR7ExWOKqMdGPTHGtqdiEjwCbQI/sZSMvR9Mymercj17zs+SWxJIWt5Qw8oIgSWMyU52JoK
 d1lDnTlIfrkIW+7fRxRZ0+b1jk4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3851.7f4ba82f41f0-smtp-out-n01;
 Thu, 12 Mar 2020 13:25:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4198C433D2; Thu, 12 Mar 2020 13:25:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EE98C433CB;
        Thu, 12 Mar 2020 13:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EE98C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/2] rtw88: add a debugfs entry to enable/disable coex mechanism
References: <20200309075852.11454-1-yhchuang@realtek.com>
        <20200309075852.11454-3-yhchuang@realtek.com>
Date:   Thu, 12 Mar 2020 15:25:34 +0200
In-Reply-To: <20200309075852.11454-3-yhchuang@realtek.com> (yhchuang's message
        of "Mon, 9 Mar 2020 15:58:52 +0800")
Message-ID: <877dzpu2lt.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Sometimes we need to stop the coex mechanism to debug, so that we
> can manually control the device through various outer commands.
> Hence, add a new debugfs coex_enable to allow us to enable/disable
> the coex mechanism when driver is running.
>
> To disable coex
> echo 0 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
>
> To enable coex
> echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
>
> To check coex dm is enabled or not
> cat /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable

I forgot, did we add a command to nl80211 for managing btcoex? At least
we have talking about that for years. Please check that first before
adding a debugfs interface for this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
