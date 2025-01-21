Return-Path: <linux-wireless+bounces-17785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932FFA17A7F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC8418818AA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5B166307;
	Tue, 21 Jan 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQVCwdUh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CECF3BBE5
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452987; cv=none; b=SvTJ05tSG4Gc4WZZAgftco/hqPgcRglahts/UUkaXvPXBvbHdI4/bELY4eoFp8+PHryH1Ecz3FeCZ2i1N4hUxsubZC/GUTM3ZwHxSwNyneLZPxlj4JrOkaM+MVU6FGUYj/xfxqGWJ9zWNMhiy8sHu2NYZy3X1JFRCu6ryNYFacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452987; c=relaxed/simple;
	bh=sBXuhRdSPlf7PvQC0JDuPAtpDLmpxAlN4/LRDL69rq0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=F+X2VCeTsNWfD/iNANxtPZ0/0XucSGtXHD3VwRxrobS4FCMsnifL7F0S1xB4A7/Eg+LGRWVnjrH5fYCYA+au10Z51rUDEpwjQMV2rXx08aNpBz5RPcKKDNNlfcwbrdrkWqPZCHmARIUsPE+0cLqoQuxsr4mjtvwzwaA3J+UktRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQVCwdUh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso4244790f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737452984; x=1738057784; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBXuhRdSPlf7PvQC0JDuPAtpDLmpxAlN4/LRDL69rq0=;
        b=EQVCwdUhriIUp5C9CcGlPVuMHBpnJ164+mk+KEwHSI8BjlIyonRzMyg+Bz0HYPKyN1
         tpRShvOjJixrQs5CNhNC/gqa7PltfPXcF9l1YjG30BZJ0eoOHqwY7xW2CdIVLp5Czp7k
         7fDDu04YBPFrLAX6xLbfgfBUHpf+yqJXMdVy/qLIcbajpDihlKvo1ilFXUGuJkYjAEAC
         GqRBR2dhoJqIsPqT8KsBxr0aLDFsPaFrYJY4/doD6U1Jyxt6XJYhEh6j017qJ0tRkxhw
         uoDhv00mNTSxt0/zhddA2uUa2oaRo5V7NaXoDYOjFbcNQZb2OWZM2nsy7pUHUZMC3TD0
         ta0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452984; x=1738057784;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sBXuhRdSPlf7PvQC0JDuPAtpDLmpxAlN4/LRDL69rq0=;
        b=Zx9ALwRB8/3ZEIBm8AVL2BoQPR2IvwTcd2I9gBC0T5sojNE/CSRAEWJ3hx4HNnXMg8
         OOtZcABGPHOzJFkj5ZgSOxOcHqpbXbMezvEkgSo/o5+/7bSyhtKJvWFwIdC2dEhsmhnH
         WigXa6kuEJWHXVjPuWhLxiTG9fwQopM9RbQ+Dj7A6qaRD2qT5rIz87ioaqir25Fk+vkh
         8CYn0R1eZQOddKVUW/QV2uBbiOj/JVl2vOEQriZOWO/qVoW6HOIqdgITlgvlCYxhucgu
         giHfeQfv1T2AjY8DCgAwEY+ewl+c7YlG6w9hXta9cl4FiMCHJ7l0c8y4sFHotoMeICuA
         mxKw==
X-Gm-Message-State: AOJu0YyzP7g+Tu4khCV5868gFeoAZ9Sq1bZoXBx9e8l9Yv2XzJM58Fns
	0//s87pwZ3ubKjPCC/U+FXEGFOmDLz6p6mdh1EBLD5oRJ+g4MlUO
X-Gm-Gg: ASbGncsq9kDHqiGxCvZVQHU++HHmly7HyqHZMQK03j9hrPHnRLaVCTDE24Ohdm6RuEz
	vCBAjrluFBdM7c1xOAhWsU00OOqlBKPBi06nbiWb7DwaC83nQHjX/qiqFGYsYFdMoLUyELEhNbL
	+BNvteqTrB1zbLiikt05ocwFCBuciFe/yvIMNSWJc8S+71YPGGzAy6AzGnR3Gx19udikinqIkly
	e99WfFy+zx3CPEUs8ooh2JqyzG4UtAvPYUZZFwgum2VD3tZZpaBUEvPWT5V9Fb9vFhaAV4AIfD9
	cWfAERh2VT4M
X-Google-Smtp-Source: AGHT+IHjVO2YcO1lMm3WQKO/pANMJVm8K7b6sxC3hG1wGqRw4v2S5uJdUOnL3mMjC9UjqV6dfEu+uA==
X-Received: by 2002:a05:6000:4011:b0:38a:4184:152a with SMTP id ffacd0b85a97d-38bf5669eb5mr17144073f8f.28.1737452984186;
        Tue, 21 Jan 2025 01:49:44 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32755cesm12798584f8f.78.2025.01.21.01.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 01:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 10:49:43 +0100
Message-Id: <D77NOHOZIN4B.E43G3MAUD8JH@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>, "P Praneesh"
 <quic_ppranees@quicinc.com>
Subject: Re: [PATCH 7/7] wifi: ath12k: add monitor interface support on
 QCN9274
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <20250107021017.3857555-8-quic_periyasa@quicinc.com>
 <D74BE3ES4HZC.GJJ2MY3UH462@gmail.com>
 <e713770a-2032-f007-f828-d24935b042e2@quicinc.com>
 <D74DNZH2FACA.1EWK96IOHSY6I@gmail.com>
 <8d81dd30-587c-89bd-56ec-2a86ec7accd7@quicinc.com>
In-Reply-To: <8d81dd30-587c-89bd-56ec-2a86ec7accd7@quicinc.com>

On Tue Jan 21, 2025 at 10:12 AM CET, Karthikeyan Periyasamy wrote:
> On 1/17/2025 6:50 PM, Nicolas Escande wrote:
[...]
>> I'm not too familiar with the driver but clearly this is the part that b=
reaks
>> sta info update when running a monitor while an ap is running.
>>=20
>> And as this is a valid interface combination it should work right ?
>>=20
>> So this change works around the problem I reported earlier, I just confi=
rmed it
>> on my setup. But maybe this is not the right fix indeed but hopefully it
>> points towards the culprit.
>>=20
>
> Addressed in the next version of the patch.

Yes thank you for that. Everything is working fine now.

