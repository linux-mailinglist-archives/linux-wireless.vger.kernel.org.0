Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943621BB913
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD1Iqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD1Iqi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:46:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93038206B9;
        Tue, 28 Apr 2020 08:46:37 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:46:35 +0200
From:   Greg KH <greg@kroah.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        Johannes Berg <johannes.berg@intel.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 1/2] staging: rtl8723bs: remove mgmt_frame_register method
Message-ID: <20200428084635.GC996383@kroah.com>
References: <20200428101400.ae19d651ec38.Ieb15844bb5ab93b3d7931d6561f42e3316ef8251@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428101400.ae19d651ec38.Ieb15844bb5ab93b3d7931d6561f42e3316ef8251@changeid>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 10:14:02AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This was changed in cfg80211, so having it broke things, but
> there's no need to adjust since it's an empty implementation.
> Just remove it.
> 
> Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 24 -------------------
>  1 file changed, 24 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
