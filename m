Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74A15C816
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 17:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgBMQTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 11:19:02 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:18983 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727675AbgBMQTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 11:19:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581610741; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VUZ0aN8mfEbISkdqNt0Kuqp4RcG69sd8211gKI8qACM=; b=jqJstANWc12CLMUif4DQiNATix3ACv1Cgoni3RmQlkfeGmBtJGi4SUA8aYy55IlSvpOOjgGn
 n71MaEtqpVTE+WDUUn6A9oRbCRZmZdhaqLNWOOcaxD8Nelefi/4zQH4o5AbyA7hPtEjwyxIT
 TYf2QKEYCUYQnG4aBoSn7crl7iQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4576f4.7fa3ae2e9500-smtp-out-n02;
 Thu, 13 Feb 2020 16:19:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C8B8C447A0; Thu, 13 Feb 2020 16:19:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 406F7C43383;
        Thu, 13 Feb 2020 16:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 406F7C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading support
References: <20191216092207.31032-1-john@phrozen.org>
        <20191217153000.76AB1C4479C@smtp.codeaurora.org>
        <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
Date:   Thu, 13 Feb 2020 18:18:56 +0200
In-Reply-To: <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
        (Tom Psyborg's message of "Wed, 18 Dec 2019 21:14:34 +0100")
Message-ID: <87mu9mv4sv.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tom Psyborg <pozega.tomislav@gmail.com> writes:

> On 17/12/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
>> John Crispin <john@phrozen.org> wrote:
>>
>>> This patch adds support for ethernet rxtx mode to the driver. The feature
>>> is enabled via a new module parameter. If enabled to driver will enable
>>> the feature on a per vif basis if all other requirements were met.
>>>
>>> Testing on a IPQ4019 based hardware shows a increase in TCP throughput
>>> of ~20% when the feature is enabled.
>>>
>>> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>
>> Depends on:
>>
>> 50ff477a8639 mac80211: add 802.11 encapsulation offloading support
>>
>> Currently in mac80211-next.
>>
>> Patch set to Awaiting Upstream.
>>
>> --
>> https://patchwork.kernel.org/patch/11293627/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>>
>
> the changeset is missing support for 64bit targets in htt_tx.c

A very good point. Doesn't this break with WCN3990 then?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
