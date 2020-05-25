Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09441E0A11
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbgEYJRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389546AbgEYJRz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:17:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A1C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 02:17:54 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd9Et-002bRu-HB; Mon, 25 May 2020 11:17:43 +0200
Message-ID: <f925bbe557bd1414d0aee506a3c0c92173f522f9.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 11:17:42 +0200
In-Reply-To: <12222a10-e5d9-514e-7667-0602919a4866@lwfinger.net> (sfid-20200525_020302_358017_7777E473)
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
         <20200524111751.GA914918@wp.pl>
         <CALjTZvbHbMEWTmZk4Li5ZNAETdVd3Q_kHUS6KQw+WDS6ayE9vA@mail.gmail.com>
         <12222a10-e5d9-514e-7667-0602919a4866@lwfinger.net>
         (sfid-20200525_020302_358017_7777E473)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-05-24 at 19:02 -0500, Larry Finger wrote:
> On 5/24/20 10:07 AM, Rui Salvaterra wrote:
> > Hi, Stanislaw,
> > 
> > On Sun, 24 May 2020 at 12:18, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> > > AFICT more work need to be done to support MFP by HW encryption properly
> > > on rt2x00. See this message and whole thread:
> > > https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/
> > > 
> > > Stanislaw
> > 
> > This RT2790 has been working just fine with my patch for hours. No
> > hangs at all. What additional bad behaviour should I expect?
> 
> I read the above thread. It seems that the best thing to do with b43 is to send 
> the MFP_CAPABLE only when nohwcrypt is set as a module option. I wish it could 
> have worked the other way, but I think the potential for keys getting out of 
> sync should be avoided.I still need to find a place the log something when 
> ciphers are present and the option is not set.

With b43 you have much less to worry about though.

Contrary to what I just said in my other email (oops, sorry) there are
two problems here:

 1) RX of management frames - if hw/fw erroneously attempts to decrypt
 2) PN assignment during TX

1) you can test easily with b43, say send a deauth from the AP to the
client and check the frame goes through properly. If it does, then the
device isn't attempting to decrypt.

2) isn't an issue with b43 since it does it in software (I believe in
mac80211) anyway.

johannes

