Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A075A1CD5C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfENRBk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 13:01:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:34323 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfENRBk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 13:01:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 10:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,469,1549958400"; 
   d="scan'208";a="171658076"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2019 10:01:37 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQao4-0002TR-Ko; Tue, 14 May 2019 20:01:36 +0300
Date:   Tue, 14 May 2019 20:01:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        =?iso-8859-1?Q?Cl=E9ment?= Perrochaud 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
Message-ID: <20190514170136.GI9224@smile.fi.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
 <20190513123751.GS9224@smile.fi.intel.com>
 <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com>
 <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
 <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com>
 <CA+icZUWZH-JS=JHLieVd2ga=Zutac2BXd4tk0tSXs+izQ5txOQ@mail.gmail.com>
 <787aff34-b1b9-b9e2-faf3-409d7fc95a52@intel.com>
 <CA+icZUV=TBfabHsbzj_JPnxXBjo114LWVJ==xSS7zVPkajmNgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUV=TBfabHsbzj_JPnxXBjo114LWVJ==xSS7zVPkajmNgw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 04:53:10PM +0200, Sedat Dilek wrote:
> On Tue, May 14, 2019 at 3:57 PM Oleg Zhurakivskyy
> <oleg.zhurakivskyy@intel.com> wrote:

> What about this one?
> 
> diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
> index a28c4265354d..b9e6486aa8fe 100644
> --- a/drivers/nfc/nxp-nci/Kconfig
> +++ b/drivers/nfc/nxp-nci/Kconfig
> @@ -2,8 +2,8 @@ config NFC_NXP_NCI
>         tristate "NXP-NCI NFC driver"
>         depends on NFC_NCI
>         ---help---
> -         Generic core driver for NXP NCI chips such as the NPC100
> -         or PN7150 families.
> +         Generic core driver for NXP NCI chips such as the NPC100 (PN547),
> +         NPC300 (PN548) or PN7150 families.
>           This is a driver based on the NCI NFC kernel layers and
>           will thus not work with NXP libnfc library.
> 
> @@ -19,6 +19,11 @@ config NFC_NXP_NCI_I2C
>           chips.
>           Select this if your platform is using the I2C bus.
> 
> +          Furthermore, the pin control and GPIO driver of the actual SoC or
> +          PCH is needed.
> +          For example set CONFIG_PINCTRL_SUNRISEPOINT=y to activate the
> +          Intel Sunrisepoint (PCH of Intel Skylake) pinctrl and GPIO driver.
> +

Besides some indentation problems (the help lines should be prefixed with
'TAB + 2 spaces'), this is not needed — it's obvious and usually distros
provide all of pin control drivers anyway.

For debugging one may check deferred devices via DebugFS, or use
'initcall_debug', or other facilities.

>           To compile this driver as a module, choose m here. The module will
>           be called nxp_nci_i2c.
> -         Say Y if unsure.
> +         Say N if unsure.


-- 
With Best Regards,
Andy Shevchenko


