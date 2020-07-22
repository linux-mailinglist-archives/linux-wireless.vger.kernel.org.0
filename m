Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203BE2293D0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jul 2020 10:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGVInS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jul 2020 04:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgGVInS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jul 2020 04:43:18 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4F2205CB;
        Wed, 22 Jul 2020 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595407397;
        bh=s/e1oHLfy/0U3pQlcZlH8vpNwublw/OdcKL1UE5F7XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mM8q8PwhMk7jSa4VFtWuITJ3EJSiVQyQsg3M2AcS6LztI6jCCiZk2L2ZuulOtmGDX
         +WGyXoNfbnmuKENTe5sMi37uQXlha5l/+MifKUg85OXppjxGXnqWli0ciaMAp69bkg
         MY72DEc4e+CjkY8E/PWQ3Si1zZexBnQGsAxCoH0k=
Received: by pali.im (Postfix)
        id 75CD67F8; Wed, 22 Jul 2020 10:43:15 +0200 (CEST)
Date:   Wed, 22 Jul 2020 10:43:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Add ath9k-devel archives to lore?
Message-ID: <20200722084315.nlvxigt3t6ifcbbm@pali>
References: <20200710200025.GA75493@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710200025.GA75493@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
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

I would like to see ath9k-devel archive available in some searchable and
indexed form too! pipermail is not really usable.

> The ath9k-devel archive still seems to exist at
> https://lists.ath9k.org/pipermail/ath9k-devel/ and
> https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/
> 
> https://korg.docs.kernel.org/lore.html says pipermail archives *can*
> be used, but it's better to start with something else.  
> 
> Is anybody interested in adding the ath9k-devel archives to lore?  If
> so, does anybody have an archive to start with?

In most cases, pipermail/mailman is configured to save unmodified copy
(with all attachments and headers) of every incoming email to some mbox
archive stored on server, which is available to server admins. This mbox
archive is not available for download via web interface, so it is not
public and some SSH access to server is required for obtaining it.

Admins of lists.ath9k.org could have access to full ath9k-devel mbox
archive which is suitable for importing into any indexing service, like
lore.

Public pipermail archive has downloadable GZIP version of all emails,
but it is stripped of all attachments and have mangled all strings in
headers and body which may look like an email address. So this public
pipermail archive is not very usable.

In past I did some research work on topic how to archive, parse and
index emails from mailing lists and I have scripts which could de-mangle
pipermail public archives and generate from it valid mbox archive.
