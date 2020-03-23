Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8418F1D3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 10:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCWJaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 05:30:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:52612 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgCWJaQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 05:30:16 -0400
IronPort-SDR: wtEkCzOqBJCZCXTvJ7JpJtqrrFFJWKBNCejQa5R6+fYcCTN/yE7mFgB9gDsc7moSMlvrGfoXJm
 4qUzhYeib9og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 02:30:15 -0700
IronPort-SDR: Y9BvRnAV2MydbT60DZ7ploFSp0UB2jlFdSIEiBifKQ/sEPxsDUiRluTEjki1D+nrriMloWx0L2
 kGlIUuom0eww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="249558814"
Received: from mkroczek-mobl.ger.corp.intel.com ([10.249.254.181])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2020 02:30:14 -0700
Message-ID: <3abf2b162f18e41345e230301d57348ba348c09f.camel@intel.com>
Subject: Re: Is iwlwifi-9260-th-b0-jf-b0-46.ucode a debug firmware?
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Equipe Soft <equipe.soft.isere@gmail.com>, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 11:30:13 +0200
In-Reply-To: <CAFb4eQmRk8o_sR2-s0h4wUdgNW2w2tqgUjaJ4t0Ca84iZL59fQ@mail.gmail.com>
References: <CAFb4eQ=Y8XUGsE2c2tur4EPTC=81Ck3tRPF9Uf+6zBnA47j-Dw@mail.gmail.com>
         <CAFb4eQkFGM1rhrccExu6B5_5-3g60nDD_aRt3JDA2qT9FVbDig@mail.gmail.com>
         <CAFb4eQmRk8o_sR2-s0h4wUdgNW2w2tqgUjaJ4t0Ca84iZL59fQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2020-03-23 at 10:13 +0100, Equipe Soft wrote:
> Hello, we really wonder if the version of the firmware we use is the right one.
> I put Luca Coelho in copy according to his activity on git about
> firmware: thank you for your help Luca.
> Best regards.
> @team.
> 
> 
> Le ven. 13 mars 2020 à 11:05, Equipe Soft
> <equipe.soft.isere@gmail.com> a écrit :
> > Hello, do you have any news about the issue?
> > Best regards.
> > @team
> > Le ven. 6 mars 2020 à 10:33, Equipe Soft <equipe.soft.isere@gmail.com> a écrit :
> > > Hello,
> > > we are using backport-iwlwifi core45 drivers and latest AC9260
> > > firmware binary blob:
> > > latest firmware available in Intel iwlwifi firmware fork:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/commit/iwlwifi-9260-th-b0-jf-b0-46.ucode?id=4bebf45872a9818a17e2079118500030a8fa377a
> > > 2019-11-28 iwlwifi: update FWs to core47-142 release
> > > 
> > > At runtime, we noticed these log traces:
> > > iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
> > > iwlwifi 0000:01:00.0: Found debug configuration: 0
> > > iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
> > > So it seems that it is a debug firmware...
> > > 
> > > Q0) can you please confirm that we can safely use this debug firmware
> > > in our product ?

You can use this firmware.  It's a production firmware and not a
debugging version.


> > > Q1) is debug mode deliberately enabled in newer firmware or is it an
> > > error (maybe like forgotten to disable it) ?

It is deliberately enabled.  We enable some debugging options by
default so they can be extracted if needed.


> > > Q2) is there an impact on performance with this debug firmware ? WiFi
> > > speed/throughput may be reduced or not ?

No, there isn't any impact on performance.


> > > Q3) moreover, can you please confirm whether or not WoWLAN (aka
> > > Wake-on-WLAN) is working with this debug firmware ?

WoWLAN should work fine with this firmware.  



> > > Q4) is WoWLAN working with any AC9260 firmware version ? and any
> > > iwlwifi driver version ?

It has been supported for many years now.  AC9260 got support for this
from the first version of the driver/FW that were publicly released.

HTH.

--
Cheers,
Luca.

