Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992453002CB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 13:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAVMWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 07:22:08 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:38340 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbhAVMVi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 07:21:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611318079; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Df5BKd8ZWR6aY7YbTqjLmKuv/IaZdEPrn9pcsc27/jw=; b=rz3kk7NLjKa8ZhNuYvRBCNXElRCoNCwbRCC9WC62e4629PnX+it4y0xC8MHsHCWnspX6y4Kr
 b1cynFkZag/V+Rryb540y+xpIgF6uohFrkc8i9iy0FrM6wyjZpb2QHHPAuZ1bPLy12G749vI
 rRwhqPvZqIvDns9S2OWWn5EIu5g=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 600ac3205677aca7bdf71300 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Jan 2021 12:20:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70496C433C6; Fri, 22 Jan 2021 12:20:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA8B7C433ED;
        Fri, 22 Jan 2021 12:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA8B7C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
References: <20210122101124.GE4867@zn.tnic> <20210122105034.GF4867@zn.tnic>
Date:   Fri, 22 Jan 2021 14:20:43 +0200
In-Reply-To: <20210122105034.GF4867@zn.tnic> (Borislav Petkov's message of
        "Fri, 22 Jan 2021 11:50:34 +0100")
Message-ID: <87v9bpb1t0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Fri, Jan 22, 2021 at 11:11:24AM +0100, Borislav Petkov wrote:
>> Hi,
>> 
>> this triggers is on 5.11-rc3 + tip/x86/urgent (shouldn't matter tho),
>> 32-bit kernel:
>
> This looks like a multiple wireless drivers issue, this is on another
> 32-bit machine with ath5k this time:
>
> [   23.810222] ath5k 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
> [   23.847597] ath5k 0000:03:00.0: registered as 'phy0'
> [   24.504999] ath: EEPROM regdomain: 0x65
> [   24.516125] ath: EEPROM indicates we should expect a direct regpair map
> [   24.527286] ath: Country alpha2 being used: 00
> [   24.535435] ath: Regpair used: 0x65
>
> [   24.551461] =============================
> [   24.561941] WARNING: suspicious RCU usage
> [   24.572030] 5.11.0-rc3+ #1 Not tainted
> [   24.580276] -----------------------------
> [   24.590764] net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
> [   24.601730] 

Can you try this commit:

51d62f2f2c50 cfg80211: Save the regulatory domain with a lock

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=51d62f2f2c50

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
