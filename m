Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B01BB911
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgD1Iq1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD1Iq0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:46:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E370206B9;
        Tue, 28 Apr 2020 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588063586;
        bh=O2FUojuzfujXTEPHXdG90VInygWbIERCNUypjs0pcF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CawfnIyldNgBbWstwbZiVDwUox+98JDbIHUk+UxCKqMZVgeF7ozxKCMWmPWmY/XTi
         nzyeuXA8G2Z+vTFfcTC0OWMDh/2P87Ve2x3Whorl2TKb0bJ2ksB/CGm3Dt0P5uBA2g
         a1bGd9tP+x80H69SPGEAlTWvnwcMP6CAGIF+HK40=
Date:   Tue, 28 Apr 2020 10:46:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 1/2] staging: rtl8723bs: remove mgmt_frame_register method
Message-ID: <20200428084624.GB996383@kroah.com>
References: <20200428101400.ae19d651ec38.Ieb15844bb5ab93b3d7931d6561f42e3316ef8251@changeid>
 <9a21da0be7d6fc70541adff2cdb676eb7b04070e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a21da0be7d6fc70541adff2cdb676eb7b04070e.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 10:16:57AM +0200, Johannes Berg wrote:
> Greg,
> 
> I'm going to take these through my tree because I broke the APIs there
> (and wasn't paying attention to staging), but every bot around the world
> is complaining now that my tree doesn't build ... :)

No objection from me!
