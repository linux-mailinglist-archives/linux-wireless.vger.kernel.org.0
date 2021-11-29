Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BAA4610E2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 10:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbhK2JQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 04:16:54 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:41526 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhK2JOx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 04:14:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638177095; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sIBFtaSZmxN6xQAD9/P2PxVpaUwKUtOvTcTuVF3BhZA=; b=pJJRP6OAqiYEAggTan0NnL/7TOzGC+cGEJWcikuTw0WVgfqp7PQLjoFKyomur3ls7T4VCOeG
 OlW8SWkFiyWNKrDTjI6o7mjNb8dQYXVFGXgr1wa+fBLZ5/GW0yDTyDEwi4B+wtNUCI4w9vWN
 ZI0htR6Phe/TOi/dD8Ziv3AVHao=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61a499473553c354be7e679c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 09:11:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A825EC4360C; Mon, 29 Nov 2021 09:11:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25F30C4360C;
        Mon, 29 Nov 2021 09:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 25F30C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH 1/2] rtw89: update scan_mac_addr during scanning period
References: <20211111023706.14154-2-pkshih@realtek.com>
        <163794315660.10370.15822860839880748383.kvalo@codeaurora.org>
        <2021378f787172b58115f6b12973e5a20af6fce0.camel@realtek.com>
Date:   Mon, 29 Nov 2021 11:11:28 +0200
In-Reply-To: <2021378f787172b58115f6b12973e5a20af6fce0.camel@realtek.com>
        (Pkshih's message of "Sat, 27 Nov 2021 00:58:02 +0000")
Message-ID: <8735nffhrz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> On Fri, 2021-11-26 at 16:12 +0000, Kalle Valo wrote:
>> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> 
>> > Update scan_mac_addr to address CAM as A1, so hardware can ACK probe
>> > response properly.
>> > 
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> Failed to apply to wireless-drivers-next, please respin.
>> 
>> error: sha1 information is lacking or useless
>> (drivers/net/wireless/realtek/rtw89/txrx.h).
>> error: could not build fake ancestor
>> hint: Use 'git am --show-current-patch' to see the failed patch
>> Applying: rtw89: fix incorrect channel info during scan
>> Patch failed at 0001 rtw89: fix incorrect channel info during scan
>> 
>> 2 patches set to Changes Requested.
>> 
>> 12613957 [1/2] rtw89: update scan_mac_addr during scanning period
>> 12613959 [2/2] rtw89: fix incorrect channel info during scan
>> 
>
> This patchset is based on the the 2 patches of another patchset
> whose status is Awaiting Upstream:
>
> 12628209 [v3,2/3] rtw89: add const in the cast of le32_get_bits()
> 12628211 [v3,3/3] rtw89: use inline function instead macro to set H2C and CAM
>
> If I do rebase on this patchset and get merged, the awaiting patchset
> could be conflict. Should I wait the awaiting patchset get merged?
>
> Please guide me the way to deal with this.

I think the easiest is that I also mark these patches as Awaiting
Upstream and apply the patches after the dependencies have been applied.

> Sorry for the inconvenience.

No problem, this is business as usual. But this is exactly why I keep
the bar high in patches going to wireless-drivers and only take
important fixes, the conflicts between w-d and w-d-next just cause too
much of a hassle.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
