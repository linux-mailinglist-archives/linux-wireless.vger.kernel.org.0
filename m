Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A212428C92
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhJKMIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 08:08:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42197 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236404AbhJKMIv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 08:08:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633954011; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JkRfWcC1JYbiM5D1ffj2oMLOxAm8acFf2CyyRSwrRGQ=; b=ts6z1i7AxkRnHC8zLoXYanTqV4YSAYNufJsqJ/0ZiiPXcb1OCJg40iDXpwJfwj9bOwoZPWKd
 rJbnvuGMt0oQjbE0IOUBTgz7VHx34XYjzqtiVwvDWNwjNv9w/jr5sECBeW3+uhnVJ53X3LsG
 hLxr3vm4xPp6ieGpgWJ0ffR/VFQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 616428d90605239689bcb8ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 12:06:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28699C4360C; Mon, 11 Oct 2021 12:06:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB048C4338F;
        Mon, 11 Oct 2021 12:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BB048C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v7 00/24] rtw89: add Realtek 802.11ax driver
References: <20211008035627.19463-1-pkshih@realtek.com>
        <87lf32622d.fsf@codeaurora.org>
Date:   Mon, 11 Oct 2021 15:06:43 +0300
In-Reply-To: <87lf32622d.fsf@codeaurora.org> (Kalle Valo's message of "Sat, 09
        Oct 2021 11:21:30 +0300")
Message-ID: <878ryz4vfw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Ping-Ke Shih <pkshih@realtek.com> writes:
>
>> This driver named rtw89, which is the next generation of rtw88, supports
>> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
>> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
>> though.
>>
>> The chip architecture is entirely different from the chips supported by
>> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
>> are totally redefined, so it's impossible to reuse register definition. To
>> communicate with firmware, new H2C/C2H format is proposed. In order to have
>> better utilization, TX DMA flow is changed to two stages DMA. To provide
>> rich RX status information, additional RX PPDU packets are added.
>>
>> Since there are so many differences mentioned above, we decide to propose
>> a new driver. It has many authors, they are listed in alphabetic order:
>>
>> Chin-Yen Lee <timlee@realtek.com>
>> Ping-Ke Shih <pkshih@realtek.com>
>> Po Hao Huang <phhuang@realtek.com>
>> Tzu-En Huang <tehuang@realtek.com>
>> Vincent Fann <vincent_fann@realtek.com>
>> Yan-Hsuan Chuang <tony0620emma@gmail.com>
>> Zong-Zhe Yang <kevin_yang@realtek.com>
>>
>> Tested-by: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>>
>> v7:
>>   - use consistent license of Kconfig
>>   - remove #ifdef and dummy functions from coex.c
>>   - C2H handler of coex uses meaningful naming insetad, and use le32_to_cpu()
>>     to convert the value.
>>   - add icmp packet notify to coex
>>   - use function call instead of a work to notify coex about traffic changed
>>   - fix dereference security CAM NULL pointer while disconnecting occasionally
>>   - fill tx descriptor once a 32 bits word (Suggested by Arnd. Thanks!)
>>   - use static pci PS, so remove pci link_ps 
>>   - make many mac tables constant
>>   - add early_h2c debugfs entry to notify firmware early
>>   - support new RA report format
>>   - configure retry_lowest_rate by band
>>   - avoid to use of whil(1) to parse power sequence
>>   - notify rfk before/after scanning to reset status
>>   - firmware: rtw89: 8852a: update fw to v0.13.30.0
>>     https://github.com/pkshih/linux-firmware.git 
>>     pick the commit 6595133a7cde82be932067afde834dcd036167f8
>
> I have not reviewed this version yet, but I pushed it to the pending
> branch for build testing:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=c321740f93af1a31d9e149ce5077e28bd4e859f7
>
> For the final commit my plan is to squash all patches into one big
> patch. I will do that after reviewing v7, if everything is ok of course.
>
> Are there more Tested-by or Reviewed-by tags?

I now created one big commit which I'm planning to take to
wireless-drivers-next:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=80b361279546ca7a57c7e7844c2e23f474f9852d

Please double check that I didn't break anything while squashing the
patches. I tried to be careful, but you never know.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
