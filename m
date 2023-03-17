Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D26BE49B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 09:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjCQI66 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 04:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCQI6U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 04:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8669206
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 01:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2806562228
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 08:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72E2C433D2;
        Fri, 17 Mar 2023 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679043438;
        bh=FXpMemzxQYVw2tXx7gDJTmaRAz6quq3n2fOh/OkLfA4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=e4Y38S3XQjoKZbC/7BkvIkEXHn9G8jUCvuWlWCFug4sMHWKWer+lJ5DRDX5Hgq7+s
         uwFcSLSs1r/xHnc06wcvX+VEj34ahAGgCrmeFhYfuNsN/rYX/+65MEnVYnMjVF12rd
         UimIaVp5/LcqYCx9BhSIEkjE8TJlE2cSvYtIcTXEmFEPU08My7kN1YxkBtz6dhN6Fd
         0Fu5HrbgO0XoZCFo+bcp+DUiR8Ea7ESCTTd11BrjVmgZbDWxIyM8Xi9RoIFHJ7q8TM
         Ws90HT9yyNLKNT5SHnqTZt0T0ezESiKCFEgbMllfx1RTSmGRCOrxbCnHnPtiWvcmWW
         jdWiZObjyQQvQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rb0171610\@gmail.com" <rb0171610@gmail.com>
Subject: Re: New binary rtw8852b_fw.bin not loading firmware not recognized
References: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
        <386367223a2547669c60f7d1dcb42b40@realtek.com>
        <87a60cvu3v.fsf@kernel.org>
        <e99f1dc26c83b24cb2bb7d6f8f92669b375d7512.camel@realtek.com>
Date:   Fri, 17 Mar 2023 10:57:14 +0200
In-Reply-To: <e99f1dc26c83b24cb2bb7d6f8f92669b375d7512.camel@realtek.com>
        (Ping-Ke Shih's message of "Fri, 17 Mar 2023 07:29:13 +0000")
Message-ID: <87edpnn4b9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> > > I did file a bug report with the details:
>> > > 
>> > > https://bugzilla.kernel.org/show_bug.cgi?id=217207
>> > > 
>> > 
>> > The firmware format is changed, and wireless-next tree or upcoming 6.3 will
>> > support it. I will also post this information on the bug.
>> 
>> We cannot break user space like that, linux-firmware needs to be
>> backwards compatible. In other words, anything you submit to
>> linux-firmware needs to work with old kernels. Should this new firmware
>> be reverted from linux-firmware?
>
> I think I should support two or more firmware with different name, like
> rwt89/rtw8852b_fw-2.bin, if format is changed. So, there will be two
> firmware existing in linux-firmware.
>
> Then, for old driver, it only supports rwt89/rtw8852b_fw.bin. For new driver,
> it will load rwt89/rtw8852b_fw-2.bin first, but if '-2' version doesn't present,
> it will try to load original version.
>
> I think it would work, but I want to confirm if this is acceptable rules
> for Linux.

Yes, this is the recommended way to handle backwards compatibility.
ath10k (and soon ath11k) will do something similar, we have
firmware-2.bin, firmware-3.bin and so on to avoid breaking older kernels
whenever there are incompatible changes in firmware.

Recently some guidelines were also written about this:

https://www.kernel.org/doc/html/latest/driver-api/firmware/firmware-usage-guidelines.html

>> What about changes in the rtw89 driver? Do they still work with old
>> firmware?
>
> New driver can work with old or new firmware. The only case that doesn't
> work is old driver + new firmware.

Very good, thanks for confirming.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
