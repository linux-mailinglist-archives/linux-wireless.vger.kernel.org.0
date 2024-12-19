Return-Path: <linux-wireless+bounces-16636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E39F887E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 00:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1697D162307
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A161D6DBF;
	Thu, 19 Dec 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCGYbsVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926B19F41A;
	Thu, 19 Dec 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734650894; cv=none; b=jf58lLGHBiFbXhBBOzOSpDB+5jejTloSZSfjVL3NdOCtuBwlOwioX9Ewjh5YSNoOMtp8k6M0dh6Fm7Tg1i4PYqOQAY5iPGNfOeapllAEmbM8R2pxfX92vvDA9wHfbPte6jmzo5L4J9IrBUGF+P/e03tCMujuuQ9ivy7wT/nHSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734650894; c=relaxed/simple;
	bh=91T4CDh+J4MnbjMEHqlDbWbhPHyManv9HM8AVh1CpQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=SB2YwKWCzvJf2c9S8at4EVYWPsVAb32f/o+sz7i7+dFq6O6LDxH/K/Xijqqy+LLmOrCLuoba1oEpi7X4tz+UdFLMGJ3oXu0AudmLhbgGI/Q3jJgXu0hvCUOCE57YSfuTOULmZY8lJahv9OwUpzdVJ8Gkl51ZUmMj70A4+z6+wgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCGYbsVL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c68b89eso1487244e87.0;
        Thu, 19 Dec 2024 15:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734650891; x=1735255691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2l2kaTxVgDXZ+WZ5RNly03lP6LWl5fzxLs2ibw+q2ng=;
        b=bCGYbsVLSF9pn3KAr+gwa9rShoT0jhM59mbBMHkXQrK8wVMbWqBvDoqoNHdu54v9/P
         UJZKIwMsIxSEqN++xr74HRff1zoETjIbOpTkhvnQ3qHgQXSVEgU8dNlazlsDZaQbiz59
         Jgk8A65Eok1Y63XfS3wfNCTjr7v8lWdwBv+crwJLofGDXcjvKfRob0iBW4Uiy+113tHt
         2bJRSRdT8N4p3OXQ/K81Bd27re0H9/oIq845GRq6XquM5soRG5Be5Kl1Qolbia73UHng
         Vx7r3DJ4x/3ausKf1oq9O4kWfbcf3CUT7dX4z9MDFv9Y5bz5rq6rZ6pmEGqkWPDGLaZE
         HIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734650891; x=1735255691;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l2kaTxVgDXZ+WZ5RNly03lP6LWl5fzxLs2ibw+q2ng=;
        b=O7yJyibjemQeHf+vOF4vuZwPuWuo/d2517cEAmb3NPpQGO/iycVJvWtvcle/VFM6lN
         EVrNYTokreP8ew16BSSyrDdLECkQ9leq20O9T6t90lje2PUwipprvxuaXIIoKxkoEsyw
         Q0syuu9R7/Ptd9BNVSvOEziVK/yjzs2xNkii0vbfmA4Z9RVgy3JUjcWq57QJbz0J+uCt
         89QISUEgl0TfLSEx4IGww96mssGJD0W3NEJFjqbIwfGrznO+9Uxz7ZkZ3smH6UTmFn0d
         Dx/UKqZbzY1BJA6rwbDWxUr+s30S8parva/eyvRDEmrPPCSjmAFPEpf4WqKnq9Balhvn
         t3fg==
X-Forwarded-Encrypted: i=1; AJvYcCU9HvsCrk1DcmBXkxlpYfp7TDy3OiZyn2VVjyhofRz4ZeTZpfiIIPOrYVZgBDLzQdSEH3/HNR0ZdZ4+@vger.kernel.org, AJvYcCV1EPNgKKxz6JogtatFVIIVmAPjCfcAYwrYmkkZds8jvTRiVibucWzSKlufwFLr2XON3QQ+IODx@vger.kernel.org, AJvYcCVJhiVpz8adtBdkKLJUoNNdzNI/zoH34M6jHiycnnTfxv/MnU6NO1GBe3z6cDbNGPP3FyjAgrDbGCuStQkmluM=@vger.kernel.org, AJvYcCVLZR1eVE23yjxQYKBmkjWT+Kpn9rZ2EIQR9fXW5tVpo0ksRfcayviYKD3CVYVmbPNdNQD6towQvv8a8s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1f1RY5LsgJoatrVQA3VRp0A1rHryrcsx0YGbTgZGlEXD09pu9
	Q7wbtuYN6Vz0yUhEc/BoenP6ZAMoRQ4zRhsLQa46mMAn+gXHRA3h
X-Gm-Gg: ASbGncu1itNiuwT9FZfr16jH3c5/cQtAIjRPb0d1BBcP+O8cwK5JANiSFADtra+b2kA
	bcypgRRk/nnHt8EsKmadPBqzeTloIEwyP4SF6ZCL5k+a0x3m6dpD2FG7WPQ2sLCqQtmja+YQFcr
	AtaXlCeOwJLNbKFqSz6twY78SB2c03JNgRD0BFecqCjiXY2DFEN4FElwYf2EN5ws/9n3ORjMhPF
	suaaHI4PTAOAhW83XMkpygKItwc43Uvk0BLAnAr15tw2Wua6xymYZyfdvidwqPg2khRjE6k3A==
X-Google-Smtp-Source: AGHT+IHwtq2DRxGiJpJfSQ3Ioq7kVn6TqoQxNI6STyt5mABoqAAJc/qvM+8M8/76Be/3GE/r3d1tWQ==
X-Received: by 2002:a05:6512:a93:b0:542:215f:e615 with SMTP id 2adb3069b0e04-54229450a3bmr193154e87.16.1734650890368;
        Thu, 19 Dec 2024 15:28:10 -0800 (PST)
Received: from foxbook (adtk139.neoplus.adsl.tpnet.pl. [79.185.222.139])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5422360075dsm310172e87.104.2024.12.19.15.28.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Dec 2024 15:28:08 -0800 (PST)
Date: Fri, 20 Dec 2024 00:27:59 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: aleksander.lobakin@intel.com
Cc: Bo.Jiao@mediatek.com, StanleyYP.Wang@mediatek.com,
 alexander.deucher@amd.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 angelogioacchino.delregno@collabora.com, apais@linux.microsoft.com,
 chui-hao.chiu@mediatek.com, cug_yangyuancong@hotmail.com,
 daniel@makrotopia.org, davem@davemloft.net, deren.wu@mediatek.com,
 dokyungs@yonsei.ac.kr, dsahern@kernel.org, dzm91@hust.edu.cn,
 edumazet@google.com, gch981213@gmail.com, git@qrsnap.io,
 gregkh@linuxfoundation.org, guanwentao@uniontech.com,
 gustavoars@kernel.org, helmut.schaa@googlemail.com, horms@kernel.org,
 jiefeng_li@hust.edu.cn, keescook@chromium.org, kuba@kernel.org,
 kvalo@codeaurora.org, kvalo@kernel.org, leit@fb.com, leitao@debian.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, lorenzo.bianconi83@gmail.com,
 lorenzo.bianconi@redhat.com, lorenzo@kernel.org, lynxis@fe80.eu,
 mailhol.vincent@wanadoo.fr, markus.theil@tu-ilmenau.de,
 matthias.bgg@gmail.com, mikhail.v.gavrilov@gmail.com,
 mingyen.hsieh@mediatek.com, mrkiko.rs@gmail.com, nbd@nbd.name,
 nelson.yu@mediatek.com, netdev@vger.kernel.org, oliver@neukum.org,
 pabeni@redhat.com, quan.zhou@mediatek.com, raoxu@uniontech.com,
 rodrigo.vivi@intel.com, romain.perier@gmail.com, rong.yan@mediatek.com,
 ryder.lee@mediatek.com, sean.wang@mediatek.com, sgruszka@redhat.com,
 shayne.chen@mediatek.com, sidhayn@gmail.com, stern@rowland.harvard.edu,
 stf_xl@wp.pl, sujuan.chen@mediatek.com, wang.zhao@mediatek.com,
 wangyuli@uniontech.com, weiwan@google.com, woojung.huh@microchip.com,
 yn.chen@mediatek.com, zhanjun@uniontech.com
Subject: Re: mt76: dealing with disconnections, -ENODEV and -EPROTO
Message-ID: <20241220002759.34dcfe11@foxbook>
In-Reply-To: <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> >  		ret = usb_control_msg(udev, pipe, req, req_type, val,
> >  				      offset, buf, len, MT_VEND_REQ_TOUT_MS);
> > -		if (ret == -ENODEV)
> > +		if (ret == -ENODEV || ret == -EPROTO)
> >  			set_bit(MT76_REMOVED, &dev->phy.state);
> > -		if (ret >= 0 || ret == -ENODEV)
> > +		if (ret >= 0 || ret == -ENODEV || ret == -EPROTO)
> >  			return ret;
> >  		usleep_range(5000, 10000);
> 
> How do other drivers handle this?
> Can -EPROTO happen in other cases, not only unplugging, which this
> patch would break?

Yes, -EPROTO may be a transient error, although they are relatively
rare as some retries are done before the URB fails. This patch will
only break things if things work in the first place, i.e. the driver
has sensible retry policies, the hardware doesn't get confused, etc.

Note that -EPROTO is not guaranteed in this case, see
Documentation/driver-api/usb/error-codes.rst

I know that xHCI gives -EPROTO and it looks like EHCI does too (IDK
if this is reliable), but I just checked that OHCI gives -ETIME.


I don't have this hardware, but I played with some other wired/WiFi
dongles and observed similar problems of varying severity.

It looks to me like USB core doesn't actually return -ENODEV on
disconnected devices, or at least doesn't react to disconnection
until .probe() returns, I am not yet sure which of those.

And drivers don't seem to expect -EPROTO or -ETIME to be fatal.

And maybe they should, if they wouldn't be able to recover from it
anyway, and I know that there are drivers which can't. But I think
this USB subsystem behavior is suboptimal too.

Regards,
Michal

