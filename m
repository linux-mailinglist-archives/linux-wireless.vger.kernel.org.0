Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADF129631
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 14:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWNBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 08:01:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:54442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfLWNBT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 08:01:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 05:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="367054476"
Received: from tblake-mobl2.ger.corp.intel.com ([10.252.4.201])
  by orsmga004.jf.intel.com with ESMTP; 23 Dec 2019 05:01:16 -0800
Message-ID: <16647dbe5d9c8431060dcf6169c12c3267d67d0d.camel@intel.com>
Subject: Re: PROBLEM: iwlwifi in 5.4 does not load firmware for Intel device
 9560
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Stuart Little <achirvasub@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 23 Dec 2019 15:01:16 +0200
In-Reply-To: <20191223125742.GA2586@system76-pc.localdomain>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
         <20191208203810.GA2920@system76-pc.localdomain>
         <20191222224207.GA2408@system76-pc.localdomain>
         <ec9092a28196f24c39051b89f9dc87b40942b6de.camel@intel.com>
         <20191223125742.GA2586@system76-pc.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-12-23 at 07:57 -0500, Stuart Little wrote:
> On Mon, Dec 23, 2019 at 02:52:11PM +0200, Luciano Coelho wrote:
> > Hi,
> > 
> > The fix for this is already in v5.5-rc3:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db5cce1afc8d2475d2c1c37c2a8267dd0e151526
> > 
> 
> I was actually going to write just now to report this: I've checked
> that the very latest 5.5.0-rc3 works fine on this machine.

Great! Thanks for letting me know.  I have now sent the patch to v5.4
stable, hopefully it will be picked up soon.

--
Cheers,
Luca.

