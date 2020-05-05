Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF651C56ED
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgEENaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgEENaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 09:30:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF715C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 06:30:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVxer-0007OB-I1; Tue, 05 May 2020 15:30:49 +0200
Date:   Tue, 5 May 2020 15:30:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [PATCH v4 0/8] rtw88: 8723d: add BB related routines
Message-ID: <20200505133049.jtpscqgo2w3v4kq3@linutronix.de>
References: <20200504105010.10780-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504105010.10780-1-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 18:50:02 [+0800], yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Add BB related routines for 8723D.
> The BB controls the channel, RX decoding, and RX gain. So, add DIG
> parameters and RX descriptor parsing for the RX frames. And the false
> alarm statistics help the driver to choose better DIG values.
> The 8723D devices have more settings for CCK rates for DIG, mostly
> because that the 8723D is 802.11n device.
> 
> The 8723D devices cannot recieve LDPC frames, do not advertise it.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
