Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B402B1E6994
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405900AbgE1SjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405896AbgE1SjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 14:39:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF1C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 11:39:15 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeNQt-0006Sa-MA; Thu, 28 May 2020 20:39:11 +0200
Date:   Thu, 28 May 2020 20:39:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com, oliver.sang@intel.com
Subject: Re: [PATCH] rtw88: 8822c: fix missing brace warning for old compilers
Message-ID: <20200528183911.zbnhfdexehur4wby@linutronix.de>
References: <20200522035521.12295-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522035521.12295-1-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-22 11:55:21 [+0800], yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> For older versions of gcc, the array = {0}; will cause warnings:

I wouldn't say older. I have here 9.3.0 and it does create the same
warning.

Anyway, 

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
