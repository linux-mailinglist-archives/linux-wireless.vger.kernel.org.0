Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97BEC2F18
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfJAIpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 04:45:01 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57132 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAIpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 04:45:01 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFDmF-0002cH-8N; Tue, 01 Oct 2019 10:44:59 +0200
Message-ID: <fd0d467d352177ac20100239cb18f80310b43fa9.camel@sipsolutions.net>
Subject: Re: [PATCH RFC/RFT 1/4] mac80211: Rearrange ieee80211_tx_info to
 make room for tx_time_est
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Tue, 01 Oct 2019 10:44:58 +0200
In-Reply-To: <156889576534.191202.17686228416284995279.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
         <156889576534.191202.17686228416284995279.stgit@alrua-x1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry for the long time to review here ...

On Thu, 2019-09-19 at 14:22 +0200, Toke Høiland-Jørgensen wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> To implement airtime queue limiting, we need to keep a running account of
> the estimated airtime of all skbs queued into the device. Do to this
> correctly, we need to store the airtime estimate into the skb so we can
> decrease the outstanding balance when the skb is freed. This means that the
> time estimate must be stored somewhere that will survive for the lifetime
> of the skb.
> 
> Fortunately, we had a couple of bytes left in the 'status' field in the
> ieee80211_tx_info; and since we only plan to calculate the airtime estimate
> after the skb is dequeued from the FQ structure, on the control side we can
> share the space with the codel enqueue time. And by rearranging the order
> of elements it is possible to have the position of the new tx_time_est line
> up between the control and status structs, so the value will survive from
> when mac80211 hands the packet to the driver, and until the driver either
> frees it, or hands it back through TX status.

Seems reasonable to me, if we end up needing it and don't have an out-
of-band path (that you seem to have been discussing in this long thread
too)

johannes

