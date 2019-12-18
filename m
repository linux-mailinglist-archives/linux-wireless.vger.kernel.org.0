Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0F124A84
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 16:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLRPAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 10:00:02 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:40891 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbfLRPAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 10:00:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576681201; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PmLPE/MsKCOt+Yh/+BlQxBho0/AAiJz3sKvvHiBrTvU=;
 b=FT4AI5JUszmpQd/kUgzf4o82zvG5XE4nWiU6e45pZeVmK8Rtj8T38kJdW8H1a+ZoEZCzHGDP
 Je72F954Eshahs37rq141lJsxt1ZeT1IUNA8mf4vGxGaeWNqYTPw8fzDgZEAhYdbtfdWkBOo
 TZMk24IjtFwsvPIF0ZAP44VH1YQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa3ef0.7fb98dd533b0-smtp-out-n02;
 Wed, 18 Dec 2019 15:00:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54A13C433A2; Wed, 18 Dec 2019 15:00:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: merez)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12632C433CB;
        Wed, 18 Dec 2019 15:00:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 17:00:00 +0200
From:   merez@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 1/8] wil6210: dump Rx status message on errors
In-Reply-To: <87y2v93dta.fsf@tynnyri.adurom.net>
References: <20191218135947.5903-1-merez@codeaurora.org>
 <20191218135947.5903-2-merez@codeaurora.org>
 <87v9qd917e.fsf@kamboji.qca.qualcomm.com>
 <87y2v93dta.fsf@tynnyri.adurom.net>
Message-ID: <0c5117bc087825617f25b8e6213b202f@codeaurora.org>
X-Sender: merez@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-18 16:31, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
>> Maya Erez <merez@codeaurora.org> writes:
>> 
>>> From: Ahmad Masri <amasri@codeaurora.org>
>>> 
>>> Dump all the Rx status message on different errors to allow more
>>> visibility of the case.
>>> 
>>> Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
>>> Signed-off-by: Maya Erez <merez@codeaurora.org>
>>> ---
>>>  drivers/net/wireless/ath/wil6210/txrx_edma.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>> 
>>> diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c 
>>> b/drivers/net/wireless/ath/wil6210/txrx_edma.c
>>> index 02548d40253c..6a1671c3a2be 100644
>>> --- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
>>> +++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
>>> @@ -903,6 +903,11 @@ static struct sk_buff 
>>> *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
>>>  	if (unlikely(!wil_val_in_range(buff_id, 1, 
>>> wil->rx_buff_mgmt.size))) {
>>>  		wil_err(wil, "Corrupt buff_id=%d, sring->swhead=%d\n",
>>>  			buff_id, sring->swhead);
>>> +		print_hex_dump(KERN_ERR, "RxS ", DUMP_PREFIX_OFFSET, 16, 1,
>>> +			       (void *)msg, wil->use_compressed_rx_status ?
>> 
>> Isn't the cast unnecessary? Please avoid casting as much as possible.
>> 
>>> @@ -963,6 +968,11 @@ static struct sk_buff 
>>> *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
>>> 
>>>  	if (unlikely(dmalen > sz)) {
>>>  		wil_err(wil, "Rx size too large: %d bytes!\n", dmalen);
>>> +		print_hex_dump(KERN_ERR, "RxS ", DUMP_PREFIX_OFFSET, 16, 1,
>>> +			       (void *)msg, wil->use_compressed_rx_status ?
>> 
>> Same here.
> 
> I fixed these in the pending branch, please double check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=51d652cdee36051bdb83809adb91951f41c7a456

Thanks for fixing it. The fix looks good.
