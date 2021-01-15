Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2AB2F7F0B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbhAOPJJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 10:09:09 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:41212 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729568AbhAOPJI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 10:09:08 -0500
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7AD972435A;
        Fri, 15 Jan 2021 07:08:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7AD972435A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1610723287;
        bh=17aCG3PbjBsTi6eKwhku2AiY0ZV4VTUvwU5ztGM7hss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IxBEJdxZDjnprWsJ3SbEzuBPb+kposF2ZJqZcbE+88NgPFXEIn1JgxotM9j63Ucnq
         TdL3mhg8kxfd66pcgc2CBI771OmnBuwo669x0sucuTL820TcyhTBXT89DKiJPTVy/0
         rlenY0BPHXXnY/ae/DtN777wEz/Teu/S+ZJLqHA0=
Received: from [10.230.40.117] (unknown [10.230.40.117])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id C264B187289;
        Fri, 15 Jan 2021 07:08:04 -0800 (PST)
Subject: Re: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
To:     Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210114163641.2427591-1-alsi@bang-olufsen.dk>
 <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
 <CAOq732KGRmQ0eq46cqkF-EW-A8W6QiOb02NZEq6H7K_28YSstA@mail.gmail.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <6a87845e-3f9d-2921-051a-d1fe7d27cbd3@broadcom.com>
Date:   Fri, 15 Jan 2021 16:08:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOq732KGRmQ0eq46cqkF-EW-A8W6QiOb02NZEq6H7K_28YSstA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/15/2021 3:51 PM, Andrew Zaborowski wrote:
> On Fri, 15 Jan 2021 at 15:12, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:>
>> + Johannes
>> - netdevs
>>
>> On 1/14/2021 5:36 PM, 'Alvin Šipraga' via BRCM80211-DEV-LIST,PDL wrote:
>>> Add support for CQM RSSI measurement reporting and advertise the
>>> NL80211_EXT_FEATURE_CQM_RSSI_LIST feature. This enables a userspace
>>> supplicant such as iwd to be notified of changes in the RSSI for roaming
>>> and signal monitoring purposes.
>>
>> The more I am looking into this API the less I understand it or at least
>> it raises a couple of questions. Looking into nl80211_set_cqm_rssi() [1]
>> two behaviors are supported: 1) driver is provisioned with a threshold
>> and hysteresis, or 2) driver is provisioned with high and low threshold.
> 
> Right.
> 
>>
>> The second behavior is used when the driver advertises
>> NL80211_EXT_FEATURE_CQM_RSSI_LIST *and* user-space provides more than
>> one RSSI threshold.
> 
> Or, when the driver doesn't implement set_cqm_rssi_config (the old
> method).  So the driver can stop supporting set_cqm_rssi_config when
> it implements set_cqm_rssi_range_config.

Argh. Totally overlooked these were two different callbacks. In that 
case it is easy to determine what is being requested.

Thanks,
Arend
