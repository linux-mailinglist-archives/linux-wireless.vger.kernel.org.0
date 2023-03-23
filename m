Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219036C64C7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCWKZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCWKZa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 06:25:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097D272D
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 03:25:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pfI8H-0005jx-B8; Thu, 23 Mar 2023 11:25:21 +0100
Message-ID: <7cc69aa5-e003-6ac7-9b2f-a95b67eb98e8@leemhuis.info>
Date:   Thu, 23 Mar 2023 11:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: pull request: rtw89: 8852b: rollback firmware to v0.27.32.1 and
 introduce new file to new format
Content-Language: en-US, de-DE
To:     Josh Boyer <jwboyer@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "rb0171610@gmail.com" <rb0171610@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "tiwai@suse.de" <tiwai@suse.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <889f3db6ca4008047595f4392388acc1f165e03c.camel@realtek.com>
 <CA+5PVA4H9Quu1954ubbcZfH-e1cOy2K27r0GfLemQcMBG-6AQA@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CA+5PVA4H9Quu1954ubbcZfH-e1cOy2K27r0GfLemQcMBG-6AQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679567126;7982c706;
X-HE-SMSGID: 1pfI8H-0005jx-B8
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20.03.23 12:43, Josh Boyer wrote:
> On Sat, Mar 18, 2023 at 9:59 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>
>> In discussion threads [1] [2], the new format of 8852b break user space.
>> To avoid this, introduce new filename rtw89/rtw8852b_fw-1.bin that old
>> drivers will not try to load it.
>>
>> Rollback firmware version of rtw89/rtw8852b_fw.bin to the latest
>> version of original format (i.e. v0.27.32.1) supported by old driver.
>>
>> The patches to support new filename in new driver are almost done,
>> and I will submit them soon. Thanks for the advice in mail and
>> bug threads.
>> [...]
> Pulled and pushed out.

Thx to both of you for submitting the revert and applying it.

Josh, do you plan to do another release soon? I fear that otherwise more
distros and users will run into this regression.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
