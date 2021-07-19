Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E513CD4D4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhGSLxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbhGSLxh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 07:53:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C2C061574
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2HCgjKWCALc7jcdCDh52donXigL1Xc1Wxf8bz20D1LI=;
        t=1626698057; x=1627907657; b=Vxi1h27AdHMAJcnHjUKNWcZFEBMDq+Z5YjlV8jWQe+Iz4zb
        Xgf8bkUlvtIKBDlbDo0Pz7MHfppkytCRRYCWxo7zdDaFyPVfejpItgD6v5ydZY2cpaCLISgoTeYip
        B80CH2JVzWESXDeGzF56LMWFkM1sUQOHBKcHmjdVuK13N+rTG4k4xMzhnSWSUJ3lNTiIao+95fE5z
        u+1TA85fyk0QaiUu4CMlpDJmoilhTfysvb9DD9eUqb0SpghxCSsQbtOjSD2i2tiYmv0+4bdRGmRGu
        fxwerqROd1insd4dvrZ7NDHAtU8wENMHqcTSzi60apGTgfgv5cRDqLFiASAJVkxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m5STO-004MNg-Tj; Mon, 19 Jul 2021 14:34:15 +0200
Message-ID: <a79b70607711ec53ab3197a31fea13f21d2bf2f0.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: include <linux/rbtree.h>
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 19 Jul 2021 14:34:14 +0200
In-Reply-To: <8735sav61j.fsf@toke.dk>
References: <20210715180234.512d64dee655.Ia51c29a9fb1e651e06bc00eabec90974103d333e@changeid>
         <8735sav61j.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-07-19 at 14:31 +0200, Toke Høiland-Jørgensen wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > This is needed for the rbtree, and we shouldn't just rely
> > on it getting included somewhere implicitly. Include it
> > explicitly.
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> Does this need a Fixes: tag?

We seem to always get it implicitly in the current kernel, so I guess
not really necessary to backport or anything, I'd say no.

I just ran into it while preparing a new backports import to our
internal tree.

johannes

