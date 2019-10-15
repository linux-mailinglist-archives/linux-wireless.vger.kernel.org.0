Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7581D7B6C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfJOQ2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 12:28:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfJOQ2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 12:28:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDCC060BE7; Tue, 15 Oct 2019 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571156913;
        bh=KOeIw3gkdA6lhYkuGUW1LTe0NI6YnsNCGDr0ZnO6Mk8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cKzFdjlLgaErSB4sPznCi+BheW8s+h/Mu5k81fmYlSPCe3TaCvjICWk+bu4Xtl2ex
         gu3k+7egf+sB9Xn4HGqd5qhpv429moKJ04Brs4+usoyYc27zbmp0+x10kzVGxfMqc5
         Mse7oDYBdfGkIuP2m0tBrUHBGWECXqw4Lw4p3Ayc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-79-201-nat.elisa-mobile.fi [85.76.79.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81BFF60B6C;
        Tue, 15 Oct 2019 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571156912;
        bh=KOeIw3gkdA6lhYkuGUW1LTe0NI6YnsNCGDr0ZnO6Mk8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bIrLcz7COORdGWYbbfTYuOMyXkjcAcvj8aF9Q531hE2qXGhU1YO8EgeJd3Q6FU/6a
         xvms0ujDc0Opbc6o5sApZgM7ZCU1rYbZho0JWF4QgWJ/Iv6d4GF3XPO02WQWMe3fDw
         8mVP3dxvIABTEj4Xd4STfTHf2+OxV13tqlAOFjis=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81BFF60B6C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
        <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
        <1635460.phzPRRphLd@bentobox>
Date:   Tue, 15 Oct 2019 19:28:27 +0300
In-Reply-To: <1635460.phzPRRphLd@bentobox> (Sven Eckelmann's message of "Wed,
        21 Aug 2019 08:16:27 +0200")
Message-ID: <87d0eym0r8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Tuesday, 20 August 2019 17:47:57 CEST Kalle Valo wrote:
>> +static void ath11k_peer_assoc_h_rates(struct ath11k *ar,
>> +                                     struct ieee80211_vif *vif,
>> +                                     struct ieee80211_sta *sta,
>> +                                     struct peer_assoc_params *arg)
>> +{
>> +       struct ath11k_vif *arvif = (void *)vif->drv_priv;
>> +       struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
>> +       struct cfg80211_chan_def def;
>> +       const struct ieee80211_supported_band *sband;
>> +       const struct ieee80211_rate *rates;
>> +       enum nl80211_band band;
>> +       u32 ratemask;
>> +       u8 rate;
>
> rate has to be u32 [1].
>
> Kind regards,
> 	Sven
>
> [1] https://patchwork.kernel.org/patch/11089507/

I have applied this now.

-- 
Kalle Valo
