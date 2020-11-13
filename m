Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC822B19AA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgKMLKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 06:10:20 -0500
Received: from z5.mailgun.us ([104.130.96.5]:55595 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgKMLIo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 06:08:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605265709; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=I/CVbI8TPJTyTAGZ/DnpOIXP94vnB8sbEPZNC//8PdI=;
 b=jlCPhgtLT9a55M/jySmSikWclLwCiLDh3YGbpAb2DH1jDziu+gM/Mf0nMZO/4C/+Bml3/c/c
 dsPTc7DiQusjGlYXd+Qw8GCpVGsfDlhL/Zk2gyNNZIat9nQs3AX4C8oGhvhXwH32QZYJJRXh
 zJ6nfltqKhwgnpDygatPABRzMY8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fae6927d6e6336a4e6accd3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 11:08:23
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A6F7C43385; Fri, 13 Nov 2020 11:08:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        LOTS_OF_MONEY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C0E8C433C8;
        Fri, 13 Nov 2020 11:08:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Nov 2020 19:08:21 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Pavel Procopiuc <pavel.procopiuc@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        ath11k@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
In-Reply-To: <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
 <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org>
 <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
 <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com>
 <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
Message-ID: <f1f471905ea99ad9b9c8a8eeae616ff9@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-13 16:17, Pavel Procopiuc wrote:
> Op 12.11.2020 om 11:48 schreef David Hildenbrand:
>> Trying to understand the code, it looks like there are always two 
>> rounds of reqests. The first one always fails ("requesting one big 
>> chunk of DMA memory"), the second one (providing multiple chunks of 
>> DMA memory) is supposed to work - and we do allocate memory.
>> 
>> 
>> In the *working* cases we have
>> 
>> Respond mem req failed, result: 1, err: 0
>> qmi failed to respond fw mem req:-22
>> ...
>> chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
>> 
>> We don't fail in qmi_txn_wait() - second request w
>> 
>> 
>> In the *non-working* cases we have
>> 
>> Respond mem req failed, result: 1, err: 0
>> qmi failed to respond fw mem req:-22
>> ...
>> qmi failed memory request, err = -110
>> qmi failed to respond fw mem req:-110
>> 
>> We fail in qmi_txn_wait(). We run into a timeout (ETIMEDOUT).
>> 
>> Can we bump up the timeout limit and see if things change? Maybe FW 
>> needs more time with other addresses.
> 
> I tried increasing ATH11K_QMI_WLANFW_TIMEOUT_MS 20 times to 100000
> (i.e. 100 seconds) and it didn't have any positive effect, the second
> error (-110) just came 100 seconds later and not 5.
> 
Checked some logs. Looks when the error happens, the physical address 
are
very small. Its' between 20M - 30M.

So could you have a try to reserve the memory starting from 20M?
Add "memmap=10M\$20M" to your grub.cfg or edit in kernel parameters. so 
ath11k
can't allocate from these address.

Or you can try to reserve even larger memory starting from 20M.
