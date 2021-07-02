Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35443BA458
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 21:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGBTaS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 15:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhGBTaR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 15:30:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EC85613C9;
        Fri,  2 Jul 2021 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625254065;
        bh=iYjQrPiRXkRzh2irdLo9QIYUrmBS1PkQ/bV8JoEOs7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjevtTKiklde2yU0mg0UaYCGC3ZZtsV1EYdf3Avv5lj3NBDhieiTkWZZENthb/KF6
         3Az5c7AWLlnp5piZfwofmma36t1OE/Bx7AaOubSVtYN+FN4rZ42kRlfchkdrU/Ldgq
         JRJo5eTST3rTmH3vqwBOMN5wvZWn2MK4eVC3Hyh/MOv4moX7rHigVCknp4ye09O7ts
         to9OIDDIgFSt18AGX7ra/dOv/aHwdszaS4rl8R4SXydOrKbwZoW/gHFr/h4MHGp2un
         hXaOQkVKZJP8khc8QqQxHucstjykkZWeN8T8chhsXehNiuz3boNQQs2HUe1Aeby+Uu
         Pedhq38g/6l5Q==
Received: by pali.im (Postfix)
        id 8B61567D; Fri,  2 Jul 2021 21:27:43 +0200 (CEST)
Date:   Fri, 2 Jul 2021 21:27:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Add ath9k-devel archives to lore?
Message-ID: <20210702192743.t6ahkdilik25uj24@pali>
References: <20200710200025.GA75493@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710200025.GA75493@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 10 July 2020 15:00:25 Bjorn Helgaas wrote:
> The ath9k-devel mailing list was closed in 2017 in favor of
> linux-wireless (per
> https://wireless.wiki.kernel.org/en/users/Drivers/ath9k), but the
> archives contain information that may still be useful.
> 
> For instance, Pali just sent me a link
> (https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html)
> about an issue with PCI enumeration.
> 
> The ath9k-devel archive still seems to exist at
> https://lists.ath9k.org/pipermail/ath9k-devel/ and
> https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/
> 
> https://korg.docs.kernel.org/lore.html says pipermail archives *can*
> be used, but it's better to start with something else.  
> 
> Is anybody interested in adding the ath9k-devel archives to lore?  If
> so, does anybody have an archive to start with?
> 
> Bjorn

FYI Konstantin imported archive into lore:
https://lore.kernel.org/ath9k-devel/
