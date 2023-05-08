Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9526F6FB4B3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjEHQGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjEHQGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 12:06:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DC5596
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BpnUEBs4ZXY/9xocH1w+1Vh29eLreHtuU7UDW74x81E=;
        t=1683561998; x=1684771598; b=Flc21BPTeImIe+SFVi03BpWTqqs2t4QV+5BPzP5Qsnrt9Nk
        5t9Pe+d9f98qIDeZlT3v9NWE5zkljQc4Laum3cH22IWQBmd0Bn1EUDY1MovZRFCw323WeAdKINlzm
        nWRm3k7oXuJJjcvSBIdLSmMjJvaGDf77q/qUTbYZsdQJWPnlrG330IMDgoSwpO9SYz/P5fVlIJyCR
        epOiXytnnghWWtAmcWCo2LSQGfuXuQzl0AQTLDDx5BgD+nKvMJtKf8q2LQOp3ymI9TNNEGkDQ6WF0
        JEcSxk/h8ZJSdEL2p6+aQWV5dxpbOq+W3gzOeLuSU3Ia93aHS8Sfl+04BQxZkWzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pw3Nk-003Mmh-0Z;
        Mon, 08 May 2023 18:06:36 +0200
Message-ID: <920f4c3a5dd5183628ad6c1196b5cc689c1ebeeb.camel@sipsolutions.net>
Subject: Re: wireless locking simplifications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Mon, 08 May 2023 18:06:35 +0200
In-Reply-To: <ZFV6fTH_7umEa5H0@slm.duckdns.org>
References: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
         <ZFV6fTH_7umEa5H0@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-05-05 at 11:51 -1000, Tejun Heo wrote:
> Hello, Johannes.
>=20
> On Fri, May 05, 2023 at 11:05:45PM +0200, Johannes Berg wrote:
> ...
> > The implementation of (2) is a bit ... awkward, @Tejun, @Lai, there's n=
o
> > way to "pause" an ordered workqueue, is there? I came up with the below
> > patch, but it's a bit ugly and requires a lot of context switches. Just
> > flushing isn't enough since then some work might start and hang on
> > acquiring the lock.
>=20
> There isn't currently but workqueue already does something similar for
> freezing by temporarily setting max_active to zero,
>=20

Ah, nice. I had thought about it but a lot of places didn't like 0 so
wasn't sure whether or not it was allowed :)

> [snip]

> and then do set_max_active(wq, 0) followed by flush_workqueue(), it shoul=
d
> be paused until max_active is restored to 1. It probably would be better =
to
> add a separate pause / resume interface which sets a per-wq flag which is
> read by pwq_adjust_max_active() tho. Anyways, it's not difficult to
> implement at all.

Ok cool, I'll take a look at it at some point. I think it would greatly
simplify the locking etc. in wifi because then we don't need to worry
about the cancel_work_sync() or flush_work() or flush_workqueue()
deadlocks.

Thanks!

johannes

