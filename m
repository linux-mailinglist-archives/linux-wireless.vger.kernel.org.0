Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9552F73DF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 08:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbhAOHxs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 02:53:48 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:45490 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbhAOHxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 02:53:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610697207; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=SKj9EC6fomQFyZM8/xL3J6ttdmy0xuoNsrUXAojzIuM=; b=cHOPpHB3y6c56DCPZRzf1nIyV2di7/ejTRPLq/2IVAhPZLZ5X8zh6pliF8f1wNDLAaL92udd
 NCY39tchSusKfNeAz3xEaP+FEWkKGCRqqwJfPEJ9OyQXzcM5ZJRX2Hb9zm2peGq1I5RLtGbH
 P5PEmvjBvPFDlGHIk3fRrxPL2J4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 600149cd02b2f1cb1a00e73c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 07:52:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0AEE4C433C6; Fri, 15 Jan 2021 07:52:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65AA2C433CA;
        Fri, 15 Jan 2021 07:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65AA2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma\@gmail.com" <tony0620emma@gmail.com>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
References: <20210114010950.3316-1-pkshih@realtek.com>
        <874kjkrnje.fsf@codeaurora.org> <1610673434.2741.20.camel@realtek.com>
Date:   Fri, 15 Jan 2021 09:52:40 +0200
In-Reply-To: <1610673434.2741.20.camel@realtek.com> (pkshih@realtek.com's
        message of "Fri, 15 Jan 2021 01:17:50 +0000")
Message-ID: <87zh1ar60n.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> To avoid frequently submitting patches results from exceeding patch size limit.
> I'd like to know the patch size limit accepted by patchwork.
> As I know, the limit is about 512k, so it is expected that below patches
> don't appear in patchwork
> 1. patch 5/5 of v1 (978K)
> 2. patch 6/7 of v2 (532K)
>
> But, I don't know why the table file (patch 16/18) of rtw89 whose size is
> 772k can appear in patchwork. Does patchwork have different limits of
> existing and new file? Moreover, if new file exceeds the limit someday,
> how can I deal with it? Can I split the new file into two or more patches?

I suspect the mailing list limits the size, not patchwork. I did
directly get "[PATCH 5/5] rtw88: 8822c: update phy parameter tables to
v60" (Message-ID 20210113092312.13809-6-pkshih@realtek.com) as you added
me to CC. But I don't see it in lore, which points that linux-wireless
dropped it.

Normally these huge patches would not be applied being to big, but
updating parameter tables is a good exception to the rule and I can
commit those manually directly from my INBOX. So for huge patches I
recommend:

* move the patch as the last patch in the patchset

* the huge patch should only have changes to parameter variables, ie.
  refactor changes to the actual code to a separate patch

* add kvalo@codeaurora.org to CC

* add a big warning to the cover letter (or reply afterwards) so that I
  notice the huge patch is missing from patchwork

Would this work?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
