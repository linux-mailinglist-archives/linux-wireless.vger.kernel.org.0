Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F012845B0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgJFFyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 01:54:05 -0400
Received: from z5.mailgun.us ([104.130.96.5]:27789 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgJFFyF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 01:54:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601963644; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mLf2F13BPGbz96PEyXgm5umMmyPInNmceDvtWNRsKj8=; b=Y/wCer8L0RfE+nYbRZzYmkDs0/Pn3JTSsq7OC1gU9OXnmt2N7ZDd5nBJwK1f6SHKAV6nzivb
 RN8UyKbpGRBdw0E8TxEKbIC2oCsi5rR2fooH0NqQBOb2Yxl8+OU1xKGbwmz6kYFc4yBEN5H+
 ErRckT7xJryC5BTkQXH2Tiz8ao4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f7c06454f8cc67c316912dd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Oct 2020 05:53:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F080BC433C8; Tue,  6 Oct 2020 05:53:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0851C433CA;
        Tue,  6 Oct 2020 05:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0851C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     tehuang@realtek.com, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de
Subject: Re: [PATCH 3/5] rtw88: add dump firmware fifo support
References: <20200925061219.23754-1-tehuang@realtek.com>
        <20200925061219.23754-4-tehuang@realtek.com>
        <20201001190641.GA3723966@ubuntu-m3-large-x86>
        <87d021cae2.fsf@codeaurora.org>
        <20201002084326.GA2013042@ubuntu-m3-large-x86>
Date:   Tue, 06 Oct 2020 08:53:04 +0300
In-Reply-To: <20201002084326.GA2013042@ubuntu-m3-large-x86> (Nathan
        Chancellor's message of "Fri, 2 Oct 2020 01:43:26 -0700")
Message-ID: <87y2kjc33z.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nathan Chancellor <natechancellor@gmail.com> writes:

> On Fri, Oct 02, 2020 at 11:14:29AM +0300, Kalle Valo wrote:
>> + arnd
>> 
>> Nathan Chancellor <natechancellor@gmail.com> writes:
>> 
>> >> +int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
>> >> +		     u32 *buffer)
>> >> +{
>> >> +	if (!rtwdev->chip->fw_fifo_addr) {
>> >
>> > This causes a clang warning, which points out it is probably not doing
>> > what you think it is:
>> >
>> > drivers/net/wireless/realtek/rtw88/fw.c:1485:21: warning: address of
>> > array 'rtwdev->chip->fw_fifo_addr' will always evaluate to 'true'
>> > [-Wpointer-bool-conversion]
>> >         if (!rtwdev->chip->fw_fifo_addr) {
>> >             ~~~~~~~~~~~~~~~^~~~~~~~~~~~
>> > 1 warning generated.
>> >
>> > Was fw_fifo_addr[0] intended or should the check just be deleted?
>> 
>> BTW what is the easiest way to install clang for build testing the
>> kernel? For GCC I use crosstool[1] which is awesome as it makes the
>> installation so simple, do we have something similar for clang?
>> 
>> Just supporting x86 would be fine, as my use case would be just to
>> reproduce build warnings.
>> 
>> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/
>> 
>> -- 
>> https://patchwork.kernel.org/project/linux-wireless/list/
>> 
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
> Unfortunately, we do not have anything for clang right now. It is on my
> TODO list but being a hobbyist, I have less time than I would like...
>
> If you do not mind building it from source, I maintain a Python script
> that tries to optimize building LLVM as much as possible by turning off
> things that the kernel does not care about so that the build is quick
> and it does not intrude or interfere with the host environment.
>
> Something like this should work to give you a stable clang toolchain
> that should work well for compiling the kernel:
>
> $ git clone https://github.com/ClangBuiltLinux/tc-build
> $ tc-build/build-llvm.py \
> --branch llvmorg-11.0.0-rc5 \
> --projects "clang;lld"
> $ tc-build/install/bin/clang --version | head -1
> ClangBuiltLinux clang version 11.0.0
> (https://github.com/llvm/llvm-project
> 60a25202a7dd1e00067fcfce512086ebf3788537)
>
> The script by default does a 2-stage build for optimization purposes; if
> you cannot spare many cycles, feel free to add
>
> --build-stage1-only --install-stage1-only
>
> to the build-llvm.py invocation. The toolchain is installed to "install"
> within the tc-build repo and it only requires a few external
> dependencies (outlined in the README) that it lets you know about before
> doing anything. Feel free to give it a shot and let me know if anything
> is broken.

Thanks, I'll try that when I have some free time.

> Otherwise, as long as your distribution has clang 10.0.1 or newer, it
> should be fine for compiling the kernel.

Good to know. My distro is old so I only have clang-8 available :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
