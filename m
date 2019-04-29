Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2680EDB78
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 07:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfD2FTr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 01:19:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51134 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbfD2FTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 01:19:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hKyhU-0007jU-37; Mon, 29 Apr 2019 08:19:36 +0300
Message-ID: <cc5e71b2ae7c72b643b9666897bbf6eda4bddbb6.camel@coelho.fi>
Subject: Re: linux-next: manual merge of the net-next tree with the
 wireless-drivers tree
From:   Luca Coelho <luca@coelho.fi>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 29 Apr 2019 08:19:34 +0300
In-Reply-To: <20190429115338.5decb50b@canb.auug.org.au>
References: <20190429115338.5decb50b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stephen,

On Mon, 2019-04-29 at 11:54 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> 
> between commits:
> 
>   154d4899e411 ("iwlwifi: mvm: properly check debugfs dentry before using it")
>   d156e67d3f58 ("iwlwifi: mvm: fix merge damage in iwl_mvm_vif_dbgfs_register()")
> 
> from the wireless-drivers tree and commit:
> 
>   c9af7528c331 ("iwlwifi: mvm: no need to check return value of debugfs_create functions")
> 
> from the net-next tree.
> 
> I fixed it up (the latter removed the code modified by the former, so I
> just did that) and can carry the fix as necessary. This is now fixed as
> far as linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

I checked your merge and it looks good, thanks!

--
Cheers,
Luca.

