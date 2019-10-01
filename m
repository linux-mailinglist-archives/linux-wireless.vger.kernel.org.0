Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCF9C3E4E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfJARNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 13:13:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34377 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfJARNl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 13:13:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id y35so10113658pgl.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AQENXz9W3lh6tp8zW2p3ipcz3DJsc45NsjiOFfnhUaM=;
        b=LtLBRh3au2KYlosRYEUIS/BLjCPifqRNJvzEEBjoueuyoSvPrzX+6ClaP7Tlybi3Bq
         vCP+DmjTQoFR4cOZpdWzGCwjjK+PrIPniBez+Pip1Cx/A0QfNH2y2DceTBpVlCVz5aWy
         DErC04jImUmW+FXm+FrMpt855FkvPH4d51LtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AQENXz9W3lh6tp8zW2p3ipcz3DJsc45NsjiOFfnhUaM=;
        b=eHZCeytNRaq2DCclco/Gy8M3QsNuXgco9A13JinjPoCjVk2kIly1NRxeGVnL6SzGkI
         tnSJ3Mf3CJVwX9GtbsamrEtkXod59NjiBsydHD11SW0hqGqlee122BFKXmfmuZ4lpr/Y
         xNXvHi+daesOo8H/pTu4YmKm2PYwtl3wG+AFafCzkYwuEOhcashEa93tgYmykNsPbX9X
         Bwhy/WqDG7j/XvZITgqGtTfD1xAoqJFIN7Nzo4OEzRbBbxswZZjP2F41uPlQpEvqi1EH
         bu/6TduV2KJLLMKSmIrk1kpRuMNzBPykyiMpbBR3jEu6zStbjqsLHeENZGbleE6OeSPc
         6BmQ==
X-Gm-Message-State: APjAAAVyK2Fwh49Pl8WCSnNFAKyJW1DMauw+AMLa5uBjF0qafX6IjTK4
        ZImI7ybBQZ4BXdsHXHPn7RivOQ==
X-Google-Smtp-Source: APXvYqwf0p5tJ29zKh4vSxVhDfuTNgdsfsk3N1ESFTW3/VZ0HnDwJmd6IwK0GPgB7wRx6rMfLlKsPQ==
X-Received: by 2002:a63:6988:: with SMTP id e130mr32071818pgc.203.1569950020378;
        Tue, 01 Oct 2019 10:13:40 -0700 (PDT)
Received: from [10.0.2.15] (c-98-234-217-115.hsd1.ca.comcast.net. [98.234.217.115])
        by smtp.gmail.com with ESMTPSA id y7sm16188954pfn.142.2019.10.01.10.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 10:13:39 -0700 (PDT)
Subject: Re: [PATCH 2/2] ath10k: switch to ieee80211_tx_dequeue_ni
To:     Kalle Valo <kvalo@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190617200140.6189-1-erik.stromdahl@gmail.com>
 <20190617200140.6189-2-erik.stromdahl@gmail.com>
 <87eezw660r.fsf@kamboji.qca.qualcomm.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <19f8023a-1943-9bf5-9a59-a7643f7692bf@eero.com>
Date:   Tue, 1 Oct 2019 10:13:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87eezw660r.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/1/19 4:48 AM, Kalle Valo wrote:
> Erik Stromdahl <erik.stromdahl@gmail.com> writes:
>
>> Since ath10k_mac_tx_push_txq() can be called from process context, we
>> must explicitly disable softirqs before the call into mac80211.
>>
>> By calling ieee80211_tx_dequeue_ni() instead of ieee80211_tx_dequeue()
>> we make sure softirqs are always disabled even in the case when
>> ath10k_mac_tx_push_txq() is called from process context.
>>
>> Calling ieee80211_tx_dequeue_ni() with softirq's already disabled
>> (e.g., from softirq context) should be safe as the local_bh_disable()
>> and local_bh_enable() functions (called from ieee80211_tx_dequeue_ni)
>> are fully reentrant.
>>
>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> I already applied this, but I still want to check _why_ you are changing
> this? Is it that you want to call ath10k_mac_tx_push_pending() from a
> workqueue in sdio.c in a future patch, or what? Because at the moment me
> and Johannes were not able to find where this is called in process
> context.
>
It seems Johannes wants to fix it in mac80211.

[PATCH v2] mac80211: keep BHs disabled while calling drv_tx_wake_queue()

Drivers typically expect this, as it's the case for almost all cases
where this is called (i.e. from the TX path). Also, the code in mac80211
itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
uses this_cpu_ptr() without additional protection.

