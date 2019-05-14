Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D11C697
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENKDb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 06:03:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:46925 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfENKDb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 06:03:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 03:03:31 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2019 03:03:29 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQUHQ-0006Bz-PK; Tue, 14 May 2019 13:03:28 +0300
Date:   Tue, 14 May 2019 13:03:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment?= Perrochaud 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
Message-ID: <20190514100328.GB9224@smile.fi.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUVn9tHQ3Zug0u2scbvGFfrLag_WYdzs9FCBJsGJ4bhuzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVn9tHQ3Zug0u2scbvGFfrLag_WYdzs9FCBJsGJ4bhuzw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 09:48:15PM +0200, Sedat Dilek wrote:
> On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> Is it possible to have an info in dmesg log when nxp-nci_i2c kernel
> module is loaded?

We have 'initcall_debug' for such purposes.

-- 
With Best Regards,
Andy Shevchenko


