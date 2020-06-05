Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591AF1EF657
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFELSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgFELSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 07:18:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E85C08C5C2
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 04:18:31 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jhAMn-0002kz-IJ; Fri, 05 Jun 2020 13:18:29 +0200
Date:   Fri, 5 Jun 2020 13:18:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH v3 0/7] rtw88: 8821c: add basic function routines
Message-ID: <20200605111829.pf6hmgmkfjqfl5gm@linutronix.de>
References: <20200603093804.19779-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603093804.19779-1-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 17:37:57 [+0800], yhchuang@realtek.com wrote:
> v1 -> v2
>   * rebase on top of tree
> 
> v2 -> v3
>   * fix some wordings
>   * give register definition possible

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
