Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0391B623
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfEMMkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 08:40:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:28048 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfEMMkw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 08:40:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 05:40:51 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2019 05:40:50 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQAG9-0001hm-Ca; Mon, 13 May 2019 15:40:49 +0300
Date:   Mon, 13 May 2019 15:40:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
Message-ID: <20190513124049.GT9224@smile.fi.intel.com>
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
 <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com>
 <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <20190513095059.GN9224@smile.fi.intel.com>
 <CA+icZUWXSup0BfXNZXxcrAAbu-b9KCiBU++OkC+eFqacMrTwRg@mail.gmail.com>
 <20190513105745.GR9224@smile.fi.intel.com>
 <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 01:20:43PM +0200, Sedat Dilek wrote:
> On Mon, May 13, 2019 at 12:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, May 13, 2019 at 12:38:27PM +0200, Sedat Dilek wrote:
> > > On Mon, May 13, 2019 at 11:51 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Mon, May 13, 2019 at 11:27:07AM +0200, Sedat Dilek wrote:
> > > >
> > > > > Sorry to say, I still have not get all correlations...
> > > >
> > > > Can you provide the output of the following on running Linux system with latest
> > > > possible kernel you can install (I am expecting v5.1) and command line with
> > > > 'ignore_loglevel'?
> > > >
> > > > 1. `dmesg`
> > > > 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> > > > 3. `acpidump -o t470-tables.dat` # the file t470-tables.dat
> > > > 4. `lspci -vv -nk`
> > > >
> > > > P.S. You may use GitHub gist for this set (please, don't share archives) or any
> > > > other resource like pastebin.
> > > >
> > >
> > > Looks like I am unable to use Debian's gist-paste package today or
> > > need more coffee.
> > >
> > > So, I add this here.
> > >
> > > I added my kernel-config.
> >
> >
> > Thanks. I just sent a series to (hopefully) support it in the vanilla kernel.
> > Can you test it?
> >
> > P.S. I see in dmesg the pn544 tries to bind to the NXP1001. Do you have some
> > custom patches for that in your kernel? If so, please drop them.

> this looks promising!
> 
> I have attached v2 of the disired outputs.

Nothing is point of interest anymore except dmesg.
But thanks for sharing.

-- 
With Best Regards,
Andy Shevchenko


