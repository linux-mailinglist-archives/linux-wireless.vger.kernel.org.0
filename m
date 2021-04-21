Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6123D3667AB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 11:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhDUJKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 05:10:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16330 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbhDUJKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 05:10:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618996178; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=+0y6P/1xk/lvgmWzCh3bqlovU2i3c0Z32yJd/m3Dj3E=; b=hyj9e3vOpCFub5u6R7rxqUoBNM4gSZwp3uMQq6RSVnVSWRE1THxXjyincqNizfmnklVzor7i
 VYGJzHmf1ghdDYNwq25JlQcxrtSWPpxLZ5F4cFFa+mkYhTR8668v8NEebSOlArxnjUTZ+xzE
 EoVGh4HuvF2nqHBOGGxcMneFP44=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 607febd2c39407c327184701 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 09:09:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 748BEC4160D; Wed, 21 Apr 2021 09:09:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBB0DC4479C;
        Wed, 21 Apr 2021 09:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBB0DC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix error check in ath9k_hw_read_revisions() for PCI devices
References: <20210326180819.142480-1-toke@redhat.com> <87a6puimgu.fsf@toke.dk>
Date:   Wed, 21 Apr 2021 12:09:34 +0300
In-Reply-To: <87a6puimgu.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Mon, 19 Apr 2021 12:43:13 +0200")
Message-ID: <87lf9cj969.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

>> When the error check in ath9k_hw_read_revisions() was added, it checked =
for
>> -EIO which is what ath9k_regread() in the ath9k_htc driver uses. However,
>> for plain ath9k, the register read function uses ioread32(), which just
>> returns -1 on error. So if such a read fails, it still gets passed throu=
gh
>> and ends up as a weird mac revision in the log output.
>>
>> Fix this by changing ath9k_regread() to return -1 on error like ioread32=
()
>> does, and fix the error check to look for that instead of -EIO.
>>
>> Fixes: 2f90c7e5d094 ("ath9k: Check for errors when reading SREV register=
")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Hi Kalle
>
> This patch is merged as "deferred" in patchwork - what's up with that?

Just lack of time on my part. Reviewed-by tags would help a lot :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
