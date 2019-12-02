Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADC010E8B3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBKYP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 05:24:15 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:33690
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfLBKYP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 05:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575282254;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=v4ppf7Uo9W6vQwiNV9E/g/TT6J6tme/wq8d9e2z5HII=;
        b=aORsLmvnoHlqxeKunYU941AgtTfkfNs0Kj66/iwMTnKS3Y/7q5kV5/K/FIriqhnh
        ++w5cjMpr0QTeLSOAOuFOrLjs9agJsn1HbmVDzjzxla/+i5gY7ycMYfhS754jPhv2zU
        RJ4biiPk2DRCHHIANj+TE+cgkG6IlisB4aBcU/Sk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575282254;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=v4ppf7Uo9W6vQwiNV9E/g/TT6J6tme/wq8d9e2z5HII=;
        b=f3QQxQfSMb0TTuCC5gbhaqssnR8W+OIprzte0UeadTWs9420swbg1OniPMmgPGb7
        5HFAlEdRBWGl9rw1y8w+pAFH8mPKdNPrbclp+2iX4qKEiScnr/ygdpllzjoCRxTSA8W
        fGTu5g1gNTks1t85UeYIUrjrkkNj05hc6tg5Qo/A=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9B87C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     wgong@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath: add support for special 0x0 regulatory domain
References: <0101016eb614d832-1f2459b1-1555-4ce7-8f90-5704d201bc10-000000@us-west-2.amazonses.com>
        <20191202100833.0C1B9C433CB@smtp.codeaurora.org>
        <82cf5270f491b1e40640eab23a3b9fb7@codeaurora.org>
Date:   Mon, 2 Dec 2019 10:24:14 +0000
In-Reply-To: <82cf5270f491b1e40640eab23a3b9fb7@codeaurora.org>
        (wgong@codeaurora.org's message of "Mon, 02 Dec 2019 18:14:51 +0800")
Message-ID: <0101016ec623a1ac-3de41a53-0a12-45fe-92e1-8cc3f2b92a2d-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.02-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wgong@codeaurora.org writes:

> On 2019-12-02 18:08, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> wrote:
>>
>>> Some sdio chips of rome QCA6174's regulatory domain code of EEPROM is
>>> empty, then ath_is_world_regd will return false for this case, and
>>> it will lead function __ath_reg_dyn_country not work, thus the
>>> regdomain
>>> will not update for NL80211_REGDOM_SET_BY_COUNTRY_IE type, it result
>>> ath10k set the same regdomain/reg_5ghz_ctl/reg_2ghz_ctl to firmware,
>>> then the tx power will not changed with different regdomain's AP. The
>>> regulatory domain code of EEPROM of some QCA6174 PCIE chip is 0x6c, it
>>> means world wide regdomain, for this chip, it does not have the issue.
>>>
>>> For empty reulatory domain code chip, set it to world regulatory
>>> domain
>>> in functio ath_regd_sanitize, then it will fix the issue.
>>>
>>> Tested with QCA6174 SDIO with firmware
>>> WLAN.RMH.4.4.1-00029.
>>>
>>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> Patch applied to ath-next branch of ath.git, thanks.
>>
>> 2dc016599cfa ath: add support for special 0x0 regulatory domain
> But I did not see it in ath-next now.
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/drivers/net/wireless/ath?h=ath-next
> is it has some delay?

Yes, it takes some time for me to apply other patches, merge branches,
servers sync etc. If you don't see the commit in the repository in 2
hours from me sending the "applied" mail, then do let me know as
something might be wrong. But before that just wait patiently :)

But now the commit is there:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=2dc016599cfa9672a147528ca26d70c3654a5423

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
