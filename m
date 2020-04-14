Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEABC1A827D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407435AbgDNPVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 11:21:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:55882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407370AbgDNPUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 11:20:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jONM4-000IqP-Lx; Tue, 14 Apr 2020 18:20:05 +0300
Message-ID: <21ab68ddec08d30c21ad8600a79a3d4343a1755d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 14 Apr 2020 18:20:03 +0300
In-Reply-To: <6e42e11cfe24f88ae1dac2ad793f9c73751e6c7d.camel@suse.de>
References: <bdb4170b21167cae89523fa688db6699539474bf.camel@suse.de>
         <6e42e11cfe24f88ae1dac2ad793f9c73751e6c7d.camel@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: iwlwifi won't probe with linux-next
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-04-14 at 16:52 +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2020-04-13 at 14:47 +0200, Nicolas Saenz Julienne wrote:
> > Hi,
> > I'm having trouble with my iwlwifi device on the latest linux-next.
> > Essentially
> > it fails at probe:
> > 
> > 	nico@linux-9qgx:~> dmesg | grep iwl
> > 	[    4.650950] iwlwifi 0000:28:00.0: enabling device (0000 -> 0002)
> > 	[    4.720086] iwlwifi: probe of 0000:28:00.0 failed with error -110
> > 
> > I made some research and the timeout happens after the call to iwl_poll_bit()
> > in iwl_finish_nic_init().
> > 
> > 
> > 

[...]

> > Note that I have a built kernel just for this, so I'll be happy to test
> > anything. Also note that I updated my firmware to the last version available
> > in
> > the linux-firmware repo.
> 
> Well, I updated my system's BIOS and the issue went away. Sorry for the noise.

That's great to hear! Don't hesitate to report if you experience any
other issue.

--
Cheers,
Luca.

