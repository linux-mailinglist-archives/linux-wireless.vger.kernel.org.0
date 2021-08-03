Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08C3DE47B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Aug 2021 04:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhHCCko (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 22:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233197AbhHCCkn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 22:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D41660187;
        Tue,  3 Aug 2021 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627958433;
        bh=2sYKRgM/qZ2S4y11Dgs9uZOu620rTaOVBulqDTl4n1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=In3S/rG7QjeIRtZcbXRS47C2iJcA2qMGFB/xy9sxPkv6z4nJhevZ6dDQ/QBQjXKAs
         GGIuUdy/mwj5mUDAMcaC/noAWq43ZomHvN4QVRaaOCI6DOnIeRZTRI9+P+uz0XvghH
         erMlrnXQYBFzwYmcICdxqFI5VrQTv8zsevLXnat0DdzG6xOuzJbnj9ywV7y7cXI313
         E2uDB17gDb8IcNiIS152iGKe8i95auBSQGhESbPfApat4SzxqJ60ayQfBkd9BMHvZ+
         0LCk3bOU/hCM8awsdxddRVWPEhji3OQzJuSHt3MHmNSCN3bRF/K/gXNbIEzIdzuq+O
         vyQL++3bNgSZg==
Date:   Mon, 2 Aug 2021 21:40:31 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Timo Witte <timo.witte@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
Message-ID: <YQisn6rrXTBdoAwJ@ubuntu-x1>
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
 <YPgvMph+3vRbrol3@ubuntu-x1>
 <CANB4YXSDuYndC26KPkV+XqPkowbN54MMceuj7MNaxh+EwLN4kw@mail.gmail.com>
 <YPg83HXFIXDAEFx1@ubuntu-x1>
 <CANB4YXS64QtxsgY0bx_Ri7bWfTY_5Ry7PbGwaGT3QVZb380vgQ@mail.gmail.com>
 <CANB4YXQMDAxwk+b+wXsTg8OzFMa4gZHxNOZ6UoWT6McM9hEVcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANB4YXQMDAxwk+b+wXsTg8OzFMa4gZHxNOZ6UoWT6McM9hEVcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Aug 01, 2021 at 03:17:43AM +0200, Timo Witte wrote:
> Any updates on this Seth?
> can we just add the "NO-OUTDOOR" line then as i did in my updated patch, if
> the kernel does not support overlapping / identical frequency ranges with
> different power limits?

Sorry, I was giving it a few days for comments, and since then I've been
quite busy. The patch wasn't formatted quite right for application, but
I made adjustments and have applied it now. Thanks!

Seth
