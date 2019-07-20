Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1B6F0D0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfGTVel (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 17:34:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38297 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGTVel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 17:34:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so2673153edo.5
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2019 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=urB8A5xDa5OE1ybq6qeJRm8B2yCV6pkJDVL4JYTo1LU=;
        b=E5pIsm6ntXAbEW72yMxB1tdGDGtexOYVkP2tP6hXfqwkZT77dHF+iCQCcKFWFjjMRu
         0JNCkVLlAv1QwCNF9wTbcRbL1FCOHU3uHqb8ndNr5F010/sLE646nxjQZgupf90oaQ6w
         jIkmqkhmGiiLbA4rYSqNLso6wro2a0UEzs1fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=urB8A5xDa5OE1ybq6qeJRm8B2yCV6pkJDVL4JYTo1LU=;
        b=ThH4HniebHWnT78PPKb1Ostc5QSqlDXVr71clB3v+gw8zzs6nChnxtPjbjv0XZv+5O
         ueHvTh8LcR4csjdiADqB/LG019RmVpjROrZkn539buGTyRMdmlwVR66uruU+LEpCmbYI
         4g6USkXJjYLCgGCXlbj5K9HoLyWgdc/MUgHzEwEnDDZ/BBx3PWU5B7R1/a4PV4py/zXt
         3xfwtBNgOioQIR+jkxciFBoEjDVTNZGyjV5WfVR50GxpceVaHPz18yLNnPAE3uQsyTxA
         dodg9fTlXfzdkFmSoEbzKC0/1dJnA19CHQScEBmBZNLqKoc5UBDiXplBdXdXSgfbTjRz
         FN3Q==
X-Gm-Message-State: APjAAAUXA4SKAD8jQpbg4N0phCfQoIf5y/i/5rRTjpZWSWHkZkX7iSwW
        Lw+w3ihhKgAwM4DliKum/3174Q==
X-Google-Smtp-Source: APXvYqzkQdHRsMLqwgS1jJxliX3REpC95TPASECUbAkiNsfkALYoIr6H8V7cl7qQiR+AuF7X0OrIRA==
X-Received: by 2002:a50:9947:: with SMTP id l7mr53679081edb.305.1563658479481;
        Sat, 20 Jul 2019 14:34:39 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id h15sm6960918ejj.49.2019.07.20.14.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 14:34:38 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Piotr Figiel <p.figiel@camlintechnologies.com>
CC:     <linux-wireless@vger.kernel.org>
Date:   Sat, 20 Jul 2019 23:34:37 +0200
Message-ID: <16c114eddc8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <b0cacc7a-22b2-82dd-f2e0-154abf1c9f69@milecki.pl>
References: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
 <20190430081142.GA27822@phoenix>
 <74b9f312-8c1a-daa8-6137-c664d37f06d1@broadcom.com>
 <b0cacc7a-22b2-82dd-f2e0-154abf1c9f69@milecki.pl>
User-Agent: AquaMail/1.20.0-1462 (build: 102100002)
Subject: Re: [PATCH] brcmfmac: change the order of things in brcmf_detach()
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On July 20, 2019 6:26:30 PM Rafał Miłecki <rafal@milecki.pl> wrote:

> On 30.04.2019 12:10, Arend Van Spriel wrote:
>> On 4/30/2019 10:11 AM, Piotr Figiel wrote:
>>> Hi Arend,
>>>
>>> On Mon, Apr 29, 2019 at 12:09:21PM +0200, Arend van Spriel wrote:
>>>> When brcmf_detach() from the bus layer upon rmmod we can no longer
>>>> communicate. Hence we will set the bus state to DOWN and cleanup
>>>> the event and protocol layer. The network interfaces need to be
>>>> deleted before brcmf_cfg80211_detach() because the latter does the
>>>> wiphy_unregister() which issues a warning if there are still network
>>>> devices linked to the wiphy instance.
>>>
>>> This seems to already happen - brcmf_cfg80211_detach() is called after the
>>> interfaces are removed.
>>
>> Right. This was just to remind me why brcmf_cfg80211_detach() must be 
>> called after removing the interfaces.
>>
>>>> This change solves a null pointer dereference issue which happened
>>>> upon issueing rmmod while there are packets queued in bus protocol
>>>> layer.
>>>>
>>>>
>>>> Reported-by: Rafał Miłecki <rafal@milecki.pl>
>>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>> ---
>>>> Hi Piotr,
>>>>
>>>>
>>>> While working on an issue with msgbuf protocol (used for PCIe devices)
>>>> your change 5cdb0ef6144f ("brcmfmac: fix NULL pointer derefence during
>>>> USB disconnect") conflicted. I suspect my reordering stuff in
>>>> brcmf_detach() also fixes your issue so could you retest this patch,
>>>> which basically reverts your change and applies my reordering, and see
>>>> whether my suspicion can be confirmed.
>>>
>>> Does the issue reported by Rafał you are trying to solve with this patch occur
>>> on current linux-next?
>>
>> Looking at you patch I suspect it does, because brcmf_proto_msgbuf_detach() 
>> is invoked in brcmf_proto_detach_post_delif(). However, I could not 
>> reproduce it with or without the patch.
>>
>> Rafał,
>>
>> Do you know whether your reported issue, ie. calling brcmf_tx_finalize() 
>> after interfaces were removed, still exists in wireless-testing (or 
>> linux-next).
>
> Sorry for a terribly late reply. It took me many attempts to crash a
> firmware in a fully reproducible way.
>
> I can say for sure this patch fixes crashes in brcmf_txfinalize() I saw
> when unloading brcmfmac after a crash.

Thanks, Rafał

There was no deadline so no need to feel sorry.

Regards,
Arend


