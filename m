Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC41076F9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 19:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKVSIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 13:08:53 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:49088 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfKVSIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 13:08:53 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iYDIK-0003FU-46; Fri, 22 Nov 2019 19:04:38 +0100
Message-ID: <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 22 Nov 2019 19:04:33 +0100
In-Reply-To: <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
         <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
         <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 10:01 -0800, Thomas Pedersen wrote:
> On 11/22/19 4:38 AM, Johannes Berg wrote:
> > Hi,
> > 
> > On Mon, 2019-11-18 at 21:35 -0800, Thomas Pedersen wrote:
> > > This patchset tries to make mac80211 power save testable with the hostap
> > > hwsim tests, and fixes a bug in STA power save.
> > > 
> > > Basic tests for AP and STA power save will be submitted to hostap
> > > separately.
> > 
> > Cool :)
> > 
> > I was going to apply all of these, but then it turned out that the first
> > one causes a bunch of hwsim tests to fail?
> 
> OK. If you point me toward which tests started to fail I can take a
> look.

Various. Jouni just said mostly concurrency ones, e.g.

p2p_cli_invite
ap_cipher_tkip_countermeasures_ap_mixed_mode
discovery_while_go_p2p_dev
radius_macacl_unreachable

but I saw quite a few more failing as well, though not always entirely
reproducibly.

johannes

