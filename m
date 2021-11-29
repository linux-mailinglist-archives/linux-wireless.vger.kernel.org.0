Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5B4612FA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 11:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhK2K7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 05:59:32 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:63689 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239851AbhK2K5c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 05:57:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638183255; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Q5OpnUeQRBjKRr8DJQYcMiUeDh8TD5lfyHLllP2qBBk=;
 b=YvJGwktdAMABREc+d8Lw6HK3NYPUn3exVTESyjTkuyQeYqF45W8hCm/hajRGVKLZ/OHedL7x
 GbqnWJMf6fIl/kJxL0yKRGbwuYG65C3yAJr7oYXnhST1tf59VwiUfSms2ldv3mBzmUZq2io5
 uLuD7CxtNfwxndfUbWNf6sGiLio=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61a4b156db3ac5552aafb240 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 10:54:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C299C43619; Mon, 29 Nov 2021 10:54:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED6E7C4338F;
        Mon, 29 Nov 2021 10:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org ED6E7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rt2x00: do not mark device gone on EPROTO errors during start
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211111141003.GA134627@wp.pl>
References: <20211111141003.GA134627@wp.pl>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Exuvo <exuvo@exuvo.se>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163818324905.4761.11561065862250916009.kvalo@codeaurora.org>
Date:   Mon, 29 Nov 2021 10:54:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> As reported by Exuvo is possible that we have lot's of EPROTO errors
> during device start i.e. firmware load. But after that device works
> correctly. Hence marking device gone by few EPROTO errors done by
> commit e383c70474db ("rt2x00: check number of EPROTO errors") caused
> regression - Exuvo device stop working after kernel update. To fix
> disable the check during device start.
> 
> Link: https://lore.kernel.org/linux-wireless/bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se/
> Reported-and-tested-by: Exuvo <exuvo@exuvo.se>
> Fixes: e383c70474db ("rt2x00: check number of EPROTO errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers.git, thanks.

ed53ae756930 rt2x00: do not mark device gone on EPROTO errors during start

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211111141003.GA134627@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

