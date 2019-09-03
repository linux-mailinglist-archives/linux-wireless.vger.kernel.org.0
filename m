Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29269A6871
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfICMRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 08:17:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICMRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 08:17:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BE66605A2; Tue,  3 Sep 2019 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567513072;
        bh=Jyqh6v/xfVlSwmEkwf8QAjZcPeN2/S+JiZriC7u102Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XWwxF0WrMTEiUMQAnJqh3Q6pgPs3JMRp6E7G4+MDZrScMPy6eUNK8P2ZyqDKpYuu8
         rbsHQ5wET9jo+kZWFy2cm8Pq02Yom9fRESGGUbHFSIMe+sxiaaYlTA9wvsWp6RzVCB
         B32bMaVyunBcS/kg0Kd0oqjqdGjXC8Xh5Jr5JLYU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68C4560213;
        Tue,  3 Sep 2019 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567513071;
        bh=Jyqh6v/xfVlSwmEkwf8QAjZcPeN2/S+JiZriC7u102Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Gb5VyOzemBV1LxovuoS8aGiwWeJLiItyZdgJblaq22vtAPQ7CuG+tqAz3ZMnVZ63F
         nPgGBnxzkJ4gcK0lF4iL3neOB1+lEYs1gTm5+eHQkOwdPOnuwdUz6+UQZIYyiME7Et
         BMbJ84U2PPfMGiwefdisRsr0V2hrbAVnxQkSFyvA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68C4560213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jano.vesely\@gmail.com" <jano.vesely@gmail.com>,
        "linux\@endlessm.com" <linux@endlessm.com>,
        "briannorris\@chromium.org" <briannorris@chromium.org>,
        "gojun077\@gmail.com" <gojun077@gmail.com>,
        "drake\@endlessm.com" <drake@endlessm.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "jian-hong\@endlessm.com" <jian-hong@endlessm.com>
Subject: Re: [PATCH rebased 0/2] rtw88: pci: interrupt routine improvement
References: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
        <871rwxr5xp.fsf@kamboji.qca.qualcomm.com>
        <F7CD281DE3E379468C6D07993EA72F84D18C5FE8@RTITMBSVM04.realtek.com.tw>
Date:   Tue, 03 Sep 2019 15:17:46 +0300
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18C5FE8@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Tue, 3 Sep 2019 11:55:56 +0000")
Message-ID: <87o901po9h.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> From: Kalle Valo [mailto:kvalo@codeaurora.org]
>> 
>> <yhchuang@realtek.com> writes:
>> 
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > This patch set includes two patches to improve PCI interrupt routine.
>> > One is to reduce HW IRQ time, the other is to enable MSI.
>> >
>> > The patches can be found at:
>> > https://patchwork.kernel.org/patch/11114043/
>> > https://patchwork.kernel.org/patch/11126007/
>> >
>> > They were rebased properly to resolve conflicts.
>> 
>> In the future, please use version markings ("v2", "v3" etc) in the
>> Subject and not something like "rebased". This makes my life easier as I
>> can immeaditely see what is the latest version I should take.
>> 
>
> Oh, I just combine two patches with different version markings.
> And I don't know how to write a proper subject in this case, maybe
> I shouldn't use cover latter?

The cover letter was helpful, please continue using that. IIRC the
separate patches were v3 and v4, so using v5 would have been clear for
me. But no need to resend because of this, just trying to streamline the
process and optimise my time :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
