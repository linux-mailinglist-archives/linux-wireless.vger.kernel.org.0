Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD036C171
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhD0JFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhD0JF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 05:05:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B1C061574
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 02:04:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lbJe7-000dG4-R7; Tue, 27 Apr 2021 11:04:44 +0200
Message-ID: <70eb55bc358d4539a8602eb0f0e7cda0757e3b3e.camel@sipsolutions.net>
Subject: Re: [PATCH] staging: rtl8723bs: fix monitor netdev
 register/unregister
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <greg@kroah.com>
Cc:     linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
        Harald Arnesen <harald@skogtun.org>
Date:   Tue, 27 Apr 2021 11:04:42 +0200
In-Reply-To: <YIfTZKtMcMAB2e4k@kroah.com>
References: <20210426212801.3d902cc9e6f4.Ie0b1e0c545920c61400a4b7d0f384ea61feb645a@changeid>
         <YIeuW57v5/qPwlzY@kroah.com>
         <aad26597fc709dd67bf010b60590120148bc16c6.camel@sipsolutions.net>
         <YIfTZKtMcMAB2e4k@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-04-27 at 11:03 +0200, Greg KH wrote:
> > There's another call to register_netdevice() here but I don't think
> > that's affected, however, it's obviously utterly broken in the first
> > place:
> > 
> >         if (!rtnl_is_locked())
> >                 unregister_netdev(cur_pnetdev);
> >         else
> >                 unregister_netdevice(cur_pnetdev);
> > 
> > *sigh*.
> 
> Sorry, these staging wireless drivers are really getting annoying.
> Maybe I need to turn an intern onto them to just get them fixed up and
> out of here to be a 'real' driver.

:)

FWIW, in this case it looks like it's actually not even incorrect,
because it's guaranteed to already hold the RTNL *itself*. Just all that
code can be removed.

johannes

