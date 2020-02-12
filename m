Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8101315A2EA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 09:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgBLIJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 03:09:21 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:59919 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728250AbgBLIJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 03:09:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581494960; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Dko3IMtvmDqNwXyp+RJBrIiwa098FR4wnLSFnSuXW/Q=;
 b=Yl2Wi84FOiln3H8UXD2gAP4KD2y3BvAxTKqhrkTYlBR0XibuqUqj+wfWpTXRCamstqT56n+I
 nexNMMViGvE8UjeagfQ4LEgbjTUAklagX9v5ggWPZBOdU4iI5WAcXpnrVqUvI6bBKj3XDRrq
 8pfz5YlfVUKfjGLbivEpmhLGSq4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e43b2b0.7fa9d5d96b90-smtp-out-n01;
 Wed, 12 Feb 2020 08:09:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28EDEC433A2; Wed, 12 Feb 2020 08:09:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA590C43383;
        Wed, 12 Feb 2020 08:09:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Feb 2020 16:09:19 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v8 1/4] ath10k: disable TX complete indication of htt for
 sdio
In-Reply-To: <CANdKZ0dTwO7XQQjJ+NKO5jO4qBRJxZPNQu=-UEQOiRPc+dpd=A@mail.gmail.com>
References: <20191128103030.6429-1-wgong@codeaurora.org>
 <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
 <76bce8e3-e05b-ace6-3edd-54f522be3fe6@chromium.org>
 <25fd4f59b39c56b2fee208713c7cbc57@codeaurora.org>
 <CANdKZ0eWJtSuOdZp6Djne21maoBtmSsEm9Rmq9HbLfriY1goWw@mail.gmail.com>
 <47925cde59e1b94766720d20ddbb4191@codeaurora.org>
 <CANdKZ0dtnvL66jps41UC+dkybuXA0NMEu=9p2N2T08YDLHb2UQ@mail.gmail.com>
 <222dd9c33e2afa94cd1ee80c03c7b00d@codeaurora.org>
 <CANdKZ0fOEZ-Ng1p4FUy6WDC2DKGUMmTQE+JhcTwrf9TjACborA@mail.gmail.com>
 <e2afd62c108d66fdb3aa590f5ded61a4@codeaurora.org>
 <CANdKZ0dTwO7XQQjJ+NKO5jO4qBRJxZPNQu=-UEQOiRPc+dpd=A@mail.gmail.com>
Message-ID: <1d529a7a40379f3244bb655e241e09e2@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-12 15:45, Pi-Hsun Shih wrote:
> On Wed, Feb 12, 2020 at 3:31 PM Wen Gong <wgong@codeaurora.org> wrote:
>> 
>> On 2020-02-12 15:08, Pi-Hsun Shih wrote:
>> > Tested that the patch fix the kernel panic, thanks.
>> >
>> > For the fixed version:
>> > Tested-by: Pi-Hsun Shih <pihsun@chromium.org>
>> >
>> Thanks Pi-Hsun's quick test,
>> could you also give me the message log:
>> dmesg | grep ath
> 
> [   11.462398] ath10k_sdio mmc1:0001:1: qca6174 hw3.2 sdio target
> 0x05030000 chip_id 0x00000000 sub 0000:0000
> [   11.472131] ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1
> tracing 1 dfs 0 testmode 1
> [   11.481490] ath10k_sdio mmc1:0001:1: firmware ver
> WLAN.RMH.4.4.1-00042 api 6 features wowlan,ignore-otp crc32 ac2d4918
> [   11.667020] ath10k_sdio mmc1:0001:1: board_file api 2 bmi_id 0:4
> crc32 e74847dc
> [   12.035056] ath10k_sdio mmc1:0001:1: msg_type: 0
> [   12.036919] ath10k_sdio mmc1:0001:1: htt-ver 3.73 wmi-op 4 htt-op 3
> cal otp max-sta 32 raw 0 hwcrypto 1
> [   12.039878] ath10k_sdio mmc1:0001:1: msg_type: 2
> [   12.053816] ath10k_sdio mmc1:0001:1: msg_type: 5
> [   12.235403] ath: EEPROM regdomain: 0x6c
> [   12.239895] ath: EEPROM indicates we should expect a direct regpair 
> map
> [   12.247223] ath: Country alpha2 being used: 00
> [   12.251973] ath: Regpair used: 0x6c
Thanks.
new patch sent:
https://patchwork.kernel.org/patch/11377827/
