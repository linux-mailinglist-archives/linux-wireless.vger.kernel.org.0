Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FCAB747
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 13:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbfIFLkq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 07:40:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732454AbfIFLkq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 07:40:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7398761156; Fri,  6 Sep 2019 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567770045;
        bh=LMiIzlU0CJH9dDYTNGM4vDyv2IrEx3dxPXVKL6qFm+4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P0mIwZhq4GRLjB+3YIZDP7CjSCeVJDmaqANaaiseh9UOfPIZPKlXe/1N71pvfK1/F
         hyPnLaFNdTSE/VmnfcMAydwNnDDEUMdsr/Axx6m03jWvYU+9BIBZRDs2s2HCqx0REy
         7tZedJWK9jWCGy6NQPEx+9Ypfl+naUfXdMqGMyIQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-130-177-42.bb.dnainternet.fi [37.130.177.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44E1C60275;
        Fri,  6 Sep 2019 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567770045;
        bh=LMiIzlU0CJH9dDYTNGM4vDyv2IrEx3dxPXVKL6qFm+4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P0mIwZhq4GRLjB+3YIZDP7CjSCeVJDmaqANaaiseh9UOfPIZPKlXe/1N71pvfK1/F
         hyPnLaFNdTSE/VmnfcMAydwNnDDEUMdsr/Axx6m03jWvYU+9BIBZRDs2s2HCqx0REy
         7tZedJWK9jWCGy6NQPEx+9Ypfl+naUfXdMqGMyIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44E1C60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] rtl8xxxu: add bluetooth co-existence support for single antenna
References: <20190903053735.85957-1-chiu@endlessm.com>
        <CAB4CAwc5OBUWFThh__FedmG=fR-_1_GxUuiAb0J5yfU8c1aTfg@mail.gmail.com>
        <874l1p28su.fsf@codeaurora.org>
        <CAB4CAwfT58Twi-TdtyDMRx+vBQeJg6G5tnyxxC=eRZM14JykHQ@mail.gmail.com>
Date:   Fri, 06 Sep 2019 14:40:39 +0300
In-Reply-To: <CAB4CAwfT58Twi-TdtyDMRx+vBQeJg6G5tnyxxC=eRZM14JykHQ@mail.gmail.com>
        (Chris Chiu's message of "Fri, 6 Sep 2019 17:41:39 +0800")
Message-ID: <87tv9py7ns.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(please don't drop linux-wireless, I don't normally reply to private email)

Chris Chiu <chiu@endlessm.com> writes:

> On Fri, Sep 6, 2019 at 3:17 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Chris Chiu <chiu@endlessm.com> writes:
>>
>> > Gentle ping. Cheers.
>>
>> Please edit your quotes. Including the full patch in quotes makes my use
>> of patchwork horrible:
>>
>> https://patchwork.kernel.org/patch/11127227/
>
>     Sorry that I don't really get what you mean about the quote
>problem. Can you give me an example that I can follow?

See what I did. I didn't include hundreds of lines of unnecessary
context from your previous email, instead I edited all that out to keep
my mail short and precise. This is really important for fluent email
discussions, as not all email clients filter out quotes automatically.

Also I would assume there's some kernel newbie documentation somewhere,
maybe others can help or at least google should.


-- 
Kalle Valo
