Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D535C71B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhDLNKM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 09:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241814AbhDLNKJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 09:10:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 947AD61356;
        Mon, 12 Apr 2021 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618232991;
        bh=9JBWP9mtxpT+PBYHDHGz+ehH5VKbP0mrVd6aKvenzu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIqiq7BMFfoi7VLfT8IFm7fwmweal1a8YVVSr4X3gVFAwPwVCcPqOZWHKFuC4xA91
         ak+BVoU9/YX9Q7gFCsgGlUKVyJB8SRj0Rv1/hBm7/wK4oUPWTvpAfGSOnarRPYRVmw
         Pk2nqCsNHDwDT0GKX8P8LvSdVQjhc8iJnEFOdMjA=
Date:   Mon, 12 Apr 2021 15:09:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH RESEND 1/3] mei: bus: add client dma interface
Message-ID: <YHRGnJbt/U3CTpe2@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 03:43:26PM +0300, Emmanuel Grumbach wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Expose the client dma mapping via mei client bus interface.
> The client dma has to be mapped before the device is enabled,
> therefore we need to create device linking already during mapping
> and we need to unmap after the client is disable hence we need to
> postpone the unlink and flush till unmapping or when
> destroying the device.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
> This is a another version of the patch:
> https://lore.kernel.org/lkml/20210206144325.25682-6-tomas.winkler@intel.com/
> 
> Greg asked to route this patch through the wireless drivers tree:
> https://lore.kernel.org/lkml/YB6sIi61X5p6Dq6y@kroah.com/
> So here it is.

Patch 2 still needs loads of work, so NAK on this getting merged through
any tree at the moment.

thanks,

greg k-h
