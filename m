Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F549AD2ED
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 08:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfIIGAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 02:00:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:58747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfIIGAP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 02:00:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 23:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,483,1559545200"; 
   d="scan'208";a="174883157"
Received: from mjtillin-mobl1.ger.corp.intel.com ([10.252.1.17])
  by orsmga007.jf.intel.com with ESMTP; 08 Sep 2019 23:00:12 -0700
Message-ID: <5d79c06b7d718e8255ee192902dba5aad780fba5.camel@intel.com>
Subject: Re: [linuxwifi] Slow performance (~30mbps) with Intel 9260 (and
 8265, 3168) using 5G
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linuxwifi@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Sep 2019 09:00:12 +0300
In-Reply-To: <c078f515-51bd-2195-6b96-901db8872028@gmx.com>
References: <c078f515-51bd-2195-6b96-901db8872028@gmx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Sun, 2019-09-08 at 06:45 +0800, Qu Wenruo wrote:
> Hi,
> 
> Recent upgraded my wifi adapter from 8265 to 9260 of my ThinkPad X1C 6th
> gen.
> 
> However the initial test is producing some unacceptable results:
> 
> Furthermore, my desktop (intel 3168), and the original 8265 of my laptop
> also reproduce the same result.
> Kernels are the same 5.2.11-arch1-1-ARCH across my laptop and desktop.
> Tried lts (4.19) on my laptop, the same result.
> Even under Windows, it's all the same.
> 
> [  5] local 240e:3a1:c40:6c0::278 port 43334 connected to
> 240e:3a1:c40:6c0::16b port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  4.95 MBytes  41.5 Mbits/sec    0    219 KBytes
> 
> [  5]   1.00-2.00   sec  2.44 MBytes  20.5 Mbits/sec    0    248 KBytes
> 
> [  5]   2.00-3.00   sec  1.58 MBytes  13.3 Mbits/sec    1   1.39 KBytes
> 
> [  5]   3.00-4.00   sec  1.10 MBytes  9.21 Mbits/sec   44    194 KBytes
> 
> [  5]   4.00-5.00   sec  4.39 MBytes  36.8 Mbits/sec    0    226 KBytes
> 
> [  5]   5.00-6.00   sec  4.39 MBytes  36.8 Mbits/sec    0    247 KBytes
> 
> [  5]   6.00-7.00   sec  4.39 MBytes  36.8 Mbits/sec    0    257 KBytes
> 
> [  5]   7.00-8.00   sec  4.57 MBytes  38.3 Mbits/sec    0    259 KBytes
> 
> [  5]   8.00-9.00   sec  3.84 MBytes  32.2 Mbits/sec    0    259 KBytes
> 
> [  5]   9.00-10.00  sec  4.39 MBytes  36.8 Mbits/sec    0    261 KBytes
> 
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  36.0 MBytes  30.2 Mbits/sec   45             sender
> [  5]   0.00-10.02  sec  34.9 MBytes  29.2 Mbits/sec
> receiver
> 
> Yep, less than 40mbps using 5G.
> While I can even feel obvious lag when using ssh, some quick keystroke
> will easily cause a lag.
> 
> I though it's the Linux support causing problem (even I'm using Arch
> with 5.2 kernel) for the newer 9260 card, then I switched back to 8265.
> But the same problem still exists!!
> What makes things even stranger, under Windows, it's all the same result.
> 
> To exclude the problem of the AP, my android phone can easily get over
> 200mbps through the same AP.
> 
> Furthermore, I tested my desktop which has an Intel 3168 card, and to my
> surprise, it's the same result less than 40mbps.
> 
> 
> Although it doesn't really hurt as both my desktop and laptop is mostly
> connected through ethernet, it still doesn't make sense to me.
> 
> Here is the dmesg of my laptop. (Please ignore the perf buffer warning,
> as I also tried to trace iwlwifi:* and iwlwifi_msg:* events)
> https://paste.fedoraproject.org/paste/d5TO6kvbBOwQ~tkLgDbXsQ/raw
> 
> The iw list output:
> https://paste.fedoraproject.org/paste/QKIOLyItCLcwTJoan8Wd3g/raw
> 
> 
> Any ideas how this could happen to 3 different intel cards on two
> different systems? (Although all running the same Arch kernel and latest
> firmware)

This really must be an environment issue.  You are describing the same
problem with different NICs (which mean different FWs are being used)
and the same problem on Windows (which means different driver version
being used), so it's not a new bug in either the firmware or the
driver.

Was it working properly before? Did it start happening only when you
changed the NIC (even though you changed it back and it remained not
working)? What else changed?

I can't see anything hinting any issues in dmesg.  Also, I'm a bit
confused about the "5G" you mention.  Does that mean that the AP is
connected to the internet via 5G?

--
Cheers,
Luca.

