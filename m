Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465D62D0AF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE1Uta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 16:49:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41032 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfE1Ut3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 16:49:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id y10so195921oia.8
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4yG8BTa1wVJfKPiNZj2mHtMsKyDLUpUqpKd1yYCLJug=;
        b=rTPOMrSvHqudl1d9AEhoup/hSDe0xq/c9J1xzmZ6odUCn5ZrfZqT+E1xq4HyLttkJc
         hMUt8QTpS2q8qrq9gA4QimBLVvO3zwhiRKwOaxuToXiFZUpAoi2n3sfBZzZKemwdZMp3
         zKl9HjPfWVwPI7HPuRHV+OCsP5IrUiALLHCD9/0qUKQ+70bEO4iF2USf+6krnKSWuH8z
         ofK+UnmEUlMAgFdFIA0bt1ADYwTl0NEEWB67/SZL2pvQbfZHwimmqabtrzQ8DKc/NbMl
         tPFhK+/KGVZqJnhLo8yhgTLhFZHLOuCZez03ZCS7Uqd8KiZxw0BBz7iP1kTm6gOHpFV9
         uCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4yG8BTa1wVJfKPiNZj2mHtMsKyDLUpUqpKd1yYCLJug=;
        b=NzXM77//dHfdxfrwO7MWrFp7uZtfhaDzo/7wmqihtzIo1Hcsf2y53foapGOTp+xOj9
         Vp1ggSIL9SywBJWCkhP5UyiciCsid+d9Qu7PtPzCEWpMyVOJUBsDUWLbovwR8gpO1dCl
         ybH/MMqdxB5SAr3aSLdHzfgmtgBh4yjPSjAqoyZHHEufJbXZ1Z4MTyziLEhNMqWgLSpR
         g9K8BnKXJZC5s16suyfazZjO589t/mVefLQAGbS/1LN+ZAJpoc7RAI++C+qL+Crs7e1/
         l1VUuTno5ThoUJ+SY5dh1fiRxeZwHFNLG4jYn4BHg8hWGI5pCsOiMTGW5Te2fYosnMyB
         TJnA==
X-Gm-Message-State: APjAAAV2gY5ffr0YVbvml907IB5AuujjlQXe+JjOn0E5DezGHu6KNyOI
        mo1+KAK/9GB62Cx/tbzUZ/0wE7/1
X-Google-Smtp-Source: APXvYqwPYoD2R6kk2nsdoJF59VJ3aQUBhUBOmaNG+ycAw4+Eoe4PICp0rrJtTk2eDLex0DZYPWdODg==
X-Received: by 2002:aca:c711:: with SMTP id x17mr364546oif.174.1559076569194;
        Tue, 28 May 2019 13:49:29 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f137sm1992416oib.27.2019.05.28.13.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 13:49:28 -0700 (PDT)
Subject: Re: brcmfmac & DEL_INTERFACE
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <089d2d0a-a802-3c2b-4993-e17326028d1f@gmail.com>
 <5679a6a1-e4a1-1f55-5b6d-21b178201078@broadcom.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <134f3c7f-5268-02bb-609b-ffbd48e78209@gmail.com>
Date:   Tue, 28 May 2019 15:49:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5679a6a1-e4a1-1f55-5b6d-21b178201078@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On 05/28/2019 03:27 PM, Arend Van Spriel wrote:
> On 5/28/2019 8:16 PM, Denis Kenzior wrote:
>> Hi Arend,
>>
>> We noticed that brcmfmac doesn't support .del_virtual_intf for 
>> non-p2p/ap interface types.  Any chance this can be added?
>>
>> We currently remove all wifi interfaces and re-create the needed ones 
>> with SOCKET_OWNER set, and it would be nice if we didn't need to treat 
>> brcmfmac specially.
> 
> This came up recently. During probe the driver creates a network 
> interface that we refer to as primary interface. We consider this 
> non-virtual and ownership is with the driver. My guess is that this 
> concept comes from the WEXT era, where we did not have the ieee80211 phy 
> objects to interact with the driver from user-space. I suppose you don't 
> mind the creation of this interface and just want to allow removing it, 
> right?

Correct.  If we can at least get the DEL_INTERFACE supported, that would 
solve our immediate use case.

I do think that the drivers should not be creating a netdev by default 
and should wait until userspace asks for it.  But that is a separate 
topic, with backwards compatibility concerns, so I'll leave it for the 
future :)

Regards,
-Denis
