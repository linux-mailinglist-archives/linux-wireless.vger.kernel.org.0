Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1992126342E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgIIRPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:15:32 -0400
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:56776
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729622AbgIIP2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599664195;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=RaWxuP5tsohwC9FoMMo1zAEbuii/YxqCi15tX+fp874=;
        b=PETWmYsIOyjWh2lwNu8y6liombLGNqB2Lc++gWvd0s5jXjYIfHwGTyhq/1XLOyNZ
        Du4EoEDby/S5r8bU7BtAXlpQYC0KL/rF1IvvYs1uXE98b2R5OKpUC/41y8dwsSIA7QH
        f/Cbts3Zm+Z6SVcH0uyEG/YxD/r64TlL7mjMNVCk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599664195;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=RaWxuP5tsohwC9FoMMo1zAEbuii/YxqCi15tX+fp874=;
        b=IyHkTGKZgVOA/AFeMIcraWj13yUYAtL3410w38Qw5ytgRL/B8Lqiz+ROVUBnYdgG
        vrd+f0mrAQC1m6DoUWcOaHpvYQ3+3URwIShyOvDgiAUt/j1x0VMzEswjB5S+Ur7xStu
        wCrueKFJPnyevNAN+pf6yFCyzn8uvz70ONONvfX0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9370BC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:pending 90/109] drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning: variable 'scb_ampdu' set but not used
References: <202009011913.HKFaLG2U%lkp@intel.com>
        <87ft8166sj.fsf@codeaurora.org> <20200909140859.GC218742@dell>
Date:   Wed, 9 Sep 2020 15:09:55 +0000
In-Reply-To: <20200909140859.GC218742@dell> (Lee Jones's message of "Wed, 9
        Sep 2020 15:08:59 +0100")
Message-ID: <01010174736a87e9-f907d9d2-791b-4c28-a8bd-a4f7e9a6cdc8-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.09-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 01 Sep 2020, Kalle Valo wrote:
>
>> kernel test robot <lkp@intel.com> writes:
>> 
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
>> > head:   391ddee90739538e99cb73bd26d7a90452d37f30
>> > commit: d7f95d9204ca1a73183fde8c5a017f2060763d05 [90/109] brcmsmac: ampdu: Remove a bunch of unused variables
>> > config: i386-randconfig-r015-20200901 (attached as .config)
>> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>> > reproduce (this is a W=1 build):
>> >         git checkout d7f95d9204ca1a73183fde8c5a017f2060763d05
>> >         # save the attached .config to linux build tree
>> >         make W=1 ARCH=i386 
>> >
>> > If you fix the issue, kindly add following tag as appropriate
>> > Reported-by: kernel test robot <lkp@intel.com>
>> >
>> > All warnings (new ones prefixed by >>):
>> >
>> >    In file included from drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h:21,
>> >                     from drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:18:
>> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h:786:1: warning: alignment 1 of 'struct d11txh' is less than 2 [-Wpacked-not-aligned]
>> >      786 | } __packed;
>> >          | ^
>> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In
>> > function 'brcms_c_ampdu_dotxstatus_complete':
>> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:850:7:
>> > warning: variable 'update_rate' set but not used
>> > [-Wunused-but-set-variable]
>> >      850 |  bool update_rate = true, retry = true;
>> >          |       ^~~~~~~~~~~
>> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In function 'brcms_c_ampdu_dotxstatus':
>> >>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning: variable 'scb_ampdu' set but not used [-Wunused-but-set-variable]
>> >     1027 |  struct scb_ampdu *scb_ampdu;
>> >          |                    ^~~~~~~~~
>> 
>> Lee, please send a followup patch to fix these issues.
>
> This is already fixed in your tree.

Great, thanks for checking.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
