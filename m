Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6616C433EF5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhJSTGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhJSTGj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 15:06:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D1C06161C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7lvzcn4EHTLcitdU5RgjbH4Qdyn8U26fGeym4oxynaQ=;
        t=1634670266; x=1635879866; b=gG/axGhkUPG2gixQ50+IvK5ysdIRlier5rO7Q3iOS68jXop
        GjZrb1+izs/1aE1NtORpd6B+4d80XPFVg1uL6ww4EQLZTd5DCkJOdmU5/jKQU/0+hn2b8pEnDwWjh
        j5ktWNFSMStEI5O4feClxO4EPpGiOadvcapaKi/bmhKzGa7/x+Iutdh9lGNzCK8fVOXRjt1g9H2Z8
        i7mZ6Td0RUnvfE4FOs45RXJyU9WA45cPmzfP/3ru+7QDtkoxY8RSUk6LL1IniX8QvPxLk2HyCDBx4
        OXu0svgnG+Su0k/57iWsW7/oPkpPmyKQlEohsak/S5ozOvp9JsmzDV4OayRmxDXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mcuPQ-004ZB5-DG;
        Tue, 19 Oct 2021 21:04:24 +0200
Message-ID: <9cb73a6676ff79a08cfa7a356dbd823b0bbf5231.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: use eth_hw_addr_set()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 19 Oct 2021 21:04:23 +0200
In-Reply-To: <20211019110617.5a4ceb73@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211019162816.1384077-1-kuba@kernel.org>
         <49d6cbb87dc23ad797a39d9f57ca48edd708fa3c.camel@sipsolutions.net>
         <20211019110617.5a4ceb73@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-10-19 at 11:06 -0700, Jakub Kicinski wrote:
> On Tue, 19 Oct 2021 19:53:01 +0200 Johannes Berg wrote:
> > On Tue, 2021-10-19 at 09:28 -0700, Jakub Kicinski wrote:
> > > Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> > > of VLANs...") introduced a rbtree for faster Ethernet address look
> > > up. To maintain netdev->dev_addr in this tree we need to make all
> > > the writes to it got through appropriate helpers.
> > >   
> > > 
> > Looks fine. Do you expect me to apply this (and if so where), or will
> > you?
> 
> I was expecting you to take these, there will be another -next PR
> before the merge window, right?
> 
Yeah, I should have one.

johannes

