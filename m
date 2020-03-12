Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF191831EE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgCLNqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:46:45 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38045 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:46:45 -0400
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1CA8D24000D;
        Thu, 12 Mar 2020 13:46:41 +0000 (UTC)
Message-ID: <8834172fd48be85552a201c6252fcc135492b16e.camel@hadess.net>
Subject: Re: [PATCH v2] rtl8188eu: Add rtw_led_enable module parameter
From:   Bastien Nocera <hadess@hadess.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Thu, 12 Mar 2020 14:46:41 +0100
In-Reply-To: <20200312133800.096EDC433CB@smtp.codeaurora.org>
References: <869a61437edb52d60721ac8b2a7cccc43e3b0fb4.camel@hadess.net>
         <20200312133800.096EDC433CB@smtp.codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92 (3.35.92-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-12 at 13:38 +0000, Kalle Valo wrote:
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > Make it possible to disable the LED, as it can be pretty annoying
> > depending on where it's located.
> > 
> > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > out-of-tree version.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> 
> Please use "staging: " prefix for staging patches, easier for me to
> filter that
> way.

Do you want me to resend it, or will you amend this patch?

Cheers

