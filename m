Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667753C274A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGIQIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 12:08:53 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:39370 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhGIQIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 12:08:52 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 12:08:52 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 29D02243962
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 15:58:54 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.172])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 12226A006D;
        Fri,  9 Jul 2021 15:58:53 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CB0A014007C;
        Fri,  9 Jul 2021 15:58:52 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 40B3513C2B3;
        Fri,  9 Jul 2021 08:58:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 40B3513C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625846332;
        bh=kfC92NJcL8vib23XloHjcGRUxQ9uYE5h0l2TBCAMAMQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=pum9wF0+/4Fi+nz0pKV2tpSLtHW3dR3LNWqjHdBbLZibOHd7+rC4RK/aXdiaRaega
         Iae+zzkvsc/Oti46ujR2qyIL0O9fCh/TSCqsTIesphUBItUqf+es2hYmMGAs5aoc5a
         axiVqIiioXo6KgAMAIfTeeraeDIEI45VE8bZdBhA=
Subject: Re: Kernel crash when scanning for APs in huge WiFi environment -
 Ath10K - ARMV7 - Linux 4.14.73
To:     Vincent RUBY <vruby@cube-technologies.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1cef8054e4e447f2ba02d1de1e6afdf8@Cube-mail.cube.local>
 <e23f3f12dcab42ea9ab4b7384080cdf2@Cube-mail.cube.local>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <c2f66f16-3800-b127-4c58-704a29ec693d@candelatech.com>
Date:   Fri, 9 Jul 2021 08:58:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e23f3f12dcab42ea9ab4b7384080cdf2@Cube-mail.cube.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1625846333-lD24sK-WlMP6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/9/21 8:48 AM, Vincent RUBY wrote:
> Hi,
> 
> I apologize in advance if I am writing at the wrong place.
> We have developed a custom embedded board based on ARMV7. On the board there is a Telit WE866C3-P Wifi module (based on ath10k).
> Linux : 4.14.73 (YOCTO/poky)
> Microcontroller : SAMA5D27
> 
> The board is working perfectly in a normal Wifi environment (e.g., at office).
> But when the board is put in a huge Wifi environment (e.g., 350 APs with 2 antennas each with more than 600 visible BSSIDS) the Linux kernel crashes when attempting to connect to a Wifi network using wpa_supplicant.
> When the Wifi antenna is attenuated with some electromagnetic obstacle (e.g., hand or metallic shield), the board connects without any problem.
> 
> The problem is the same when running a scan from wpa_cli .
> 
> Do you have any idea where I can find some clue to resolve this issue?
> 
> Many thanks in advance !
> 
> VinceCube
> 

Please show the details of the kernel crash.  And either way, answer is probably to try more
recent kernel and see if problem is already fixed.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

