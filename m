Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2DAD305
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfIIGTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 02:19:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:2052 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfIIGTC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 02:19:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 23:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,483,1559545200"; 
   d="scan'208";a="359386304"
Received: from mjtillin-mobl1.ger.corp.intel.com ([10.252.1.17])
  by orsmga005.jf.intel.com with ESMTP; 08 Sep 2019 23:19:00 -0700
Message-ID: <10f877f29750ceb357fa5b54bf07122c658270ca.camel@intel.com>
Subject: Re: [linuxwifi] Slow performance (~30mbps) with Intel 9260 (and
 8265, 3168) using 5G
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linuxwifi@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Sep 2019 09:18:59 +0300
In-Reply-To: <42bd356c-6c59-79dc-bb37-5bc36d07a9af@gmx.com>
References: <c078f515-51bd-2195-6b96-901db8872028@gmx.com>
         <5d79c06b7d718e8255ee192902dba5aad780fba5.camel@intel.com>
         <42bd356c-6c59-79dc-bb37-5bc36d07a9af@gmx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-09-09 at 14:09 +0800, Qu Wenruo wrote:
> 
> On 2019/9/9 下午2:00, Luciano Coelho wrote:
> > Hi,
> > 
> > On Sun, 2019-09-08 at 06:45 +0800, Qu Wenruo wrote:
> > > Hi,
> > > 
> [...]
> > > Any ideas how this could happen to 3 different intel cards on two
> > > different systems? (Although all running the same Arch kernel and latest
> > > firmware)
> > 
> > This really must be an environment issue.  You are describing the same
> > problem with different NICs (which mean different FWs are being used)
> > and the same problem on Windows (which means different driver version
> > being used), so it's not a new bug in either the firmware or the
> > driver.
> 
> You're completely right. I have reset and upgraded my router (an MT7621
> based router with OpenWRT) to latest OpenWRT, then the problem just went
> away.

Great!


> It looks like, under the original environment, it's the Android phone
> doing something strange.

It's hard to tell, because the characteristics of the WiFi on your
Android phone are very different from those on your laptop.


> > Was it working properly before? Did it start happening only when you
> > changed the NIC (even though you changed it back and it remained not
> > working)? What else changed?
> 
> Nothing really, so I may hit something wrong with the NIC of the router,
> not all these NICs.

There was probably an upgrade of OpenWRT that started causing the
issue.  Hard to say.


> > I can't see anything hinting any issues in dmesg.  Also, I'm a bit
> > confused about the "5G" you mention.  Does that mean that the AP is
> > connected to the internet via 5G?
> 
> Sorry for the confusion, I mean 5Ghz.

Ah, I should have guessed, of course.  It's just that the word 5G has a
totally different meaning, hardcoded in my head, so I got confused. ;)


> All tests are done in 5GHz freq (802.11ac), and iperf server is
> connected by RJ45 (1Gbps) and iperf client is through wifi.
> 
> Anyway, after resetting the router, it's now back to the ~300 mpbs range.

That's great to hear! Let us know if you encounter any further issues.

--
Cheers,
Luca.

