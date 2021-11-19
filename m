Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE8457188
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKSPUg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 10:20:36 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:61627 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhKSPUg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 10:20:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637335054; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=98RvqJggobL+7ravMaBg0zgt1DNk6wTkO7cgYtCsuCU=; b=qlZcmLd7ZgQ9k3Ijx7on4ua6e8DRihJEu9wwT7Rq5tNC5W+vvmdTGGWgPPqiSRUd1G2C2lnz
 9dotguVCFkVGEqUdVxl0FC4ZTkfJtgjK61b56twMfXIXiyjgtYIZsREefNp0TIzUfrsLaSc1
 NatNinEQcbsgLSfvivsl3MBRuHk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6197bffa5bbbed1f70f1ccec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 15:17:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 45D3BC43617; Fri, 19 Nov 2021 15:17:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95882C4338F;
        Fri, 19 Nov 2021 15:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 95882C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Subject: ath11k: using boolean bitfields?
References: <20211116041522.23529-1-quic_wgong@quicinc.com>
        <1752085.FWK5zBq28I@ripper> <87mtm3dwu0.fsf@codeaurora.org>
        <2357945.8AGfkZV0UB@sven-desktop>
Date:   Fri, 19 Nov 2021 17:17:08 +0200
In-Reply-To: <2357945.8AGfkZV0UB@sven-desktop> (Sven Eckelmann's message of
        "Wed, 17 Nov 2021 09:46:08 +0100")
Message-ID: <87v90ob2ff.fsf_-_@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Wednesday, 17 November 2021 09:12:55 CET Kalle Valo wrote:
>> > https://www.kernel.org/doc/html/v5.15/process/coding-style.html#using-bool
> [...]
>> 
>> Yeah, I have been worried about this as well and we should fix this. But
>> instead of u8 I would prefer to use bool like mt76 uses:
> [...]
>> I didn't even know using bool is legal until I saw it in mt76.
>
> Interesting, I was also not aware of it. And it also seems to have some 
> interesting implications when assigning values to it (example 4):
>
>     #include <stdbool.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     
>     struct test {
>     	uint8_t u:1;
>     	uint8_t u2:1;
>     	bool b:1;
>     	bool b2:1;
>     };
>     
>     int main(void)
>     {
>     	struct test x;
>     
>     	x.u = false;
>     	x.b = false;
>     	printf("u %u b %u\n", x.u, x.b);
>     
>     	x.u = true;
>     	x.b = true;
>     	printf("u %u b %u\n", x.u, x.b);
>     
>     	x.u = 0;
>     	x.b = 0;
>     	printf("u %u b %u\n", x.u, x.b);
>     
>     	x.u = 8;
>     	x.b = 8;
>     	printf("u %u b %u\n", x.u, x.b);
>     
>     	return 0;
>     }
>
>
> Result:
>
>     u 0 b 0
>     u 1 b 1
>     u 0 b 0
>     u 0 b 1
>
>
> The last example is basically the reason we see stuff like
>
>     boolean_like_value = !!(some_retrieved_value);
>
> when using unsigned bitfields instead of bool (bitfields).
>
>
> And the memory layout (on x86-64):
>
>     $ pahole test.o                                    
>     struct test {
>             uint8_t                    u:1;                  /*     0: 0  1 */
>             uint8_t                    u2:1;                 /*     0: 1  1 */
>             _Bool                      b:1;                  /*     0: 2  1 */
>             _Bool                      b2:1;                 /*     0: 3  1 */
>     
>             /* size: 1, cachelines: 1, members: 4 */
>             /* bit_padding: 4 bits */
>             /* last cacheline: 1 bytes */
>     };
>
>
> To my surprise, it was already mentioned in one of the discussions [1].
> Was there anything in the discussion which I might have missed and 
> is a good reason to not use "bool ...:1" in structs?

No responses so must be safe to use ;) Changing the subject to gain more
visibility. But IMHO we should just switch using boolean bitfields as I
would expect mt76 to have noticed any problems by now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
