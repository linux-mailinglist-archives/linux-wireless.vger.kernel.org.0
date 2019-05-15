Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533801EBD5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEOKJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 06:09:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:3238 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfEOKJX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 06:09:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 03:09:22 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 03:09:20 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQqqd-0003py-Pf; Wed, 15 May 2019 13:09:19 +0300
Date:   Wed, 15 May 2019 13:09:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        =?iso-8859-1?Q?Cl=E9ment?= Perrochaud 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
Message-ID: <20190515100919.GJ9224@smile.fi.intel.com>
References: <20190513123751.GS9224@smile.fi.intel.com>
 <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com>
 <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
 <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com>
 <CA+icZUWZH-JS=JHLieVd2ga=Zutac2BXd4tk0tSXs+izQ5txOQ@mail.gmail.com>
 <787aff34-b1b9-b9e2-faf3-409d7fc95a52@intel.com>
 <CA+icZUV=TBfabHsbzj_JPnxXBjo114LWVJ==xSS7zVPkajmNgw@mail.gmail.com>
 <20190514170136.GI9224@smile.fi.intel.com>
 <CA+icZUW0KM07sUH=muhRwFBZQKQpeqN6wCDHSDrQM-L35bA+SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUW0KM07sUH=muhRwFBZQKQpeqN6wCDHSDrQM-L35bA+SQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 10:32:36AM +0200, Sedat Dilek wrote:
> On Tue, May 14, 2019 at 7:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> So, this is enough?

Yes, please send it as a formal patch, I will chain it to my series and resend
in a bunch of v3.

> $ git diff
> diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
> index a28c4265354d..d85a4761e271 100644
> --- a/drivers/nfc/nxp-nci/Kconfig
> +++ b/drivers/nfc/nxp-nci/Kconfig
> @@ -2,8 +2,8 @@ config NFC_NXP_NCI
>         tristate "NXP-NCI NFC driver"
>         depends on NFC_NCI
>         ---help---
> -         Generic core driver for NXP NCI chips such as the NPC100
> -         or PN7150 families.
> +         Generic core driver for NXP NCI chips such as the PN547 (NPC100),
> +         PN548 (NPC300) or PN7150 families.
>           This is a driver based on the NCI NFC kernel layers and
>           will thus not work with NXP libnfc library.
> 
> @@ -21,4 +21,4 @@ config NFC_NXP_NCI_I2C
> 
>           To compile this driver as a module, choose m here. The module will
>           be called nxp_nci_i2c.
> -         Say Y if unsure.
> +         Say N if unsure.
> 
> Shall I sent a patch for this, or do you want to that yourself?
> 
> Thanks.
> 
> - Sedat -

-- 
With Best Regards,
Andy Shevchenko


