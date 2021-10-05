Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D5421E73
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 07:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhJEFyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 01:54:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61019 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhJEFyc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 01:54:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633413162; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gMqvJgekcZySHHIa0xtcLlJMXLYA9XaQIaDPiYEJ6Xc=; b=OXX5cGLeMcZRxUUWbK/uwXaX3fGFCWF6gXW60FjrsJQEeFzPmFN8HsoDku79AvDuGN1+M6d9
 ih8alDOc5NF14nrt4UHgULZ0S5jM/mcQnH5N5HPPNHU7Nk/Wcp5heQN2ZAf3oVfLKWrwJ6gb
 3/cqdctxhOJTvqt3Z7YNkt+U9MQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 615be823a5a9bab6e86342f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 05:52:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE587C4360C; Tue,  5 Oct 2021 05:52:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBCB1C4338F;
        Tue,  5 Oct 2021 05:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CBCB1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
References: <20210820043538.12424-1-pkshih@realtek.com>
        <8735pkiu0t.fsf@codeaurora.org>
        <9b54e3c321a4414cbae62616d8a913f4@realtek.com>
Date:   Tue, 05 Oct 2021 08:52:29 +0300
In-Reply-To: <9b54e3c321a4414cbae62616d8a913f4@realtek.com> (Pkshih's message
        of "Mon, 4 Oct 2021 06:46:57 +0000")
Message-ID: <877desggrm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> The community has been testing this driver already, right?
>
> As Larry mentioned, end users use this driver. Since bugs found in v6,
> we have fixed them and driver is under QA. I plan to have that fixes in v7
> released this week.
>
> This version will also include fixes of your comments. 
> Does it work to you?

Sounds good to me. I hope the changes in v7 will be small in size,
bigger changes (especially new features) is better to do after the
driver is applied to wireless-drivers-next.

This reminds me, if anyone has any objections about taking this to
wireless-drivers-next speak up now. Otherwise I assume everyone are
happy with the driver.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
