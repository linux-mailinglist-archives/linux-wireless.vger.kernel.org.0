Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6581E7654
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgE2HF6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 03:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2HF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 03:05:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387AC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 00:05:58 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeZ5X-0006AG-Gl; Fri, 29 May 2020 09:05:55 +0200
Date:   Fri, 29 May 2020 09:05:54 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Subject: Re: [PATCH 7/7] rtw88: 8821c: add phy calibration
Message-ID: <20200529070554.h3vrap3lxlata6zn@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-8-yhchuang@realtek.com>
 <20200528162727.57bxyoi76bqpacge@linutronix.de>
 <c0f716a120b74c7a8f3ce3fd79d8471c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0f716a120b74c7a8f3ce3fd79d8471c@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 06:31:23 [+0000], Tony Chuang wrote:
> > > +static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
> > > +{
> > > +	rtw8821c_do_iqk(rtwdev);
> > 
> > Why this extra step? You could name it rtw8821c_phy_calibration_iqk().
> > 
> 
> This is hooked at rtw_chip_ops::phy_calibration(). For 8821C, only IQK is
> required. So just keep the name consistent.

Ah okay.

> Yan-Hsuan

Sebastian
