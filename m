Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3862E9636
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 07:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfJ3GEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 02:04:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41800 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ3GEj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 02:04:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id j131so469447ywa.8
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VmzNbGg34FnbG5Nbkk0uiTVnFkTAGV+lRGweiedphdo=;
        b=JUb5oATapZ8cFR6+UNLQPySWl/+RFqK3ccphBvJAJx9Sn24eqYrpbzx9HMQeshfi2o
         zTp+vn87GasFaEJcMbP9sl1ZMS2GW2Md83UhldxxT/8i0uc+1DdCO5h/hWsj/txpPjQ+
         8OE/I4kdivJgObIFnU+/p9plKd+fkaCuELy2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VmzNbGg34FnbG5Nbkk0uiTVnFkTAGV+lRGweiedphdo=;
        b=mEepPRQwAuV+GZns5cdV03t04MCXYks1KQLSvrp+cm3OOLd4QAch8GB48aVw7j+GL2
         5GGrVYvNUxJULDqe8d1jS+yebWOxqTrcA1N/OOabW+N9cLOT5TPDmnhMrq9iyeZqGG4j
         Ltyi9ozdF20fjbRHLb72HXlv38BC5M6HljjLuJYMRX0xzs8fdYmKiDD6H/T7R7ylp3xs
         U8PV1JQDyWbbXPJzRCYM3MR32IqmsTafWsgIKbF/qzsU1Z3li63pwT4LR8qe/wxnY7Nq
         359jlFUA41CZrADnmqH3/LlCuLg3mHjd6r20ECv+wF+9R7vxlJPijBIZOIGrBW+pCuOw
         lq5g==
X-Gm-Message-State: APjAAAVxtMWS0N/KqTb6Xtrr5n8ZKvHGNpUZ4fj2Z6XiThQ4N94h7F97
        hhICVoWukKqIZHHjCFrifX9ZnmnqqRE=
X-Google-Smtp-Source: APXvYqyuiOOOuO6kU5b7wixMyo1Wa+E2D0aiRdAnTB816TlperTzJZvCLfKQkg4cEy47RNToZSh6Pg==
X-Received: by 2002:a0d:c585:: with SMTP id h127mr20719404ywd.325.1572415478146;
        Tue, 29 Oct 2019 23:04:38 -0700 (PDT)
Received: from [10.0.2.15] (75-25-130-58.lightspeed.sjcpca.sbcglobal.net. [75.25.130.58])
        by smtp.gmail.com with ESMTPSA id d192sm846986ywb.3.2019.10.29.23.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 23:04:37 -0700 (PDT)
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     Adrian Chadd <adrian@freebsd.org>
Cc:     Zhi Chen <zhichen@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless@vger.kernel.org
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
 <CAJ-VmonXbUQ=Gv9fBbpN+ez25c3Pz+xxLoL67etMdC0Q+bwyXg@mail.gmail.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <8211c499-ec34-d1de-221e-e037e1fd0332@eero.com>
Date:   Tue, 29 Oct 2019 23:04:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ-VmonXbUQ=Gv9fBbpN+ez25c3Pz+xxLoL67etMdC0Q+bwyXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/22/19 11:24 AM, Adrian Chadd wrote:
> On Tue, 22 Oct 2019 at 10:17, Peter Oh <peter.oh@eero.com> wrote:
>>
>> On 10/22/19 1:57 AM, Zhi Chen wrote:
>>> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
>>> PCIe hung issue was observed on multiple platforms. The issue was reproduced
>>> when DUT was configured as AP and associated with 50+ STAs.
>>>
>>> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
>>> issue happened. It broke PCIe spec and caused PCIe stuck.
Can you elaborate how 64 bytes DMA size breaks PCIe spec?
>> How can you say value 0 (I believe it's 64 bytes) DMA burst size causes
>> the symptom and 1 fixes it?
>
> +1 to this question.
>
> Also, shouldn't the DMA engine be doing what the firmware says? Is the
> firmware/copy engine actually somehow bursting / prefetching across a
> 4K page boundary?
>
> Surely this is something that can be fixed in software/firmware by
> correctly configuring up buffer size/offsets?
>
>
>
> -adrian
