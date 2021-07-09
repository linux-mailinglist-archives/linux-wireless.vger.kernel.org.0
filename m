Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFC3C27B1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhGIQnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 12:43:03 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:57210 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGIQnD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 12:43:03 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 12:43:03 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 55A6B222EC4
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 16:34:06 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.203])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 167781A006B;
        Fri,  9 Jul 2021 16:34:05 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C5B29AC007E;
        Fri,  9 Jul 2021 16:34:02 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C141E13C2B1;
        Fri,  9 Jul 2021 09:34:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C141E13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625848441;
        bh=qS0h/xScgqIvXBaFqVwygpyIfq5IKbJ7mtjvYrRCsKw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ihVci9gtNU8XjDfqhL0IhakBD8g5hrCWJg4BYKq0Xic9WpVFFU/0ZcRq5E0YhTUKw
         9S8onN3IQIV5aKsQdoCxJqWk/C21Qoj9GexmNE+UCKiW93RVVILIzxpyGkTVGozDlF
         dSbhVCKAQW7KhS6GPNEwz6lchIpp8QJSnkUfYJtE=
Subject: Re: Kernel crash when scanning for APs in huge WiFi environment -
 Ath10K - ARMV7 - Linux 4.14.73
To:     Vincent RUBY <vruby@cube-technologies.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1cef8054e4e447f2ba02d1de1e6afdf8@Cube-mail.cube.local>
 <e23f3f12dcab42ea9ab4b7384080cdf2@Cube-mail.cube.local>
 <c2f66f16-3800-b127-4c58-704a29ec693d@candelatech.com>
 <2eb86fb560cc482fa63bf42fafb97922@Cube-mail.cube.local>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <2b3885f7-c48a-a3a8-92a9-780405527bf3@candelatech.com>
Date:   Fri, 9 Jul 2021 09:34:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2eb86fb560cc482fa63bf42fafb97922@Cube-mail.cube.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1625848445-xXiUFcd9I-sK
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/9/21 9:15 AM, Vincent RUBY wrote:
> Thank you Ben for your quick reply.
> 
> Unfortunately, when the system crashes, there is no detail. No trace or log can be retrieved, even in dmesg.
> It is simply rebooting.
> 
> Trying a newer kernel is not easy since we are hardware driver dependent.

Yep, is sucks to develop on ancient cruft.

You should be able to wire in a serial console somehow, that is first step to
debugging such kernel crashes.  But, assuming this is some hacked up SDK
or other non-standard kernel, the fix will be between you and your vendor.

You could also put a similar chipset NIC into a PC and try same test on latest
upstream kernel and normal OS like Ubunto or Fedora.
If it crashes there, that would likely be easier to debug and folks on the list
might could help.

Thanks,
Ben

> 
> VinceCube
> 
> -----Message d'origine-----
> De : Ben Greear <greearb@candelatech.com>
> Envoyé : vendredi 9 juillet 2021 17:59
> À : Vincent RUBY <vruby@cube-technologies.net>; linux-wireless@vger.kernel.org
> Objet : Re: Kernel crash when scanning for APs in huge WiFi environment - Ath10K - ARMV7 - Linux 4.14.73
> 
> On 7/9/21 8:48 AM, Vincent RUBY wrote:
>> Hi,
>>
>> I apologize in advance if I am writing at the wrong place.
>> We have developed a custom embedded board based on ARMV7. On the board there is a Telit WE866C3-P Wifi module (based on ath10k).
>> Linux : 4.14.73 (YOCTO/poky)
>> Microcontroller : SAMA5D27
>>
>> The board is working perfectly in a normal Wifi environment (e.g., at office).
>> But when the board is put in a huge Wifi environment (e.g., 350 APs with 2 antennas each with more than 600 visible BSSIDS) the Linux kernel crashes when attempting to connect to a Wifi network using wpa_supplicant.
>> When the Wifi antenna is attenuated with some electromagnetic obstacle (e.g., hand or metallic shield), the board connects without any problem.
>>
>> The problem is the same when running a scan from wpa_cli .
>>
>> Do you have any idea where I can find some clue to resolve this issue?
>>
>> Many thanks in advance !
>>
>> VinceCube
>>
> 
> Please show the details of the kernel crash.  And either way, answer is probably to try more recent kernel and see if problem is already fixed.
> 
> Thanks,
> Ben
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

