Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6C4A906E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 23:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355667AbiBCWGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 17:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiBCWGy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 17:06:54 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619AC061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MBkPpCMGtP5tKapRV2F3fF1Sm+CvzADC+b/7o62zs+o=;
        t=1643926014; x=1645135614; b=uVOgZYkFyjuRPDzBpw0yLWLgUVSrjhb744wOGZ/MQQYiX0d
        pjrrtTYWFUiVfPpXtytL6We0MyYL65kyRff3zxNtBd2zHB/XC1/Ehh3+uZEA/dfdtjAyjvkXhtAnN
        0XQbBFhqwLVD0bCD+eNYHyvP7km4yJxcBi8cJWAzXuJ+MJgMGuRqQHMjb7va5UvsYQ/zoUsnWkzaw
        rwWd/xeR5JENhd0Dcm4R3ijqViFy6S2GE6a1w6rolaeXdZ5A/uAAHACNU6rSB2uddMBQ8Fni2BwrL
        AaArbq2Nz6DTsEX7bXSpavjDxlq6MB0TenR2scI6eme5Na7P9PxpBltv/HHGAcBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFkFf-00EFjG-JK;
        Thu, 03 Feb 2022 23:06:51 +0100
Message-ID: <a5c2cbdc9f0c1587f0d27850ca3bbac2d5103e9c.camel@sipsolutions.net>
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 03 Feb 2022 23:06:50 +0100
In-Reply-To: <8557b62e0f1c6a94f7ec9b27a596d7499fd072d7.camel@gmail.com>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
         <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
         <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
         <d8250f97a2be736736374974095f219d858acb1e.camel@sipsolutions.net>
         <58ebff51d64d1ae6b01d85cff7bb9e137e19848a.camel@gmail.com>
         <17e3eb62ed0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
         <8557b62e0f1c6a94f7ec9b27a596d7499fd072d7.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-01-10 at 09:13 -0800, James Prestwood wrote:
> > 
> > Even if it only supports STA mode it can. The constraint being that
> > it is 
> > not associated (or busy trying to associate) to an AP. When it is 
> > associated it has to sit on the channel of the AP, as announced in
> > it's 
> > beacon and/or probe response, at regular intervals. You referred to
> > DPP to 
> > provision the STA so I assume it is not associated, right? Could you
> > write 
> > out the whole scenario as you think it should/could be done?
> 
> Correct, I'm only talking about doing this while not associated.
> 
> As for my intentended scenario I simply want to call CMD_SET_CHANNEL
> then run the entire DPP auth/config protocol while on this channel.
> Then, once finished, call (a new API) CMD_SET_CHANNEL_CANCEL.
> 

So I think Arend and I are approaching this from a different angle :-)

I was mostly thinking about the iwlwifi firmware implementation, to be
honest, which simply doesn't have such a thing today. The closest would
probably be putting it into monitor mode, which of course means you
don't get proper ACK behaviour etc.

I think Arend was probably more thinking of semantics rather than
implementation, surely it'd be _possible_ to do it, but it's not
something that you can _practically_ do today on all hardware.

So practically, if we add such API

 1) it might fix the issue on some devices that can implement it

 2) it would leave us having to emulate it using remain-on-channel or
    similar when the firmware doesn't support

 3) you'd still have to implement it for older kernels

(or we leave out 2, and you have to have the implementation for 3 for
newer kernels too)

I guess I wouldn't particularly mind adding APIs for it, but I'm not
sure I'd want to have to implement and maintain (2).

johannes
