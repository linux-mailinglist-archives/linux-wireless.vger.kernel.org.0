Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6517906C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 13:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbgCDMb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 07:31:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:3078 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbgCDMb1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 07:31:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 04:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="243934693"
Received: from mtosmanx-mobl.amr.corp.intel.com ([10.249.254.162])
  by orsmga006.jf.intel.com with ESMTP; 04 Mar 2020 04:31:23 -0800
Message-ID: <292a5e4477ce3069950ee513d207e70ae218af9f.camel@intel.com>
Subject: Re: Non-working Web site URL in MAINTAINERS
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Mar 2020 14:31:22 +0200
In-Reply-To: <b5cfc13d-8d26-65e3-0377-8d53979c0096@molgen.mpg.de>
References: <b5cfc13d-8d26-65e3-0377-8d53979c0096@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Paul,

Thanks for your report and sorry for the delay in responding (I was on
vacations).

I'm working with our IT department to change the URL this domain is
forwarded to.  But I will also change the MAINTAINERS file so that it
points directly to the correct URL, namely:

https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi

--
Cheers,
Luca.


On Sat, 2020-02-15 at 11:40 +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> http://intellinuxwireless.org redirects to [1], and that page is not 
> found (404 error).
> 
> If you fix this, maybe you can also set up HTTPS.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: http://wireless.kernel.org/en/users/Drivers/iwlwifi

