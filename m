Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE81190B2F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 11:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCXKgM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 06:36:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50791 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCXKgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 06:36:12 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C8806C001F;
        Tue, 24 Mar 2020 10:36:10 +0000 (UTC)
Message-ID: <8a30069c82aaa737030071d988436a85dce1b60f.camel@hadess.net>
Subject: Re: [PATCH v2] rtl8188eu: Add rtw_led_enable module parameter
From:   Bastien Nocera <hadess@hadess.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Tue, 24 Mar 2020 11:36:10 +0100
In-Reply-To: <87r1xx64nn.fsf@codeaurora.org>
References: <869a61437edb52d60721ac8b2a7cccc43e3b0fb4.camel@hadess.net>
         <20200312133800.096EDC433CB@smtp.codeaurora.org>
         <8834172fd48be85552a201c6252fcc135492b16e.camel@hadess.net>
         <87r1xx64nn.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 (3.36.0-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-12 at 16:15 +0200, Kalle Valo wrote:
> Bastien Nocera <hadess@hadess.net> writes:
> 
> > On Thu, 2020-03-12 at 13:38 +0000, Kalle Valo wrote:
> > > Bastien Nocera <hadess@hadess.net> wrote:
> > > 
> > > > Make it possible to disable the LED, as it can be pretty
> > > > annoying
> > > > depending on where it's located.
> > > > 
> > > > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > > > out-of-tree version.
> > > > 
> > > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > 
> > > Please use "staging: " prefix for staging patches, easier for me
> > > to
> > > filter that
> > > way.
> > 
> > Do you want me to resend it, or will you amend this patch?
> 
> Greg applies staging patches so it's up to him. Ah, only noticed now
> tha
> you didn't CC him so he didn't see this patch. You should check how
> staging patches are supposed to be sent, I don't know that subsystem
> exactly works.

Done.

Cheers

