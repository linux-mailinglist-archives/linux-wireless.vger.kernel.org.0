Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D852A7980
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 09:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgKEIgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 03:36:07 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:28883 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKEIgH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 03:36:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604565366; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hZ5mEVv0/kXvZfDCQAmTT/elJmLdNkZVpazrrI4COQc=; b=HvvS1oAkNCuFUHoE5QzPSy9FTsYQEYt240nPBHo81iQCoD7XsyYJ72hshz//qMnx6DYD3wyU
 KzFBILXj44ke4W8NS2JpcIn44LSlCjuJhPa8cFwEq/Zi63cCuCrsRnfGRGQ9jcbF9fYDIsKP
 30qGDI2YPiSopJFAM3TEAdSaVdE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa3b972550ef6ef19ba5666 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 08:36:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA772C433CB; Thu,  5 Nov 2020 08:36:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21C0AC433C6;
        Thu,  5 Nov 2020 08:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21C0AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org, ath10k <ath10k@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
        <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
        <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
        <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
Date:   Thu, 05 Nov 2020 10:35:56 +0200
In-Reply-To: <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
        (Brian Norris's message of "Wed, 4 Nov 2020 09:44:55 -0800")
Message-ID: <877dr0nqtv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> + ath10k
>
> [ I realize I replied to the "wrong" RFC v1; I fell trap to Kalle's note:
>
> "When you submit a new version mark it as "v2". Otherwise people don't
> know what's the latest version." ]
>
> On Tue, Nov 3, 2020 at 11:32 PM Carl Huang <cjhuang@codeaurora.org> wrote:
>> On 2020-11-04 10:00, Brian Norris wrote:
>> > What are the ABI guarantees around a given driver/chip's 'sar_capa'?
>> > Do we guarantee that if the driver supports N ranges of certain bands,
>> > that it will always continue to support those bands?
> ...
>> For a given chip(at least a QCOM chip), we don't see that the
>> range will grow or change.
>
> That's good to know. But that's not quite the same as an ABI guarantee.

I'm not sure if I understood Brian's question correctly, but I have
concerns on the assumption that frequency ranges never change. For
example, in ath10k we have a patch[1] under discussion which adds more
channels and in ath11k we added 6 GHz band after initial ath11k support
landed. And I would not be surprised if in some boards/platforms a
certain band is disabled due to cotting costs (no antenna etc). My
preference is to have a robust interface which would be designed to
handle these kind of changes.

[1] [PATCH] ath10k: enable advertising support for channels 32, 68 and 98

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
