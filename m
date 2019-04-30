Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EBF3C2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfD3KKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 06:10:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39467 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3KKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 06:10:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id x204so5441827ywg.6
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2019 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1gHdn0Co5oNIchJTUkvgYYqJ8AdRsWz7PLBE4Lnx2WM=;
        b=X+Mrb4dimilB7jhANlrhaA1dkeXiJFgpxtdl4yX0gSXqdtw/2EjWyl8NGrUQAozc6O
         J3TKcYWAt71sEL+DMaKw1VpejVEbPI6Ak+xmsAHgPYxzbwciWn64wOcH/xeCUhlyc+bQ
         IqFcOznu/iD22oe+h0R3+nzXT9JLdv+i8JzzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1gHdn0Co5oNIchJTUkvgYYqJ8AdRsWz7PLBE4Lnx2WM=;
        b=NYBgvHAKubqYIece5qmzvoPI/0I7dor5uG6LTnT6wQMcgPyChElliiwW6E5PlxAQEb
         n1GlKT/rpyQEsIKvNGA5ucgTe1RMyURik5Lw7zoRenpWHk8TAyNsZqkXFU+RCXvm39ZI
         rKhQSluj4tna5SPnGGeak2cqUqThzUALOWVYN+b78oRcRPYObRr2GPZlbZCt0aRlnT9P
         KIrqjwgmvb6rWk7qTH4HHQnJ9YwjU+6G7J4eWBu/3r/Hm8OreAcTWt7REKJU942ugL29
         m9xg/WZuOAJlS3iAK4p553fvolnwVEi+cY7dnH1N23+RDw3iex7K+x1kI8eEDzMCrBJl
         ydGA==
X-Gm-Message-State: APjAAAVZ96hIiToYZOBO5Z7Cq439DbIbJ4Ssv5nLDcskMF1xaXzMnr59
        vEN4EydxjGTj7hWfVCx1CSkkJsXVyXdP0c+6vdqDG//0zmvNbW3BAE1vBF4VYhU5f7AfCE9fB6f
        YIwBZqfla/O5I7AOkq91BlmUeV2Lt6X4sXWHjHGtSr2FlaUOouKuu19fADaqXR6cNGMXcleGjw/
        vEwZfqc9bu+oIWQA==
X-Google-Smtp-Source: APXvYqygJQVBwmr5ItIjOeak/LQem/dg3hI3nAFyEJKwyrKmXeqvgY7WzC++B07UPBcXKyS3Up1flg==
X-Received: by 2002:a81:a651:: with SMTP id d78mr14073840ywh.169.1556619029094;
        Tue, 30 Apr 2019 03:10:29 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id a4sm12256246ywa.7.2019.04.30.03.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 03:10:28 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: change the order of things in brcmf_detach()
To:     Piotr Figiel <p.figiel@camlintechnologies.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
 <20190430081142.GA27822@phoenix>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <74b9f312-8c1a-daa8-6137-c664d37f06d1@broadcom.com>
Date:   Tue, 30 Apr 2019 12:10:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430081142.GA27822@phoenix>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 4/30/2019 10:11 AM, Piotr Figiel wrote:
> Hi Arend,
> 
> On Mon, Apr 29, 2019 at 12:09:21PM +0200, Arend van Spriel wrote:
>> When brcmf_detach() from the bus layer upon rmmod we can no longer
>> communicate. Hence we will set the bus state to DOWN and cleanup
>> the event and protocol layer. The network interfaces need to be
>> deleted before brcmf_cfg80211_detach() because the latter does the
>> wiphy_unregister() which issues a warning if there are still network
>> devices linked to the wiphy instance.
> 
> This seems to already happen - brcmf_cfg80211_detach() is called after the
> interfaces are removed.

Right. This was just to remind me why brcmf_cfg80211_detach() must be 
called after removing the interfaces.

>> This change solves a null pointer dereference issue which happened
>> upon issueing rmmod while there are packets queued in bus protocol
>> layer.
>>
>> Reported-by: Rafał Miłecki <rafal@milecki.pl>
>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> Hi Piotr,
>>
>> While working on an issue with msgbuf protocol (used for PCIe devices)
>> your change 5cdb0ef6144f ("brcmfmac: fix NULL pointer derefence during
>> USB disconnect") conflicted. I suspect my reordering stuff in
>> brcmf_detach() also fixes your issue so could you retest this patch,
>> which basically reverts your change and applies my reordering, and see
>> whether my suspicion can be confirmed.
> 
> Does the issue reported by Rafał you are trying to solve with this patch occur
> on current linux-next?

Looking at you patch I suspect it does, because 
brcmf_proto_msgbuf_detach() is invoked in 
brcmf_proto_detach_post_delif(). However, I could not reproduce it with 
or without the patch.

Rafał,

Do you know whether your reported issue, ie. calling brcmf_tx_finalize() 
after interfaces were removed, still exists in wireless-testing (or 
linux-next).

Regards,
Arend



