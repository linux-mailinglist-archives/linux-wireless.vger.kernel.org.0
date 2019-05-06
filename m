Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001C4149D9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfEFMfK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 08:35:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMfJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 08:35:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 726FD60A00; Mon,  6 May 2019 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557146108;
        bh=Sl1Jad6J9aoFlZ5p3cIAH0XrZsM7leN/gWNTry1oNl0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kupzxsCMPJz1OH2Jm/fvkw9sC3uslA3KRNjKpLbGielzd56tqLfDPQ9SduNqgnwlI
         QepGhTQqp4IVTx13C1xAu+SDDZy3oJ9nohw4MYeRBbmCfbdIzN2VWbeMXvf1PkGqAN
         RbDFV9BLIbH+oIC86SsiL5SGabG/cUqGLi+UMjhk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-75-57-nat.elisa-mobile.fi [85.76.75.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 405B560A05;
        Mon,  6 May 2019 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557146107;
        bh=Sl1Jad6J9aoFlZ5p3cIAH0XrZsM7leN/gWNTry1oNl0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LQEN6T6ejOd98MpjGhQHprdRlBftPBHporEqGxDCWujiGfhsFlXF3K6fh3ttsMECQ
         D03UVVbjBAjRNmcB9qWRjy9mAGvPpsKp8WUBDWAuV4nGn0+fa0GEt1dIcIoplwjcfP
         8hyGh2/EVfW20F5yFTkASNDkkO3KfUTNcckxOvbE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 405B560A05
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
References: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
        <1556884415-23474-5-git-send-email-yhchuang@realtek.com>
        <874l68vuhi.fsf@purkki.adurom.net>
        <F7CD281DE3E379468C6D07993EA72F84D17EB4C9@RTITMBSVM04.realtek.com.tw>
Date:   Mon, 06 May 2019 15:35:03 +0300
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D17EB4C9@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Mon, 6 May 2019 08:54:14 +0000")
Message-ID: <874l67vk08.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo [mailto:kvalo@codeaurora.org]
>> Sent: Monday, May 06, 2019 4:49 PM
>> To: Tony Chuang
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
>> 
>> <yhchuang@realtek.com> writes:
>> 
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > The new rssi_level should be stored in si, otherwise the rssi_level will
>> > never be updated and get a wrong RA mask, which is calculated by the
>> > rssi level
>> >
>> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> 
>> Stanislaw suggested that this should go to 5.2. So what breaks from
>> user's point of view if this is not applied?
>> 
>
> If the rssi level remains unchanged, then we could choose wrong ra_mask.
> And some *bad rates* we be chosen by firmware.
> The most hurtful scene would be *noisy environment* such as office, or public.
> The latency would be high and overall throughput would be only half.
> (This was tested, such as 4x Mbps -> 1x Mbps)

Yeah, then this is definitely suitable for 5.2. Could you please resend
the patch and mention the symtomps in the commit log? And mark the patch
as "[PATCH 5.2 v3]" so that I can easily see it's for v5.2, please.

-- 
Kalle Valo
