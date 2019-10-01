Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292E5C2FC0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfJAJMj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:12:39 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57582 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfJAJMi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:12:38 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFECy-0003Lo-QI; Tue, 01 Oct 2019 11:12:36 +0200
Message-ID: <e8d37726819f1b8eb51b370960a9be75cc9eaa26.camel@sipsolutions.net>
Subject: Re: [PATCH RFC/RFT 1/4] mac80211: Rearrange ieee80211_tx_info to
 make room for tx_time_est
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Tue, 01 Oct 2019 11:12:35 +0200
In-Reply-To: <87v9t8vnn5.fsf@toke.dk>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
         <156889576534.191202.17686228416284995279.stgit@alrua-x1>
         <fd0d467d352177ac20100239cb18f80310b43fa9.camel@sipsolutions.net>
         <87v9t8vnn5.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-01 at 11:08 +0200, Toke Høiland-Jørgensen wrote:
> 
> Awesome! Any idea for how to make it work on big-endian systems? I got a
> splat from the kbuild robot that triggered the BUILD_BUG_ON when
> building for m68k. I assume it's the union with codel_time_t that ends
> up being aligned wrong...

Hmm. Pad out the u16 part of the union by putting it into a struct, or
perhaps it's enough to make the union __packed?

johannes

