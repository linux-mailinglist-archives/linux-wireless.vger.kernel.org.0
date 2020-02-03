Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5682E150892
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBCOke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 09:40:34 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:47136 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbgBCOke (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 09:40:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580740833; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sha3FlisbQv9dZwqSTMvOoYAc27o0Fi9GObgxH4RJbg=; b=VgW/RgNa6n9mcc2tDLUurlTHoXMlWaNdFWJPdbxY1FOU3NaySVI1xQXTaFBos8Z58XqqwrQu
 f2q2M6jl8E32qTOW9iTtAL4QeI+cZjpzbYwnSfPIqG99Bp/6HnymVAvjhY8kY428955zfl+o
 nwbf/o44hfIIpP83PBVIdb1f7Ks=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3830e0.7f95a5029d88-smtp-out-n03;
 Mon, 03 Feb 2020 14:40:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 745C9C433A2; Mon,  3 Feb 2020 14:40:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A471C433CB;
        Mon,  3 Feb 2020 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A471C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: REMINDER: wireless workshop at netdevconf 0x14, registration now open
References: <70df55a1da3e8a99c6d2fc3a479c9c0eed3b71a0.camel@sipsolutions.net>
Date:   Mon, 03 Feb 2020 16:40:27 +0200
In-Reply-To: <70df55a1da3e8a99c6d2fc3a479c9c0eed3b71a0.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 23 Jan 2020 22:40:00 +0100")
Message-ID: <87wo9391k4.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Just a reminder. We will be having a wireless workshop at netdevconf
> 0x14 in Vancouver, BC. As far as I know, it's scheduled for day 1, i.e.
> March 17th.
>
> https://netdevconf.info/0x14/
>
> Since some people have asked: In order to attend the wireless workshop
> you only need to be registered for the conference, there are no other
> restrictions.
>
> If you have anything you'd like to present or any topics to suggest, let
> Kalle or myself know!

There's now a wiki page up:

https://wireless.wiki.kernel.org/en/developers/summits/vancouver-2020

If you are planning to come please add yourself to the attendee list on
the page, it helps us estimating how many people there might be. And
there's also a list of proposed topics.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
