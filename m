Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5C19063C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCXH3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 03:29:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43680 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727358AbgCXH3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 03:29:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGdzq-0002dg-3d; Tue, 24 Mar 2020 09:29:10 +0200
Message-ID: <122b75308eea43076367d06879552270e11dfbb4.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 24 Mar 2020 09:29:08 +0200
In-Reply-To: <87wo7a8cex.fsf@kamboji.qca.qualcomm.com>
References: <20200324111653.35c368e4@canb.auug.org.au>
         <87wo7a8cex.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with
 the wireless-drivers tree
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-24 at 09:00 +0200, Kalle Valo wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > Today's linux-next merge of the wireless-drivers-next tree got a
> > conflict in:
> > 
> >   drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > 
> > between commit:
> > 
> >   cf52c8a776d1 ("iwlwifi: pcie: add 0x2526/0x401* devices back to cfg detection")
> > 
> > from the wireless-drivers tree and commits:
> > 
> >   67eb556da609 ("iwlwifi: combine 9260 cfgs that only change names")
> >   d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device tables")
> > 
> > from the wireless-drivers-next tree.
> > 
> > I fixed it up (I am not sure wat to do with this, so I just dropped
> > the former changes for now) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Thanks Stephen. Luca, how do you propose to fix this conflict?

The resolution is correct.  Just drop the cf52c8a776d1 changes, since
the list of specific subsytem device IDs are not necessary after
d6f2134a3831 anymore.  The detection is based on other characteristics
of the devices.

Thanks!

--
Cheers,
Luca.

