Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC1C2FCA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfJAJOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:14:25 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57668 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbfJAJOZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:14:25 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFEEh-0003RM-Rj; Tue, 01 Oct 2019 11:14:23 +0200
Message-ID: <83bde7f521e636903b6b386faaa31b73479add8b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: Add LIVE_ADDR_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 01 Oct 2019 11:14:23 +0200
In-Reply-To: <b43f737c06a392957e6f651d59282a3f36fd05e5.camel@gmail.com> (sfid-20190913_231625_014352_843A9715)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         (sfid-20190913_220113_419728_36032050) <6c85d9b108825939afb84ebc8a708a211f7e2b98.camel@sipsolutions.net>
         <38c222129dd182de4c55e536a89eada7f58a1bf1.camel@gmail.com>
         (sfid-20190913_225826_111097_E5ED9AB1) <47aaaccf7d8fb58587f0cfbe38acd18e1420dc9a.camel@sipsolutions.net>
         <b43f737c06a392957e6f651d59282a3f36fd05e5.camel@gmail.com>
         (sfid-20190913_231625_014352_843A9715)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > > Because userspace needs to know if this is supported?
> > > IFF_LIVE_ADDR_CHANGE is a private flag... AFAIK userspace has no
> > > way of
> > > obtaining this.
> > 
> > Oh, annoying.
> > 
> > But that doesn't really mean that nl80211 is an appropriate place to
> > advertise it, IMHO?
> 
> The intention of the flag was not soley related to
> CMD_CONNECT/CMD_AUTHENTICATE. Its an indication that the
> hardware/driver supports a live address change. If you don't want it
> here could you suggest a better location for it?

I guess RTNL would be the right place? This can hardly be specific to
wireless, the flag comes from elsewhere.

johannes

