Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934F41800AE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2020 15:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCJOy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Mar 2020 10:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbgCJOy1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Mar 2020 10:54:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06048205F4;
        Tue, 10 Mar 2020 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583852067;
        bh=2/32sqBhxkdkjNGWB/aP5WYuqavfZPVMUc8D3JGZstA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5rK/EmPst7K8Dnlw7j8WX5mSGJNV4PtCGI+ZjFHHFVjSPLN1LqzRFKOr8oByHnmh
         dTpL4R3qSqujLC9nv8onqWaA1zWbQ+rHsmkZQMaClPjZuqFIkh+h4O9+upNnkDV3nQ
         pC9DnXI+o9/WFHOCtEAG6Mglz+Dnikdov54VMqws=
Date:   Tue, 10 Mar 2020 15:54:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Support for RTL8188FU
Message-ID: <20200310145424.GA3422200@kroah.com>
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
 <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
 <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
 <b958b669-a683-d7cd-6bbf-bfe3e674f62d@lwfinger.net>
 <20200304102152.a25cczvat2mujxwa@linutronix.de>
 <9c6717de-5ffc-47dc-6db7-7e070cbc41b9@lwfinger.net>
 <20200310144809.se2oqvlnnh55fhfd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310144809.se2oqvlnnh55fhfd@linutronix.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 10, 2020 at 03:48:09PM +0100, Sebastian Andrzej Siewior wrote:
> What would be the challenges to get the 8188f Realtek driver upstream?
> Looking at the todo list for the staging driver, it is mostly clean up
> and checkpatch kind of thing. The more difficult/non mechanic task is to
> convince the driver to use lib80211/mac80211 layer.

Tht mac80211 layer stuff is probably the biggest issue.

thanks,

greg k-h
