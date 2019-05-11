Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2C1A7F2
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfEKN2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 09:28:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:13270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfEKN2L (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 09:28:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 May 2019 06:28:11 -0700
X-ExtLoop1: 1
Received: from ozhuraki-desk.fi.intel.com (HELO [10.237.67.35]) ([10.237.67.35])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2019 06:28:09 -0700
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
 <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
From:   Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Message-ID: <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com>
Date:   Sat, 11 May 2019 16:27:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Sedat,

On 5/10/19 10:40 PM, Sedat Dilek wrote:

> Can you guide me how to do that?

I try and then decide whether this is help or not.
	
If I remember correctly, support for PN547 was done by multiple parties for some Broadwell based designs through the upstream, both on the kernel and neard side.

Assuming the integration details of PN547 didn’t deviate much, this might be:

- From relatively simple, i.e. getting the relevant data from ACPI and hinting the kernel/driver with a minimally sufficient changes. Most likely, once you sort the basic details (i2c, gpio, etc), everything would just work.

- To more laborious and would require a working and ideally open source reference. An option here might be Broadwell based Chromebooks with PN547 (just not sure whether plain or OEMs).

Regards,
Oleg
