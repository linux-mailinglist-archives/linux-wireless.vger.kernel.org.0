Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6956E14CCEC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2PCV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 10:02:21 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:43396 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgA2PCV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 10:02:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580310140; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=uemquSOnrrMSHzBuQAa1e+yDwcYxtWwmFeDw2ffjOsA=; b=Lwzkjk6jqK8z0I9KKmelSXZLYA1fCSRCP2AzjgYUlFrL2IHWVEyoEvVOhoSf/259eUk9BjQ4
 87bqY3zP7/FwG7pFvYoHZQ3jggqvdA4gvE1QkTAynr2g5TfS4nGub2ZNCND2LFg3IEO5J/f+
 Pt5/uT1D+3xXtXKhI3Qog+FWRVs=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e319e77.7fab97493110-smtp-out-n03;
 Wed, 29 Jan 2020 15:02:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6393DC4479F; Wed, 29 Jan 2020 15:02:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0419FC433CB;
        Wed, 29 Jan 2020 15:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0419FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: Re: [PATCH v2] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
References: <20200126155108.7DDD7C433CB@smtp.codeaurora.org>
        <20200126193339.167346-1-sandals@crustytoothpaste.net>
        <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <20200126230029.GI4113372@camp.crustytoothpaste.net>
        <71763ca9-ed7a-2403-b85a-d7dc624cd050@broadcom.com>
Date:   Wed, 29 Jan 2020 17:02:09 +0200
In-Reply-To: <71763ca9-ed7a-2403-b85a-d7dc624cd050@broadcom.com> (Arend Van
        Spriel's message of "Tue, 28 Jan 2020 10:47:37 +0100")
Message-ID: <87a766xq4u.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

>> There is also precedent for users acquiring firmware themselves via the
>> b43 and b43legacy drivers, where users have to use a script to extract
>> the firmware from other drivers.
>>
>> I wish I had a better answer to this, but I don't work for Broadcom or
>> anyone associated with it and am just trying to get the Mac I was given
>> for $DAYJOB to work with Linux.  Perhaps since you do you'd be willing
>> to ask them to release the firmware.
>>
>> The alternative is that the chip doesn't work at all (and can't be added
>> via the new_id sysfs entry because of the rambase setting) and users
>> have to compile a custom patched kernel to make their wireless card work
>> at all.  I'd really prefer to avoid that if possible, since it's
>> a strictly worse experience in every way.
>
> How about putting this device under some Kconfig flag. If distro
> kernel start probing the device and fail, most users will probably
> turn to their distro for help. Having a Kconfig with a good
> description could avoid that. It would mean an extra step of building
> the driver though.

I don't understand the issue you are trying to solve. If the firmware
image is missing there's a clear error message in the log and the kernel
continues to operate normally, right? That way users have a clear
understanding why their wireless is not working, and hopefully push
Broadcom to release the firmware with a suitable license :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
