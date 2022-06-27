Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529CF55C18A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiF0PC4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiF0PCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:02:43 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81D1834D
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:02:42 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342161; bh=cHKQCUBBiM4gNJRCZXFg3yqIjINruZHTUeyr8uHXBXk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jNoTMT94bF0H52oIEt5zGebTYV+vZh7eS8rCDmwdSCwkNF8HEca6UHeu7sUXOGFkO
         MeVqessLtbWblO4eJNmOEE5gaT9kmasC5y4Ai2TBrccmniTeNpRG/pMhaIPfqPVxJw
         xjiPHeMhKEFsBvUKraV1NdCpnwQmu3cvg0DesFcAGX2E37RR13ZMMdy1R06c5LhviZ
         xge625dEaYScEycyikE3xLpYriUwzof+4bAVLTHTWLESvQV1M5BUtGijAD7LUyF0/L
         UbeYmdvsptzT/1UyuTAOO9BrF4TDVozDvI6y14uPgeEu+79cAtQ7hFHvKep+tzS+/w
         /lqJRbc/VfIfg==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 3/7] mac80211: consider aql_tx_pending when checking
 airtime deficit
In-Reply-To: <20220625212411.36675-3-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
 <20220625212411.36675-3-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:02:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ilomb14f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> When queueing packets for a station, deficit only gets added once the pac=
kets
> have been transmitted, which could be much later. During that time, a lot=
 of
> temporary unfairness could happen, which could lead to bursty behavior.
> Fix this by subtracting the aql_tx_pending when checking the deficit in tx
> scheduling.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
