Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC05721D8B4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2020 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgGMOje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 10:39:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44516 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729871AbgGMOjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 10:39:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594651173; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=RbZonCviqU0Iw3ZoaD2UXTdlv+ufrHYsECP40xt9bL8=; b=xkEQ6y54oQmTgXa9CUwJUcHTec03vFfvRiyuDiOIh3Xisol/bU+NtosVUjvh/btnKzvMORKf
 +JXiTi4VX9y4wNich7atiufcQF2PjvUvalxwa1rWJ7UelkPZdLY91uxFP9ncyZiM8rPf5iP1
 bnWQsD2GEakPynSFKmbl0JEEnkA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f0c72022991e765cd4ef400 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 14:38:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6FA8C433CA; Mon, 13 Jul 2020 14:38:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D742C433C8;
        Mon, 13 Jul 2020 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D742C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdio: Move SDIO IDs from rsi_sdio driver to common include file
References: <20200629072144.24351-1-pali@kernel.org>
        <CAPDyKFp-meAG4XNgL3ixacYKpFByV-Pynz6-GRDtfT95hC-Jmw@mail.gmail.com>
Date:   Mon, 13 Jul 2020 17:38:53 +0300
In-Reply-To: <CAPDyKFp-meAG4XNgL3ixacYKpFByV-Pynz6-GRDtfT95hC-Jmw@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 6 Jul 2020 16:49:17 +0200")
Message-ID: <87eepfxywy.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Mon, 29 Jun 2020 at 09:22, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>
>> Define appropriate macro names for consistency with other macros.
>>
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Applied for next, thanks!
>
> If it turns out that it's a better idea to funnel this via Kale's
> wireless tree, then I can drop it - and you may consider this as an
> ack instead.

I'm not expecting any conflicts with this so going via mmc tree is fine
with me.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
