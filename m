Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63B91CEF0B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgELIY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 04:24:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:20290 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgELIY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 04:24:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589271896; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cCctq8gjD4nM2LcNYkndfQF2Cac743L0F9BdR/7eCW4=; b=URqgKmy9PbQklJFzSyRWJVE95gPsH5LSPOO24vBtF2BrlolUERABMJ8tPEo3YtXO720O2Lux
 A4XvBLoTXiV36KtPh/OghnS/hEfobky6OBpNKLRCVoa/HlD1ccEwGNRp8anXjERcCyx9hYdE
 /wgxbkO878vAugJfxOhAYpK26NA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba5d57.7f0d1993e6c0-smtp-out-n03;
 Tue, 12 May 2020 08:24:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8376CC433F2; Tue, 12 May 2020 08:24:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D95F4C433CB;
        Tue, 12 May 2020 08:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D95F4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
References: <20200508085850.23363-1-govinds@codeaurora.org>
        <20200508085850.23363-5-govinds@codeaurora.org>
        <87d07a4acz.fsf@kamboji.qca.qualcomm.com>
        <20200512071323.GI4928@Mani-XPS-13-9360>
        <871rnp4lc7.fsf@kamboji.qca.qualcomm.com>
Date:   Tue, 12 May 2020 11:24:50 +0300
In-Reply-To: <871rnp4lc7.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Tue, 12 May 2020 11:19:04 +0300")
Message-ID: <87wo5h36i5.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

>> But we have made few changes to the MHI stack which will impact the
>> controller drivers.
>
> Oh, that will create problems. What kind of changes are needed in
> ath11k?

I did a test of pulling
'git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next' to
my pending branch and at least it compiled without issues. So hopefully
the changes in mhi-next won't break ath11k.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
