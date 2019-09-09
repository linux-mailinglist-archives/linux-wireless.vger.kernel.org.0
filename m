Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405E6ADC91
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfIIQA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 12:00:28 -0400
Received: from www.zeus07.de ([194.117.254.37]:55896 "EHLO mail.zeus07.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388236AbfIIQA1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 12:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=ibk-consult.de; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=Q6VY6wQt8L9Lvj
        FH5cF+mS70M8zMN6vB7i41NCdPBGA=; b=iQk4/vM3UobDjKUe/lMuFUR0EOg+F0
        cE6gH6T6xb+2hx8MyR5hHk/38ek2e4W0JQ9rsuph0bxpVM0MVLgg3UdJNKAe+BDt
        sYQsDVSLoE5JO8qETpTKVN5rXo7tmwcQWjUq9/WGjd6ce67fi8SbWl+UITIF0MDR
        P4F8nfTCdjE6M=
Received: (qmail 31171 invoked from network); 9 Sep 2019 18:00:23 +0200
Received: by mail.zeus07.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 9 Sep 2019 18:00:23 +0200
X-UD-Smtp-Session: l3s7167p2@2N2r4iCSVJ1NAw2m
Subject: Re: Fwd: Asus x540m - RTL8723befw.bin and rtl8723befw_36.bin
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Cc:     kyle@kernel.org
References: <ql15114vjvsd2m1ywuv1u1b1.1565285708045@email.android.com>
 <12353dc2-5beb-7d65-54ee-5dd6cdd4fc47@ibk-consult.de>
 <746c6c58-04a1-42b6-9657-197677d173cd@lwfinger.net>
From:   Joerg Kampmann <kampmann@ibk-consult.de>
Message-ID: <dcea9c36-e9c5-a80a-ec81-eb3454af4425@ibk-consult.de>
Date:   Mon, 9 Sep 2019 18:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <746c6c58-04a1-42b6-9657-197677d173cd@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This seems to be very strange. Does anybody have an explanation for this 
strange behaviour?

Am 09.09.19 um 17:38 schrieb Larry Finger:
> On 9/9/19 9:32 AM, Joerg Kampmann wrote:
>> Hallo I just posted a remark on Github concerning the above firmware! 
>> I applied it on Debian 10 (buster) Linux ... Any idea on the causes 
>> of the fault? *firmware is too big*
>>
>> The machine is a notebook from ASUS: X540M - this notebook has only 3 
>> USB-slots no LAN, no CD drive -- Debian buster requires during 
>> installation: rtlwifi/
>
> No. Both those firmware files work just fine on my openSUSE system.
>
> The md5sums for the firmware are as follows:
> 1850c1308fbcd95e9f6a7f58ede1e35f /lib/firmware/rtlwifi/rtl8723befw_36.bin
> a2c544e90d41fa9097b18ba86f11bec9 
> /lib/firmware/rtlwifi/rtl8723befw_36.bin.xz
> bc828ddc6cd700abb79a8df5794bcf04 /lib/firmware/rtlwifi/rtl8723befw.bin
> 7c310f301623cf16211ef5b4a3a3078d /lib/firmware/rtlwifi/rtl8723befw.bin.xz
>
> The sizes for the uncompressed modules are:
> 31762 /lib/firmware/rtlwifi/rtl8723befw_36.bin
> 30746 /lib/firmware/rtlwifi/rtl8723befw.bin
>
> Larry
>
>
>
-- 
=============================================================================
Joerg Kampmann, Dr. Dipl.-Phys - IBK-Consult for Climate Physics -
D-31228 Peine +49-177-276-3140
www.ibk-consult.de - www.kampmannpeine.org
www.xing.com/hp/Joerg_Kampmann
www.xing.com/net/mathe
www.researchgate.net/profile/Joerg_Kampmann - https://independent.academia.edu/J%C3%B6rgKampmann
===============================================================================
This e-mail may contain confidential and/or legally protected information.
If you are not the intended recipient (or have received this e-mail in
error) please notify the sender immediately and delete this e-mail. Any
unauthorized copying, disclosure use or distribution of the material in
this e-mail is strictly forbidden.
Diese E-Mail enthält vertrauliche und/oder rechtlich geschuetzte Informationen.
Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich
erhalten haben, informieren Sie bitte sofort den Absender und loeschen
Sie diese Mail
===============================================================

