Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764E33691ED
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbhDWMVR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 08:21:17 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:40059 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242383AbhDWMVQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 08:21:16 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d63 with ME
        id wCLc2400A21Fzsu03CLcf0; Fri, 23 Apr 2021 14:20:38 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 14:20:38 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
References: <YIKzmoMiTdToaIyP@mwanda>
 <427e33af49758c61bc23cf1eedb6dd6964c40296.camel@sipsolutions.net>
 <20210423121110.GO1981@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <bda7ae6b-00f9-ae0e-66d3-413049bc543d@wanadoo.fr>
Date:   Fri, 23 Apr 2021 14:20:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423121110.GO1981@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Le 23/04/2021 à 14:11, Dan Carpenter a écrit :
> On Fri, Apr 23, 2021 at 01:59:36PM +0200, Johannes Berg wrote:
>> On Fri, 2021-04-23 at 14:46 +0300, Dan Carpenter wrote:
>>> This code is supposed to loop over the whole board_type[] string.  The
>>> current code kind of works just because ascii values start 97 and the
>>> string is likely shorter than that so it will break when we hit the NUL
>>> terminator.  But really the condition should be "i < len" instead of
>>> "i < board_type[i]".
>>>
>>> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> index a7554265f95f..9b75e396fc50 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> @@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>>   		len = strlen(tmp) + 1;
>>>   		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
>>>   		strscpy(board_type, tmp, len);
>>> -		for (i = 0; i < board_type[i]; i++) {
>>> +		for (i = 0; i < len; i++) {
>>>   			if (board_type[i] == '/')
>>>   				board_type[i] = '-';
>>>   		}
>>
>> It should probably just use strreplace() though :)
> 
> Good point.  I'll send a v2.
> 

and the 2 lines above look like a devm_kstrdup.

The (unlikely) malloc failure test is also missing.

CJ

> regards,
> dan carpenter
> 
> 

