Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE7211293
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2020 20:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbgGASZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 14:25:39 -0400
Received: from mon2.sibername.com ([162.144.51.228]:53685 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732835AbgGASZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 14:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VOV12LcUZl9Oo2kBPEp6C7SdaEl0OZP7zW7vmfLhSz4=; b=nxRzokorspUIEG8q1Gu3iz0BOE
        fRfpIescuj7YHhtcRqNKd5cVMpun5HR1bDSOVNj7EBcApjBotbHpr/YZszq1hF3V5YFDp/S01XM4E
        g6T0mi4aLZds7sKd+QOyBOj2zzhNxUnTII7luVzPf5MfIjviug9jzeOMEDzWX+YxQslgLMAFIEYgs
        O6Aw5sF43/JW/ykCpH8QOcabaj3dXN5d25Uo7bH2QffYryVLE9/D4qPgDToi8egrlaHZvXQ0JSR79
        B3SN2TsAjb3CvLEEa+kJwA/aWQdoPaoRM1fPx0TANcxALWlJqRYQ8ZojKolBK4zTaLaGsICgF7S/E
        AE+zfWHQ==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:43368 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jqhQG-006SU8-SJ; Wed, 01 Jul 2020 14:25:33 -0400
Subject: disable_usb_sg=1
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
 <CAFXAJYwgRPAbY4i8XHNGzcyJg-11BwOSdDS6098eh_CEzxeEUQ@mail.gmail.com>
 <9c44f87b-eaa5-afcb-b830-30b2b36232d5@lockie.ca>
 <20200629091919.GA10533@localhost.localdomain>
From:   James <bjlockie@lockie.ca>
Message-ID: <f47e22d4-4a9e-a658-18ed-ecc7f80bf689@lockie.ca>
Date:   Wed, 1 Jul 2020 14:25:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629091919.GA10533@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-0.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: rjl@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: rjl@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-29 5:19 a.m., Lorenzo Bianconi wrote:
>> Kernel 5.4.48 is better so far:
>> Uptime
>> 1d 18h 6m 32s
>> It sounds like it is only a matter of time since you have the problem on a
>> later kernel.
>> I did get rid of a cable and use a powered USB 3 hub.
> Can you please try to load the mt76_usb module with disable_usb_sg=1?
>
> Regards,
> Lorenzo
Almost 2 days and no problem after disable_usb_sg=1
https://docs.gz.ro/tuning-network-cards-on-linux.html
 >TCP offload engine
 >Linux doesn't support TOE by default
Why isn't it disabled by default?

