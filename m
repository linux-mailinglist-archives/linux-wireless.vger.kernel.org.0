Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1333119A608
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgDAHPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 03:15:25 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33690 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHPZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 03:15:25 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJXat-00BUJo-NK; Wed, 01 Apr 2020 09:15:23 +0200
Message-ID: <1fb3634babea0a8bd0021493919d3ebd0e279087.camel@sipsolutions.net>
Subject: Re: [RFC 0/7] add a KHz component to wireless channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 01 Apr 2020 09:15:22 +0200
In-Reply-To: <20200401062150.3324-1-thomas@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:

> Some cfg80211 and nl80211 internals have been converted to handle units
> of KHz, which is not unprecedented (net/wireless/reg.c), and the
> collateral damage is localized.

:)

> One thing which is still unclear is backward compatibility in nl80211.
> If a frequency offset is supplied to an older kernel, it'll just
> silently fail to do the right thing.

But will it? It mostly requires to have a struct ieee80211_channel
registered with the wiphy for a given frequency, and won't find that?

But speaking of which - I was expecting to see a new *band* here for
S1G, so that you can actually register the channels properly in the
wiphy struct? Or is that just not part of this patchset yet?

johannes

