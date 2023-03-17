Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBB6BE07E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 06:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCQFM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 01:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQFM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 01:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9BB06D5
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 22:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E5D62189
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 05:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DDFC433EF;
        Fri, 17 Mar 2023 05:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679029975;
        bh=LmCiF47VSTwDZ4RwGffaCKzU9QGlrNQZ718BiwbXuXE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=f2QCLC672kHbA6o+EGPDSQG9Cw2HKEY7i9bH20F4IIOjOFCUQ9WNbc+9Ft8ORMprN
         UshfGkYLYxoqQ0LDBPyzJRK7FXF7kuxlu+nDx88/NaBAqxCECdG/Zwo8mIrCgAAxNf
         xvLsgCOdtIRcsA74s543TH+udqO001+INPX+0nybrrTW/69ZdyDUvz8KlwS8VUYj8D
         puXSV7elayoRxG10Ig4+T158tyvt7BJQHRP2/UZDJRaDWNZTAdI5ynxhMvGEnupNrR
         Hp29fKndw4n6WCyytNr9us0gTR5RGPAfgeBjF1E7ZB/VXCT4EqRfrLJsYmJ9IswRv9
         l1B099CgyYpGw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     rb <rb0171610@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: New binary rtw8852b_fw.bin not loading firmware not recognized
References: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
        <386367223a2547669c60f7d1dcb42b40@realtek.com>
Date:   Fri, 17 Mar 2023 07:12:52 +0200
In-Reply-To: <386367223a2547669c60f7d1dcb42b40@realtek.com> (Ping-Ke Shih's
        message of "Fri, 17 Mar 2023 00:35:27 +0000")
Message-ID: <87a60cvu3v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: rb <rb0171610@gmail.com>
>> Sent: Friday, March 17, 2023 6:48 AM
>> To: linux-wireless@vger.kernel.org
>> Subject: New binary rtw8852b_fw.bin not loading firmware not recognized
>> 
>> Briefly,
>> 
>> I use rtw89_8852be in kernel driver
>> 
>> HARDWARE:
>> Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:b852]
>> 
>> Lenovo Ideapad 1i
>> 
>> ISSUE:
>> Newest version of binary firmware 2023_03_10,
>> rtw89/rtw8852b_fw.bin, will not load/firmware not recognized on Linux Kernel 6.2.5 (and others):
>> 
>> [] loading firmare: rwt89/rtw8852b_fw.bin
>> [] rtw89_8852be 0000:03:00.0: no suitable firmware found
>> [] rtw89_8852be 0000:03:00.0: failed to recognize firmware
>> 
>> Issue persists regardless of which 6.2 series kernel is used.
>> 
>> All previous rwt89/rtw8852b_fw.bin firmware from linux-firmware 2023_02_10 and earlier loads and works
>> correctly.
>> 
>> I did file a bug report with the details:
>> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=217207
>> 
>
> The firmware format is changed, and wireless-next tree or upcoming 6.3 will
> support it. I will also post this information on the bug.

We cannot break user space like that, linux-firmware needs to be
backwards compatible. In other words, anything you submit to
linux-firmware needs to work with old kernels. Should this new firmware
be reverted from linux-firmware?

What about changes in the rtw89 driver? Do they still work with old
firmware?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
