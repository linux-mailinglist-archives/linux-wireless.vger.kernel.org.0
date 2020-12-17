Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1AA2DD589
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgLQQ4P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQQ4P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:56:15 -0500
Date:   Thu, 17 Dec 2020 08:55:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608224134;
        bh=Bc8Ie/Te3DKHx7xw80Dxr07M0FViOmP34g0gX77pFLo=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=WqlMbehDnvfj/wWI/qfrLje85nFp9qUzwIQwu20J4/WOKWL4UqAkFLCTU6FUMxciq
         4clMJ4a90JSYhHnw0Zv0yj19wjko3LUYW5aM/5Z2sE6owPeT3XG5C7V0gtQGInSPI0
         7jgjeuIf2N9mF5WyvqZRE4JtwNoGdAbTMcvPFObITngGNOiKv1Yr9dTaCu0nhqK4Jm
         +EVnuIiHdRN51bzc2FU0aUGN+nsNL0quHjsNMM8k0KpULncKVbMxkrhqT9tg83eOFP
         gDQ56B5WDRbj8j2PTCxhHLhAxhdMFwvODkKd4PwzB+OYTEIpzOoEyMVDYTgFGvDQmm
         03lQt6+e4NQIQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhi Han <z.han@gmx.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt7601u: check the status of device in calibration
Message-ID: <20201217085533.18b90ffb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201217161657.GB12562@E480>
References: <20201217161657.GB12562@E480>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 17 Dec 2020 17:16:57 +0100 Zhi Han wrote:
> When the usb device being plugged out, before ieee80211 gets to know the
> hw being removed, it gets to know that the association status changed,
> and thus ask for the device to do the calibration. This causes error as
> the hw is absent.
> 
> This can be avoid by checking the status of the device before sending
> the calibration request to the device.
> 
> Signed-off-by: Zhi Han <z.han@gmx.net>

Acked-by: Jakub Kicinski <kuba@kernel.org>
