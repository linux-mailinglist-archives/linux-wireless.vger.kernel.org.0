Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114982C641F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 12:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgK0LzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 06:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK0LzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 06:55:14 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4FC0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 03:55:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x16so97197ejj.7
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 03:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FKBTvTDTKQY4yiSQZjm4/5f3Ed4buFyJBrSHw7Dmmcc=;
        b=l/dqb2bBnqErG10czuFOu4vRDSFVWAQ/+5kkvXnhqxnMI+5sN3J8sSpTC1p535xwxk
         t8V1xuexvf+uOvMhg1Oze2MFpzpSg6whdrq1ZqPywweRn5auCOrTWeR8ejvatZibTPQ8
         6wy32MRCZY7eTw9dggYp8JsrnQvOiJbEAMSfcPCblZiwH4ZSTZ2fUbCZVMGMUGeT+DoI
         YU3xz07WkEqNI47tGBRAiQ95Ozq+87j5TLERfTHBW4nk4W34FVmNF/t3hgqGtHx/f+Ds
         rg2+StElHY4XIKq9K5fVs6V/oDutYMyTFpA5lCk8NHe0hDBOvJn4VsDXf6YUUfg6VXXJ
         t9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FKBTvTDTKQY4yiSQZjm4/5f3Ed4buFyJBrSHw7Dmmcc=;
        b=EzEv616vKrq9vMDgUy/tqDI43Qb0oX8e6vX7zceivBnU0IfpOJxeu8cn8fU5eVGBt9
         52pXPvQ65GHFV7fQwoZgORtCQ4RvupFMsPHkoynOxZv9UtYXp++0m3WqZ2/b063KFHh/
         ziMWIwMa1saP5cwCamITIyrNvmlki/Em/dU2PpoeL0XZqIZIrtT6+LpSIdjEzirPA41w
         WyCn/VjmJA98glyCtkBDpBd/YtpG6Ms8fuxOi/5m4VDRSUALXHwe+gRMdyDFww5pyxCx
         Ta8cYRgGD/DdzRoooYJnAaYM3zq3PEJohmctWRSsHYD38C5UMs6zDXugcg4ia+RbdJgw
         j4+Q==
X-Gm-Message-State: AOAM531/Zdl8kvqz/CVv30IMEtdS9Sax/5/bxVfgo1F09dE31nArgmjZ
        oDq0McoOqVK28hnKJOizhn2eOys/dv5g7w==
X-Google-Smtp-Source: ABdhPJy+vFUlQ7aku7+niwDmgzAFLuErxYaDt81S7L5KSrhOcSbnSuMpRgmDSN3gjizwyDTK5DXgYg==
X-Received: by 2002:a17:907:20dc:: with SMTP id qq28mr5371020ejb.403.1606478111245;
        Fri, 27 Nov 2020 03:55:11 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:a9d0:5753:89c8:13cf? (p200300ea8f232800a9d0575389c813cf.dip0.t-ipconnect.de. [2003:ea:8f23:2800:a9d0:5753:89c8:13cf])
        by smtp.googlemail.com with ESMTPSA id f13sm4648634ejf.42.2020.11.27.03.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 03:55:10 -0800 (PST)
Subject: Re: AX210 version 0024 not detected by iwlwifi
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linuxwifi <linuxwifi@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
 <ce7fab1d400a04eb31727546b99af0292a0d30f4.camel@intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9b5d4919-1c62-7438-3f50-18197a92a9cf@gmail.com>
Date:   Fri, 27 Nov 2020 12:55:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ce7fab1d400a04eb31727546b99af0292a0d30f4.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 23.11.2020 um 09:17 schrieb Coelho, Luciano:
> Hi Heiner,
> 
> On Sun, 2020-11-22 at 22:35 +0100, Heiner Kallweit wrote:
>> I have an AX210 card that isn't detected by iwlwifi.
>>
>> 01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
>>         Subsystem: Intel Corporation Device 0024
>>
>> Adding following entry seems to be sufficient.
>>
>>         {IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
>> +       {IWL_PCI_DEVICE(0x2725, 0x0024, iwlax210_2ax_cfg_ty_gf_a0)},
>>         {IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
>>
>> [  419.473140] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
>> [  419.486984] iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
>> [  419.487190] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 93.8.63.28
>> [  419.488828] iwlwifi 0000:01:00.0: loaded firmware version 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
>> [  419.533136] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
>>
>> Maybe there are more AX210 subversion id's to be added ..
>>
>> How about the api flags index warning? I saw it in several posts,
>> is there something to be fixed in the driver?
> 
> Good catch.  This indeed seems to be missing.  I'll add it and try to
> send it still for the 5.10-rc series, so it propagates asap.
> 
> --
> Cheers,
> Luca.
> 

I face another issue I hope you can help me with:
Frequently on system reboot the PCI device vanishes, it's not listed
by lspci any longer. This doesn't happen after a power-cycle.
Not sure whether device is in D3cold or whether it doesn't react
for another reason.

Rgds, Heiner
