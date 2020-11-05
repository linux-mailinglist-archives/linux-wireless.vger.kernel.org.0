Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D749D2A7CA1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 12:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgKELKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 06:10:47 -0500
Received: from z5.mailgun.us ([104.130.96.5]:47984 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgKELKr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 06:10:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604574647; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Fp6b/xyCJroMGvyCNefT0lZ82V3tfdSR9M6Pw5BPg3o=;
 b=d74u3m8M5WojQHgKos1RU0VfFQQoCtEFx5dEgDcpHqn76IFgMq1w6a6jJcXXOutTvpZGTqs9
 DkWPNxuXuz70kMBX9228cS8vjQ1dsoFgqo5CtTIF6bx0Uqi9zQo4l/uBNy7BZnH4h4woNYsD
 eMsY4fktq+RCkdv1xynHv5Do9/8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fa3ddaf89543359d3d5ce4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 11:10:39
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B90D1C433CB; Thu,  5 Nov 2020 11:10:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63789C433C6;
        Thu,  5 Nov 2020 11:10:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 19:10:37 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org, ath10k <ath10k@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <877dr0nqtv.fsf@codeaurora.org>
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
 <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
 <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
 <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
 <877dr0nqtv.fsf@codeaurora.org>
Message-ID: <728196c17b4e70e18c99798a9945d1e6@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-05 16:35, Kalle Valo wrote:
> Brian Norris <briannorris@chromium.org> writes:
> 
>> + ath10k
>> 
>> [ I realize I replied to the "wrong" RFC v1; I fell trap to Kalle's 
>> note:
>> 
>> "When you submit a new version mark it as "v2". Otherwise people don't
>> know what's the latest version." ]
>> 
>> On Tue, Nov 3, 2020 at 11:32 PM Carl Huang <cjhuang@codeaurora.org> 
>> wrote:
>>> On 2020-11-04 10:00, Brian Norris wrote:
>>> > What are the ABI guarantees around a given driver/chip's 'sar_capa'?
>>> > Do we guarantee that if the driver supports N ranges of certain bands,
>>> > that it will always continue to support those bands?
>> ...
>>> For a given chip(at least a QCOM chip), we don't see that the
>>> range will grow or change.
>> 
>> That's good to know. But that's not quite the same as an ABI 
>> guarantee.
> 
> I'm not sure if I understood Brian's question correctly, but I have
> concerns on the assumption that frequency ranges never change. For
> example, in ath10k we have a patch[1] under discussion which adds more
> channels and in ath11k we added 6 GHz band after initial ath11k support
> landed. And I would not be surprised if in some boards/platforms a
> certain band is disabled due to cotting costs (no antenna etc). My
> preference is to have a robust interface which would be designed to
> handle these kind of changes.
> 
> [1] [PATCH] ath10k: enable advertising support for channels 32, 68 and 
> 98

So the trick here is even if more channels are supported, it doesn't 
mean
that it can support different SAR setting on these new channels. In this 
case,
it likely falls into 5G range. It's safe for driver to extend the 5G 
range and
doesn't break userspace. (68 and 98 are already in the 5G range, so 
driver just
extends the start edge freq to 32 here.).

But for flexibility, given 6 GHz as example here, let's keep the 
explicit
index for SET command. For sar_capa advertisement, the explicit index is
dropped as Johannes suggested. New ranges can only be appended to 
existing
ones. Like Brian said, only add or split is allowed. The complexity to 
handle
splitted range Vs whole range is left to WLAN driver itself.

Userspace can SET any ranges which are advertised by WLAN driver. It's
not required to set all ranges and userspace can skip any ranges.
