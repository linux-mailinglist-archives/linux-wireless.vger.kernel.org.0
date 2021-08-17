Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945543EF08C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHQRC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 13:02:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10253 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhHQRCX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 13:02:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629219710; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=LYwT4eDRj2JiICfdihGDs8jIqG9wwZd/0YayCwFiVtU=; b=wR6MsQjYOcemFCkvAKQnC8mI+o57gPv7qFey4QtszlNfzuiZ6LkeNQ3jqFdQtkueTtRl2vys
 W9z9HUaeLWLyK3SdtGKBJ3IEmgQWznZn2qPmR2hTig6DUAIDB+xTyuSdaPtHgjKojmUpKC4d
 PRaK59MQ4cLxk73Gs0CcTIR4ySs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 611beb65f746c298d9b1f586 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Aug 2021 17:01:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C28C9C43617; Tue, 17 Aug 2021 17:01:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA75AC4338F;
        Tue, 17 Aug 2021 17:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CA75AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with the printk tree
In-Reply-To: <20210809131813.3989f9e8@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 9 Aug 2021 13:18:13 +1000")
References: <20210809131813.3989f9e8@canb.auug.org.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 17 Aug 2021 20:01:16 +0300
Message-ID: <87bl5wf1k3.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
>
>   MAINTAINERS
>
> between commit:
>
>   337015573718 ("printk: Userspace format indexing support")
>
> from the printk tree and commit:
>
>   d249ff28b1d8 ("intersil: remove obsolete prism54 wireless driver")
>
> from the wireless-drivers-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, the conflict is trivial enough so Linus should handle it without
problems.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
