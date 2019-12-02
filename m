Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0C10E86C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 11:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfLBKOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 05:14:55 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:36270
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbfLBKOy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 05:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575281693;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=7jfhDHYrFmOsa+E/bKLTMYNOGK/iizPKQh4d9/trfkw=;
        b=I+VtD9c8/yhepRWKpJGbfldALQGUzaPOJt1d84nQ3vl8MDD+hFpOkOpQ+VS0Y7jD
        BvKoqMt8PGjuV9iYlGTdBIXcUCBKzVv7vd5/y1uO9v+5L6gFnTU0f6rJZZeQJFB0p/F
        TVMiSBuT22Loer2Uae44hk8VL9xHa3V6djAORx+U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575281693;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=7jfhDHYrFmOsa+E/bKLTMYNOGK/iizPKQh4d9/trfkw=;
        b=gfo1tzhCNS3ennAL7euFkBVZBXWb62z9wmDCOPwNwj8YMgWF9O8pvA90NScLiQdL
        PNsyQWGr5adU6r8+cVc3VxndlPWbeqxpHKn5RIG+XSd8Tlo326OqerKm/vNgof29yId
        DuOsBNkkR7tRlASq7XqXxpBaq8+EqCyd344wI8+I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 2 Dec 2019 10:14:53 +0000
From:   wgong@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath: add support for special 0x0 regulatory domain
In-Reply-To: <20191202100833.0C1B9C433CB@smtp.codeaurora.org>
References: <0101016eb614d832-1f2459b1-1555-4ce7-8f90-5704d201bc10-000000@us-west-2.amazonses.com>
 <20191202100833.0C1B9C433CB@smtp.codeaurora.org>
Message-ID: <0101016ec61b1404-3332a101-8b2a-4d7f-a0fe-ed043075ee81-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.12.02-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-02 18:08, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> wrote:
> 
>> Some sdio chips of rome QCA6174's regulatory domain code of EEPROM is
>> empty, then ath_is_world_regd will return false for this case, and
>> it will lead function __ath_reg_dyn_country not work, thus the 
>> regdomain
>> will not update for NL80211_REGDOM_SET_BY_COUNTRY_IE type, it result
>> ath10k set the same regdomain/reg_5ghz_ctl/reg_2ghz_ctl to firmware,
>> then the tx power will not changed with different regdomain's AP. The
>> regulatory domain code of EEPROM of some QCA6174 PCIE chip is 0x6c, it
>> means world wide regdomain, for this chip, it does not have the issue.
>> 
>> For empty reulatory domain code chip, set it to world regulatory 
>> domain
>> in functio ath_regd_sanitize, then it will fix the issue.
>> 
>> Tested with QCA6174 SDIO with firmware
>> WLAN.RMH.4.4.1-00029.
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> Patch applied to ath-next branch of ath.git, thanks.
> 
> 2dc016599cfa ath: add support for special 0x0 regulatory domain
But I did not see it in ath-next now.
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/drivers/net/wireless/ath?h=ath-next
is it has some delay?
