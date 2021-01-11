Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493022F1229
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 13:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAKMLl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 07:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAKMLl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 07:11:41 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A7C061786
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 04:11:01 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kyw1Y-004pA1-6H; Mon, 11 Jan 2021 13:10:55 +0100
Message-ID: <036e334c2a0a2ebaf940d3f7ae03ab0d9f7c45fb.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix incorrect strlen of .write in debugfs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Date:   Mon, 11 Jan 2021 13:10:39 +0100
In-Reply-To: <1610345954.4985.7.camel@mtksdccf07>
References: <20210108105643.10834-1-shayne.chen@mediatek.com>
         <0efec65815ff9e26b3da69cb35d503a90086760c.camel@sipsolutions.net>
         <1610345954.4985.7.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-01-11 at 14:19 +0800, Shayne Chen wrote:
> 
> Regarding the case "10\n\0\0\0\0", both count and strlen() fail to get
> the correct strlen.

Yeah.

I don't think we need to worry about this case.

> # echo "10\n\0\0\0\0" > /sys/kernel/debug/ieee80211/phy0/airtime_flags
> airtime_flags_write: count = 13, strlen = 15 
> > > +	buf[count] = '\0';
> > 
> > But if count == sizeof(buf) then this is an out-of-bounds write.
> > 
> > Same for all the other copied instances.
> > 
> > johannes
> > 
> 
> Should we consider this kind of case here?

Sure, we're at the kernel/userspace trust boundary, we can't just read
out-of-bounds? Or what do you mean?

johannes


