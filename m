Return-Path: <linux-wireless+bounces-9054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738AC90A9A5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C8AB27B88
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B419149E;
	Mon, 17 Jun 2024 09:22:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCB190055;
	Mon, 17 Jun 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616154; cv=none; b=qaxt042oLQGFeo0jSldqquNaUjfKNzF8X76OKKWhweOF5mMblhy7s8/VnpzUOgNyhyYch/Tw2RTL6L94OGXyOQKrSuL0bBEcWxdP3/TSMqwOMpegEDRgifJFOPTRfiX3g0x9Khr2qVNK0tqmsm90avbbR1p28vhEPfDMXv44dic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616154; c=relaxed/simple;
	bh=IhgTRvnm+8oWn/6L7YuXPMreikmbVcVNk+2beHEEtkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm+AvPGL89FWbMZbmFj/GO9UFoN19OlKQJ30J+xDqli2DuxZFS2cXOypvhOjyoH1CxTzJhHjPKun2NMOaSOwv3yKHY8xph9t1vMEzuOuqzv8YUKqOGl3yXfb3TLIfdMUAMROYQ8++DEwmmzc4kQlX98kXACT8rGMvgxXLdhir3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c76497cefso4825482a12.1;
        Mon, 17 Jun 2024 02:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616150; x=1719220950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEUIpHnQGVoJgFUUtr6K5uLL6KfCGzBVgBBz+mc8EC8=;
        b=Ye+FpuyN2yXD2CD29De1o7qKGFo2yvWPUwML5zMCVaNzHx2WFMx8xiJytZz7EJChK7
         F2CttLk2H/JN0IV4DTPGr0JhOiT3zxTKVLtOULAM+Qwh3oMEbn8roieOpxFPxu2DRO77
         o0xl+PMmdF/qwS50ff2mRF8OAak6iZyE6Vlqpe/te2ZaYxVQ9gIr6JATtaxT8DjF1AKF
         aUyYFyP0Y6HkkjPo69Fb/Pz0bwxsHyfTziMekhj6EO1fri8y8FmSkTuImgPKnFYtd8o0
         Rqcp8yPAMS6SrukFr+VGB6ZMOq7Obs9l6YzFFMpwx8Z7e2NsePGTbh50Zv9+6GoU/p/P
         1hTw==
X-Forwarded-Encrypted: i=1; AJvYcCXs9ndNFYYCrL7XynZDJUv7FYgmDFh8MqTpHU6AvxEzKinxf+EfhLqQSv9YgJIqnUJ1LNNiwBgfN+R3nH0fUO5cCJPmgkZMEM6HXQ+BBIbwoorwRInJ0EGtyD029lP8nqmjLwBZ
X-Gm-Message-State: AOJu0Yx/uBWY7dhLXNb8dSRiGJibG32X9yljsxc0Kck0rRh1V5O0G3+0
	RnCaHbKFT4fnHYdXHoz9MDHKt7n9FiOgD8adFnkFDw8+P7SAAkJT
X-Google-Smtp-Source: AGHT+IFOEUVidGPJxpO+GgKTTkPjj7sUIp7yTZvciRnrHQQDmvCrLJJ+SpiU6a/ssk+qbAl8zn9V3Q==
X-Received: by 2002:a50:a693:0:b0:57c:6773:d9c1 with SMTP id 4fb4d7f45d1cf-57cbd6a5a0emr5821631a12.39.1718616149646;
        Mon, 17 Jun 2024 02:22:29 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57ccc173673sm3466975a12.44.2024.06.17.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:22:29 -0700 (PDT)
Date: Mon, 17 Jun 2024 02:22:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, horms@kernel.org, kees@kernel.org,
	kuba@kernel.org, Bo Jiao <Bo.Jiao@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Alexander Couzens <lynxis@fe80.eu>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>, Ingo Rohloff <lundril@gmx.de>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: un-embedd netdev from mt76_dev
Message-ID: <ZnAAT/a3DKnTgUoz@gmail.com>
References: <20240614115317.657700-1-leitao@debian.org>
 <87cyogkkju.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyogkkju.fsf@kernel.org>

Hello Kalle,

On Mon, Jun 17, 2024 at 12:03:49PM +0300, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> >
> > Un-embed the net_devices from struct mt76_dev by converting them
> > into pointers, and allocating them dynamically. Use the leverage
> > alloc_netdev_dummy() to allocate the net_device object at
> > mt76_dma_init().
> >
> > The free of the device occurs at mt76_dma_cleanup().
> >
> > Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >
> > PS: Due to the lack of hardware, this patch was not tested on a real
> > hardware, unfortunately.
> >
> > PS2: this is the last driver that is still using embedded netdevices.
> 
> Is this patch a dependency to other patches? I'm asking because it will
> be _slow_ to get this patch to net-next via wireless trees. If there's
> urgency then it's much better to take it directly to net-next (of course
> with acks from Felix and Lorenzo).

Since this is the last patch for the whole flexible netdev work, I would
prefer to have it through net-next then, so, we finish the whole work
sooner rather than later.

I will prepare a v2 with Simon's suggestion, and I can target net-next.
I am just waiting a bit more to hear from Felix and Lorenzo.

Thanks!

