Return-Path: <linux-wireless+bounces-5542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF26891820
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC281F23361
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6B80621;
	Fri, 29 Mar 2024 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MceLROgt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98C7CF2C
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712762; cv=none; b=uDP+AIcSs7OeDutuPjkFZHmMb/JeNmnWS0wLvLXtHexF2G5bm/tXhw6KrS7vMLc5R87amfg8wWmeFEUhHKDPjmAJdulEy4rQPEzVHVauO7k5aGemE+0ceuLNCEs38XzG32brNYUYY0ywcvPOnv7uhF8E+J1E60zzXzqQkxMP8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712762; c=relaxed/simple;
	bh=kNMj+YT8/hRCP1/RW7aCBo3XA153NEDluUwsJT0u81M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4zJyEpGqCaua7WmrCgeCfBucReiOOZ9wOPWMZ10liyrtV2+zPnPZEXCd0D6ikp0GZcRVJXE1oLG5tONr7GzRUeedU5+34RvZLwhontKmRhxfuyE03rRSKNC9wcM146S+j/SddC297Z01jIvIs6KVlK4J0QHFlUdJV85AHqoWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MceLROgt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711712758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+LLP6jd0zeIvxHanQorL3kqCJpFSSxGEDWd7CPARJUA=;
	b=MceLROgtcM5ObFRbVkesrrPbZZMTFiIRd/QqOZXAVsJ5DFXi/5VBRFshquKkChd14wRGGD
	0aKUWbFpH0x0n3ozxvCEIVwOhsjkm17AKMe9NJUaIYqtuSoxoQUxBtjKpHeFmMgL3HxHAR
	PFJcu2APNY/F6xAVAlXcMWFRFdK87B4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Sc5bCCKMNGClZ9cdck5u-Q-1; Fri, 29 Mar 2024 07:45:55 -0400
X-MC-Unique: Sc5bCCKMNGClZ9cdck5u-Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5684bbeb4b9so1118510a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 04:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712754; x=1712317554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LLP6jd0zeIvxHanQorL3kqCJpFSSxGEDWd7CPARJUA=;
        b=ZgLsjN8/7YbkGAVdNZjqbpBa91wZLAg3OAnG49UtY0uh3J0gh/BP+4cb9/ByzFd/Dl
         qvgY+YP6DhMvyZ6QfBYBfyuwYVF4B+TTFTvY7gfXMrQ2g90vZnAku5VOIxjZKkev0qs5
         kdqPpmkSuM//9QGddZqS15rz8A5LZ5t+Y17u7zaYoM39G+bQiB9QSHFcLnv7Rrwr7Zxe
         JDW0ON/A0Q2ZciLB1LIBds+G/9uaxcK9qzOc/Uc3zKA/twIyl2Aa79P+m3n/rxmzQqFJ
         diYny/+muYGmLJ9l6gdqzyngyBc0LjxuoO3ZKaVCBvrJlX2AWaioodhuk6kTe7uZbhJ6
         t63Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo4D0JZWztDiylzVkPa7K8vOLKtY3kS8rte1PcwAXVKxS0AvNqloOatJVrPOLKf7cr2gsNLilBqFUYdXDanTWQW4Dbf536Uy7RShk21GA=
X-Gm-Message-State: AOJu0YwvlTtIZktqgzrJHpr8x5P/Uo2AkvxAz6BvdtmypYVlP8kYemfO
	0NQMpBJXQz7AhQOdA8IssPGyHRp5ORYS4/RVw+xTnmGAtkV3zqLIfchFPne+p/n1OJGYmrjck08
	dWAO71DbgnbRYYWa7XdcWAIKEcDz0LeHmszZql5eDIBX2E4mmtip3qihwuG8FkW9P
X-Received: by 2002:a50:9b1b:0:b0:566:4aa9:7143 with SMTP id o27-20020a509b1b000000b005664aa97143mr1413904edi.14.1711712753978;
        Fri, 29 Mar 2024 04:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYo6QfJYFEsVSF15QDDFwx8DOxbmiwf/M/DPk0Gc7NLZc79Ft95vFE1vuYwIhBFYvCdq0kyQ==
X-Received: by 2002:a50:9b1b:0:b0:566:4aa9:7143 with SMTP id o27-20020a509b1b000000b005664aa97143mr1413848edi.14.1711712753534;
        Fri, 29 Mar 2024 04:45:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id e12-20020a50d4cc000000b0056bf6287f32sm1991237edj.26.2024.03.29.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:45:52 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:45:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 16/22] net: vmw_vsock: virtio: drop owner assignment
Message-ID: <xhr3nq5n5acn6m7lg7ai2cfaqvlc2a2nihruj54f7um2bjdpaf@tivbri5udlrb>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-16-0feffab77d99@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240327-module-owner-virtio-v1-16-0feffab77d99@linaro.org>

On Wed, Mar 27, 2024 at 01:41:09PM +0100, Krzysztof Kozlowski wrote:
>virtio core already sets the .owner, so driver does not need to.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>---
>
>Depends on the first patch.
>---
> net/vmw_vsock/virtio_transport.c | 1 -
> 1 file changed, 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Nit: you can use "vsock/virtio: " as prefix for the commit title.

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..13f42a62b034 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -858,7 +858,6 @@ static struct virtio_driver virtio_vsock_driver = {
> 	.feature_table = features,
> 	.feature_table_size = ARRAY_SIZE(features),
> 	.driver.name = KBUILD_MODNAME,
>-	.driver.owner = THIS_MODULE,
> 	.id_table = id_table,
> 	.probe = virtio_vsock_probe,
> 	.remove = virtio_vsock_remove,
>
>-- 
>2.34.1
>


