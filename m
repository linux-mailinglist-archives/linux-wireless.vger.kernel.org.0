Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B90F21EB94
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNIkj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 04:40:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59000 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgGNIkg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 04:40:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594716035; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VnSMU06GceCsRYOOdGyZP1O5FA/lUKd375PdgWf8H4Y=; b=pa1ECT1MGSAW2pzlOtTsIpCr70anrzhochu+Eewg6csrSxLFb6NauvTnoDt53U6Yhkhv155J
 kEwNmUt2tD7/25/CVit/BUYy4A0xSZeIhqHuCShpi/OjRtevvQYs/jjChEgas2qoEv8i+VEE
 yzwzN1u+PmCxuy3XG23h9jW/SuQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f0d6f7f2991e765cd01e416 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 08:40:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28531C43395; Tue, 14 Jul 2020 08:40:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3F55C433CA;
        Tue, 14 Jul 2020 08:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3F55C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: Replace HTTP links with HTTPS ones
References: <CACna6ryNBH7ZSie985YV9zXaEa_XmTXX2S2XH5LC8WfMZNFuAg@mail.gmail.com>
        <20200710062151.28871-1-grandmaster@al2klimov.de>
Date:   Tue, 14 Jul 2020 11:40:27 +0300
In-Reply-To: <20200710062151.28871-1-grandmaster@al2klimov.de> (Alexander A.
        Klimov's message of "Fri, 10 Jul 2020 08:21:51 +0200")
Message-ID: <87mu42cww4.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Alexander A. Klimov" <grandmaster@al2klimov.de> writes:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Better?

When you submit a new version of the patch you should mark it as v2 and
add a changelog what changed since v1, see link below for more. But this
is for the future, no need to resend because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
