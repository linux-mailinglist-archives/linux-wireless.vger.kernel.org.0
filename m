Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9337B5A1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 May 2021 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhELGDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 May 2021 02:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhELGDk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 May 2021 02:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69991613CB;
        Wed, 12 May 2021 06:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620799352;
        bh=koM8/yk5mVjE1gQcep1Ru8neyPqMRMdGQLBznUI8/gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ycv+IAjib84HQjgEUWHEYRgEqd/bAaDz2eikX/t3qfXDzAS5WTPoXrDb90WeTjDm1
         370PDcn/Hzm23k88StxF/Q6tc8ezKLu5cz4TdJ6LWNMsllED5e3tuIB/RPMlr7BbGs
         2T/Pp38Y/xC9tMY9ZtTCQvD3hFSbdDJnTHCe5t3w=
Date:   Wed, 12 May 2021 08:02:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v2 1/3] mei: bus: add client dma interface
Message-ID: <YJtvdMu0NRzGVonT@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210420172755.12178-1-emmanuel.grumbach@intel.com>
 <CANUX_P0enDyHC_j9s2+w-a+mJgE4NqK=soBfbBLb+iA3O-42dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUX_P0enDyHC_j9s2+w-a+mJgE4NqK=soBfbBLb+iA3O-42dQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 12, 2021 at 08:49:06AM +0300, Emmanuel Grumbach wrote:
> Hi Greg,
> 
> On Tue, Apr 20, 2021 at 8:29 PM Emmanuel Grumbach
> <emmanuel.grumbach@intel.com> wrote:
> >
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > Expose the client dma mapping via mei client bus interface.
> > The client dma has to be mapped before the device is enabled,
> > therefore we need to create device linking already during mapping
> > and we need to unmap after the client is disable hence we need to
> > postpone the unlink and flush till unmapping or when
> > destroying the device.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> > This is a another version of the patch:
> > https://lore.kernel.org/lkml/20210206144325.25682-6-tomas.winkler@intel.com/
> >
> > Greg asked to route this patch through the wireless drivers tree:
> > https://lore.kernel.org/lkml/YB6sIi61X5p6Dq6y@kroah.com/
> > So here it is.
> > ---
> 
> I think I fixed all the issues you raised on the previous version of the patch.
> This series has been reviewed internally as well. The merge window is
> now closed, can we move forward with this?

$ mdfrm -c ~/mail/todo/
1823 messages in /home/gregkh/mail/todo/

Please relax, there is no rush.

greg k-h
