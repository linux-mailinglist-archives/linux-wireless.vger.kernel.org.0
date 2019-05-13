Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF131B61A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfEMMh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 08:37:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:50251 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfEMMh6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 08:37:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 05:37:53 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2019 05:37:52 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQADH-0001fj-Es; Mon, 13 May 2019 15:37:51 +0300
Date:   Mon, 13 May 2019 15:37:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment?= Perrochaud 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
Message-ID: <20190513123751.GS9224@smile.fi.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 02:18:03PM +0200, Sedat Dilek wrote:
> On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It has been reported that some laptops, equipped with NXP NFC300, have
> > different ID then mentioned in the driver.
> >
> > While at it, I found that the driver has a lot of duplication and redundant
> > platform data. The rest of the series (11 out of 12 patches) is dedicated to
> > clean the driver up.
> >
> > Sedat, would be nice if you can compile kernel with this patch series applied
> > and test on your laptop.
> >
> > In v2:
> > - added new ID patch
> > - added new clean up patch
> > - Cc'ed to linux-wireless@ as well, since linux-nfc@ bounces my mails
> > - Cc'ed to the reported of the problem with T470 laptop
> >
> > Andy Shevchenko (12):
> >   NFC: nxp-nci: Add NXP1001 to the ACPI ID table
> >   NFC: nxp-nci: Get rid of platform data
> >   NFC: nxp-nci: Convert to use GPIO descriptor
> >   NFC: nxp-nci: Add GPIO ACPI mapping table
> >   NFC: nxp-nci: Get rid of code duplication in ->probe()
> >   NFC: nxp-nci: Get rid of useless label
> >   NFC: nxp-nci: Constify acpi_device_id
> >   NFC: nxp-nci: Drop of_match_ptr() use
> >   NFC: nxp-nci: Drop comma in terminator lines
> >   NFC: nxp-nci: Remove unused macro pr_fmt()
> >   NFC: nxp-nci: Remove 'default n' for tests
> >   NFC: nxp-nci: Convert to SPDX license tags
> >
> >  MAINTAINERS                           |   1 -
> >  drivers/nfc/nxp-nci/Kconfig           |   1 -
> >  drivers/nfc/nxp-nci/core.c            |  15 +--
> >  drivers/nfc/nxp-nci/firmware.c        |  13 +--
> >  drivers/nfc/nxp-nci/i2c.c             | 147 ++++++--------------------
> >  drivers/nfc/nxp-nci/nxp-nci.h         |   1 -
> >  include/linux/platform_data/nxp-nci.h |  27 -----
> >  7 files changed, 37 insertions(+), 168 deletions(-)
> >  delete mode 100644 include/linux/platform_data/nxp-nci.h
> 
> Can we have NPC300 listed in the Kconfg help text?

Sure, it's good thing to do!

Either as a separate patch or I may incorporate in the next iteration.
Samuel, what do you prefer?

-- 
With Best Regards,
Andy Shevchenko


