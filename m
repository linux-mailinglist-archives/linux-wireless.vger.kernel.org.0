Return-Path: <linux-wireless+bounces-20690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43478A6C926
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A6168A62
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB71F4627;
	Sat, 22 Mar 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVmOrvmq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30A1EB5D7
	for <linux-wireless@vger.kernel.org>; Sat, 22 Mar 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638790; cv=none; b=qal4gcb02/mH7MFotDsqfxhTvXNJW6Ilkm3SKvbat6eTPAtB5daB3gPs15aG1b/Qb2xMcxifEUzgYubRkogeqTKXDi3RN5TtGuKPZXt99Qbuf1VEtUkZBHyxeFtzeJZ3ifOiNMQWQ83VLnF/BjNLiAxQev2Ar/4+se0uVZTuXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638790; c=relaxed/simple;
	bh=maMryLb5HMvpE5OP65ltf8GjK4I+0KtLt8vUom9lyjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGDwYBhGq9dJbKUVvhHLp5eATxh/in1m+mls+VYklJ6CZZBRvh2KwVo8vI0vDBtDzYzAJmVi4539yPk+crAE6ck5aHBUFEJHpZUXWqATOLcij8DQ6CgFvLD9vDvDZKvlSUqz12qa1pUMRlG1kvSn53ZDLVjNrfWTZyhpTbmocSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVmOrvmq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so16533435e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 22 Mar 2025 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742638786; x=1743243586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMfqR7BxervAfhU36qPFX9900VIMKC1P3TtL+FMdSXA=;
        b=dVmOrvmqdRDcKq2cU5QpVwDfoUzCNkj0Bihc1NXGXHs8j6i+HVqEZG+fN3PZaa2kyq
         LhhFi+HGQU+6B5bhWqLLckEPcIId5oBF3Mde8X27ZYOR4XFkCYi3eg7Q/OkAT/WZtRpK
         YawGvvB7Cw+5q7idFUuvrJJubHjBkiZ4+KRjIvatqkE3i9Q3cZv0H/Kao2hMZLvG/dOE
         K8jHbzwDa9rGZkpJ3vKPZDZ0FsD9EaIxgA1oxw6ecj8MlJN5CQdwjGpUrdjGVqahD7jQ
         t74P0H/cXY7NssmMahS7S0q8JAu172JGleYfhUchmP4ioTHOo+hamGvBe9PxKz3XklHv
         TIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742638786; x=1743243586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMfqR7BxervAfhU36qPFX9900VIMKC1P3TtL+FMdSXA=;
        b=Vr9oPlUNzpjg0eaB/XJFctM7+MFgxz9Gl1XPd4NLJAFYs189mDuoHyJQFniXOAazkI
         PtvpPzllzAtcvkGQRKVi8icAABfJ6MUfwGiO8pLqmZsZg74Lvtxk5xra5zsIN7Pou1Cw
         ccZUAqv2/YRilRjmsBgCP3eFN3Bw9pzsJ9kVPRMomfhUrtIE1C2U65F4TSlFTrOXT6Ua
         3VF+q+8fL4h21ZYVmhhuPfKDWjK5UAavUItXIcm35ToCbSsih3NZOV5baMuyK+QMaICi
         wmqxKduLtJdURZYrG6ku9iMu3da9VDeKwlC09i9009+ezl4w/jZBdq4QWelew71cxnPi
         111w==
X-Forwarded-Encrypted: i=1; AJvYcCW7yGiTHSKgA1zBf34j35h8FaVWGjzll1u3N62fSGrgt/fKfp0Rj8TLZ5V0WEE0s+TAECZDOhV2IsK3BwpyuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VdfaoyKCeboqyu1mtx2M+kL/3ZypsDmi+Iou/w4GeszLjzqE
	SkWExdsvUy2mHmN8N0C/wvpygjiHRkwTl4EfXr3BsdzLWUet+A00+bJKGgqYWg0=
X-Gm-Gg: ASbGnctc/gsLjc0MpwctdR1uvLQNWPsbphOTpfNoj75ctIBblDKhfAZXxDPeJXOs4JA
	xGbUGumCrupBblmbqPmhYatoesY18qzIivEuWC+z8DiXYfaEA+s1wlnxoxgrem9UL9oD4SZFrnT
	oNYSsHyfyQxvZjC3xGCbVt9FUeEeP568vks2+POi/ngsUXEh1IZgAbmHYyQ+IB6XCmovchVaGwI
	0JWqnObf6zlbwLeIu+B3dA5rX2w9zKw0hkjOxQRTGmRlxOUMsjuIzemtN8Gxk32U8dBS5nJJJvV
	HEwtOwyr1TbbiW5oeunCPhLa1kFxx/8w+yFvZkTzeNul/Q7Dkg==
X-Google-Smtp-Source: AGHT+IEPG1arfHtpohOj/xn036w6qfXf/DIsE1g/1+STIZT2hgcYRfebfuDsK3XXOFOXWdgPtcRXdQ==
X-Received: by 2002:a05:600c:3ca5:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-43d509ec5a9mr61035965e9.11.1742638786140;
        Sat, 22 Mar 2025 03:19:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a325csm4721308f8f.22.2025.03.22.03.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:19:45 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:19:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
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
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <8b342640-f4e7-45a1-a6d4-471e687bbbc7@stanley.mountain>
References: <20250320201914.48159-1-qasdev00@gmail.com>
 <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>

On Sat, Mar 22, 2025 at 11:01:18AM +0100, Markus Elfring wrote:
> …
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
> >  			continue;
> >
> >  		link_conf = link_conf_dereference_protected(vif, link_id);
> > -		if (!link_conf)
> > +		if (!link_conf) {
> > +			err = -EINVAL;
> >  			goto error_unlink;
> > +		}
> >
> >  		link = mt7996_vif_link(dev, vif, link_id);
> > -		if (!link)
> > +		if (!link) {
> > +			err = -EINVAL;
> >  			goto error_unlink;
> > +		}
> …
> 
> I suggest to avoid such repeated error code assignments.
> Can an additional label be applied instead for this purpose?

Maintainers get the final vote but generally when someone is doing
the work they get to decide.

I would say that generally the way that Qasim did it is normally
more readable and more future proof.

regards
dan carpenter

