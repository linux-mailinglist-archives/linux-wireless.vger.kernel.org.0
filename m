Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B98F01AA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfKEPkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 10:40:09 -0500
Received: from mail.toke.dk ([52.28.52.200]:35505 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389799AbfKEPkI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 10:40:08 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 10:40:08 EST
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1572967984; bh=xAHDL82gecPwNtpcLYvqhCOsdaSg4bYDDeWK4hm2RNE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hB7nIsB5fZ+6bljmrku1+t0+LeQzWR7H4d6EZeKDuKZQKcV4Vo3O7u3mHI0NAmAyR
         MWnIM6tnA/oyfnTW6V+3eEKBkqCeT/ipZPP/N0ew9sgVl/6XibHQks0x0Hz3tRcpat
         ExheoZc7nrPMCtDyvoOzxLwkZHRNUwIbiTRvrbSg1xTFgpYK2BVmBGPXkxxHpWxkWA
         XwesXWDTqqOC6L8yfFi4u1NdK+bPiy3CS/wMows7EBi8KPmqkYr3Rnnub11c8K2nv3
         8NBJ7R/W9+LeY0B/wcUzDMPezA6U9IyM0c7t+aq1XHIkz9jQAnsIaUK8R7FYbgJRYZ
         sovsHYS6c35YA==
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: fix ieee80211_txq_setup_flows() failure path
In-Reply-To: <20191105154110.1ccf7112ba5d.I0ba865792446d051867b33153be65ce6b063d98c@changeid>
References: <20191105154110.1ccf7112ba5d.I0ba865792446d051867b33153be65ce6b063d98c@changeid>
Date:   Tue, 05 Nov 2019 16:33:02 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87eeymjq35.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> If ieee80211_txq_setup_flows() fails, we don't clean up LED
> state properly, leading to crashes later on, fix that.
>
> Fixes: dc8b274f0952 ("mac80211: Move up init of TXQs")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Oops, my bad; thanks for the fix!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
