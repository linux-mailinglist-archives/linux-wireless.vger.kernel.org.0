Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E47433E0E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhJSSIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 14:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhJSSIb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 14:08:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2D1E604AC;
        Tue, 19 Oct 2021 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634666778;
        bh=k1EHwcbCo+tqTQS84e2v2jrT1VDbs8LT+cL6EG6t7/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u94MV0z7/BTn0VqC41QfjfQtXWG4GkM78xsKVdtC4/wg8k+oimn5p7PcxtrLgsGl1
         sQLW0poQt/mmI8ZP+rgLNk0HfAcsBL9byU3reay18pJE5hCSuz3kUVvAT9pL0uGlnf
         ehv/mSjAg/guk8BMSYsw+mzmW8fN0G8o7hHFWGZxNJ/6uVXUDW3rpS9QrROEzRiQUv
         EgwvuJgmOf/BDJAd5otdUhaEgz4TiKzxaBsLmgXSXL0DWF3l6sVMfmMAF4koqN3Du3
         DBuMBjwiTKhQaalqPNN6pIlww9RdAZDjefaHCPsCqAzpfrpOCjXzj5sdgKqv3ugRmC
         40a6qYrna0XBg==
Date:   Tue, 19 Oct 2021 11:06:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: use eth_hw_addr_set()
Message-ID: <20211019110617.5a4ceb73@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <49d6cbb87dc23ad797a39d9f57ca48edd708fa3c.camel@sipsolutions.net>
References: <20211019162816.1384077-1-kuba@kernel.org>
        <49d6cbb87dc23ad797a39d9f57ca48edd708fa3c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 19 Oct 2021 19:53:01 +0200 Johannes Berg wrote:
> On Tue, 2021-10-19 at 09:28 -0700, Jakub Kicinski wrote:
> > Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> > of VLANs...") introduced a rbtree for faster Ethernet address look
> > up. To maintain netdev->dev_addr in this tree we need to make all
> > the writes to it got through appropriate helpers.
> >   
> Looks fine. Do you expect me to apply this (and if so where), or will
> you?

I was expecting you to take these, there will be another -next PR
before the merge window, right?
