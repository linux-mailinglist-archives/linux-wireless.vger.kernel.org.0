Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21751844F7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMKdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:33:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34581 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgCMKdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:33:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584095618; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=X7JgTLVJSb3w2MgQ8TIVswg89owBNyVmDZy/Ps2jmYY=; b=IgLtidEMlSO22faOw3N5bjYhliHbVbHPhYnN1PWgMvi9EvgFRosHlfss8+lLAY3scqsK5V9w
 HB8fKWCMsg8WfpzNeeiQK1SZFQPnmVn0cNnezlF6/lzAjZU8WBZBtg+Dm28cFk9BqGybXHLv
 d6vjsp63lXjMZkbbGYM9VfGu3TI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b616d.7fb83714f2d0-smtp-out-n01;
 Fri, 13 Mar 2020 10:33:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BCAD2C433BA; Fri, 13 Mar 2020 10:33:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0E65C433D2;
        Fri, 13 Mar 2020 10:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0E65C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
References: <20200313065114.23433-1-yhchuang@realtek.com>
Date:   Fri, 13 Mar 2020 12:33:13 +0200
In-Reply-To: <20200313065114.23433-1-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 13 Mar 2020 14:51:14 +0800")
Message-ID: <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> It is useful to fix the bit rate of TX packets. For example, if
> someone is measuring the TX power, or debugging with the issues
> of the TX throughput on the field.
>
> To set the value of fixed rate, one should input corresponding
> desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
> Set a value larger than DESC_RATE_MAX will disable fix rate, so
> the rate adaptive mechanism can resume to work.
>
> Example,
>   To fix rate at MCS 1:
>   echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>
>   To not to fix rate:
>   echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>
>   To know which rate was fixed at:
>   cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

No way, debugfs is not a method for working around nl80211 and doing
whatever idea you come up with. The goal is that we have a generic
nl80211 command for all generic actions, like this one. And I think we
already have an nl80211 command for fixing the tx rate, right?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
