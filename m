Return-Path: <linux-wireless+bounces-20680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84CA6C00C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E3A7A932A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2422AE75;
	Fri, 21 Mar 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQDh2FHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A522B8C4
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575011; cv=none; b=TwC15uGrkdNw7KW7hcxceKNsF1rNb0WNE9d2KFT45VNJtwy8PWT4yli9M2krCIOqLt8KvAGgtH5D3NSV6mnVTMHrXs+qX1ugi5pfwCUmVFeRFGiZeZngPcMQ9+yjZk4O7KQk7+2tmGAuyXkYvWPhJfFLxmgcdtzw7bf5MBmvdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575011; c=relaxed/simple;
	bh=EYXvUxlOmseeifJZO5lf+exAGIwHnoh8eUMozDOfeNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj3IMQKxE3ZB5ZQt/L1iWAMXpziXTZoXLsbO5jcb5Olzq6XcYP7IiuNabUzhkay3bj+lNJQWZBbH8Dd/6hyU1TsQRWCyx5JUdvMlHxpzaY7YHzFiVgItJIGZrvZaXGhzkjMhqp+bc8+Z5wZNciOJKCfxyxeX88KXIcjL2nLH3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sQDh2FHd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3965c995151so1175583f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742575007; x=1743179807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dfJ83Y79NwDQ+8qNzxM+p5WkOeUg86p4gkdxrYkNv4=;
        b=sQDh2FHdP1ifr+hdjjuM9zb3UOf2lzxVRZCMxlPXwICKwVkXF5ByDKUUpo2NO+xsa7
         rHT3koL2aeIK96CpVBS5u53o7hsXSZvTs/O41DuuQpbHdseDfiQmYBgUci4c4n3nyEI3
         56C0yjvCtML7NVVUNvu67hsdK5xgb+MLl0cg2paN6lsmFLjyuv4XXAon2DoeVexv0AH4
         FfI5q4srAwJnjqgnIvc+xlMrgiL6QxA4hbvRJxYEqe8tVuiqv5OPYS7j/XSQP5XmZTTs
         pV3//M6X6skmM/G094GIVDpl5UUIa/4DGgHIQtqwHTE3lUveBRM7Ob7136u6bUpWU1Ca
         nIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575007; x=1743179807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dfJ83Y79NwDQ+8qNzxM+p5WkOeUg86p4gkdxrYkNv4=;
        b=sq36paXmcb5FbYTTZrontrEhXEu5/AUUnRuHX0aobrDYQi2flk3Cewzt7K1Uso0mSL
         K9nKVl1h7hcSlVsK7cR7PSiJrCp50qAy4spueTyR3vcozVshS1PIzB8SgHL0uCgHQJSH
         1nJbzB/hIejoa2spJaNt3bcn5kLOhZY9zxabYFVFtezEGowG1FW21Hzr0E9TJ2Q3CJ5W
         lD+GDYqLnQFH+VYeOSPCn/c7U0VNc+1zysblyewmAv2780ilDvRrCroJjt5KUNsWJdlZ
         6EKTvdedqIvQQT2+xAlej9mLwOp5Pt2ripFk0k+7PgAEM2g0c8EPCLHsXRZwK8+o8nMp
         ojpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQNiumxhs6Qr2PSeTV8BQYWyaD9agzho+YQ8mMj/RIACZrZbu4AiY+sEUTU+u5AxE8MhCzCjjf23dBWcAE8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1nVSHpu87ZJ12+Z+wEOLBoatW0ud7IOGLxW4k5iNek9yW8+5
	Td1PhZWQSsVUckxXKDEuxirPIdO3lSDQU397D9AEZR2wdKcn9vN/yKozRfHEWtU=
X-Gm-Gg: ASbGncuogDREID53vWplk0X/gGypGwT7vbCoLEopRXY1UpCL1tjvjwrdvswmzo0+SyP
	VfOhOyEuTKqasmgPXG/LhM8sRGFnapTH5VYX+LH49VVhEKdEEhN54zS5ZPpRd61y89n+b+Zsux6
	Bxzw5avCCK59u6w8dHgnxkX07gX0MXxNvmcjg1cUHLhwEmHblhmolwR0dABATnEjMyLFw8rzsq8
	kCYdx3p2mKlox418CBvTv6nXTlv6zb8qBXM7Mg9QN5S6IkiTRbJ1R+XqlniwT2ZG/jODIMIL5VB
	5rPFiylMMlc1okuAeRZcz9DpgmxO8EaSizHatFABX23ABS6RTQ==
X-Google-Smtp-Source: AGHT+IH1Gh+yAviT4FQBLCA4J0rbTJcI0EGBOTqg0d19KW+FNDv9FqBQEn8luqW5P6A+FmDu+T7bTA==
X-Received: by 2002:a5d:6485:0:b0:391:4231:414 with SMTP id ffacd0b85a97d-3997f9397e6mr4352017f8f.40.1742575007313;
        Fri, 21 Mar 2025 09:36:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d440eda26sm82421375e9.36.2025.03.21.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:36:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 19:36:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <46a714fb-8a14-4d24-a0a6-a22cc9d45768@stanley.mountain>
References: <20250320201914.48159-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320201914.48159-1-qasdev00@gmail.com>

On Thu, Mar 20, 2025 at 08:19:14PM +0000, Qasim Ijaz wrote:
> If link_conf_dereference_protected() or mt7996_vif_link() 
> or link_sta_dereference_protected() fail the code jumps to
> the error_unlink label and returns ret which is uninitialised.
> 
> Fix this by setting err before jumping to error_unlink.
> 
> Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support")
> Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index 91c64e3a0860..78f7f1fc867e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
>  			continue;

What about if the list is empty or we hit this continue on every link?

regards,
dan carpenter

>  
>  		link_conf = link_conf_dereference_protected(vif, link_id);
> -		if (!link_conf)
> +		if (!link_conf) {
> +			err = -EINVAL;
>  			goto error_unlink;
> +		}
>  
>  		link = mt7996_vif_link(dev, vif, link_id);
> -		if (!link)
> +		if (!link) {
> +			err = -EINVAL;
>  			goto error_unlink;
> +		}
>  
>  		link_sta = link_sta_dereference_protected(sta, link_id);
> -		if (!link_sta)
> +		if (!link_sta) {
> +			err = -EINVAL
>  			goto error_unlink;
> +		}
>  
>  		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
>  					       link_id);
> -- 
> 2.39.5
> 

