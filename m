Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD12E0151
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgLUTyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 14:54:37 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:40071 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLUTyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 14:54:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608580453; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=iPs1eZk0G/knaly+Pu8IDcD6AR0WgxZXKzna114NbZo=; b=vbyhNQbCVMwrXUEQuZRBrsqFmAgyScvQg9+uX8YCQb8IBr2SYcA8hMkxBrycufw49Vz3jJDf
 WbrlYOGMwp/dm9O/CRESA/KzFusFcKCHMQPyEoNwTmrS4zh8kOSGyP3WX9xA24+mFxrOsEIf
 I2BWkLNWbUeIpMClbCbfDTnvia4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fe0fd3cda4719818890beca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 19:53:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1CC5C43461; Mon, 21 Dec 2020 19:53:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CE26C43461;
        Mon, 21 Dec 2020 19:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CE26C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH] ath10k: fix wmi mgmt tx queue full due to race condition
References: <1608515579-1066-1-git-send-email-miaoqing@codeaurora.org>
        <CA+ASDXP8LotnQZNvXYZqfYH8za6rx1DaZmnH21TsO2NmzX+OZA@mail.gmail.com>
Date:   Mon, 21 Dec 2020 21:53:28 +0200
In-Reply-To: <CA+ASDXP8LotnQZNvXYZqfYH8za6rx1DaZmnH21TsO2NmzX+OZA@mail.gmail.com>
        (Brian Norris's message of "Mon, 21 Dec 2020 11:31:40 -0800")
Message-ID: <87ft3zndfr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> Hi,
>
> On Sun, Dec 20, 2020 at 5:53 PM Miaoqing Pan <miaoqing@codeaurora.org> wr=
ote:
>>
>> Failed to transmit wmi management frames:
>>
>> [84977.840894] ath10k_snoc a000000.wifi: wmi mgmt tx queue is full
>> [84977.840913] ath10k_snoc a000000.wifi: failed to transmit packet, drop=
ping: -28
>> [84977.840924] ath10k_snoc a000000.wifi: failed to submit frame: -28
>> [84977.840932] ath10k_snoc a000000.wifi: failed to transmit frame: -28
>>
>> This issue is caused by race condition between skb_dequeue and
>> __skb_queue_tail. The queue of =E2=80=98wmi_mgmt_tx_queue=E2=80=99 is pr=
otected by a
>> different lock: ar->data_lock vs list->lock, the result is no protection.
>
> Nice catch!
>
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -3763,23 +3763,16 @@ bool ath10k_mac_tx_frm_has_freq(struct ath10k *a=
r)
>>  static int ath10k_mac_tx_wmi_mgmt(struct ath10k *ar, struct sk_buff *sk=
b)
>>  {
>>         struct sk_buff_head *q =3D &ar->wmi_mgmt_tx_queue;
>> -       int ret =3D 0;
>> -
>> -       spin_lock_bh(&ar->data_lock);
>>
>>         if (skb_queue_len(q) =3D=3D ATH10K_MAX_NUM_MGMT_PENDING) {
>
> I believe you should be switching this to use skb_queue_len_lockless()
> too.

Why lockless? (reads documentation) Ah, is it due to memory
synchronisation now that we don't take the data_lock anymore?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
