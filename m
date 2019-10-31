Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353C9EB358
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfJaPEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 11:04:05 -0400
Received: from www74.your-server.de ([213.133.104.74]:59422 "EHLO
        www74.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfJaPEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 11:04:05 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www74.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1iQBzU-0004qq-1v; Thu, 31 Oct 2019 16:04:00 +0100
Received: from [95.91.84.106] (helo=[192.168.178.28])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1iQBzT-000Vgr-Nh; Thu, 31 Oct 2019 16:03:59 +0100
Subject: Re: PATCH: Change log level of "iwlwifi 0000:6f:00.0: BIOS contains
 WGDS but no WRDS" to "info"
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linuxwifi@intel.com, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, linux-wireless@vger.kernel.org
References: <dcd58b9b-43d0-a05c-68fe-2f787457f2a4@computerix.info>
 <30e95fb1-96df-b96a-c79e-e35a945ec889@computerix.info>
 <87r22tcbnw.fsf@tynnyri.adurom.net>
From:   Klaus Kusche <klaus.kusche@computerix.info>
Message-ID: <474a9d73-e55f-99c6-dd5a-f21de8df6394@computerix.info>
Date:   Thu, 31 Oct 2019 16:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87r22tcbnw.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: klaus.kusche@computerix.info
X-Virus-Scanned: Clear (ClamAV 0.101.4/25619/Thu Oct 31 09:55:29 2019)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 31/10/2019 14:00, Kalle Valo wrote:
> Klaus Kusche <klaus.kusche@computerix.info> writes:
> 
>> Hello again,
>>
>> On 22/10/2019 20:39, Klaus Kusche wrote:
>>> Hello,
>>>
>>> every time I boot my dell notebook (with Wi-Fi 6 AX200), I get the error message 
>>> "iwlwifi 0000:6f:00.0: BIOS contains WGDS but no WRDS".
>>>
>>> This is the only message which such a high log level I get while booting,
>>> it is the only message which is displayed on all text consoles on boot,
>>> and it is the only message which makes my automated logchecker nervous each time.
>>>
>>> However, iwlwifi works perfectly fine for wifi in spite of the message
>>> (and bluetooth has deliberately been disabled in the bios settings
>>> for security reasons),
>>> and there is absolutely nothing I could do about the message
>>> (I have no influence what dell does in their bios and what they don't).
>>> Internet wisdom also says that the message is just annoying and
>>> can be safely ignored.
>>>
>>> Hence, the message is not an error at all ("error" being defined as
>>> "something definitely failed, manual intervention required for correct operation").
>>> It does not even qualify as a warning ("warning" being defined as
>>> "something is likely to fail, manual checking recommended").
>>>
>>> So please set the log level of that message down to "info"
>>> (besides, the message text is completely cryptic and uninformative,
>>> I still don't know what this message wants to tell me,
>>> although I searched the internet).
>>
>> Discussed this with Mario.Limonciello@dell.com.
>> He also wants this to be patched:
>>
>> On 29/10/2019 22:43, Mario.Limonciello@dell.com wrote:
>>> Dell Customer Communication - Confidential
>>>
>>>> -----Original Message-----
>>>> From: Klaus Kusche <klaus.kusche@computerix.info>
>>>> ...
>>>> When booting, there is a single kernel message of loglevel error
>>>> which stands out in red in journalctl
>>>> and which gets displayed on all text consoles (very annoying):
>>>>
>>>> kernel: iwlwifi 0000:6f:00.0: BIOS contains WGDS but no WRDS
>>>
>>> If possible, you should probably submit a patch to iwlwifi driver to downgrade this message to
>>> debug.  It really isn't useful to many people typically.
>>
>> So here comes a patch:
>>
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c       2019-10-19 09:21:14.541422680 +0200
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c       2019-10-27 14:43:43.990623338 +0100
>> @@ -1345,7 +1345,7 @@
>>                  * available, issue an error, because we can't use SAR
>>                  * Geo without basic SAR.
>>                  */
>> -               IWL_ERR(mvm, "BIOS contains WGDS but no WRDS\n");
>> +               IWL_INFO(mvm, "BIOS contains WGDS but no WRDS\n");
> 
> There are so many things missing here. Please read the instructions how
> to submit a patch from the link in my signature below and resend.
> 

???

I'm not a kernel developer, I'm a plain linux user.

No git here at all (not even installed), 
hence no git-related things in the patch mail, 
and no changelog format or commit message.
The patch was manually created with diff against the sources 
of the production kernel running on my system (gentoo 5.3.7).

And how or where could I include a signed-off line 
if i can't provide a patch in changelog format?

If that helps:
I hereby certify that I wrote that patch and I'm allowd to publish it.
Feel free to include that patch in linux, modify it or whatever
with or without mentioning my name.


-- 
Prof. Dr. Klaus Kusche
Private address: Rosenberg 41, 07546 Gera, Germany
+49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
+49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
