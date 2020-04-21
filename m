Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630A41B26A5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDUMsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:48:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26519 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgDUMsJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:48:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587473289; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=k5QdzNJxww6MBMhijJcDgUGBLQ0TyxwDmilnMeGchIE=; b=nI+9PTUDykFIPD0Q3hogigc6Rznm3bEYT84ZSZsfT2emL4lBNGuGXs/wdDhS0xw1Qvet4eQj
 BJcfHpMWXsZer4EvJpEQ13OZ8MlSicYeDTwd9aMdVkN7KVdcs3XRqQjU1MSEGdo73EajJ6V4
 Ihum1zmJjobywdyHH/weLYUey0g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9eeb82.7fbac3363ea0-smtp-out-n05;
 Tue, 21 Apr 2020 12:48:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42429C433BA; Tue, 21 Apr 2020 12:48:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F459C433F2;
        Tue, 21 Apr 2020 12:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F459C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     linux-wireless@vger.kernel.org,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH] qtnfmac: enable access to the card in calibration mode
References: <20200416210025.1096-1-sergey.matyukevich.os@quantenna.com>
Date:   Tue, 21 Apr 2020 15:47:55 +0300
In-Reply-To: <20200416210025.1096-1-sergey.matyukevich.os@quantenna.com>
        (Sergey Matyukevich's message of "Fri, 17 Apr 2020 00:00:25 +0300")
Message-ID: <87sggxj98k.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> writes:

> Enable access to the wireless card in calibration mode using service
> ethernet port. Wireless functionality is not available in calibration
> mode. Service ethernet port can be used for various maintenance tasks
> including calibration, configuration, troubleshooting. Add new kernel
> module parameter force_svcmode. Set this parameter to one in order
> to boot wireless card into the calibration mode.
>
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
>
> ---
>
> Hello Kalle and all,
>
> I would like to add support for a simple service mode for calibration.
> This patch includes some controversial bits, that is why it is marked
> as RFC. Could you please take a closer look and tell me whether it is
> acceptable for mainlining.

Is there a reason why you can't use nl80211 testmode? The use cases you
list were exactly the reasons why we added testmode to nl80211 in the
first place.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
