Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB93EE784
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfKDSmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 13:42:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfKDSmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 13:42:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so1313894plk.6
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2019 10:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nT1u9EQrXODKur5odFwwtyLmwUgE0+RfIth/A09d2R8=;
        b=WoFLNN5tuCCp5Kto7GDa7Zfc2f+aR4xJRPljt5Yu/Y8F6SV7/4Fke+FUfuLjoMwVml
         GBbeGbfUdi62P3CvZIdn3o5CTXZcPSqRNCVboLZ21YBajslkUKqmsqP4g7n/ojekav4X
         gI8E+icmh5DkeLTPQyU6QCQXUoGKl0ys7fAjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nT1u9EQrXODKur5odFwwtyLmwUgE0+RfIth/A09d2R8=;
        b=uGlqBE3xg3HI+rGruKYZ8jjMVCZhs+DSVf0dPmy7BShzwFxeCw23OFx84Z/FWvUBa6
         kh1tiBwtouhk4kLow9eKBsTKCeYQyguzJonGyS26yfhsw5XnSiegNq02nrHINhRaVU0O
         yVZ1/2MHYZAxO4BMs0U3KcZGEE3iL75tgTGLhlsidDOWIdA55mHkUZfDhPmZ7x5Hnf9u
         fUL3WnbPN1JAPjwGlqfcd/yRQi7NBb1F3SAM+xP/MNO6Ax2BNyThJVy28FCIiI/uRK2r
         jsSVd5XQZFVo/SL2H7hFEXCWVbJ+oKFxmhryPc2jVcVE8ewCWIyGLCzv485mCRhRn37y
         pdMw==
X-Gm-Message-State: APjAAAXC/GtCT9REg9Kx4tjxA/Atw5bRsW389+IOxoFQkEKzPBemYR0O
        e13nKuPCAI7XagkzmpalLJg07g==
X-Google-Smtp-Source: APXvYqx06VbV+n2SyPHyycKi9+nLaUzlgRkD9ESoNTpcTEqFErpUN1XFsYra7EGKEP9CSGc5vpnkdg==
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr29337765plb.303.1572892921528;
        Mon, 04 Nov 2019 10:42:01 -0800 (PST)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id b6sm18195396pga.12.2019.11.04.10.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:42:00 -0800 (PST)
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     Tom Psyborg <pozega.tomislav@gmail.com>, zhichen@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
 <8c6d531f6474faf4df55f90185466774@codeaurora.org>
 <CAKR_QV+Qh_ErYduYoD8=u_i-y=cbKSJkkajtKxsJ5ML8-Z79EQ@mail.gmail.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <3f3b683f-789a-9b7f-a854-0fdcc20819d1@eero.com>
Date:   Mon, 4 Nov 2019 10:41:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKR_QV+Qh_ErYduYoD8=u_i-y=cbKSJkkajtKxsJ5ML8-Z79EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11/3/19 7:36 AM, Tom Psyborg wrote:
> On 30/10/2019, zhichen@codeaurora.org <zhichen@codeaurora.org> wrote:
>> On 2019-10-23 01:16, Peter Oh wrote:
>>> How can you say value 0 (I believe it's 64 bytes) DMA burst size
>>> causes the symptom and 1 fixes it?
>>>
>>> Peter
>> Confirmed from HW team that the configuration controls AXI burst size of
>> the RD/WR access to the HOST MEM.
>> 0-	No split , RAW read/write transfer size from MAC is put out on bus as
>> burst length.
>> 1-	Split at 256 byte boundary
>> 2,3- Reserved
>>
>> That's why we see issue with value 0.
>>
>> Zhi
>>
>> _______________________________________________
>> ath10k mailing list
>> ath10k@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/ath10k
>>
> is this true for both wave1 and wave2 ? at least per this commit
> message: ath10k: Fix DMA burst size
> it's suppose to be:
>
> 0 - 128B max (not sure if this means 128B static, or any size between 0 and 128)
> 1 - 256B
I didn't check other chipsets, but QCA4019 registers say AXI read/write 
burst size is 64 bytes for 0.
