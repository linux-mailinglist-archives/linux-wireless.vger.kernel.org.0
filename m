Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA17A107200
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKVMMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:12:41 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44452 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVMMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:12:40 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY7nj-0002lN-42; Fri, 22 Nov 2019 13:12:39 +0100
Message-ID: <3e7bea0cc643714ec90978a7999022544a39b118.camel@sipsolutions.net>
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from
 mt76
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com
Date:   Fri, 22 Nov 2019 13:12:37 +0100
In-Reply-To: <20191119060610.76681-3-kyan@google.com> (sfid-20191119_070625_522904_ADC19544)
References: <20191119060610.76681-1-kyan@google.com>
         <20191119060610.76681-3-kyan@google.com>
         (sfid-20191119_070625_522904_ADC19544)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-11-18 at 22:06 -0800, Kan Yan wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Felix recently added code to calculate airtime of packets to the mt76
> driver. Import this into mac80211 so we can use it for airtime queue limit
> calculations.
> 
> The airtime.c file is copied verbatim from the mt76 driver, and adjusted to
> be usable in mac80211. This involves:
> 
> - Switching to mac80211 data structures.
> - Adding support for 160 MHz channels and HE mode.
> - Moving the symbol and duration calculations around a bit to avoid
>   rounding with the higher rates and longer symbol times used for HE rates.

:)

I'll apply this, I guess, but I do wonder to what extent it overlaps
with cfg80211_calculate_bitrate()?

johannes

