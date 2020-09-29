Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AB27BE69
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgI2HwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 03:52:10 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:19822 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2HwJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 03:52:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601365929; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dLH1lxt1EAHgWS7vy6HHEQIBg6nBFYFWxkhJ6uCqv80=; b=fY2o7LSaeSBRjKPEqFzjmJcj60nLGRsgPBGoiU73JCaHuSYGlQuMen7Mwsbth9IOqCn/u5RL
 vgj38/GV4/i1p4M2ZIghb8V9IAuRzq7GVHeAtfxVRO6t1i20kH47yovDXaRvuos2TmReWb79
 nxno2WDfuT29l6PCEI/UI7hqfKc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f72e7a897ca3ed0fb5c786e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 07:52:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36B3FC433FE; Tue, 29 Sep 2020 07:52:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7BFDC433F1;
        Tue, 29 Sep 2020 07:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7BFDC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/15] iwlwifi: mvm: split a print to avoid a WARNING in ROC
References: <20200925213053.454459-1-luca@coelho.fi>
        <iwlwifi.20200926002540.c76108b9c476.Ib06008665e7bf1199c360aa92691d9c74fb84990@changeid>
Date:   Tue, 29 Sep 2020 10:52:02 +0300
In-Reply-To: <iwlwifi.20200926002540.c76108b9c476.Ib06008665e7bf1199c360aa92691d9c74fb84990@changeid>
        (Luca Coelho's message of "Sat, 26 Sep 2020 00:30:43 +0300")
Message-ID: <87sgb1dnq5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> A print in the remain on channel code was too long and caused
> a WARNING, split it.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Fixes: 758cba88d008 ("iwlwifi: mvm: ROC: Extend the ROC max delay duration & limit ROC duration")

Is the commit id correct?

$ git show 758cba88d008
fatal: ambiguous argument '758cba88d008': unknown revision or path not in the working tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
