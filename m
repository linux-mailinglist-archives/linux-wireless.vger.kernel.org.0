Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7512E268
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 05:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgABEqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 23:46:43 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:18145 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgABEqn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 23:46:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577940402; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nIcW/PK0m8U9tBMl8GYbhKzVPmBAZUIKE8raJFatUnc=;
 b=UA4YjE6PZiu3vB5SikLflT4g/Vnvl0WSGNQ6CqV0y2AAuBuCwZnpRkrxsxJOTcOIKCOyjxKK
 mmXRkIy35kFRLJ+3330eVFSS+Vcbtp2ov+jOrto6UGbrTfXARDvzBkTY4jz7znI/Ao5QQTL+
 VyGVgT+EAn1HxCJpDh7jUJZpD9g=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0d75b1.7fc28ce64570-smtp-out-n01;
 Thu, 02 Jan 2020 04:46:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B8A8C43383; Thu,  2 Jan 2020 04:46:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91CA6C433CB;
        Thu,  2 Jan 2020 04:46:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Jan 2020 20:46:40 -0800
From:   wgong@codeaurora.org
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <CAMrEMU_eLfD6=7esrYJA4GnU=CcWgBey1QZL+-=RVoRUUcfZKw@mail.gmail.com>
References: <20191225120002.11163-1-wgong@codeaurora.org>
 <20191225120002.11163-2-wgong@codeaurora.org>
 <CAMrEMU-p3+HRZYW6TzXwZSwhxj9oJ9JW1Rg=ZysJ3fr0rm45Ng@mail.gmail.com>
 <5f6eb95de0f877b86b90d0c32d458d43@codeaurora.org>
 <CAMrEMU_eLfD6=7esrYJA4GnU=CcWgBey1QZL+-=RVoRUUcfZKw@mail.gmail.com>
Message-ID: <37eab887aaa350be0489f7e19f17d024@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-01 19:10, Justin Capella wrote:
> Instead of the atomic restart count, can the state be updated to
> ATH10K_STATE_RESTARTING while holding
>      mutex_unlock(&ar->conf_mutex);
> 
the recovery process is begin with ath10k_core_restart, and end with 
ath10k_reconfig_complete.
I already see it has mutex_lock(&ar->conf_mutex) and 
mutex_unlock(&ar->conf_mutex) in ath10k_core_restart,
but it is not enough, for example:
1st recovery has finished ath10k_core_restart, but not arrive 
ath10k_reconfig_complete, then the 2nd recovery
begin to enter ath10k_core_restart, it will destroy the 1st recovery and 
let 1st recovery fail.
After apply this patch, after recovery about 18000+ times, and still can 
connect/scan/ping success.

> I don't understand the bundles, but I wonder about the case when there
> are multiple packets (n_rx_pkts) and if pkt_bundle_len might be the
> one to check. Also if there needs to be a check that the len > sizeof
> HTC HDR.
> 
the htc_hdr->len is len of payload, so it allow < sizeof HTC HDR, but 
not allow > ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH.
pkt_bundle is only used when it has many packet in rx side, otherwise it 
is not bundled in rx.

patch v3:
https://patchwork.kernel.org/patch/11313853/
https://patchwork.kernel.org/patch/11313859/

> On Tue, Dec 31, 2019 at 1:37 AM <wgong@codeaurora.org> wrote:
>> 
>> On 2019-12-25 23:14, Justin Capella wrote:
>> > This does not only effect SDIO.
>> >
>> > Why a semaphore / count? Could the conf_mutex be held earlier, or
>> > perhaps change the state to ATH10K_STATE_RESTARTING first?
>> > ath10k_reconfig_complete is also called in mac.c when channel is
>> > changed so
>> patch v2:
>> https://patchwork.kernel.org/patch/11313853/
>> https://patchwork.kernel.org/patch/11313859/
