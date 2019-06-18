Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91D74A041
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFRMIb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 08:08:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 08:08:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B1050607DE; Tue, 18 Jun 2019 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560859710;
        bh=qR34Iivj/ilni2WGW0zWLdv96kQrOxL9WUb1agw8MHY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GEXuqc4eqMLqs83uNip1uvLcXRrWiFdxVehv8SZxcGX+UseaQ/iaO9lVPVoSaLQcy
         e3NQds3g7sqnyZDSBqimx1vT+PsthHP0n+XE2pK+SNHWCx5QLTOUCgTFoeIP0iWF3d
         h/O2JCEk2QgWFs8ZQuWcjFSTUip+XJI1qxa0X188=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16B0E60A63;
        Tue, 18 Jun 2019 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560859709;
        bh=qR34Iivj/ilni2WGW0zWLdv96kQrOxL9WUb1agw8MHY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AXBMNFlxS7tFkdVDC9Z7Pr7LaHuTlOrqYay473hjw25ImxjpY2GfoZD2CSN6ybXGb
         FqdKhTbFIViAOXrLlT4lt0sUxwJlVKiOA8hHMezxOfkBZd/PeiiHW82BFVkgaU4hLE
         QgtCz6AI4czQLavBi8hALDFH53N9eCnqkUOJ+ZJI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16B0E60A63
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: fix sparse warnings: warning: dubious: x & !y
References: <d8a003eda05150fb21842d7755fe8081b86cf6df.1560851052.git.lorenzo@kernel.org>
Date:   Tue, 18 Jun 2019 15:08:26 +0300
In-Reply-To: <d8a003eda05150fb21842d7755fe8081b86cf6df.1560851052.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Tue, 18 Jun 2019 12:02:10 +0200")
Message-ID: <87imt3t7t1.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix following sparse warnings in mt7603/mac.c and mt76x02_mac.c
>
> drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:113:17: warning: dubious: x & !y
> drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:145:16: warning: dubious: x & !y
> drivers/net/wireless/mediatek/mt76/mt7603/mac.c:730:9: warning: dubious: x & !y
> drivers/net/wireless/mediatek/mt76/mt7603/mac.c:790:15: warning: dubious: x & !y
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 6 ++++--
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 7 +++++--
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> index ab5141701997..62e0a7f4716a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> @@ -709,6 +709,7 @@ int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
>  {
>  	enum mt7603_cipher_type cipher;
>  	u32 addr = mt7603_wtbl3_addr(wcid);
> +	bool key_set = !!key;
>  	u8 key_data[32];
>  	int key_len = sizeof(key_data);
>  
> @@ -727,7 +728,7 @@ int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
>  	mt76_rmw_field(dev, addr + 2 * 4, MT_WTBL1_W2_KEY_TYPE, cipher);
>  	if (key)
>  		mt76_rmw_field(dev, addr, MT_WTBL1_W0_KEY_IDX, key->keyidx);
> -	mt76_rmw_field(dev, addr, MT_WTBL1_W0_RX_KEY_VALID, !!key);
> +	mt76_rmw_field(dev, addr, MT_WTBL1_W0_RX_KEY_VALID, key_set);

I'm not seeing you really _fixing_ anything here, you are just working
around a sparse warning by adding an extra variable. I'm having a hard
time to see the benefit from that, it's just an unnecessary variable.

FWIW I had similar warnings in ath11k, I decided to ignore those. But
anyone has suggestions how to solve it better, please do let me know.

-- 
Kalle Valo
