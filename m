Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDA516D2B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384027AbiEBJTS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384160AbiEBJS5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 05:18:57 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 02:15:28 PDT
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D72BB3C;
        Mon,  2 May 2022 02:15:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80A1141139;
        Mon,  2 May 2022 11:05:45 +0200 (CEST)
Date:   Mon, 2 May 2022 11:05:42 +0200
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Crash / Null pointer dereference in l2cap_chan_send()
Message-ID: <Ym+exknyLoxOZqFe@sellars>
References: <20201110062039.GC2423@otheros>
 <20201110205950.GF2423@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110205950.GF2423@otheros>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 10, 2020 at 09:59:50PM +0100, Linus Lüssing wrote:
> On Tue, Nov 10, 2020 at 07:20:39AM +0100, Linus Lüssing wrote:
> > [...]
> >
> > The issue was introduced with the following commit:
> > 
> >     f4bfdc5e571e ("iwlwifi: mvm: stop supporting swcrypto and bt_coex_active module parameters")
> >     * first affected tag: v5.8-rc1
> > 
> 
> PS: As this commit mentioned bt_coex_active, I retried with a
> vanilla 5.9.6 kernel while leaving bt_coex_active at its
> default value. That is leaving it enabled while all previous tests
> I did had it disabled.
> 
> However I still get the Bluetooth A2DP freeze and subsequent
> kernel panics.
> [...]

I did a few more tests and found out that it was the old iwlwifi
firmware causing the kernel panics for me when Bluetooth co-existence
is enabled.

With firmware-iwlwifi_20170823-1_all.deb on Debian I can reproduce
the issue, with firmware-iwlwifi_20180518-1~bpo9+1_all.deb or
firmware-iwlwifi_20210818-1_all.deb I can't.

Also, I can still reproduce the kernel panic with firmware-iwlwifi at
version 20170823-1 and with a recent Linux kernel on Debian Sid
(linux-image-5.17.0-1-amd64, 5.17.3-1). So nothing which has fixed
it in the upstream kernel since v5.8-rc1.


I'm a bit surprised that a non-free firmware can create kernel
panics in "random" code paths. But maybe that's expected as
whatever is running the iwlwifi firmware has access to more memory
areas than I would like it to have? Let me know if I should dig
deeper, if there is something that should/could be fixed in the
upstream, opensource iwlwifi driver to prevent such kernel panics.

Regards, Linus


PS: firmware-iwlwifi_20170823-1_all.deb seems unavailable on Debian
at the moment, even the archives. But I found a copy in the Kali
Linux archives:
http://old.kali.org/kali/pool/non-free/f/firmware-nonfree/firmware-iwlwifi_20170823-1_all.deb
