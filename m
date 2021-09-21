Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A961413594
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhIUOt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 10:49:26 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11979 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233688AbhIUOtZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 10:49:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632235677; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0Z5rU5WAi7fjvHbvWeQgflIhRU+xnMZWswvMEHdDCDM=; b=gBn+6CyC9Rl6HLyVCBTyTOVmoJoahPKvL5UqJ5nXdlkbJVuU8Tv4KE6Ye9aqbU5Q1vF6RT0q
 5CGzHEWi7DA23KSNWFj7dl9yA7krwCf9SZkin8ghmF2PA1Zr45DVksaLdob111Fv2vK1fXhs
 8OS22GBa+KYe9t3w7gbfyFAofk4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6149f09bbd6681d8edd05ad3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 14:47:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84D04C43616; Tue, 21 Sep 2021 14:47:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49491C4360D;
        Tue, 21 Sep 2021 14:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 49491C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "tony0620emma\@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>, Kevin Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 3/4] rtw88: support adaptivity for ETSI/JP DFS region
References: <20210802063140.25670-1-pkshih@realtek.com>
        <20210802063140.25670-4-pkshih@realtek.com>
        <87ilzo4gyr.fsf@codeaurora.org>
        <61a242c186bf453d80820d81e1c48464@realtek.com>
Date:   Tue, 21 Sep 2021 17:47:48 +0300
In-Reply-To: <61a242c186bf453d80820d81e1c48464@realtek.com> (Pkshih's message
        of "Mon, 30 Aug 2021 06:46:57 +0000")
Message-ID: <87y27qt27f.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> > --- a/drivers/net/wireless/realtek/rtw88/main.c
>> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
>> > @@ -23,6 +23,7 @@ EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
>> >  bool rtw_bf_support = true;
>> >  unsigned int rtw_debug_mask;
>> >  EXPORT_SYMBOL(rtw_debug_mask);
>> > +bool rtw_edcca_enabled = true;
>> 
>> You are making rtw_edcca_enabled per driver, should it instead be per
>> device? If something is changed via debugfs the assumption is that the
>> value is per device.
>> 
>> For example, let's say you have two rtw88 devices attached on the same
>> system, device A and B. If a user changes edcca via debugfs on device A
>> it will also change the state in device B. Is that the desired
>> functionality? If yes, I think you should add a comment to
>> rtw_edcca_enabled explaining that.
>> 
>
> As mentioned in commit message, the debugfs is expected to be used when debugging
> in noisy environment. In that case, we think all rtw88 devices will probably
> be affected. Besides, we believe that turning EDCCA off is a temporary state under
> debugging.
>
> Based on the two points, it seems no need to maintain rtw_edcca_enabled by device,
> so a comment will be added to explain this.

Ok, fair enough.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
