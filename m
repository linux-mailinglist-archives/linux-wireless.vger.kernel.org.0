Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB50173434
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 10:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgB1JhW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 04:37:22 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:60630 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgB1JhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 04:37:22 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j7c59-000Tqb-Jm; Fri, 28 Feb 2020 10:37:19 +0100
Message-ID: <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
Subject: Re: [mac80211]: wds link and Radius authentication issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Steve deRosier <derosier@gmail.com>,
        Cedric VONCKEN <cedric.voncken@acksys.fr>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 28 Feb 2020 10:37:17 +0100
In-Reply-To: <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com> (sfid-20200228_022737_077710_BB93474D)
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
         (sfid-20200228_022737_077710_BB93474D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-02-27 at 17:26 -0800, Steve deRosier wrote:
> On Thu, Feb 27, 2020 at 9:37 AM Cedric VONCKEN <cedric.voncken@acksys.fr> wrote:
> > Where can I found some information on how the wds system should
> > work? I looked in 802.11-2012 standard and I didn't found any
> > informations.
> > 
> 
> I think Wikipedia says it best:
> "WDS may be incompatible between different products (even occasionally
> from the same vendor) since the IEEE 802.11-1999 standard does not
> define how to construct any such implementations or how stations
> interact to arrange for exchanging frames of this format. The IEEE
> 802.11-1999 standard merely defines the 4-address frame format that
> makes it possible."

I think really what Cedric is asking is how this is/should be done with
mac80211's 4-addr client/AP mode(s)?

Cedric, are you running mac80211 on both sides of the link, the AP and
the (4-addr) client?

johannes

