Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB122E5CB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jul 2020 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgG0GW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jul 2020 02:22:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:53448 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgG0GW2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jul 2020 02:22:28 -0400
IronPort-SDR: MvcTnF2hWmXyCFnEXmgTJE26gNESBiL0nmOuZHRt1oIaPo1V/j3ijT0oSnghb/chPZz7Ky2/UX
 tH/NuqzPoE1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150139875"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="150139875"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 23:22:28 -0700
IronPort-SDR: cVcA1MbSggbVlEp+p7dXxBiOAuCwWtJzSAgPMiIwkSTcLQQvmiyiUKeDcV/LuesgJvzUyMFGYb
 smB9QGXQIS4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="433786627"
Received: from bfarkas-mobl.ger.corp.intel.com ([10.249.254.210])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2020 23:22:26 -0700
Message-ID: <80afa796cefcc78f8a56059b279d6d424bc00d5e.camel@intel.com>
Subject: Re: iwlwifi: Direct firmware load for iwl-debug-yoyo.bin failed
 with error -2
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 27 Jul 2020 09:22:25 +0300
In-Reply-To: <87mu3magfp.fsf@tynnyri.adurom.net>
References: <CA+icZUWoycCvAAs5H0sigHTB+GGhX5NRVonYqKg7BRLB97dGkA@mail.gmail.com>
         <87mu3magfp.fsf@tynnyri.adurom.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-07-26 at 10:22 +0300, Kalle Valo wrote:
> Sedat Dilek <sedat.dilek@gmail.com> writes:
> 
> > Hi,
> > 
> > I am seeing this failed/error message for a long time:
> > 
> > [Sat Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> > for iwl-debug-yoyo.bin failed with error -2
> > 
> > So, I started to look for the file "iwl-debug-yoyo.bin" in [1], but failed.
> > AFAICS this is a file for debugging purposes?
> > 
> > Why do I see such a message as an end-user w/o iwlwifi-debugging enabled?
> > For some end-users I can imagine this looks scary and they will look
> > into their cupboards and below their beds but will not find any
> > monsters.
> > 
> > I found a rename from an ini file to bin here:
> > commit 8d9e982bf9bf ("iwlwifi: dbg_ini: rename external debug
> > configuration file")
> > 
> > Is "iwl-debug-yoyo.bin" a binary or as before an ini (text) file I
> > have to configure somehow.
> > 
> > Does this need to be guarded by some "ifdef CONFIG_IWLWIFI_DEBUG" in
> > "drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c"?
> > 
> > Or does drivers/net/wireless/intel/iwlwifi/Makefile needs some tuning
> > - as said I have no iwlwifi debugging enabled via Kconfig?
> > ...
> > iwlwifi-objs            += iwl-dbg-tlv.o
> > 
> > Please enlighten me/us?
> > 
> > Thanks.
> > 
> > Regards,
> > - Sedat -
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/
> > [2] https://git.kernel.org/linus/e8d9e982bf9bf0e6f99099f1f09a37563b2b95b5
> > 
> > > From my dmesg-output:
> > 
> > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: can't disable ASPM; OS
> > doesn't have ASPM control
> > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: loaded firmware
> > version 18.168.6.1 6000g2b-6.ucode op_mode iwldvm
> > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> > for iwl-debug-yoyo.bin failed with error -2
> 
> There's an RFC patch about this:
> 
> https://patchwork.kernel.org/patch/11625759/
> 
> I think that should be applied. Intel folks, should I take that directly
> to wireless-drivers-next?

As I wrote in the other thread, yes, please.  Go ahead and merge it.

--
Cheers,
Luca.

