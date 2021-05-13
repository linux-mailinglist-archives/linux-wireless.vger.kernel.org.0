Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D57937FDAD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 20:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhEMS64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 14:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhEMS64 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 14:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1322C613B5;
        Thu, 13 May 2021 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620932266;
        bh=tjUSVYeJHoCEPyWCHJ5eIqs95vfc6nkd73K72QqLfLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7x1ilYIIBAi6+kB2dqq0VI3hzwEQBu6oM1U2o0j9xw8Gq9s1BnQPdQbVC48ZzHlF
         CKih9nzbbn0+Rqm3xZ3pHwtA1ZxNrAVuzw+g6n6gsFZEHNbbjeoqopJb2UQTlhc4/H
         T3K2ilYQJOhEfiPmHjC7mzLOazf2UonMaFpBaR4I=
Date:   Thu, 13 May 2021 20:57:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org, johannes.berg@intel.com,
        tomas.winkler@intel.com, luciano.coelho@intel.com,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v2 1/3] mei: bus: add client dma interface
Message-ID: <YJ12qPXtL41AUhuo@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210420172755.12178-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420172755.12178-1-emmanuel.grumbach@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 20, 2021 at 08:27:53PM +0300, Emmanuel Grumbach wrote:
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
