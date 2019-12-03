Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1F10F90B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 08:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLCHl6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 02:41:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:29477 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfLCHl5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 02:41:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 23:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="242282973"
Received: from cmccall-mobl1.ger.corp.intel.com ([10.252.22.53])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2019 23:41:55 -0800
Message-ID: <7808e30fc20684cc0b47a5caf36a747e179c035c.camel@intel.com>
Subject: Re: [PATCH v1.2] Revert "iwlwifi: assign directly to iwl_trans->cfg
 in QuZ detection"
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Anders Kaseorg <andersk@mit.edu>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 03 Dec 2019 09:41:54 +0200
In-Reply-To: <0101016ecab326d1-88123857-cf37-47ab-b452-13658625364c-000000@us-west-2.amazonses.com>
References: <alpine.DEB.2.21.999.1912010127330.108936@department-of-alchemy.mit.edu>
         <alpine.DEB.2.21.999.1912021653360.21300@department-of-alchemy.mit.edu>
         <alpine.DEB.2.21.999.1912021706060.21300@department-of-alchemy.mit.edu>
         <0101016ecab326d1-88123857-cf37-47ab-b452-13658625364c-000000@us-west-2.amazonses.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-12-03 at 07:39 +0000, Kalle Valo wrote:
> Anders Kaseorg <andersk@mit.edu> writes:
> 
> > This reverts commit 968dcfb4905245dc64d65312c0d17692fa087b99.
> > 
> > Both that commit and commit 809805a820c6445f7a701ded24fdc6bbc841d1e4
> > attempted to fix the same bug (dead assignments to the local variable
> > cfg), but they did so in incompatible ways. When they were both merged,
> > independently of each other, the combination actually caused the bug to
> > reappear, leading to a firmware crash on boot for some cards.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=205719
> > 
> > Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> > ---
> > [Nope it was more than just format=flowed damage. This one should be
> > better for real.]
> 
> This is nitpicking but as a general comment I would prefer to use simple
> version numbering v2, v3 and so on. Trying to sort v1.2 in a script is
> awful. So calling this version v3 is very much preferred, it's not like
> we are running out of numbers :)

Kalle, this patch makes sense.  There was some merge damage because the
functions were moved around and the local variables' names have
changed, causing this mess.

Can you please take this patch to v5.4 fixes when you're satisfied?

Thanks!

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Cheers,
Luca.

