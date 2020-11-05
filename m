Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95452A79FE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 10:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgKEJEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 04:04:50 -0500
Received: from z5.mailgun.us ([104.130.96.5]:60422 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgKEJEs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 04:04:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604567087; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/kilLHoG2diu6RpSa3tfIWIaNOYj+vv0zBOZ2rAIu6I=; b=WfK03FCs6nAXjtJNSYUONdTwyhTXNYzIprmzOtXVxT7xlM4p2cXpG1lyGlf3EoLpQREq+BYJ
 /Ap8QGWceYFr9sZ5Z4+aWqtkh8ZrzHhH2QEmYecad4ehxThG9ikUi5hh2BcFG5PZ6hqekNOY
 bQ0NGmmOTcwIt/Y+CJTukuvOJas=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa3c02e15332c7001f0676a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 09:04:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87C19C433CB; Thu,  5 Nov 2020 09:04:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0E23C433C6;
        Thu,  5 Nov 2020 09:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0E23C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pavel Procopiuc <pavel.procopiuc@gmail.com>, david@redhat.com
Cc:     ath11k@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Regression: QCA6390 fails with "mm/page_alloc: place pages to tail in __free_pages_core()"
References: <fa22cf0f-3bac-add6-8c71-6f6cad5206d8@gmail.com>
        <87lffjodu7.fsf@codeaurora.org>
        <fa338986-8de4-fde1-6805-d46793c947e4@gmail.com>
        <c9cc0ec6-4dda-2608-3575-0e6dfb6d0852@gmail.com>
        <87ft5rszcs.fsf@codeaurora.org> <87ft5qsem9.fsf@codeaurora.org>
        <f99862f4-9b3a-03e5-cd26-1de6136f9e46@gmail.com>
        <87blgdscxd.fsf@codeaurora.org>
        <229c31e7-9aff-18e6-a6db-be7b46331173@gmail.com>
Date:   Thu, 05 Nov 2020 11:04:41 +0200
In-Reply-To: <229c31e7-9aff-18e6-a6db-be7b46331173@gmail.com> (Pavel
        Procopiuc's message of "Wed, 4 Nov 2020 23:15:05 +0100")
Message-ID: <87361onphy.fsf_-_@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(changing the subject, adding more lists and people)

Pavel Procopiuc <pavel.procopiuc@gmail.com> writes:

> Op 04.11.2020 om 10:12 schreef Kalle Valo:
>> Yeah, it is unfortunately time consuming but it is the best way to get
>> bottom of this.
>
> I have found the commit that breaks things for me, it's
> 7fef431be9c9ac255838a9578331567b9dba4477 mm/page_alloc: place pages to
> tail in __free_pages_core()
>
> I've reverted it on top of the 5.10-rc2 and ath11k driver loads fine
> and I have wifi working.

Oh, very interesting. Thanks a lot for the bisection, otherwise we would
have never found out whats causing this.

David & mm folks: Pavel noticed that his QCA6390 Wi-Fi 6 device (driver
ath11k) failed on v5.10-rc1. After bisecting he found that the commit
below causes the regression. I have not been able to reproduce this and
for me QCA6390 works fine. I don't know if this needs a specific kernel
configuration or what's the difference between our setups.

Any ideas what might cause this and how to fix it?

Full discussion: http://lists.infradead.org/pipermail/ath11k/2020-November/000501.html

commit 7fef431be9c9ac255838a9578331567b9dba4477
Author:     David Hildenbrand <david@redhat.com>
AuthorDate: Thu Oct 15 20:09:35 2020 -0700
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Fri Oct 16 11:11:18 2020 -0700

    mm/page_alloc: place pages to tail in __free_pages_core()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
