Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99931313343
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 14:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBHN3F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 08:29:05 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:40259 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhBHN1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 08:27:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612790840; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=z6ZwIHh7y5vGMSqjwAK3kPvYaKc8utOqrZSnbrQ1G3M=; b=gWa/8DBYBRGQt6qO7fj25enJ1MzyIpo4TLgtxKC6REb4/F0Se7b9lVzqvrR6cU9wX1urEDzA
 AqfNxQSJB1iVfTcC462GQKtdhWbuTXKlmM2yvk9AEjgkOVIKoFuN3pYCN7B1m0ITqJzjcxid
 JDL2DOIrMZZ/TWm5fKg6/0LZTyI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60213c1c81f6c45dcefaa98c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 13:26:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80136C43465; Mon,  8 Feb 2021 13:26:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61358C433ED;
        Mon,  8 Feb 2021 13:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61358C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: dma: do not report truncated frames to mac80211
References: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
        <87mtwfkr6u.fsf@tynnyri.adurom.net> <20210208082516.GB2593@lore-desk>
        <87im735593.fsf@codeaurora.org> <20210208112035.GD2593@lore-desk>
Date:   Mon, 08 Feb 2021 15:26:47 +0200
In-Reply-To: <20210208112035.GD2593@lore-desk> (Lorenzo Bianconi's message of
        "Mon, 8 Feb 2021 12:20:35 +0100")
Message-ID: <87a6se667c.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> >> 
>> >> > If the fragment is discarded in mt76_add_fragment() since shared_info
>> >> > frag array is full, discard truncated frames and do not forward them to
>> >> > mac80211.
>> >> >
>> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> >> 
>> >> Should there be a Fixes line? I can add it.
>> >
>> > I am not sure it needs a Fixes tag.
>> 
>> I think the commit log should have some kind of description about the
>> background of the issue, for example if this is a recent regression or
>> has been there forever etc.
>
> Agree. Can you please check the commit log below?
>
> "
> Commit 'b102f0c522cf6 ("mt76: fix array overflow on receiving too many
> fragments for a packet")' fixes a possible OOB access but it introduces a
> memory leak since the pending frame is not released to page_frag_cache if
> the frag array of skb_shared_info is full.
> Commit '93a1d4791c10 ("mt76: dma: fix a possible memory leak in
> mt76_add_fragment()")' fixes the issue but does not free the truncated skb that
> is forwarded to mac80211 layer. Fix the leftover issue discarding even truncated
> skbs.
> "

Looks good, but I think the recommended style for commit ids is not to
use ' chararacter. So I would change it to this:

----------------------------------------------------------------------
Commit b102f0c522cf6 ("mt76: fix array overflow on receiving too many
fragments for a packet") fixes a possible OOB access but it introduces a
memory leak since the pending frame is not released to page_frag_cache
if the frag array of skb_shared_info is full. Commit 93a1d4791c10
("mt76: dma: fix a possible memory leak in mt76_add_fragment()") fixes
the issue but does not free the truncated skb that is forwarded to
mac80211 layer. Fix the leftover issue discarding even truncated skbs.
----------------------------------------------------------------------

Should I add that to the commit log and queue the patch to be applied
after the merge window opens?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
