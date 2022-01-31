Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CF4A4AE7
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379799AbiAaPsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 10:48:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43514 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359646AbiAaPrd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 10:47:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69F51B82B6C
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 15:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16541C340E8;
        Mon, 31 Jan 2022 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643644051;
        bh=T4sV+adbOpest17bA007/cwC2xcQMZZvPfLLl7fWaYY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X1h/FAA65OSpD+DzrhpzYJYwH4hoOGPLW/2gLaFGmIxdwgO0PxI0w0PWWpCHWT0Kp
         TeFEzNrk8mZ5TYcewMtU6iIhjVF/LnQZ42tKvYpu9I3OLjM6zs8mlp0iKwwGh9711d
         PLshnb/R3h+lL8IUjcTOl1vZ1zD9rZsD//SoXFn4LHdZ7MWMGWymHcyPYYx+iTipKX
         +gDQBCWR9/3FkRnIfo6GkDGDTM4kxlvdAUxxE/mN/E/+WCtRiPZ77bYTz7Yb8WAMol
         UF2mHLrgHY9QCtnJCl/or1iweKVaKAdJWu6QWn24tTRClJ62UZk8j0ykcNuIPUG5c4
         XN/70OTesAOFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtw88: check for validity before using a pointer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220121070813.9656-2-pkshih@realtek.com>
References: <20220121070813.9656-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <usama.anjum@collabora.com>, <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164364404807.21641.12155836646677086597.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 15:47:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> ieee80211_probereq_get() can return NULL. Pointer skb should be checked
> for validty before use. If it is not valid, list of skbs needs to be
> freed.
> 
> Fixes: 10d162b2ed39 ("rtw88: 8822c: add ieee80211_ops::hw_scan")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

a12f809968db rtw88: check for validity before using a pointer
c17f27167b4c rtw88: fix idle mode flow for hw scan
d95984b5580d rtw88: fix memory overrun and memory leak during hw_scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220121070813.9656-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

