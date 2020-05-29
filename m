Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB81E7677
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 09:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2HSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2HSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 03:18:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C20C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 00:18:02 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeZHE-0006I5-9Y; Fri, 29 May 2020 09:18:00 +0200
Date:   Fri, 29 May 2020 09:18:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, kai.heng.feng@canonical.com,
        vicamo.yang@canonical.com
Subject: Re: [PATCH v2 0/3] rtw88: 8723d: follow up fixes
Message-ID: <20200529071800.bqepirt5g4p7wsw3@linutronix.de>
References: <20200529025009.2468-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529025009.2468-1-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 10:50:06 [+0800], yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> The RTL8723DE devices have been tested by Canonical for the coex
> and basic wifi functions. And they have reported some issues for
> RTL8723DE. Fix them accordingly.

Looks good,

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
