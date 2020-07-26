Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCB22DCE9
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jul 2020 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgGZHXP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jul 2020 03:23:15 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32243 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbgGZHXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jul 2020 03:23:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595748194; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=P9/WVVMgNuEVZ2lL6lp5i3zGw0G7WWHSy768IkuWabM=; b=a7d0QhOqBEdr4x9Mx2/IUBQnQ/9doz+ad3kw3mbqsqYE9WcP9IvkjG4s+lmO9vM/Aba2ZDlx
 5ngdb/xaHcwDqREp880HQVDTQ6+oQpBWcAcTgLIsytdHsDiaBU5YAmZmbbSnGlwifvDs7ZfV
 nwdJB/0j7vjYzbhRlrbBLNDIL2Q=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f1d2f4fa19b5f4b115ed6f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 26 Jul 2020 07:22:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 083F1C433CA; Sun, 26 Jul 2020 07:22:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1F26C433C9;
        Sun, 26 Jul 2020 07:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1F26C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: Direct firmware load for iwl-debug-yoyo.bin failed with error -2
References: <CA+icZUWoycCvAAs5H0sigHTB+GGhX5NRVonYqKg7BRLB97dGkA@mail.gmail.com>
Date:   Sun, 26 Jul 2020 10:22:50 +0300
In-Reply-To: <CA+icZUWoycCvAAs5H0sigHTB+GGhX5NRVonYqKg7BRLB97dGkA@mail.gmail.com>
        (Sedat Dilek's message of "Sat, 25 Jul 2020 14:11:32 +0200")
Message-ID: <87mu3magfp.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sedat Dilek <sedat.dilek@gmail.com> writes:

> Hi,
>
> I am seeing this failed/error message for a long time:
>
> [Sat Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> for iwl-debug-yoyo.bin failed with error -2
>
> So, I started to look for the file "iwl-debug-yoyo.bin" in [1], but failed.
> AFAICS this is a file for debugging purposes?
>
> Why do I see such a message as an end-user w/o iwlwifi-debugging enabled?
> For some end-users I can imagine this looks scary and they will look
> into their cupboards and below their beds but will not find any
> monsters.
>
> I found a rename from an ini file to bin here:
> commit 8d9e982bf9bf ("iwlwifi: dbg_ini: rename external debug
> configuration file")
>
> Is "iwl-debug-yoyo.bin" a binary or as before an ini (text) file I
> have to configure somehow.
>
> Does this need to be guarded by some "ifdef CONFIG_IWLWIFI_DEBUG" in
> "drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c"?
>
> Or does drivers/net/wireless/intel/iwlwifi/Makefile needs some tuning
> - as said I have no iwlwifi debugging enabled via Kconfig?
> ...
> iwlwifi-objs            += iwl-dbg-tlv.o
>
> Please enlighten me/us?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/
> [2] https://git.kernel.org/linus/e8d9e982bf9bf0e6f99099f1f09a37563b2b95b5
>
>>From my dmesg-output:
>
> [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: can't disable ASPM; OS
> doesn't have ASPM control
> [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: loaded firmware
> version 18.168.6.1 6000g2b-6.ucode op_mode iwldvm
> [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> for iwl-debug-yoyo.bin failed with error -2

There's an RFC patch about this:

https://patchwork.kernel.org/patch/11625759/

I think that should be applied. Intel folks, should I take that directly
to wireless-drivers-next?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
