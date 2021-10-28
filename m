Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE943E996
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ1UiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 16:38:14 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:58038 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230380AbhJ1UiN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 16:38:13 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.179])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0B5432A0064;
        Thu, 28 Oct 2021 20:35:45 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8F6D2AC0104;
        Thu, 28 Oct 2021 20:35:44 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id DB28C13C2B1;
        Thu, 28 Oct 2021 13:35:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DB28C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1635453344;
        bh=3wDN7YU3xvWl5RF2dX/juEVHlHc4Hb786bT6tcV/HmQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nmRnxWJfmEu1MFU6QJkHV4VP1TeA4rQOAeY+lhxV3+DtMo3UJX9eURawtWiUgv8AW
         2g6K8UmUPa0pcDT8//BkizpQYv1P2wlamId8VB+RdBkbEJbrfVa+8tDFnsdl7LtSD0
         DEICdlvgy04IFPCAuVHoxJhn5PbkcqXA0dY5Dd58=
Subject: Re: new "[1/2] ath10k: Try to get mac-address from dts"
To:     Christian Lamparter <chunkeey@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <20211016234609.1568317-1-chunkeey@gmail.com>
 <87ee855xwa.fsf@codeaurora.org>
 <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
 <875yth5pt3.fsf@codeaurora.org>
 <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com>
 <CA+_ehUxFDUE6BU3TbngKOA-VKCBkTnpOv7ibTjtpur37KrQ4Jw@mail.gmail.com>
 <e6936f55-6ca7-209c-8c3f-5eeae879c9dc@gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <5a2bc68a-603c-9a8a-0e7c-eb69b3045dc7@candelatech.com>
Date:   Thu, 28 Oct 2021 13:35:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e6936f55-6ca7-209c-8c3f-5eeae879c9dc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1635453345-ZIwNKbTqYTkI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/28/21 1:29 PM, Christian Lamparter wrote:
> On 28/10/2021 20:57, Ansuel Smith wrote:
>>>
>>> The "[1/2] ath10k: Try to get mac-address from dts" patch
>>> will need a respin, so it can apply cleanly.
>>>
>>> Is Anyone interested? If not, I can take a shot at it on Saturday.
>>>
>>
>> A refreshed patch is applied to atk10k-ct repo so it would be good to
>> have the same patch on normal ath10k. Many router would benefit
>> from that.
> 
> Found it!
> 
> https://github.com/greearb/ath10k-ct/commit/e6a7d5b5b834737cd12e357b5efdc2e42d923bf6.patch
> 
> Hmm, Author is now "Ben" and the whole commit message is gone.
> Now, adding the commit message back from your original patch
> is not a problem, but the missing "Signed-off-by" from him and
> you might be.
> ...
> 
> But then, do we need it? Because there might be the option to extend
> device_get_mac_address() instead?! ...

I applied this since owrt was using it and it decreased out-of-tree patches,
and it does not break my (non-owrt) use case.  Other than that, I don't know much
about this patch...

If it is decided this patch should go away, please let me know so I can adjust
ath10k-ct accordingly.

Thanks
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

