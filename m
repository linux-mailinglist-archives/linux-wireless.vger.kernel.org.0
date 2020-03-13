Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A918459B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMLI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 07:08:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49039 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgCMLI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 07:08:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584097738; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cI5PlALYk4PZRTl5dIq/S7BKjORzBnYpEmJPyaelpYQ=; b=k9Nd6rhVR1ndPzBR276Tb1mgbB5xXYgb6pEBuusBacwLlx5oFUZu2cGEuNo36ylRmmnYtHLE
 tdGdfM79x8YagHjHEQALaNQ4TnXGwgq3OvTrS8Gcz4dv8+M7DImpuod8RT8Huj9ErEwmcu50
 p9wbTrmSX7Wwth3zNa/0UatBM3o=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b69c7.7f580f9b0420-smtp-out-n02;
 Fri, 13 Mar 2020 11:08:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8064BC432C2; Fri, 13 Mar 2020 11:08:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89FEDC433CB;
        Fri, 13 Mar 2020 11:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89FEDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Ashish <ashishkumar.yadav@students.iiserpune.ac.in>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: Fix regression due to commit d1d1a96bdb44
References: <20200219200041.22279-1-Larry.Finger@lwfinger.net>
        <20200312133159.12782C44791@smtp.codeaurora.org>
Date:   Fri, 13 Mar 2020 13:08:45 +0200
In-Reply-To: <20200312133159.12782C44791@smtp.codeaurora.org> (Kalle Valo's
        message of "Thu, 12 Mar 2020 13:31:59 +0000 (UTC)")
Message-ID: <87y2s4se9u.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
>> For some unexplained reason, commit d1d1a96bdb44 ("rtlwifi: rtl8188ee:
>> Remove local configuration variable") broke at least one system. As
>> the only net effect of the change was to remove 2 bytes from the start
>> of struct phy_status_rpt, this patch adds 2 bytes of padding at the
>> beginning of the struct.
>> 
>> Fixes: d1d1a96bdb44 ("rtlwifi: rtl8188ee: Remove local configuration variable")
>> Cc: Stable <stable@vger.kernel.org>  # V5.4+
>> Reported-by: Ashish <ashishkumar.yadav@students.iiserpune.ac.in>
>> Tested-by: Ashish <ashishkumar.yadav@students.iiserpune.ac.in>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>
> Patch applied to wireless-drivers.git, thanks.
>
> c80b18cbb04b rtlwifi: rtl8188ee: Fix regression due to commit d1d1a96bdb44

While writing the pull request for Dave I noticed that the commit log
does not describe the symptoms in any way. I found the report (connect
issues) but in the future please describe the bug from user's point of
view in the commit log, not just the solution.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
