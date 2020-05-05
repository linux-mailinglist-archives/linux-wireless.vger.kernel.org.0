Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF98A1C5879
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgEEOPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729704AbgEEOO5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 10:14:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E49C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 07:14:57 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVyLX-0001Ge-AY; Tue, 05 May 2020 16:14:55 +0200
Date:   Tue, 5 May 2020 16:14:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, pkshih@realtek.com,
        linux-wireless@vger.kernel.org, briannorris@chromium.org,
        kevin_yang@realtek.com
Subject: Re: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT
 USB suspend
Message-ID: <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-29-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417074653.15591-29-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-17 15:46:41 [+0800], yhchuang@realtek.com wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> Without this patch, wifi card can't initialize properly due to BT in USB
> suspend state. So, we disable BT USB suspend (wakeup) in shutdown callback
> that is the moment before rebooting. To save BT USB power, we can't do this
> in 'remove' callback.

So you can't initialize the USB part because it is in suspend and the
only way to avoid it to disable it on the PCI side. That means you don't
see it enumerated on the USB bus at all?

> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Sebastian
