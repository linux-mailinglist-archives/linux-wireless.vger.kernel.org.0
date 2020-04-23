Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2671B550E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDWHB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 03:01:27 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40180 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgDWHB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 03:01:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587625285; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jnGBvqgD2+rCZ5dqwcs/N0/DjWzyVn5656ZJjEr5E6M=; b=OAzIGJKgfr85qP3QxlRii25LA6STpSJc6aC+5Xf4J6IcwF359FXzoVjDlcTLcHoY57CbkuM6
 0+UDTVrTQsBG/g+0dY+vK9NRvjmtRO+KCFhtkjisxJ3qPaRT6d5FizasnmJvMQYoF95SgmWi
 hT5IuJ/x1eJeAztbPJbzw0ceVuI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea13d35.7f87b6312490-smtp-out-n02;
 Thu, 23 Apr 2020 07:01:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0E57C433F2; Thu, 23 Apr 2020 07:01:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 917ACC433D2;
        Thu, 23 Apr 2020 07:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 917ACC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list\:REALTEK WIRELESS DRIVER \(rtw88\)" 
        <linux-wireless@vger.kernel.org>,
        "open list\:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rtw88: Use udelay instead of usleep in atomic context
References: <20200423063811.2636-1-kai.heng.feng@canonical.com>
        <20200423063811.2636-2-kai.heng.feng@canonical.com>
        <87h7xan1cy.fsf@kamboji.qca.qualcomm.com>
        <D2ACB475-AE1A-41D1-BEB9-1FC30DA13AE8@canonical.com>
Date:   Thu, 23 Apr 2020 10:01:03 +0300
In-Reply-To: <D2ACB475-AE1A-41D1-BEB9-1FC30DA13AE8@canonical.com> (Kai-Heng
        Feng's message of "Thu, 23 Apr 2020 14:53:18 +0800")
Message-ID: <87d07yn0sw.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

>> On Apr 23, 2020, at 14:49, Kalle Valo <kvalo@codeaurora.org> wrote:
>> 
>> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>> 
>>> It's incorrect to use usleep in atomic context.
>>> 
>>> Switch to a macro which uses udelay instead of usleep to prevent the issue.
>>> 
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> 
>> This fixes a regression, right? So there should be a Fixes line.
>
> Yes, but the regression commit isn't in Linus' tree, so the sha1 may change.

No, the commit id won't change after I have commited the patch. I don't
rebase my trees.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
