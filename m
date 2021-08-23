Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E413F4E0D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHWQMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 12:12:40 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51188 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhHWQMj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 12:12:39 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Aug 2021 12:12:39 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id D0EB3205A4;
        Mon, 23 Aug 2021 18:02:33 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B5AD92021B;
        Mon, 23 Aug 2021 18:02:33 +0200 (CEST)
Subject: Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13 9310
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wren Turkal <wt@penguintechs.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
 <87y28sqq4l.fsf@codeaurora.org>
From:   Nicolas Schichan <nschichan@freebox.fr>
Message-ID: <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
Date:   Mon, 23 Aug 2021 18:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87y28sqq4l.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Aug 23 18:02:33 2021 +0200 (CEST)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23/08/2021 14:53, Kalle Valo wrote:
> (adding linux-wireless, regressions and some mhi folks)
> 
> Wren Turkal <wt@penguintechs.org> writes:
> 
>> I have no device for the wifi on my computer. 5.13 worked pretty well.
>> I also found others reporting similar issues:
>> https://forum.manjaro.org/t/kernel5-14-rc6-ath11k-on-qca6390-regression-mhi-probe-failure/79362
>>
>> Here's info about the hardware on my laptop:
>> ➜  ~ sudo dmidecode -s system-product-name
>> XPS 13 9310
>>
>> ➜  ~ sudo dmidecode -s bios-version
>> 3.0.4
> 
> Do you get the same mhi error as in the forum post?
> 
> qcom_mhi_qrtr: probe of mhi0_IPCR failed with error -22
> 
> MHI folks, any ideas? I have XPS 13 9310 myself but I'm not able to test
> v5.14-rc6 kernel right now.

Hello,

I have hit the same issue on Linux 5.14-rc7:

[   14.780566] qcom_mhi_qrtr: probe of mhi0_IPCR failed with error -22

This looks to be caused by commit:

ce78ffa3ef16 net: really fix the build...

Reverting this commit results in ath11k being able to load without errors.

Regards,

-- 
Nicolas Schichan

