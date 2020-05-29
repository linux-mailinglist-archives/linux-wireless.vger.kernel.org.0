Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100BE1E84A6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE2RUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:20:17 -0400
Received: from mail.as201155.net ([185.84.6.188]:43530 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RUR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:20:17 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:52504 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jeify-0006qE-2Y; Fri, 29 May 2020 19:20:13 +0200
X-CTCH-RefID: str=0001.0A782F25.5ED143C9.00A9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=+sfk/qw/yE7gEzFHqbV4TA0D0rPny+zSVyE+eBhnsaQ=;
        b=Nc6soMT435j/2GUQH2Typ7FTjQs233CSRoFtFPU1Ohnl3B8UenDRJ6S+BkwoGsQuTxylvUn1Bx99uQ+uQXiRI6VLkFxZ+7SMk2Ra1Xulc009RQDbfXfkymhc9VjcAnuc9//4I/6E9ej179v9qNUWoO1o+3YQ/qj9JD6pzuJ//OA=;
Subject: Re: [PATCH] ath10k: Avoid override CE5 configuration for QCA99X0
 chipsets
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <1587649759-14381-1-git-send-email-mkenna@codeaurora.org>
 <20200505073422.BFA51C433BA@smtp.codeaurora.org>
 <63ec6f30-ee3b-c412-7c56-46d447b17c8e@dd-wrt.com>
 <87ftbisqgf.fsf@codeaurora.org>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <e105f898-85c0-b4e6-43e3-0d20d7a9590d@dd-wrt.com>
Date:   Fri, 29 May 2020 19:18:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <87ftbisqgf.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [212.111.244.53] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jeiaa-0004Kz-5E; Fri, 29 May 2020 19:14:36 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

will check it

Am 29.05.2020 um 17:36 schrieb Kalle Valo:
> Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:
>
>> Am 05.05.2020 um 09:34 schrieb Kalle Valo:
>>
>>> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
>>>
>>>> As the exisiting CE configurations are defined in global, there
>>>> are the chances of QCA99X0 family chipsets CE configurations
>>>> are getting changed by the ath10k_pci_override_ce_config()
>>>> function.
>>>>
>>>> The override will be hit and CE5 configurations will be changed,
>>>> when the user bring up the QCA99X0 chipsets along with QCA6174
>>>> or QCA9377 chipset. (Bring up QCA99X0 family chipsets after
>>>> QCA6174 or QCA9377).
>>>>
>>>> Hence, fixing this issue by moving the global CE configuration
>>>> to radio specific CE configuration.
>>>>
>>>> Tested hardware: QCA9888 & QCA6174
>>>> Tested firmware: 10.4-3.10-00047 & WLAN.RM.4.4.1.c3-00058
>>>>
>>>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>> Patch applied to ath-next branch of ath.git, thanks.
>>>
>>> 521fc37be3d8 ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
>> this patch will crash on ipq4019 devices. i reverted it and it worked again
> Yeah, that patch is buggy but this should fix it:
>
> commit 32221df6765b3773ff1af37c77f8531ebc48f246
> Author:     Arnd Bergmann <arnd@arndb.de>
> AuthorDate: Sat May 9 14:06:33 2020 +0200
> Commit:     Kalle Valo <kvalo@codeaurora.org>
> CommitDate: Tue May 12 10:33:13 2020 +0300
>
>      ath10k: fix ath10k_pci struct layout
>
