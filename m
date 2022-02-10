Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF554B105B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 15:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbiBJO1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 09:27:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbiBJO1E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 09:27:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F247398
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 06:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6C4B8242B
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 14:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AEAC004E1;
        Thu, 10 Feb 2022 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644503223;
        bh=qRqePo7JAnU5LCTvMFZT+gUbKlvkHvMrT5l1Zf/RQB0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Od6n6Vul9Ax5khFsSj4YbLDXs8vF9GvjX3LBUV+ThDrH1FVK8B6O/fjZZZxTXOyMp
         4EKnDuEc3rgrb/znRExYjlt9JlGUAwnOXBBdu+sYBZhjWMAgo38fJK7Gkx2gU6LWBS
         RXsGRdxFnGZ6MOijchDRHKPuZKqoazJJBMQKhAJSlOLk/722Wu16ApM96nIJsXRMxu
         LBBoNq93upWfztZFhYiO9ZFHbMb81Ma7WBszJKaBnZU4NTWe2pnU3RaZEvzD5RRog0
         TkZCt9xJ7Nq7fiB/XT5/9XW+nMLkk5uB4xgvMka2hG1w+BVTSyVwg8FkcwzMQHJGeP
         KHV8ekRh8oTFQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "Larry.Finger\@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Funny log entries for rtw88_8821ce
References: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
        <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
        <ef7361eb-17ce-5ecf-a46a-a9f0c5aab35b@lwfinger.net>
        <87czjxbukz.fsf@tynnyri.adurom.net>
        <6baf4ae2f36c89269f74f0905ce81f38adc3a284.camel@realtek.com>
Date:   Thu, 10 Feb 2022 16:26:57 +0200
In-Reply-To: <6baf4ae2f36c89269f74f0905ce81f38adc3a284.camel@realtek.com>
        (Pkshih's message of "Tue, 8 Feb 2022 12:02:33 +0000")
Message-ID: <87mtiy3iha.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Tuesday, February 8, 2022 5:02 PM
>> To: Larry Finger <Larry.Finger@lwfinger.net>
>> Cc: Pkshih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
>> Subject: Re: Funny log entries for rtw88_8821ce
>> 
>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>> 
>> > From these log entries, I see no reason why there should be a stop-vif
>> > 412 seconds after the interface is set from disabled to disconnected.
>> > This cycling does not cause any problems. Perhaps the statements that
>> > do the logging should be removed.
>> 
>> I did a quick check on how rtw88 uses rtw_info() and indeed that should
>> be cleaned up.
>> 
>> These should be warning or error messages:
>> 
>> rtw_info(rtwdev, "invalid H2C command format for debug\n");
>> rtw_info(rtwdev, "incorrect lna index (%d)\n", lna_idx);
>> rtw_info(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
>> rtw_info(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
>> rtw_info(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
>> rtw_info(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
>> 
>> Not sure if warn or debug, most likely debug:
>> 
>> rtw_info(rtwdev, "HW scan aborted with code: %d\n", rc);
>> 
>> These should be debug messages to avoid spamming the logs:
>> 
>> rtw_info(rtwdev, "start vif %pM on port %d\n", vif->addr, rtwvif->port);
>> rtw_info(rtwdev, "stop vif %pM on port %d\n", vif->addr, rtwvif->port);
>> rtw_info(rtwdev, "change vif %pM (%d)->(%d), p2p (%d)->(%d)\n",
>> rtw_info(rtwdev, "sta %pM joined with macid %d\n",
>> rtw_info(rtwdev, "sta %pM with macid %d left\n",
>> rtw_info(rtwdev, "On freq %u to %u, set SAR %d in 1/%lu dBm\n"
>> 
>> This is ok:
>> 
>> rtw_info(rtwdev, "Firmware version %u.%u.%u, H2C version %u\n",
>> 
>
> I will fix them as well as rtw89. To avoid mistakes, I do google search for
> KERN_INFO, and find [1]
> 	KERN_INFO: this is the log level used for informational messages
> 		   about the action performed by the kernel.

Not following you here.

> Then, I have a question about the message of setting SAR:
> 	rtw_info(rtwdev, "On freq %u to %u, set SAR %d in 1/%lu dBm\n"
>
> When a user sets SAR via iw, this message can reflect the action performed
> by driver. Is this rtw_info acceptable?

In general the preference for user space commands is not to print
anything to the log when debug messages are disabled, but of course
there can be exceptions if the reasons are good. Why do you want to
print this always? What benefit does it bring for the user?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
