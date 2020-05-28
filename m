Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2791E651A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403877AbgE1O7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403870AbgE1O7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:59:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDAFC08C5C7
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:59:16 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeK02-0002aJ-9Z; Thu, 28 May 2020 16:59:14 +0200
Date:   Thu, 28 May 2020 16:59:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH 2/7] rtw88: 8821c: add set tx power index
Message-ID: <20200528145914.grwqbmytbrzx6urx@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-3-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520052335.22466-3-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 13:23:30 [+0800], yhchuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> To configure the transmit power of 8821c, implements trasmit
> power index setting callback function for 8821c, which is very
> similar to the callback function of 8822b.

To configure the transmit power of 8821c implement trasmit
power index setting callback function for 8821c. This is very
similar to the callback function of 8822b.

> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Sebastian
