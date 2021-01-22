Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1CD300719
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 16:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbhAVPXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 10:23:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:38090 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbhAVPV7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 10:21:59 -0500
IronPort-SDR: jHKcvVUVmKbOqg2NIY+ENRcIKAKmK5XsF1fFiB3xoVP3tCqfZGqF5wkf2GTWYFagFhTiIpuwwa
 wY1vDbtJIHzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="175946606"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="175946606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:20:02 -0800
IronPort-SDR: whsO398kFbHnc97DbV7s3ZCOu0G/Q3wKeOTR/i5nUmkhIzZCpBPmYXjfSPC12Oa7ukT49H911j
 1NP+Nw9C40Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="348295148"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2021 07:19:59 -0800
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
To:     Andreas Hartmann <andihartmann@freenet.de>,
        Greg KH <greg@kroah.com>, stf_xl@wp.pl
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
References: <20210122104342.12451-1-stf_xl@wp.pl> <YAq9bt6q9dfk4F+F@kroah.com>
 <b0025964-490d-d8a0-f9af-f916d44e4f52@maya.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <4690235c-9676-7985-12a1-b8bcfd195a43@linux.intel.com>
Date:   Fri, 22 Jan 2021 17:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b0025964-490d-d8a0-f9af-f916d44e4f52@maya.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.1.2021 15.17, Andreas Hartmann wrote:
> 
> On 22.01.21 at 12:56 Greg KH wrote:
>> On Fri, Jan 22, 2021 at 11:43:42AM +0100, stf_xl@wp.pl wrote:
>>> From: Stanislaw Gruszka <stf_xl@wp.pl>
>>>
>>> Since f8f80be501aa ("xhci: Use soft retry to recover faster from transaction
>>> errors") on some systems rt2800usb devices are unable to operate. Looks
>>> that due to firmware or hardware limitations of those devices, they
>>> require full recovery from USB Transaction Errors.
>>>
>>> To avoid the problem add URB transfer flag, that restore pre f8f80be501aa
>>> xhci behaviour when the flag is set. For now only add it only to rt2800usb
>>> driver.
>>
>> This feels like a really heavy hammer, to add a xhci flag for a single
>> broken device.
>>
>> Are you sure this is really needed?  What does this device do on other
>> operating systems, do they have such a quirk for their host controller
>> driver?
>>
>> Or is this due to the specific host controller device hardware?  Should
>> this be a xhci quirk for a specific pci device instead?
> 
> Well, rt2800usb USB implementation does have a lot of potential for
> optimization since the very beginning (current throughput comparison
> 2 MiB/s vs 13 MiB/s with the original driver e.g.). That's why I'm
> using until today a self patched version (it's bound to cfg80211
> meanwhile) of the original driver (rt5572sta), which doesn't have those
> problems at all. From my point of view, the goal should be to solve the
> real reason for the problem. The original driver works much better
> (leastwise here) and doesn't show this problem at all!

Ok, so it could be a rt2800 driver issue, or it just hitting some
unlucky sequence that triggers this.

>
> But anyway, there is from my point of view a basic problem with xhci_hcd,
> which just seems not to be completely backward compatible to existing USB 2
> drivers (see https://marc.info/?l=linux-usb&m=161130327411612&w=2) if the
> device is plugged to an USB 3.x interface.

This looks like a different issue, lets keep it in its own thread.

The xHCI usb host controller handles both USB 2 and USB 3 speeds.
If the USB port is connected to a xHC controller then the xhci driver will
be used. If the port is connected to a EHCI then the ehci driever is used.
EHCI does not support USB3 speeds.

It's very possible that something that worked behind a EHCI host has issues
when connected to a xHCI host.

-Mathias

