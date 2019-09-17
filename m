Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2DB5440
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 19:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfIQRaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 13:30:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfIQRaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 13:30:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0622D613A8; Tue, 17 Sep 2019 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568741429;
        bh=VeoMTg9D75uSeZQHx+Ox+CDzOqOQgKcDZagRAuvhNrk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=l6jZVDVRmQQAr1h1v3m6f7DhCrFVhhm4N+WHHvBQSiHacETSbGQ/6Ahv3Jw4cVbJ9
         IQn7QehpTXS6Rr5nsEouW6h5tqU5hYZVh3fsBI4DI5jNqwVjVgjemJ3NLzFCtV7Z7v
         O7TprVzc02TxAspisObTDrrLTQjuyN8mMZzajpVI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5E73611CE;
        Tue, 17 Sep 2019 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568741428;
        bh=VeoMTg9D75uSeZQHx+Ox+CDzOqOQgKcDZagRAuvhNrk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bSbWXakEfBPBSIHa/Pu3trr9fQSivuon/L/gIL6R0VyBk1b3ZOSFnh2e39gcx28/r
         7EUGO5oHtLnparUgYOlMCw76LkPQggyxN29YesTAxpgwijE8DhQCcBOC8RKNCSm/zT
         9Hc4K/wMy1+Y0TYcEpNi7GJnFo0x7xP0sDbnADF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5E73611CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: use ath10k_pci_soc_ functions for all warm_reset instances
References: <1564305118-3059-1-git-send-email-pozega.tomislav@gmail.com>
        <20190917141014.6A1DA602F3@smtp.codeaurora.org>
        <CAKR_QVKtLM7fWs94y_KqndSXmUNTVHO7xqBK3sr5M44DSO_K0g@mail.gmail.com>
Date:   Tue, 17 Sep 2019 20:30:24 +0300
In-Reply-To: <CAKR_QVKtLM7fWs94y_KqndSXmUNTVHO7xqBK3sr5M44DSO_K0g@mail.gmail.com>
        (Tom Psyborg's message of "Tue, 17 Sep 2019 18:54:07 +0200")
Message-ID: <87a7b2bzkf.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tom Psyborg <pozega.tomislav@gmail.com> writes:

> On 17/09/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
>> Tomislav Po=C5=BEega wrote:
>>
>>> Use ath10k_pci_soc_read32 / ath10k_pci_soc_write32 functions for
>>> the rest of warm_reset functions. Until now these have been used
>>> only for ath10k_pci_warm_reset_si0, but since they already exist
>>> it makes sense to simplify code a bit.
>>> Runtime tested with QCA9862.
>>>
>>> Signed-off-by: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> is this a typo or should've I add your SoB line to that commit?

This is just because of my pwcli patchwork script and it's stgit mode.
It takes the commit log directly from the pending branch, where I need
to add my s-o-b as I publish the branch.

In general you should only add your own s-o-b line:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

> btw what about this patch it's been sent out quite a several months
> ago? https://patchwork.kernel.org/patch/10860301/

I have not looked at that yet but it's in my queue.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
