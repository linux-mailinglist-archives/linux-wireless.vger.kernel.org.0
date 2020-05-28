Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6731E63AA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbgE1OVf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390953AbgE1OVf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:21:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1475C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:21:34 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeJPZ-0001ZI-9u; Thu, 28 May 2020 16:21:33 +0200
Date:   Thu, 28 May 2020 16:21:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, kai.heng.feng@canonical.com
Subject: Re: [PATCH 0/3] rtw88: 8723d: follow up fixes
Message-ID: <20200528142133.jkl6j3vyk6nkccsk@linutronix.de>
References: <20200518081444.7664-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518081444.7664-1-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-18 16:14:41 [+0800], yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> The RTL8723DE devices have been tested by Canonical for the coex
> and basic wifi functions. And they have reported some issues for
> RTL8723DE. Fix them accordingly.

Minor rewording in 3/3, otherwise looks good.

Sebastian
