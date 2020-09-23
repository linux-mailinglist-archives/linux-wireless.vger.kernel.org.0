Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4D275EDC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Sep 2020 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIWRkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Sep 2020 13:40:36 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:57814 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIWRkg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Sep 2020 13:40:36 -0400
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1088213C2B0;
        Wed, 23 Sep 2020 10:40:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1088213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600882835;
        bh=TrRdEE1bfF/zK54bksFaYOhAOhTZ7EfmGTCdqIY9v0k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vx9gSYlWGE+Nftk92BlGpfmCFblu546kBx7nasUUBLPZ1vHkgkQXD6kGNFJ7KvKoz
         02RQm3aUqtYVZao8kj6XDpRSQ6LKuTXU1dgHmyzVNv3Dts091hyKV47Jfeh1eja402
         1+G2mIFzUurhPY9+WmNVP6BPe8FjqcU3X2AUyIhQ=
Subject: Re: Configuring WiFi6 in hostapd
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chaitanya.mgit@gmail.com" <chaitanya.mgit@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "sugandhgowda@gmail.com" <sugandhgowda@gmail.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Cedric.Izoard@ceva-dsp.com" <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
 <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
 <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
 <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
 <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
 <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
 <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com>
 <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
 <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com>
 <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net>
 <CABPxzYLEZ5KU5x3w9rex3SQqj+TwGXFOXnC_QXdEu9NLfcRHMQ@mail.gmail.com>
 <CABPxzYKPHXtJHP4FhdrtJ763ZeHwf4bjyPOr5c7g_88r_pSdLQ@mail.gmail.com>
 <27c3af2e3128614ffe6321a95935378f35fee1b3.camel@intel.com>
 <e2cd5f5c162373e367d0e94bf2250e9a7f8144d2.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <0ef00fa9-d94a-8049-c711-6a061dabd4aa@candelatech.com>
Date:   Wed, 23 Sep 2020 10:40:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e2cd5f5c162373e367d0e94bf2250e9a7f8144d2.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/23/20 1:36 AM, Coelho, Luciano wrote:
> On Wed, 2020-09-23 at 11:16 +0300, Luciano Coelho wrote:
>> On Thu, 2020-09-17 at 03:01 +0530, Krishna Chaitanya wrote:
>>> On Sat, Sep 12, 2020 at 12:56 AM Krishna Chaitanya
>>> <chaitanya.mgit@gmail.com> wrote:
>>>> On Fri, Sep 11, 2020 at 10:41 PM Johannes Berg
>>>> <johannes@sipsolutions.net> wrote:
>>>>> On Fri, 2020-09-11 at 20:37 +0530, Krishna Chaitanya wrote:
>>>>>
>>>>>>> [  228.315290] iwlwifi 0000:03:00.0: 0x00002078 | ADVANCED_SYSASSERT
>>>>>>> [  228.315294] iwlwifi 0000:03:00.0: 0x00A0A200 | trm_hw_status0
>>>>>>> [  228.315297] iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
>>>>>>> [  228.315300] iwlwifi 0000:03:00.0: 0x004F8E3C | branchlink2
>>>>>>> [  228.315303] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink1
>>>>>>> [  228.315307] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink2
>>>>>>> [  228.315310] iwlwifi 0000:03:00.0: 0x07000101 | data1
>>>>>>> [  228.315313] iwlwifi 0000:03:00.0: 0x48308403 | data2
>>>>>>> [  228.315316] iwlwifi 0000:03:00.0: 0x00000005 | data3
>>>>>
>>>>> This means that we got an invalid TX rate, notably an HE rate was
>>>>> requested/configured on a MAC configuration that didn't have HE.
>>>>>
>>>>> I think I saw some patches in this area (configuring the MAC to be HE)
>>>>> fly by internally recently, but not sure... Luca probably knows.
>>>> Ah okay. This was reported on 5.4 kernel, do you think is it worth
>>>> trying on latest iwlwifi-next tree? Or as you are referring to the internal tree
>>>> the issue is present in the latest as well?
>>> Hi Luca,
>>>
>>> Can you please take a look? Any help is appreciated.
>>
>> Hi,
>>
>> There have been some new patches in this area, but after a quick look I
>> didn't find anything specific that jumps out.  I'll take a closer look
>> and let you know if I find anything.
> 
> In the meantime, you could try our public backport-iwlwifi tree, where
> most of the internal tree is published:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/
> 
> This is an out-of-tree driver, based on the linux-backports project.
>   You could try the core56 branch, for instance, or even master and
> check if the problem is still there.  If not, we can try to look for
> the patch that fixes it and push it to stable.

I'm curious if anyone is interested in helping to maintain a non-backports version of this,
something like how I did the ath10k-ct driver.  I'd like to use this driver, but
don't want to use the rest of the backports funk.

Thanks,
Ben

> 
> --
> Cheers,
> Luca.
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
