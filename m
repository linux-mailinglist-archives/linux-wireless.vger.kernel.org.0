Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA023006DB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbhAVPCK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 10:02:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:32907 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbhAVPAS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 10:00:18 -0500
IronPort-SDR: u7ej3DzUCXK5uiglhRu/y+C8IijM/LPeQNjuhqHM+Rms/ZTpDdF3gOMmrnLwN2ZgGmK1SxNosX
 9tVl7wK+YCXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179599391"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="179599391"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 06:58:22 -0800
IronPort-SDR: gCs2QRqJIDSxR47Y7ZpqrBltZK0ls7Lg0mnE87ieoIz8WTZjzLtO8o2VahKuu4ER//ABNsJIum
 yzAMKrfHAqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="348288845"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2021 06:58:20 -0800
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
To:     Stanislaw Gruszka <stf_xl@wp.pl>, Greg KH <greg@kroah.com>
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
References: <20210122104342.12451-1-stf_xl@wp.pl> <YAq9bt6q9dfk4F+F@kroah.com>
 <20210122132650.GA13029@wp.pl>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <eb37b28d-5046-f0cd-92ee-55af0e350802@linux.intel.com>
Date:   Fri, 22 Jan 2021 17:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122132650.GA13029@wp.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.1.2021 15.26, Stanislaw Gruszka wrote:
> On Fri, Jan 22, 2021 at 12:56:30PM +0100, Greg KH wrote:
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

I agree, rootcause is still unknown.
This bug hasn't gotten enough attention.

I'm tidying up a rewrite of areas that touches this, but it didn't seem to help.
I'd anyway like to get the rewrite done first, then get a new set of logs and traces,
and take a fresh look at this

Meanwhile it could be checked if this issue is seen only on some xHCI controllers.
Maybe some vendors don't support soft retry properly.
we could easily prevent soft retry usage on those xHC hosts. 

>>
>> Are you sure this is really needed?
> 
> I'm not sure if this is needed, however this particular bug was reported
> as regression caused by f8f80be501aa commit on 4.19 -> 4.20 cycle. It
> was reported to Mathias Nyman - xhci maintainer and f8f80be501aa commit
> author. But since then, regardless of some Mathias work on this on xhci
> side, we did not get solution that fixed the problem.
> 
> From other side, I can ask why change from f8f80be501aa is need? Taking
> it's commit message, the benefit of the change is not obvious. What
> I can notice, is that it only broke support for hardware that worked
> previously. However I assume that the change is useful and needed,
> so I come up with patch that just revert this change only for rt2800usb.

Significantly faster recovery from transaction errors. Many errors are temporary
due to electrical interference, and a simple retry will solve the case.
see xhci spec section 4.6.8.1 "Soft Retry" for details.

> 
>>  What does this device do on other
>> operating systems, do they have such a quirk for their host controller
>> driver?
> 
> I don't know what other OSes do.
> 
>> Or is this due to the specific host controller device hardware?  Should
>> this be a xhci quirk for a specific pci device instead?

Exactly, this should be checked.
Stanislaw, weren't there a few users already that saw this issue?
Do we know what xHCI controllers they were using?

-Mathias
