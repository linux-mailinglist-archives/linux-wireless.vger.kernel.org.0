Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3235C57E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhDLLoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:44:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14405 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbhDLLoA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:44:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618227823; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Cj9QbcIEtjhj4xLhCkMZP7/Uck0rtvoqwAPn/5VfulQ=; b=Li+pPZ886CN5FUgNaLZf0iifSIe96kRLtFEwUlznWga9Z4JS9VzMD/zfagd+6sQWYBwdO2vF
 5XlCjXD835vTYZ79fnAzNDWZuJsmZzyBkPwiGQ8Hq1Z9KMs3tm5D9QyKm023sT5xd8A9aohx
 KIOuUSkZXSPkOa3s1uS4SOR+ULY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 607432678807bcde1d91af1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Apr 2021 11:43:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06529C433ED; Mon, 12 Apr 2021 11:43:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92FFAC433CA;
        Mon, 12 Apr 2021 11:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92FFAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: pull-request: iwlwifi-next 2021-04-12
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
Date:   Mon, 12 Apr 2021 14:43:31 +0300
In-Reply-To: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi> (Luca
        Coelho's message of "Mon, 12 Apr 2021 13:52:05 +0300")
Message-ID: <87v98rlod8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the first batch of patches intended for v5.13.  This includes
> the four last patchsets I sent out for v5.13 with the usual development
> work.  It also includes Emmanuel's series for adding the iwlmei driver,
> including one patch by Alexander Usyskin in the misc drivers directory.
> (which Greg asked us to push via our tree).

But no Acked-by from Greg? I would like to have that in the commit log.

>  include/net/cfg80211.h                                 |   11 +-
>  net/wireless/core.c                                    |    7 +-

Why are you changing cfg80211? Has this been checked with Johannes, at
least I don't see any acks from him? I prefer making cfg80211 changes
via Johannes' tree, smaller risk of conflicts that way.

Also every commit seems to have Change-Id tag.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
