Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAA26098E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIHE3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 00:29:16 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:44464
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgIHE3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 00:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599539354;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=nPyk91QGICe40tqUkwXWorKLPuEnFUtbs9ATHi046o8=;
        b=b0zvwszXxXEsfzYhI6lwek9iNkhoK3TMdO0f++Bx58tF5lDPgSa7ty2g+AEhdkaC
        OsEvsWUEEgLwCBEQcJOs3ToRspdP3WRX+jLf1a1G/WjzHGop7eAFeoyPxx7AYgozKdM
        Zye5m3/xc2QqUTQKd6KjuisAMjg+G4WxpBWH/STg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599539354;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=nPyk91QGICe40tqUkwXWorKLPuEnFUtbs9ATHi046o8=;
        b=nuF+A5Jh2e0qdmOZD2Ru58qZWz6w6uUECV2NseOn6etZg6NlwLTzVVvSIwaQaDYT
        ZPHzBapjUk7h89WipvxiTxEh4UQpHsnjX/I7FCdfiPPIv4jWGzQSErcs9GkIL9YNjSD
        jq+kB/BWHlNgEiJFpymT7IY3Wly1X0D9YUJZE27s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0821C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <Wright.Feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list\@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
References: <20200901063237.15549-1-wright.feng@cypress.com>
        <20200901063237.15549-2-wright.feng@cypress.com>
        <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
        <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com>
        <0101017467f80c0c-9d33c4e2-53c3-486a-8dec-40e51161feb4-000000@us-west-2.amazonses.com>
        <9c5de429-ff6f-cad2-39a7-d5812fd3df09@cypress.com>
        <01010174692f7c3f-4b7369b2-0665-4324-b1c8-57bd22ac9ce7-000000@us-west-2.amazonses.com>
        <1746948ecc8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <6cc3759f-9dc5-f505-4878-33700e41fb73@cypress.com>
Date:   Tue, 8 Sep 2020 04:29:13 +0000
In-Reply-To: <6cc3759f-9dc5-f505-4878-33700e41fb73@cypress.com> (Wright Feng's
        message of "Tue, 8 Sep 2020 02:13:20 +0000")
Message-ID: <010101746bf99937-d6a76b8c-7358-4f9e-a8ee-140a8d7627ab-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.08-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <Wright.Feng@cypress.com> writes:

>>> Oh, I didn't realise ap_isolate can be -1 as struct bss_parameters
>>> didn't document that. Can someone submit a patch to fix that?
>>>
>>> * @ap_isolate: do not forward packets between connected stations
>> 
>> Me too. I assumed it was a boolean reading that description.
>> 
>> Regards,
>> Arend
>
> The ap_isolate -1 value in nl80211_set_bss means not to changed.I
> intend to add a check of "params->ap_isolate >= 0" like
> ath/wil6210/cfg80211.c does in brcmf_cfg80211_change_bss. And I will
> submit another patch to revise the comment in cfg80211.h as below. Let
> me know if you concern about it.

Great, thanks.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
