Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3F11DE9E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMH0J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 02:26:09 -0500
Received: from m228-4.mailgun.net ([159.135.228.4]:56813 "EHLO
        m228-4.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLMH0J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 02:26:09 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 02:24:15 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576221969; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5RGQcIjU5nvc/zSvZDQ8uDmmZwR55bG4rFuY0Tw0BCw=; b=cMsezWEfQGJnwQEptfUcp0IhYvzE+0Yr/Aia69zDI2mSiMB/xkcx1H55qnrYYcinwXbCKaOe
 kdz+JC6YuixHYhsX5CjRhkWg42PoYj0Z+owO2Ni1aVLL8pBXkgzTexjJJCU9sYedScxgUNIr
 nsLNPLH5n+dRxR7fE+eB6Bdob7M=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df33d0e.7fce4a8cc0d8-smtp-out-n01;
 Fri, 13 Dec 2019 07:26:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 46F71C433CB; Fri, 13 Dec 2019 07:26:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-131-106-69.bb.dnainternet.fi [85.131.106.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EFF1C43383;
        Fri, 13 Dec 2019 07:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EFF1C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Bjoern Franke <bjo@schafweide.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Realtek 8822BE: r8822be vs. rtwpci (mainline / lwfinger)
References: <50038b2f-8b90-d803-0377-2c19cc7ad78e@schafweide.org>
        <0101016eea4be8c6-86cd4509-2811-4de8-92be-bd5cfa50d49c-000000@us-west-2.amazonses.com>
        <e28ce50db6344157832fc860a65a3ae9@realtek.com>
Date:   Fri, 13 Dec 2019 09:25:58 +0200
In-Reply-To: <e28ce50db6344157832fc860a65a3ae9@realtek.com> (Tony Chuang's
        message of "Fri, 13 Dec 2019 06:37:17 +0000")
Message-ID: <87h824zny1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> Subject: Re: Realtek 8822BE: r8822be vs. rtwpci (mainline / lwfinger)
>> 
>> Bjoern Franke <bjo@schafweide.org> writes:
>> 
>> > I'm a little confused about the status of the modules for the Realtek
>> > 8822BE.
>> >
>> > Once, there was r8822be which had some issues, but worked more or less
>> > reliable. Then came rtw88/rtwpci and in my Thinkpad A275 it is hardly
>> 
>> Tony, that rtwpci sounds like very confusing name for a rtw88 module,
>> even I was first confused what driver is that. I think it should be
>> rtw88_pci or something like that.
>> 
>
> True, I can rename it to rtw88_pci.

Great, thanks.

> I am also thinking if I should rename all of the prefixes from "rtw_"
> to "rtw88_", but that seems to be a huge patch. I will try to see if
> this is necessary to do it.

Yeah, that's not so important but good to have anyway. I think you
should start with symbols marked with EXPORT_SYMBOL().

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
