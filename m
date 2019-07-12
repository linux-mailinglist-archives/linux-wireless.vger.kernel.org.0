Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FE675AB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGLUGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 16:06:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37488 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfGLUGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 16:06:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hm1oC-0004IG-F5; Fri, 12 Jul 2019 22:06:20 +0200
Message-ID: <a4c6be4ba7cf8594d05af78a7e4dfa1310d0c3b9.camel@sipsolutions.net>
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jouni Malinen <j@w1.fi>, Tova Mussai <tova.mussai@intel.com>
Date:   Fri, 12 Jul 2019 22:06:16 +0200
In-Reply-To: <4ea863a3-656e-0c7a-57f0-b7cf88614233@quantenna.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
         <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
         <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
         <48a43287e65e1d24082dea2cc32ca14998acb8d1.camel@sipsolutions.net>
         <8ca6ef2e-b41b-da40-b29a-77666d440495@broadcom.com>
         <a6e317539fbd53ad5e2fd62ce3544260a3f74e77.camel@sipsolutions.net>
         <d22d5159-60d3-5926-5b3f-bdc3ff07af82@broadcom.com>
         <4ea863a3-656e-0c7a-57f0-b7cf88614233@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-12 at 15:16 +0000, Igor Mitsyanko wrote:
> On 7/12/19 1:40 PM, Arend Van Spriel wrote:
> > 
> > 
> > The inclusion of the "HE extended capabilities" element is determined by 
> > the dot116GOptionImplemented option. (band[6G] != NULL) provides that 
> > condition although there are other ways to solve that I guess :-p
> > Come to think of it. Does mac80211 need that. Guess IEs are provided by 
> > user-space, right?
> 
> Maybe not for transmission, but we probably will need to parse peer's 
> IEs at least to properly fill SCAN information and properly report 
> peer's capabilities.

Probe requests may also be transmitted there though 6 GHz scanning is
sufficiently complicated this might not happen; as well as association
request which definitely this is relevant to.

> > > However, from a feature advertisement point of view, we might very well
> > > consider 6 GHz to be a separate nl80211 band, in particular if there
> > > *are* indeed differences around what rates are permitted? Which is
> > > really the only place where we care. Or maybe, thinking about this more,
> > > if there could be devices that have different capabilities in 6 GHz than
> > > in 5 GHz, in the sense of HT/VHT/HE capabilities?
> > 
> > Regarding rates the answer seem to be in clause 26.17.2.1 as well:
> > 
> > """
> > A STA shall not transmit an HT PPDU in the 6 GHz band. A STA shall not 
> > transmit a VHT PPDU in the
> > 6 GHz band. A STA shall not transmit a DSSS, HR/DSSS, or ERP-OFDM PPDU 
> > in the 6 GHz band.
> > """
> > 
> > I may be wrong but that seems to say only HE rates are allowed.
> 
> Unless I'm wrong myself, this leaves us with 5GHz OFDMA PHY (802.11a). 
> Further in 26.17.2.1 spec states the following regarding beacons:
> "the Beacon frames may be sent in non-HT duplicate PPDUs."

OFDMA is HE :-)

802.11a is OFDM (Clause 17, at least in 802.11-2016), but I think you're
otherwise right.

> I think we do need a new value in band enum, it seems natural because:
> - it has different capabilities
> - it has different rates
> maintaining this information in any other way seems will be much more 
> cumbersome.

I'm starting to agree here despite having initially thought it wasn't
necessary, and so I'll review Arend's patches again with an eye towards
actually merging them.

johannes

