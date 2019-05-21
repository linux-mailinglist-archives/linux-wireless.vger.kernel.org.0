Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBB249E5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2019 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEUILe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 May 2019 04:11:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33796 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfEUILd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 May 2019 04:11:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so8075140plz.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2019 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=seG9nkQSqs8RhZuvy16Lfz590I3pgtHI3E7ZJ7O1oS4=;
        b=axNqkDqBEkqOMiqvkILmD8H7xVgy/yxds+U6jMpqoyfzdLG/rwofCIkPqUuMQdxacR
         Q5Fz2SzCkRczK8YfaLqUUcCWeB2jiKxreM3rezGEF+2EBr6u690bTbC6UapRNBUbxGEU
         SB7hz3Ih8eUkmKBbq1IT07rrvkf83XY12Ot1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=seG9nkQSqs8RhZuvy16Lfz590I3pgtHI3E7ZJ7O1oS4=;
        b=KBsWViOv+Mt62+Q60622jZcwhW/Ux1nigk9LT/TrwpU7f2dIzxkeo7ukiITNp6Mt5w
         vMcoaofHfDWuPIGMAXEDD1Y9I3j0zvBMohFNRJZ9ckEFTUQJsVpY0HVXGEUxg9IS4N6+
         xxjmuIB5AwsgOjyl6WCPyArFehXsrMoXSjk4eGkX51aGQ5Q/v3LTgpfpuARKlY4StLiP
         svvL1jPT7H9XiE21VPY59Y2+EAd1OtaDvs4Yt6W/NIA9+gxfviRAIrF9pJZk/UyOmKwq
         XUU0LWx47C5M2I5Ze5drMckEj2DryChxKgYc562mPirgaBS4EP6mEzKdFMu9y7ieovhN
         2Hmw==
X-Gm-Message-State: APjAAAXrF7kH2kevtdhOGCxs2J5bcwc9zaXe7l1a4okMBUVRWC3jrHES
        sKQ/eq/6Rl1aMW5+nQwaVTuuooa3lrYRVm1Ep8XJUN1fru5sn9yNIV9Vt1dBqgGxSz6yMmGBWfd
        1Ol7vK7uufyenivrG6CfKnRse4Vm6724OWiLtCuE2WYnHXH1UibfoCoyPIKJ64FOm0UmSBO1Xh6
        7KTba4t7vv/C0Exg==
X-Google-Smtp-Source: APXvYqwc+e5LsnNpHPJjD1/qzsKQuz6hwdw7dR66MWxYMtjsdNeCdCypFY1mYpyWfd9u5iBzgGDIvg==
X-Received: by 2002:a17:902:3383:: with SMTP id b3mr35209830plc.193.1558426292671;
        Tue, 21 May 2019 01:11:32 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id f22sm20724092pgl.25.2019.05.21.01.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:11:31 -0700 (PDT)
Subject: Re: [PATCH 1/7] brcm80211: switch common header files to using SPDX
 license identifier
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
 <3dcbfbab-a1f0-bdc6-909a-d9ed225e060a@broadcom.com>
 <f35219bc-88c2-cc8d-530e-516fb7a4ce80@broadcom.com>
 <87mujhoymm.fsf@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <f4d582e8-3d65-959f-78bd-88b7c47131a5@broadcom.com>
Date:   Tue, 21 May 2019 10:11:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87mujhoymm.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/20/2019 6:54 PM, Kalle Valo wrote:
> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
> 
>> On 5/16/2019 10:57 PM, Arend Van Spriel wrote:
>>> On 5/16/2019 2:04 PM, Arend van Spriel wrote:
>>>> With ISC license text in place under the LICENSES folder switch
>>>> to using the SPDX license identifier to refer to the ISC license.
>>>
>>> Hi Kalle,
>>>
>>> Given the feedback on checkpatch (or spdxcheck) failures let me
>>> respin this series.
>>
>> Actually let's *NOT* respin and leave this series as is and ignore the
>> warning for the header files as Thomas wrote in his response: " So we
>> can fixup the documentation and allow // style for headers as well.".
> 
> What about patch 3, should I drop that patch? Wasn't the conclusion that
> you need separately change led.c?

Okay. Let's do that. Or do you want me to resend the whole series 
without patch 3?

Regards,
Arend
