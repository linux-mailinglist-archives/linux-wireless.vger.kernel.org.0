Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA01814FB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 10:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgCKJdk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 05:33:40 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45608 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgCKJdk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 05:33:40 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBxkA-000vje-Br; Wed, 11 Mar 2020 10:33:38 +0100
Message-ID: <3673cbf5c5779f5909bf677ceab89db08f2c0f25.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: fix tx_control_port trace point
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 11 Mar 2020 10:33:37 +0100
In-Reply-To: <720231bf-8ae0-409d-039e-bc27f3d46fff@tu-ilmenau.de>
References: <20200304114952.1827-1-markus.theil@tu-ilmenau.de>
         <5c542c4ce1b5373e8fe280913b74926f4d36e2d1.camel@sipsolutions.net>
         <1073945b-ec01-7303-0bfb-92456e1ca7a5@tu-ilmenau.de>
         <7e3d534a42bf119c92d9e81145940fb02dbc676e.camel@sipsolutions.net>
         <720231bf-8ae0-409d-039e-bc27f3d46fff@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-03-04 at 17:17 +0100, Markus Theil wrote:

> Should cfg80211_rx_control_port then also adopt this behavior?
> It currently does the conversion in the way I changed
> cfg80211_tx_control port to.
[...]
> TRACE_EVENT(cfg80211_rx_control_port,
> ...
>     __entry->proto = be16_to_cpu(skb->protocol);
>         __entry->unencrypted = unencrypted;
>     ),
>     TP_printk(NETDEV_PR_FMT ", len=%d, " MAC_PR_FMT ", proto: 0x%x,
> unencrypted: %s",
>           NETDEV_PR_ARG, __entry->len, MAC_PR_ARG(from),
>           __entry->proto, BOOL_TO_STR(__entry->unencrypted))

Great ...

I dunno. I guess I don't like touching these so much, because it may be
that somebody is relying on them for some kind of tooling?

But I guess that's actually unlikely and we can just try, but then I'd
rather change this one to BE than the other way around.

> IMHO, as long as the trace events are just printed, it is cleaner to
> do the endiannes conversion already in the kernel.

But they aren't just printed, trace-cmd can record them in binary form,
and you can have python plugin code to consume that, for example.

johannes

