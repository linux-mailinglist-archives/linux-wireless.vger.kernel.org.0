Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC62D1313
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 15:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgLGOG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 09:06:26 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:35655 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLGOG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 09:06:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607349960; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=XIGlois2vnmKs2WFvnA2HZRgMXT+WIDDoIsxtrajS7M=; b=wzUodCJuHD3IUoMFOj8VWa6iDQptZ4uH4TsNIK+aPVDJXjuV5fryUt35FQwcv9MpmahiIkci
 4c+mTMPQBZzMeKkohVKJIqgX+/zcFtqkmAxPGeA6DykHMfqZ56B9oPr9eoHgR7vgVtKq5ksI
 7o6c3JbvLeuLJkS/KpaYP0nG+2E=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fce36aeae7b10576654ac7a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 14:05:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF458C433ED; Mon,  7 Dec 2020 14:05:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37B8EC433C6;
        Mon,  7 Dec 2020 14:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37B8EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH 0/2] iwlwifi: updates intended for v5.11 2020-12-05
References: <20201205090252.337391-1-luca@coelho.fi>
        <ec07608552a69bf03cab926712a42f13925b91e6.camel@coelho.fi>
Date:   Mon, 07 Dec 2020 16:05:29 +0200
In-Reply-To: <ec07608552a69bf03cab926712a42f13925b91e6.camel@coelho.fi> (Luca
        Coelho's message of "Sat, 05 Dec 2020 17:05:07 +0200")
Message-ID: <87eek1g192.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Sat, 2020-12-05 at 11:02 +0200, Luca Coelho wrote:
>> From: Luca Coelho <luciano.coelho@intel.com>
>> 
>> Hi,
>> 
>> Here's the second set of patches intended for v5.11.  This time it's
>> only support for 6GHz and one dependency patch.
>> 
>> This is the work of several developers, I just aggregated everything
>> into a single patch.  The following developers were involved in either
>> initial development or bugfixes:
>> 
>> Haim Dreyfuss <haim.dreyfuss@intel.com>
>> Ilan Peer <ilan.peer@intel.com>
>> Tova Mussai <tova.mussai@intel.com>
>> Andrei Otcheretianski <andrei.otcheretianski@intel.com>
>> Tali Levi Rovinsky <Tali.Levi-rovinsky@intel.com>
>> Avraham Stern <avraham.stern@intel.com>
>> Ayala Beker <ayala.beker@intel.com>
>
> Johannes suggested that I add these developers in "Co-developed-by"
> tags, so add them in patch 2/2.

Yeah, I was thinking the same. Just remember to use also s-o-b:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
