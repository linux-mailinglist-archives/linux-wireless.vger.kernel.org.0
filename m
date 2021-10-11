Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D642342899C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhJKJ0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 05:26:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54720 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhJKJ0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 05:26:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633944256; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=QydTH4waEaVfOlxGLPlSurpSmfn0ZSIvUJE3zRI+o74=; b=s5DYRsGnphhLv6rqb891dLXQxRT2nMpWhZ8LXazaXXMM6lImiTGjPOswtpbffqrudIYLO4Oz
 /kS9OO1Bw/JhRlc7LBxlYXaRU5ahUzFJGE6+sw0tS+6T3s1RPXqHQow39mbwxArz114bzfyH
 fmIjI57Qx9JTT7oEekd5XM4Nk6s=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 616402b1a45ca75307bf4c7a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 09:24:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D832C43618; Mon, 11 Oct 2021 09:24:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 282FAC4338F;
        Mon, 11 Oct 2021 09:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 282FAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        linux-wireless@vger.kernel.org, steventing@realtek.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: wireless: guidelines for user space interfaces
References: <20210422030413.9738-1-pkshih@realtek.com>
        <20210422030413.9738-2-pkshih@realtek.com>
        <YMPqT8VH5alHQXXA@google.com>
Date:   Mon, 11 Oct 2021 12:23:54 +0300
In-Reply-To: <YMPqT8VH5alHQXXA@google.com> (Brian Norris's message of "Fri, 11
        Jun 2021 15:57:19 -0700")
Message-ID: <87mtnf52z9.fsf_-_@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(changing subject, was "Re: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate")

Brian Norris <briannorris@chromium.org> writes:

> BTW, if we have clear guidelines on debugfs, module parameters, etc.,
> maybe those should be going on the wiki? I know this came up before:
>
> https://lore.kernel.org/linux-wireless/87d09u7tyr.fsf@codeaurora.org/
>
> At this point, I'm willing to write such guidelines, if I get an ack
> from the relevant folks (I guess that's just Kalle?). It probably
> belongs somewhere in this tree:
>
> https://wireless.wiki.kernel.org/en/developers/documentation
>
> similar to this:
> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
> except it's not really an nl80211 thing. Suggestions welcome.

I think this is a very good idea. Having general guidelines for wireless
drivers using user space interfaces would help both people submitting
patches and also people like me reviewing the patches.

We should try to get an ack for the guidelines at least from Johannes,
but I would prefer also involve Jakub and Dave (CCed) as they might have
some input from the network subsystem point of view.

Just to get this started, here's a draft list I came up of different
user space interfaces upstream wireless drivers are using:

* generic nl80211 (excluding testmode and vendor commands)

* nl80211 testmode commands

* nl80211 vendor commands

* sysfs[1]

* debugfs

* relayfs

* configfs[1]

* module parameters

* thermal subsystem

* firmware_request()

I'm not saying that we need to document all these in the first version,
I'm just trying to come up a comprehensive overview how wireless drivers
interact with the user space. And I'm sure I missed something. so please
do fill in.

> Side note: it could really use some cleanup -- like this page:
> https://wireless.wiki.kernel.org/en/developers/process

Heh, that is old information. TBH in practise I maintain only the
submittingpatches page (link in the signature), other pages I rarely
touch. And naturally I also look after ath10k and ath11k pages.

Any volunteers to clean that up?

[1] Actually I don't know if there are any valid use cases for sysfs and
    configfs at the moment, but I'll include them in the list for
    completeness.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
