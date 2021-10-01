Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9141F26F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhJAQtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:49:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:33721 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355292AbhJAQtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:49:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633106837; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O0iMA2NxRLNSsdwiaNY+od0iDnY2qVXvuDQlsaO1spo=; b=slr7Xy0i6XlmATY9DPgvHFFvGRVoQLhNddX228B9MFeHImickbShQntrdA6mkMwHcq6Drs88
 0/3/e0tGvrsUiMXaZf+zxP1RSDMCTaDU3jnF6JnRmXaTCqoYbDI6lsPh0gRdNIBsla41qdve
 QpNuLtUPoeirQJQa4IGqSTjzrHs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61573b8b9ffb413149febb65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 16:47:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66F14C4360D; Fri,  1 Oct 2021 16:47:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0072AC43460;
        Fri,  1 Oct 2021 16:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0072AC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
References: <20210820043538.12424-1-pkshih@realtek.com>
        <8735pkiu0t.fsf@codeaurora.org>
        <7df9058b-4983-6d0e-07f7-8fe4df1cff27@lwfinger.net>
Date:   Fri, 01 Oct 2021 19:46:59 +0300
In-Reply-To: <7df9058b-4983-6d0e-07f7-8fe4df1cff27@lwfinger.net> (Larry
        Finger's message of "Fri, 1 Oct 2021 11:42:27 -0500")
Message-ID: <87y27chev0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 10/1/21 11:34, Kalle Valo wrote:
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>>
>>> This driver named rtw89, which is the next generation of rtw88, supports
>>> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
>>> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
>>> though.
>>>
>>> The chip architecture is entirely different from the chips supported by
>>> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
>>> are totally redefined, so it's impossible to reuse register definition. To
>>> communicate with firmware, new H2C/C2H format is proposed. In order to have
>>> better utilization, TX DMA flow is changed to two stages DMA. To provide
>>> rich RX status information, additional RX PPDU packets are added.
>>>
>>> Since there are so many differences mentioned above, we decide to propose
>>> a new driver. It has many authors, they are listed in alphabetic order:
>>
>> I did a review now and this looks pretty good to me. Kconfig has a
>> different license and lots of static/extern variables which are not
>> const, otherwise I only saw smaller issues. But I do have to admit that
>> after mac.h (in alphabetical order) my review was more on the sloppy
>> side, this is a large driver.
>>
>> The community has been testing this driver already, right?
>
> Kalle,
>
> As soon as Ping-Ke submitted this driver, I created a stand-alone
> version at GitHub so that people with new laptops containing this chip
> would have a source for the driver. There have been minor hiccups that
> we have fixed along the way. I am also testing it on my system.

Nice, so I can assume there are quite a few users for this driver
already?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
