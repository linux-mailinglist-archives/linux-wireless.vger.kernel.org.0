Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EF41F2EE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbhJARUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354719AbhJARUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 13:20:23 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D5C06177D
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 10:18:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so12377384ota.6
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vp6zPzIO3u4VKL5ysfqttOaOZ6ty7expoQX1fDvrE0Q=;
        b=dWg9XKuktA0U+1xtgau5LbOsS5YV3oJmNHGQSc/wAvD389JHR8BPIEPmbnE4ra/qgl
         YZhYfKZVPJN4deKaKcwg7/MxkoSsbl2VVOL5fFaP2ZfvnE6W/he9xvfnlH9bM5amyIVK
         2Vk0ve6hlNuTAsH0xwI2+F31uCfa7rAmSJAYsl/N/OOMkA/zinWr1ZbLeocHrVIPrcQD
         5NHGaLyinnGHV2CL52sDFgB+KxSw4GEL+FtuyEu3Hcu4XRiGmup/x3waKB7dVDgZSmFd
         7lhmnL6PxuI+jWAaHsSYXyP10JJl3G5FvfkPc6HL8mFILvFRbYHeOmtohItnr69DqNNi
         08ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vp6zPzIO3u4VKL5ysfqttOaOZ6ty7expoQX1fDvrE0Q=;
        b=bL0lnMVpa6/Hhrn95ZZFePepMgz7n1QPFvxcE2d1XEZPzuGoivBaAXd7xLYvmJvQ4d
         eAv789SXwDgGGFQJYyvfgNqeNnf7ctgIpheUKtscbldawtTmGXnpqWDd8PON/eWtTeoR
         kw0EIGm0fR15ORoBfs4op4NaF39yx2rXUoSgup88K5QOTmI1ioQhjet6Q2wzR/5bvxx6
         ydH36F9MlV3bix91AzxGMeCHMbbNbBeAxzgVzxWzG81pVd8myFxI+n6VwICNSyV1/ysg
         NrMEtIWhzThZCE/GBBhSp3m0S0jF4tlwuhw026lekBAofPz5BvO+BdWr2uH+93SA+7FA
         gAiA==
X-Gm-Message-State: AOAM533cpySEzvNNFsKnoUX4zBt97sWhic5KqA9rg2H01rMWeAU6Y+vM
        cXnZSZERqL9hoKsDWh5WCwto0n7Y2LE=
X-Google-Smtp-Source: ABdhPJw5hc9X4fnxnftjmxEcjTMyHW2NAxHahLVPKcbwRBZlbZAHF62OOFv0fOqHpOaU8wprCD8P8w==
X-Received: by 2002:a05:6830:1da6:: with SMTP id z6mr11544051oti.234.1633108718894;
        Fri, 01 Oct 2021 10:18:38 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1014? (2603-8090-2005-39b3-0000-0000-0000-1014.res6.spectrum.com. [2603:8090:2005:39b3::1014])
        by smtp.gmail.com with ESMTPSA id s10sm1227360oib.58.2021.10.01.10.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 10:18:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <482cc641-7ba1-7d7a-f2eb-5d39aea9a5cd@lwfinger.net>
Date:   Fri, 1 Oct 2021 12:18:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20210820043538.12424-1-pkshih@realtek.com>
 <8735pkiu0t.fsf@codeaurora.org>
 <7df9058b-4983-6d0e-07f7-8fe4df1cff27@lwfinger.net>
 <87y27chev0.fsf@codeaurora.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87y27chev0.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/1/21 11:46, Kalle Valo wrote:
> 
> Nice, so I can assume there are quite a few users for this driver
> already?
> 

Yes. I do not know how many times the repo has been cloned or how many people 
are using it, but GitHub reports 31 forks of the driver, and 252 star ratings. 
The numbers are roughly comparable with those for my rtw88 repo.

Larry


