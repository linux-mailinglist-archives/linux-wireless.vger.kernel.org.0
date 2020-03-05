Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5983C17A6DA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCEN5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 08:57:42 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33352 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCEN5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 08:57:42 -0500
Received: by mail-wr1-f49.google.com with SMTP id x7so7157841wrr.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2020 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=F+r0wTvmPFxz4yHrWQPROI0nReD205HCjjqgusQeKxo=;
        b=MDxSg9cEHpfqDTQnA91aApBNwE3vJ2gj6FZE42UytrraTYt1psuxEUimZbs7zbMHCh
         pG2lsw192cvpLc056JLFuaFHO2RhA45fyeYvOGE8l/nGEgXnyPWONHUQozU+SYniXryy
         tfHaGLp6Uf8aGlzTxUY28FSP7wLLW2wHMaPo5oiSH3Y6mXlHnJ58AbWlsaIiPrTG8sK/
         onj0wHYWI07uWkVgTYw9Dq0WV6zPHEoSKBcZsywMvAo9lR4H/P2GyLg9Ah539tlswJP8
         a8uCvNZVtFfFMd638BCfekDO1I5PkR5PIg8LGh2v6R/ttENn1PGbtypNfiBSBLOdyNKK
         2Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F+r0wTvmPFxz4yHrWQPROI0nReD205HCjjqgusQeKxo=;
        b=sOCB9NtPp0VcKE5Msp1g7ZzwuSxoFE8oYqz+/kZSohXwhLSOB5FV6CUMw6iNz+KN/j
         xjDLzeTYMPXN0EaSL2I4rya1Nrou/3d50VaYLt4zcYv4CMzxt+azp/D0R/0NTle/uFHv
         qJyrSgdU2jt13mCyW7jSffYFr4BVAWt3pmMt5kUxSz3DkiN1y0Bhpbb0ax1fOxpbZNJA
         NHZu/6Bpg12/GLVpZVRZ/svzcJffpfJOa6vfv3Uqve8WuYOgKjFQRYzQZON1VRfBsFY4
         3eJaBPjkhNqd9wk5j0IFWK0yZv1X/pu4FthQlUCMyl49ziqC7+4N51vLllesHPt2FzFK
         lxgg==
X-Gm-Message-State: ANhLgQ0yBHjJs6G+dWjIC9nAAeRehzCDqc/+YdWIPySX7rOEKCZOKDSE
        WsIZ5ivzvIE3xD4/z1YaeB0o1sWdNCRO7A==
X-Google-Smtp-Source: ADFU+vvOWNxU6HsxdedlG47P0kKdKegx2LLR86hwGXHe+h22OfHcmPFL+MtwCGTeUIC+wQaNI9ukhQ==
X-Received: by 2002:a05:6000:4a:: with SMTP id k10mr9925942wrx.381.1583416660434;
        Thu, 05 Mar 2020 05:57:40 -0800 (PST)
Received: from ?IPv6:2a02:1811:e422:ad00:5027:3352:e346:d5f0? (ptr-eiyd620mf51u7z4p88g.18120a2.ip6.access.telenet.be. [2a02:1811:e422:ad00:5027:3352:e346:d5f0])
        by smtp.gmail.com with ESMTPSA id c14sm30803621wro.36.2020.03.05.05.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 05:57:39 -0800 (PST)
Subject: Re: Precise time synchronization via wifi interface (intel AX201
 iwlwifi driver)
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org, linuxwifi@intel.com
References: <032f07e2-2771-619b-52b4-a25c8cd10f86@gmail.com>
 <87r1y72g60.fsf@toke.dk>
From:   Wei Liu <wei.liu1011@gmail.com>
Message-ID: <627ba0df-e4c6-7fe6-0d1a-e3d77d35c564@gmail.com>
Date:   Thu, 5 Mar 2020 14:57:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87r1y72g60.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Toke,

Yes, it is challenging, but IEEE802.1AS already takes consideration of 
IEEE802.11 MAC. So I count on the standardization to take care of the 
challenge :)

Point being that the Intel AX201 card claims Timesync feature 
(https://www.mouser.com/pdfDocs/wi-fi-6-ax201-module-brief.pdf), which 
is based on IEEE802.1AS. So there must be some way to run gptp like 
application on the AX201 intel card.

I appreciate any help here if someone has relevant experiences.

Best,

Wei

On 3/5/2020 12:29 PM, Toke Høiland-Jørgensen wrote:
> Wei Liu <wei.liu1011@gmail.com> writes:
>
>> Hi,
>>
>> I am trying to achieve precise time synchronization via wifi
>> interface.
> Erm, good luck with that? :)
>
> You do realise that there's a whole bunch of stuff going on below the
> driver level (listen-before-send, etc) that makes 'precise' timing (as
> in microsecond-accuracy like ptp)... shall we just say challenging?
>
> -Toke
>
