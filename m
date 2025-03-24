Return-Path: <linux-wireless+bounces-20723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E13A6D3E5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 06:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB057A590D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433E175D39;
	Mon, 24 Mar 2025 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVjlNRCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8678F4C
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795445; cv=none; b=kqaXj6pXds38UNUcxagt6gXhgBLbZgCaNwM+7B6seq1iID2ZzSurNlA9EozzIGC49YA75wEbJ0ev7XfiiE/fX0nFrSJlcing71ZcWJlv3oYqUW47wt3Lm9U0lEzkgDnacTWUHfguoSLNQdqiC+eSEFFEGMPH/IdYNqOIjlaPI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795445; c=relaxed/simple;
	bh=oA91usqyqVBPuUrkzcyR4m1vhf7Mob5Ut2kSyX8cV48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbaGcBqXR2ku4M+8JllyoCOuRqMF2vfrtJexP1lfQRgL+hSUYRmCBsVvf9DNluP65P5PqKdxQ1TE8Cz1DwPlh5dOCusFRg/Ag43fec4OkcVuDK3r1Iz8zQ/0rNUmOxJw51RFE0oL50jJ8CW0W6yLQnEfVpX2i5Cvhp5nBk1IFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EVjlNRCF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso17239435e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742795441; x=1743400241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y17ZL3We+j0Um9q8f67tlcHCzUzcIfQ03LepCBYfNfQ=;
        b=EVjlNRCFmFk/eP4K5WUK6/tuvYV0aYyJwHx77UiG5FcKi4yodD0LKI/orUE/S65/+U
         +PjsZMNiTLTu/zFQut9OdQ+TGmSL7nJWKwgljmf2aBljOY8RbBfA0P8/B7o1hIrut4a7
         htMeLnMfOfcDOgSG7HLcmNBJgLFhNW4ry9agPC0thyaUXcadarZiCfkJ6te1OWlB8s2r
         hK4h8nTb+zxJ5ujCYqAlX64huFLIlzeouuJ2sqWOJhqceOMzHe69VRzqKpFxWbkeAMO3
         ZHpH+btXqHqh57v0wHupqKY8hb9IXlro3UQYBCLEblEA00X4ZIh1zScItYRQs9iq/Jbn
         dGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742795441; x=1743400241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y17ZL3We+j0Um9q8f67tlcHCzUzcIfQ03LepCBYfNfQ=;
        b=GrA5yXonPaEu5uT/7j76FswyUbE685C9aOfvRJn7vGfRftMfkF2/yqZY5F0MCSdr0q
         zQOaycS6eLhVy1DhgoL2BaoRdAKHii+3duU0o99THoXKk5X+OhvpDKfWbCw6l+PM5zwJ
         J2lZhYKTNMaYy41ToYqFZskPa4NFSIU8cesHagLJKsp751+OHFsIuphyJJDKDYEr0mtE
         GmV5iQP0nk9yBHwoj5YHnnwSTgYwLJTqOuUHLiML0jOoe/EP5nKzu44XnLsxrPJweCam
         doi9Bn5ViOyksMhCq0kGo0b1yupX7TT8R3fEWeufMNc4aP6lfSB5edXBevcMvWzr6+aE
         uOIw==
X-Forwarded-Encrypted: i=1; AJvYcCVq6vk+/ZfS740kCuaTUfTbXWZtfxxrF4U607zvuiXgDmnB6aklo2x3XWS4edtcvhsVr6XEPZJR6llZsfymbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpa9KXh7jI1u1bsN7xFa969tXP8I01cQa0xDzbEx60OEqXygte
	SG72b5o2nAZFCv35GmmpXQwVOEcvWD8eKA4lxHbZAagwn/oXH4krrRUKjEEG5K8=
X-Gm-Gg: ASbGnctbQWPYiPG/O2wZ3l8n3BReiyHk+zdK1uvcN+uUBwLlkVLJYyVAciYbWJazvEF
	z7Aoie0j+0/Cspu2NWohKYBn/XG4W6KWqXVulKR8OQvd9puxLqgejTpJcGan9KW/6O14Y3QdBcx
	g4J7OtigX1Y3LtGsCUQWDdMMM3E9Q9qEu1OP4AuWkTQsHsQPeTkZYiGSEJcOIBmbfHT4A1weh9+
	b52rgCMWaVeIDUvq28vLAaWqssGbeE5r/jFDsSAZq1ct1rZ3A7JbSkxvrlIlUASslC27f25qoLT
	HqiNsLm2b/JwxeWshpv1UFELvOTgZbkYVdSaUGlxckFenIor4A==
X-Google-Smtp-Source: AGHT+IHmTYmhdJOC8tWd9mJoKjnOkYwl7qqf/27G1AO/Qiuynr43p01EUz4e7kx3RkIBljch7G1LIg==
X-Received: by 2002:a05:600c:c8a:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-43d509ec4ebmr103517695e9.12.1742795440557;
        Sun, 23 Mar 2025 22:50:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f332cfsm161996995e9.6.2025.03.23.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 22:50:40 -0700 (PDT)
Date: Mon, 24 Mar 2025 08:50:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Dutton <james.dutton@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Markus Elfring <Markus.Elfring@web.de>,
	Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
Message-ID: <223c7280-443d-49b4-96b2-90472339dcd4@stanley.mountain>
References: <20250322141910.4461-1-qasdev00@gmail.com>
 <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
 <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
 <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>

On Sun, Mar 23, 2025 at 11:59:45AM +0000, James Dutton wrote:
> As a security side note in relation to the following patch:
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index 66575698aef1..88e013577c0d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -68,11 +68,13 @@ static int mt7996_start(struct ieee80211_hw *hw)
> 
>  static void mt7996_stop_phy(struct mt7996_phy *phy)
>  {
> -       struct mt7996_dev *dev = phy->dev;
> +       struct mt7996_dev *dev;
> 
>         if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
>                 return;
> 
> +       dev = phy->dev;
> +
>         cancel_delayed_work_sync(&phy->mt76->mac_work);
> 
>         mutex_lock(&dev->mt76.mutex);
> 
> 
> 
> Prior to that patch, the code looks like this:
> static void mt7996_stop_phy(struct mt7996_phy *phy)
>  {
>        struct mt7996_dev *dev = phy->dev;
> 
>         if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
>                 return;
> 
> 
> The compiler will completely remove the !phy check entirely because of
> the use above it, so it being present in the source code is completely
> bogus.

No, in the kernel we use the -fno-delete-null-pointer-checks so the
NULL check will always be there.

Also the "phy" point will never be NULL so the check should be removed.

regards,
dan carpenter

> If one actually needs a !phy check to be present in the compiled code,
> one must arrange it as per the patch above.
> 
> The fact that the !phy check is in the source code, implies to me that
> someone, in the past, thought it was necessary, but I think an opinion
> could be taken that it is there to obfuscate a security vulnerability.
> 
> Kind Regards
> 
> James

