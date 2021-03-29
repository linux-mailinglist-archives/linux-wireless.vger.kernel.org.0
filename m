Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56934CEEC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Mar 2021 13:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhC2L1i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Mar 2021 07:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232263AbhC2L1P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Mar 2021 07:27:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D10161938;
        Mon, 29 Mar 2021 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617017235;
        bh=3qExdSaTXP/OF4dBTjwIgHgkgxce4KUD+yLB8ozixsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMuM0Cy0yxrhEOZkLLB3ZrDN5RxhkRGK+NxMtmz6Ma1lckY0xswmKHvGmWS6Ose6X
         UMG2zGGY0LE5lgdL55BRS1hv6nzJoMPZcIqeoucAvadUexbit+0/7+hOfJwN6JuUOO
         qB+iE0rdZ5qWZRVODSsOygRuNwVJszYPBwirw9HCRs3D9NzCINiWEKMUfKq81Hy3Z3
         sRkJCkc9KWeHbdAnQZ16KaK+U702Q3KZJ4LvbDJnSFax8Sb45o5iG08NDFUbzz2q6Z
         a/nYd2IIExO9nTtfOu92KuLGOBCbg58H203vVSlu9lagH5d07cBK7HvdxxMje0l7YT
         5fzq670hh0f4g==
Received: by pali.im (Postfix)
        id E0492A79; Mon, 29 Mar 2021 13:27:12 +0200 (CEST)
Date:   Mon, 29 Mar 2021 13:27:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Add ath9k-devel archives to lore?
Message-ID: <20210329112712.ls2wn5qu5w53q77l@pali>
References: <20200710200025.GA75493@bjorn-Precision-5520>
 <20200722084315.nlvxigt3t6ifcbbm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722084315.nlvxigt3t6ifcbbm@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Konstantin

On Wednesday 22 July 2020 10:43:15 Pali Rohár wrote:
> On Friday 10 July 2020 15:00:25 Bjorn Helgaas wrote:
> > The ath9k-devel mailing list was closed in 2017 in favor of
> > linux-wireless (per
> > https://wireless.wiki.kernel.org/en/users/Drivers/ath9k), but the
> > archives contain information that may still be useful.
> > 
> > For instance, Pali just sent me a link
> > (https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html)
> > about an issue with PCI enumeration.
> 
> I would like to see ath9k-devel archive available in some searchable and
> indexed form too! pipermail is not really usable.
> 
> > The ath9k-devel archive still seems to exist at
> > https://lists.ath9k.org/pipermail/ath9k-devel/ and
> > https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/
> > 
> > https://korg.docs.kernel.org/lore.html says pipermail archives *can*
> > be used, but it's better to start with something else.  
> > 
> > Is anybody interested in adding the ath9k-devel archives to lore?

I would really like to see ath9k-devel archive available & searchable in
lore web service.

Konstantin, do you think it is possible?

> > If so, does anybody have an archive to start with?
> 
> In most cases, pipermail/mailman is configured to save unmodified copy
> (with all attachments and headers) of every incoming email to some mbox
> archive stored on server, which is available to server admins. This mbox
> archive is not available for download via web interface, so it is not
> public and some SSH access to server is required for obtaining it.
> 
> Admins of lists.ath9k.org could have access to full ath9k-devel mbox
> archive which is suitable for importing into any indexing service, like
> lore.
> 
> Public pipermail archive has downloadable GZIP version of all emails,
> but it is stripped of all attachments and have mangled all strings in
> headers and body which may look like an email address. So this public
> pipermail archive is not very usable.
> 
> In past I did some research work on topic how to archive, parse and
> index emails from mailing lists and I have scripts which could de-mangle
> pipermail public archives and generate from it valid mbox archive.
