Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05C6EFF0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 07:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfD3Fag (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 01:30:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:4457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfD3Fag (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 01:30:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 22:30:35 -0700
X-ExtLoop1: 1
Received: from sgvili-mobl.ger.corp.intel.com ([10.252.0.36])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2019 22:30:33 -0700
Message-ID: <bad0f559fdd6eb83c9354ee473c1d7377e83b4d9.camel@intel.com>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with
 the wireless-drivers tree
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>
Date:   Tue, 30 Apr 2019 08:30:32 +0300
In-Reply-To: <20190430140831.6095243c@canb.auug.org.au>
References: <20190430140831.6095243c@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-04-30 at 14:08 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
> 
>   drivers/net/wireless/intel/iwlwifi/fw/file.h
> 
> between commit:
> 
>   b35f63972c5c ("iwlwifi: dbg_ini: check debug TLV type explicitly")
> 
> from the wireless-drivers tree and commit:
> 
>   aee1b6385e29 ("iwlwifi: support fseq tlv and print fseq version")
> 
> from the wireless-drivers-next tree.
> 
> I fixed it up (the latter is a superset of the former) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Thanks, Stephen!

Your resolution is correct, thanks.  I accidentally included the block
that was already in b35f63972c5c when I rebased aee1b6385e29, but it's
harmless (except for the minimal conflict it causes).

--
Cheers,
Luca.

