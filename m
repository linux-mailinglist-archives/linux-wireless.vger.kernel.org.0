Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39181DEDF7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgEVRPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVRPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 13:15:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98060C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 10:15:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b3so9866768oib.13
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckgg64SC7fdaahBmYEinAAOpnv23m7eSUns6AU0ttpM=;
        b=WV++N2+NBkx939H4jCUnBjEIa5vqsfMYuYB9/gNv32VZ01Vt1N4KUaqF8YeMW+S1B6
         ML8n9WN17S5sY970pKC9/Smncy1NGrEAV+GdSRlaybfdHyHAnSLOigLVTKbMmz7JRYYc
         psgyf9xT4D2PdYq0m0wXX2N0HwGA5xNBSrmu4Yp3Gsi19NXEysm2FG0iGaOsrEDMkJ+9
         96NbUqdPqbykiEKhJmc396bcP5SCgwly7PBrNOQh9zANC2V0teZVaDEFrpxRXz0+4Ye0
         LzgcuR5UIPDEjQPgf48bl85nX0fDh6wypvtbi3jkeKT87uc+01LHqZwYPv+xPL9OdWP5
         5Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckgg64SC7fdaahBmYEinAAOpnv23m7eSUns6AU0ttpM=;
        b=FDXvNKxvkgnJwqWUdT98/yDU8GyQscoYEOrAsMu72yhACbP3TL61YU55Ii0zjXsP4f
         ElaPSfOpq54DKLxRUJ6ip2ErJmcYaTW499bEU2Ijj0zfJHw9e5lNToZKJukzZX86F96O
         qRZ2JdslsI0TJX1g5sT/4BXZjrH2PR1YkUgsHtU6IJ3EH7JWdpTCQOqF+VO/hQ82k1wQ
         kUmpM62eq5A3CnovtHyY8QEAuXt6V2Iq9yRvWB+jBFrf2/RoGEHCqDbyJDxRFAJKP6Bd
         TJWPoTW0Mv7w8r+gQeYRSxWyCpgtnvgToOlIh9Ivr5HUtL3s+d8LJqeB0S5WINnxtuus
         fn8w==
X-Gm-Message-State: AOAM531a1n6F7FhA4Xa5GlgmBXd9ydJ52QofZy6+1aeSP06OFoXe0J3W
        QVNxjWFmdJvEXez4I2XidUZXYjtl
X-Google-Smtp-Source: ABdhPJxcM6bXLt737eva3Gj24e82sS+5h+WaUPfDEvgAJ/BEkVNj9TGuK+NG3G0OJOBNl2tJgxqJ9g==
X-Received: by 2002:aca:d609:: with SMTP id n9mr3372266oig.77.1590167702013;
        Fri, 22 May 2020 10:15:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z12sm2707473oor.0.2020.05.22.10.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 10:15:01 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum>
 <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum>
 <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
 <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net>
 <20200522121910.254aefc1@wiggum> <87a720gpfb.fsf@tynnyri.adurom.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <842ae4a0-5aa5-a464-3218-8955a3ee445a@lwfinger.net>
Date:   Fri, 22 May 2020 12:15:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87a720gpfb.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/22/20 6:49 AM, Kalle Valo wrote:
> 
> And did the "bad" performance even have any real visible changes to the
> user? IMHO this "bad" performance is small price to pay from getting
> WPA3 supported out-of-box, especially when the data throughput is
> unaffected.

Kalle,

The only bad effect is to consume 2-3 times more CPU than used if the firmware 
handles encryption. On a modern system, the effect is negligible; however, these 
cards are found only on older systems that have uni-processors.

I have reread the mac80211 documentation (comments in code at least), and it 
appears that it should be possible to set MFP_CAPABLE unconditionally, and use 
the set_key() callback to let mac80211 know if the driver/firmware will handle 
encryption. The module parameter could be removed; however, I favor leaving it 
in case of broken hardware.

@Rui: I will send you a new patch for testing.

Larry


