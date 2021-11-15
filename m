Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABA4502BA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhKOKqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:46:49 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:54391 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbhKOKqi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:46:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636973023; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=lHHQtvzm1kZlhsMmeFc8wx+xr4QzIoTJvqtDFW9WNKw=; b=ksShXhnwClS5e+j/BcPg4q7oDlSAc5PzeznfL0u7prRfDYajs6auBhxNJMB0/M2CWmMQn38w
 dCOUol3u7xWogwPGAI5DFkhj5sq1rQ+LpxHk0jJjfpInGDCrJrWQEPKyUTKqZI0NLb0YREW9
 brTHvEIviRGeA18kcpNAitW8k0g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 619239dec48ba48884ede9a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 10:43:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E193EC4338F; Mon, 15 Nov 2021 10:43:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 127D6C43616;
        Mon, 15 Nov 2021 10:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 127D6C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/6] ath11k: support one MSI vector
References: <20201223030225.2345-1-cjhuang@codeaurora.org>
        <87czx7t748.fsf@codeaurora.org>
        <CAFED-jnaYfXvz8S7d8orJmY+_=T-MRZ+v-c9OJFCg78HqS7=cw@mail.gmail.com>
Date:   Mon, 15 Nov 2021 12:43:34 +0200
In-Reply-To: <CAFED-jnaYfXvz8S7d8orJmY+_=T-MRZ+v-c9OJFCg78HqS7=cw@mail.gmail.com>
        (Janusz Dziedzic's message of "Fri, 22 Oct 2021 10:04:46 +0200")
Message-ID: <87zgq5hf6x.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Janusz Dziedzic <janusz.dziedzic@gmail.com> writes:

> czw., 11 lut 2021 o 08:10 Kalle Valo <kvalo@codeaurora.org> napisa=C5=82(=
a):
>>
>> Carl Huang <cjhuang@codeaurora.org> writes:
>>
>> > This patch set is to support one MSI vector for QCA6390.
>> >
>> > Carl Huang (6):
>> >   ath11k: get msi_data again after request_irq is called
>> >   ath11k: add ce and ext irq flag to indicate irq_handler
>> >   ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for dp irqx
>> >   ath11k: refactor mulitple msi vector implementation
>> >   ath11k: supports one MSI vector
>> >   ath11k: do not restore ASPM in case of single MSI vector
>>
>> I did some cleanup and before submitting v2 I noticed the patchset (both
>> v1 and v2) is crashing during suspend on my Dell XPS 13 9310. We are
>> investigating the reason for that and will submit v2 once those are
>> fixed.
>>
> Hello Kalle,
>
> What is status for this series?

There's now a new version available:

https://patchwork.kernel.org/project/linux-wireless/cover/20211026041616.49=
56-1-bqiang@codeaurora.org/

If you can, please do test the version in the master-pending branch
(commit 9a914cfdbfd69):

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=3Dmast=
er-pending

> I am using ath11k in my banana-pi-r64 (backports-5.15-rc6) board and hit:
> [  162.392043] ath11k_pci 0000:01:00.0: failed to get 32 MSI vectors,
> only -28 available
> [  162.399927] ath11k_pci 0000:01:00.0: failed to enable msi: -28
> [  162.405778] ath11k_pci 0000:01:00.0: disabling bus mastering
> [  162.411481] ath11k_pci: probe of 0000:01:00.0 failed with error -28
>
> I suspect this series should fix my issue?

Most likely this should fix it. You could also try changing your BIOS
settings to get more MSI vectors, IIRC enabling VT-d help on NUC boards
at least.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
