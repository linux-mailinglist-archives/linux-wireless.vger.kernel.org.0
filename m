Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCD73A4ABE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFKVsM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 17:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFKVsJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 17:48:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D8961246;
        Fri, 11 Jun 2021 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623447970;
        bh=W+I1oxP/+qWOuosj2J/EsNNiVn7rYAGOcsNLNLC7wgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWQL2Rku5R6zqjetp/7Tlws3WC/OD2G3nxPDcGpBDR1+npzXgdNI4OLUn00BU0moM
         IfIeSvduzOwHN1B0WypW3C88dLm3McoHtCEKFQtGWW/mrIxCQ4NHoGpkYCoVjl6oNV
         Bz6tjE359B+WeR5kI9pIldVFtBx7FWvtsS8YmKMDCfHLH2Drj5Skr4xJ/lVVea83Es
         +keK7J1vVP57l5XSa3/WSZAiXRLW/8ie7wn84Huyl9euTQ03nea0uuHdz9AdmI/frw
         GsoeRJ1btGplAfrtwad/XTJDtYeSyGiZQaIQAvu+QZZBHz4W7qdZ9H/XO/GGHcva+M
         10tVSQfz3mfMw==
Received: by pali.im (Postfix)
        id 177292A45; Fri, 11 Jun 2021 23:46:07 +0200 (CEST)
Date:   Fri, 11 Jun 2021 23:46:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     mrenzmann@madwifi-project.org, ath9k-devel-owner@lists.ath9k.org
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Add ath9k-devel archives to lore?
Message-ID: <20210611214607.lehtcridmcs3ojig@pali>
References: <20200710200025.GA75493@bjorn-Precision-5520>
 <20200722084315.nlvxigt3t6ifcbbm@pali>
 <20210329112712.ls2wn5qu5w53q77l@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329112712.ls2wn5qu5w53q77l@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ mrenzmann

Do you have access to mbox file archives on lists.ath9k.org for ath9k-devel list?

On Monday 29 March 2021 13:27:12 Pali Rohár wrote:
> + Konstantin
> 
> On Wednesday 22 July 2020 10:43:15 Pali Rohár wrote:
> > On Friday 10 July 2020 15:00:25 Bjorn Helgaas wrote:
> > > The ath9k-devel mailing list was closed in 2017 in favor of
> > > linux-wireless (per
> > > https://wireless.wiki.kernel.org/en/users/Drivers/ath9k), but the
> > > archives contain information that may still be useful.
> > > 
> > > For instance, Pali just sent me a link
> > > (https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html)
> > > about an issue with PCI enumeration.
> > 
> > I would like to see ath9k-devel archive available in some searchable and
> > indexed form too! pipermail is not really usable.
> > 
> > > The ath9k-devel archive still seems to exist at
> > > https://lists.ath9k.org/pipermail/ath9k-devel/ and
> > > https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/
> > > 
> > > https://korg.docs.kernel.org/lore.html says pipermail archives *can*
> > > be used, but it's better to start with something else.  
> > > 
> > > Is anybody interested in adding the ath9k-devel archives to lore?
> 
> I would really like to see ath9k-devel archive available & searchable in
> lore web service.
> 
> Konstantin, do you think it is possible?
> 
> > > If so, does anybody have an archive to start with?
> > 
> > In most cases, pipermail/mailman is configured to save unmodified copy
> > (with all attachments and headers) of every incoming email to some mbox
> > archive stored on server, which is available to server admins. This mbox
> > archive is not available for download via web interface, so it is not
> > public and some SSH access to server is required for obtaining it.
> > 
> > Admins of lists.ath9k.org could have access to full ath9k-devel mbox
> > archive which is suitable for importing into any indexing service, like
> > lore.
> > 
> > Public pipermail archive has downloadable GZIP version of all emails,
> > but it is stripped of all attachments and have mangled all strings in
> > headers and body which may look like an email address. So this public
> > pipermail archive is not very usable.
> > 
> > In past I did some research work on topic how to archive, parse and
> > index emails from mailing lists and I have scripts which could de-mangle
> > pipermail public archives and generate from it valid mbox archive.
