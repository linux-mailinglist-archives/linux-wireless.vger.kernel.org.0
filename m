Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB31B80FB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgDXUfx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 16:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgDXUfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 16:35:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F01C09B048
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 13:35:50 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jS536-00FmK6-1R; Fri, 24 Apr 2020 22:35:48 +0200
Message-ID: <259da597c3902c79c9d5c6e171e109dcb68564eb.camel@sipsolutions.net>
Subject: Re: Auth/Assoc/Connect events coming before CMD_CONNECT response
 (hwsim)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 22:35:46 +0200
In-Reply-To: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com> (sfid-20200415_192413_715843_5D57B158)
References: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com>
         (sfid-20200415_192413_715843_5D57B158)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-15 at 10:23 -0700, James Prestwood wrote:
> Hi,
> 
> I have noticed this sometimes happening with mac80211_hwsim where the
> Authenticate, Associate, and Connect events arrive in userspace before
> the actual response to CMD_CONNECT. It seems to be a scheduling/timing
> problem as turning on logging in hostapd or other applications "fixes"
> the issue

Yeah, sounds like a consequence of immediately handling the frames
through.

I guess you could "fix" that by running with wmediumd?

Or adding some kind of fake air latency into hwsim.

johannes

