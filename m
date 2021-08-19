Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C233F1D1F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhHSPoS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbhHSPoS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:44:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B8C061575;
        Thu, 19 Aug 2021 08:43:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gt38so13720352ejc.13;
        Thu, 19 Aug 2021 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=8ijfvDsyns8e3FukmUhdkOQH6x/qKdqiPKSWYcH8vCQ=;
        b=uRArM1418rKa3Ik+eFB00LsUjzkgm36oxmEK4qhRf18YDCMT0Yj6uO3UdWZMesM+k5
         AgOYoyXhbXJTRAmslaoytrJCNtewyodI71iH0yElf4j1MW+XwUA9JmeVzuLbAEy7Xy+2
         Gs348JTcM7BsyEpsYPXGnaddijcdXuj3faxT1tn7xuJfTjb+jrlUrk83fLLHrDeg//g9
         1awXgQnvbxRweafyGXmBs74HlGyONGnTFaWxw1VrHYofTm8FlZnTLWxctuDjFkT0RRDZ
         Y6jFT0rbYNKG85a+fsoAAwduXw6sezPAWF87SA2Htv/PrsJlWx8L1R8T27PHKp8XQIuM
         E76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=8ijfvDsyns8e3FukmUhdkOQH6x/qKdqiPKSWYcH8vCQ=;
        b=M73wMzZYV93QxSQdYXjdJV/ZpMIHzFSEEbLOyV8ETJXADAB/Ms4R34HfKB87Yv/qLn
         ZjI1qBEb+BwsiITVOkVvwdEqqsblGohrdOHG+uKm1QZdam5euVjyngTHg+/hKC+gkKTe
         /oF2dOXMrSGH9T4HYSs8iL8u/8Tb2jfVPUuLxF4qPExj1uOM9G1CWPriUJDnpbiXWCwX
         X40ZrEqKuf06z30hc7iYOkqZrcss/gNN2AVdlmSR8+kgtkx1jssPAEPa/GVmw6FhONwD
         XPmQDNCBNjhVeP32cmOo9I1GHiKArBa8dJv1vEWAUcyE0zvooNdmYP9+UTOmPhqEQiJV
         uR1A==
X-Gm-Message-State: AOAM531O45dz3qXtXL30co5mrQX11lWQZ3msd5FV1JuePKA2po1QRJG9
        0VFesw8iumBrZYznm2uNdIw=
X-Google-Smtp-Source: ABdhPJzYk8WPSyVPDcVziWsVFYS9DWtlTlJXLGKJAGueSaNlhcVXrqy9s/u14lPIBO4YpR6WKQHbJw==
X-Received: by 2002:a17:906:f910:: with SMTP id lc16mr16206536ejb.478.1629387820145;
        Thu, 19 Aug 2021 08:43:40 -0700 (PDT)
Received: from [10.230.42.144] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id v13sm1428864ejh.62.2021.08.19.08.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 08:43:39 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     Angus Ainslie <angus@akkea.ca>, <kernel@puri.sm>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-bluetooth@vger.kernel.org>
Date:   Thu, 19 Aug 2021 17:43:38 +0200
Message-ID: <17b5f150410.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <5766C95B-D5A4-463C-A87F-41B35BF82046@holtmann.org>
References: <20210812165218.2508258-1-angus@akkea.ca>
 <20210812165218.2508258-3-angus@akkea.ca>
 <1cd0e008-9239-f430-7294-865d34795a2f@broadcom.com>
 <5766C95B-D5A4-463C-A87F-41B35BF82046@holtmann.org>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: [PATCH v3 2/2] btbcm: add patch ram for bluetooth
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 19, 2021 5:26:42 PM Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Arend,
>
>>> Bluetooth on the BCM43752 needs a patchram file to function correctly.
>>> Signed-off-by: Angus Ainslie <angus@akkea.ca>
>>> ---
>>> drivers/bluetooth/btbcm.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>> index e5d706ed55ea..e4182acee488 100644
>>> --- a/drivers/bluetooth/btbcm.c
>>> +++ b/drivers/bluetooth/btbcm.c
>>> @@ -387,6 +387,7 @@ struct bcm_subver_table {
>>> };
>>> static const struct bcm_subver_table bcm_uart_subver_table[] = {
>>> + { 0x1111, "BCM4362A2" }, /* 000.017.017 */
>>
>> Noticed Marcel applied this one already, but as I asked in earlier patch I 
>> would like to know why the commit message says 43752 but this entry says 
>> 4362? Still confused.
>
> seems I missed that part. Can you look internally what this hardware is and 
> we fix it?

I will check although not internally as this is probably a Cypress chipset. 
Anyway, I will follow up on this.

Regards,
Arend



