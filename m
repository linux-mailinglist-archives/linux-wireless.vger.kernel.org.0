Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC47D622
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbhLVRyK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 12:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhLVRyK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 12:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BDCC061574
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 09:54:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C4B4B81DCC
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 17:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAADC36AE8;
        Wed, 22 Dec 2021 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640195647;
        bh=8SSppL4Bk0CNHeP44VSZdYQO2VFk0zYSmSyF4odmUaw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O6X3nI0mFU6HWr/N9RItHMdcL8MW4INs71QIqi9E50h517IbTIpg3wh46VhGnRd8l
         9oJFPpzimWhZfsN0VONmh3C3dDQ5qPITlHLmoW1z3LalXjwjlVaTMyEC9Z4/BzGJoo
         HGytSNFZ97x1BuUH6ZXKabkmREG2T/nPKLqe9rIgWhIBVfnLlz70rYxdQZtVRKZ8ff
         SaY4HoMJMP6uQq5A6ujzKVnMY/PS5M6tDEl/IC+2GmR8GPyUoVrZUqmYJlrJAazZLm
         06OMNdDvJuyImFJCXnmHcbPXayvw7En5cf0TH2KGVUAum0wSu2NQMac2tg+rXuoIFD
         bjnpXada3xTIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76: mt7921: fix a possible race
 enabling/disabling runtime-pm
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org>
References: <0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, deren.wu@mediatek.com,
        sean.wang@mediatek.com, sven@narfation.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164019564392.8004.5312965285903271643.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 17:54:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix a possible race enabling/disabling runtime-pm between
> mt7921_pm_set() and mt7921_poll_rx() since mt7921_pm_wake_work()
> always schedules rx-napi callback and it will trigger
> mt7921_pm_power_save_work routine putting chip to in low-power state
> during mt7921_pm_set processing.
> 
> Suggested-by: Deren Wu <deren.wu@mediatek.com>
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

d430dffbe9dd mt76: mt7921: fix a possible race enabling/disabling runtime-pm

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

