Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5389036342A
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhDRGre (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 02:47:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20739 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhDRGrd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 02:47:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618728426; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oNr22xusNiJrAIdIJDLO5qmuHHcDtLjxcA/5so6lgPw=; b=Vsr3LrurGd8FwlyPJJsnFFbkzTR97zKdVQhZEgDSzINxeP+CmerKEz1ZQr5+nhnTuV8Ksmgq
 NZmyVZKSI75Uwti79moMWXUobapN23+DbSAkmJwm7h/Hfq+Q0uI96Wo7GRU0Rzrtd481dULJ
 Ez8cYsCKo8zWr32EVxocUDvjEwE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 607bd5e2e0e9c9a6b6009abc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Apr 2021 06:46:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96224C43460; Sun, 18 Apr 2021 06:46:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D5F0C433F1;
        Sun, 18 Apr 2021 06:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D5F0C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
        <20210417085010.58522C433C6@smtp.codeaurora.org>
        <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
Date:   Sun, 18 Apr 2021 09:46:55 +0300
In-Reply-To: <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm> (Jiri
        Kosina's message of "Sat, 17 Apr 2021 11:12:33 +0200 (CEST)")
Message-ID: <871rb8ks2o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:

> On Sat, 17 Apr 2021, Kalle Valo wrote:
>
>> This is malformed in patchwork, check the link below. Please resend, and
>> I strongly recommend to use git send-email to avoid any format issues.
>
> Honestly I have no idea what you are talking about, there is no whitespace 
> damage nor anything else that I'd see to be broken. I just took the patch 
> from the mail I sent, applied with git-am, and it worked flawlessly.

Compare these two links:

https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/

https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm/

In v1 there's email discussion in the commit log which shouldn't be
there.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
