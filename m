Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B7C3EE7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfJARqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 13:46:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56062 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJARqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 13:46:14 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iFME0-0000wv-Am; Tue, 01 Oct 2019 19:46:12 +0200
Date:   Tue, 1 Oct 2019 19:46:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Support for RTL8188FU
Message-ID: <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
 <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-01 11:47:44 [-0500], Larry Finger wrote:
> A quick Internet search shows me that the RTL8188FU is a low-cost chip used
> on Raspberry PI and other similar low-cost systems.
> 
> The USB group at Realtek is notorious for their lack of support for Linux
> drivers. The ones they release have lots of dead code used for Windows and
> FreeBSD drivers, and they have lots of code that applies to other chips.
> With other drivers that I have placed at GitHub, some of the commits that
> remove dead code will remove as many of 10K lines.

yeah, seen that.

> You should be able to find the code that differs between 8188EU and 8188FU
> to see what is different.

So you would recommend to try to merge it to the staging driver.

> The 8188RU is a special variant of the 8188EU. I have no idea what an 8188CU is.
> 
> Your only starting point is the driver that is next to you!

Thank you for your reply.

> Larry

Sebastian
