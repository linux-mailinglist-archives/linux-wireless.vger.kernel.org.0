Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A825FD23
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 17:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgIGPad (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 11:30:33 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:37910
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730125AbgIGP32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 11:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599492568;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=IcFaEJ09/p2rgp+bLxyiPBUfIuoi7mAchqyMMtfa8o4=;
        b=gmXYO6qKF/COapEk8at6xu5yYD5izJTbRF2nyIMZdbQXbBx716mYaC+X8tYFcfE6
        ypDaO3FOrwQsKtMvBGBcn4urrq5+GcX9djlXM4y1skz/DfTE8SmNq3H6pcohwfDaha3
        SPsRnZ7NkOrRF1F82FgAEq7ucOnFhcFayUvZRVgg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599492568;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=IcFaEJ09/p2rgp+bLxyiPBUfIuoi7mAchqyMMtfa8o4=;
        b=YV3YjJ9u0/6ZNv85/i5wXcfIpffDZC65xoJfieM0+7VThsTqZMmwul9eS7Iy+PqG
        JJjR5dI6YRBiOmL2htLhseVBDQEOIgO9lQ0K1QdQhtFb0qBDqZo9Q7gpbuPXtS3zDmg
        SWxb+pxfit0d4A4vRFy4S3ESqMX4epgwUhXa4VgM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EBF6C4344A
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
Date:   Mon, 7 Sep 2020 15:29:28 +0000
In-Reply-To: <9c5de429-ff6f-cad2-39a7-d5812fd3df09@cypress.com> (Wright Feng's
        message of "Mon, 7 Sep 2020 10:09:17 +0000")
Message-ID: <01010174692fb3ae-bbe3383d-9087-4078-9bbc-f44915df446b-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <Wright.Feng@cypress.com> writes:

>>>>> +brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
>>>>> +			  struct bss_parameters *params)
>>>>> +{
>>>>> +	struct brcmf_if *ifp;
>>>>> +	int ret = 0;
>>>>> +	u32 ap_isolate;
>>>>> +
>>>>> +	brcmf_dbg(TRACE, "Enter\n");
>>>>> +	ifp = netdev_priv(dev);
>>>>> +	if (params->ap_isolate >= 0) {
>>>>> +		ap_isolate = (u32)params->ap_isolate;
>>>>> +		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", ap_isolate);
>>>>
>>>> Is the cast to u32 really necessary? Please avoid casts as much as
>>>> possible.
>>>
>>> It seems to me. struct bss_parameters::ap_isolate is typed as int. It
>>> is passed to brcmf_fil_iovar_int_set() which requires a u32 (maybe
>>> function name is causing the confusion).
>> 
>> What extra value does this explicit type casting bring here? I don't see
>> it. Implicit type casting would work the same, no?
>
> The value will be -1, 0 or 1.
> I will submit v2 patch that ignores doing iovar if getting 
> params->ap_isolate -1 and removes explicit type casting. Thanks for the 
> comment.

Oh, I didn't realise ap_isolate can be -1 as struct bss_parameters
didn't document that. Can someone submit a patch to fix that?

 * @ap_isolate: do not forward packets between connected stations

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
