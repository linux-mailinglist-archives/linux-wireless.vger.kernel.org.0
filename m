Return-Path: <linux-wireless+bounces-2373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D0838D2B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8022B284E10
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5965DF2C;
	Tue, 23 Jan 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mms7Mx/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3D5DF29
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008576; cv=none; b=ai+HubOPsnO3VtFIoUW6WIjOD8T8S9PRYFTDvooBFlPWllZTueVU5SXIYskBUegU9pZSStHCb+KWO/aaIq7bNtrJ22ZDtkE9l9NaLoIaS2cXIHD58ZWT+NbkttkI9e9JqFl+ob1WKn7Lvrpwys6cWQl9/FdYT9kkwrmnnUaeRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008576; c=relaxed/simple;
	bh=N0PTVL4fzc2fc/gANIXJx4GzQxydfHxxGy/6qDhdsGQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ttLE8i65Q6zsLILGYJ44VHopLg6YgABgAAzbTCBb50ZHzoZW85j9XjX+hLcZchJzy4P4Og1Usr5OboZ9BPm9/vDFLglqy1gd61wEkSimuFxIS2v1SZgqxej7CFBGv1YeSsjVg/JAhdkxAPlTElmXVlteuutw6x8nlTkqGnGHzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mms7Mx/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8DC433C7;
	Tue, 23 Jan 2024 11:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706008576;
	bh=N0PTVL4fzc2fc/gANIXJx4GzQxydfHxxGy/6qDhdsGQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Mms7Mx/xwoGkELZcascvJnqmwS2Euw+S50aiglr9vVeFDJVoHZkkKJt7WbBiBtlwh
	 /P8tIdk9hiSaOZmCS+c7cHcVnV7YMvpblJecAU1zz98c8gbRWq70e5GV02jCZKojVR
	 mmV6LgYG60CxqorR5eHRMwMZhdv91j5LWqhBlfCMVxbzLVawEpyuP3yHk1DbswrTur
	 hT/vXKYKhWpKXFRIBsDNaJ9ONPFKAXHpwoTrvWXWq+s3X18Yj0orHAPNXOxNG2DHlS
	 yUIx5kdXG7nWWa83F/fdo6sqtJHoNTIFcml6/3j8lbMyXrAC1fw8XZz42sFAQ4ZjuR
	 fb/9S13Cf2O8w==
From: Kalle Valo <kvalo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,  linux-wireless
 <linux-wireless@vger.kernel.org>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>,  Evelyn Tsai
 <evelyn.tsai@mediatek.com>,  Bo Jiao <Bo.Jiao@mediatek.com>,
  linux-mediatek <linux-mediatek@lists.infradead.org>,  Benjamin Lin
 <benjamin-jw.lin@mediatek.com>
Subject: Re: [PATCH 04/12] wifi: mt76: mt7996: fix incorrect interpretation
 of EHT MCS caps
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
	<20240119085708.23592-4-shayne.chen@mediatek.com>
Date: Tue, 23 Jan 2024 13:16:12 +0200
In-Reply-To: <20240119085708.23592-4-shayne.chen@mediatek.com> (Shayne Chen's
	message of "Fri, 19 Jan 2024 16:57:00 +0800")
Message-ID: <87v87kcnb7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shayne Chen <shayne.chen@mediatek.com> writes:

> From: Benjamin Lin <benjamin-jw.lin@mediatek.com>
>
> The EHT MCS map subfield of 20 MHz-Only is not present in the EHT
> capability of AP, so STA does not need to parse the subfield.
> Moreover, AP should parse the subfield only if STA is 20 MHz-Only, which
> can be confirmed by checking supported channel width in HE capability.
>
> Fixes: 92aa2da9fa49 ("wifi: mt76: mt7996: enable EHT support in firmware")
> Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> index 3c729b563edc..02d858fdc9fe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -1240,6 +1240,9 @@ mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
>  static void
>  mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
>  {
> +	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
> +	struct ieee80211_vif *vif = container_of((void *)msta->vif,
> +						 struct ieee80211_vif, drv_priv);

The void pointer cast looks to be unnecessary. This is nitpicking but I
really hate casts.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

