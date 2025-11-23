Return-Path: <linux-wireless+bounces-29267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427AC7E830
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 23:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0BCE4E046F
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306F25782D;
	Sun, 23 Nov 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a77dhATn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841501B4F2C
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763937895; cv=none; b=Xmqt2Tz/l73ylTixKYweDdTHLpdlsNTG8SJYQbgj/drSzJj3918h0CRI9xkjuLt8W6CoeLnS/ViyOluzvLnbxH4AfGOx+HP8UfflOlikLx3r0a+Q7F6tvI8RMCCBKnTA9369jR1jOcKro6ldr9KohAOM9baHAK/8KLAVm5dn9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763937895; c=relaxed/simple;
	bh=+TDbtIkIFEEONvTehrmAhkI6gQakZJSj185rwv07CnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aXcMFJ6bouYEg9v1yB3UR3I1z3hqAlRoQrm6tNm2PRSJ6Uv6hW3LUmzR402BCgnnx9Bg22OXiHiaRjFWCapdSwq4xrsKeB8r9LqbN9YaanIKxAIPWHH3agbskh6MqFot69li15mtkE1NG3C/yGsAZgzV0RlhF1aUIIAbPnlRucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a77dhATn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso6349251a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 14:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763937892; x=1764542692; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TDbtIkIFEEONvTehrmAhkI6gQakZJSj185rwv07CnY=;
        b=a77dhATnnnSZOVg1wkVGhHS+H1ZqYPbIrU8vj9N1g7yvkyNcZ9b7g/vEkCIpV8SjHe
         erHi+2csBH7lz3ZLU/paxDdV0+ZRIaPG2A7/ujnIseUoLkPm6C1ZVd0RJ0+vjvsaxs7M
         wk/o/5l9nuuruPqnPbysd2AqvZQX0FR+wBBsXBvqfsaBLCUZXw2K+tM2/diLcup6di0d
         OZIgO6zCH1xwOHeq/dV84y8D+406BtrU1nUVRYm8XqA7Z/+qRF4UmehFhx7F6wo3HaDj
         jtA1rNZ0hRE1yfQvAXfr3XHu7CpZUQG5SlJQZpmJYYJuMKGxdR9ixWBtA/ihDBcfpGlK
         ZBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763937892; x=1764542692;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TDbtIkIFEEONvTehrmAhkI6gQakZJSj185rwv07CnY=;
        b=jCD5EPRVyPfVKTBWquZWNgW/sphzavEs7wgJrIDZKvSWowEpnv8by+XqkGSmAIiBC1
         YhKmmu75aP2ZitKEgPR/1QZ3LuKVPPCpJnvC+cfSAyUWlso/tSI1HMxjepi2nKezpzIK
         Wk6yaiSq5xMkRJngcn1tN/GsOHglNg0JpQgTrKzdgyoj/4EeLbglg/sr2h4l5ojVk2W7
         oBfpxS1BoLZbcldT+KGxd4MsFk2FWMtf9f24pFHt1pMoqCbn1Vjj187qLFXR9IFtI9RZ
         c+M97WAROeZ+iWp7MD3hfPEapQ4ix9Dl1a0aMbcMCfSuO021mXH2QCWcDwp35igyjTh7
         vK6A==
X-Forwarded-Encrypted: i=1; AJvYcCWSFGUH1f8JGK1ADbAWBlsqqWTCwcCFGQNcgBGHxcQ4V5vvkIY3Bz/f5RhFDjkfAR5EAijvkssWFLFnbr+x5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNwbbdZbygkCUNLXgz0ahEMuA1NOz7+0exRaqi7U5sHD8MxOd
	uAO43ccXQXtIH29cupJLr5ai/Yhi5qAIjxnrzcQJ8mWvN2Hfz3LgTTP6SGk+hLPKQFgK2n+1ZKo
	CdGWoFXBKQl9e/hNAIDiddsSAvS++YyzWdZ3tUbo=
X-Gm-Gg: ASbGncv+c0UjtiO2elmI7VEcxvFcNkXVj5MN47goXAkHaH0Ev1bLXf4xGKWEy8xo8R9
	kXoIHCeUTJjWn3voKnWsejArWzVN1kpfsK8GtR4sYmPCTM6tRekOTt8IxIrg/Xff8HlDQLbWoet
	V0r9jfIEH1OpGLSBxTcDNMNDw2GPPLTPzRSdJ9gbmL6zuJqCOy97njvzHX/Wy9rGQoBml2sqX96
	LELRh/pXkZzOHd6PuqXgOM9q0pEkzqC0hGLu71Px6z5Hlw1Wu8I9kF+m6jQDeuWuuKy5dzQJKHP
	tQ/0k3Q=
X-Google-Smtp-Source: AGHT+IE5s9btl8KFE8c+4keBiMFcig0gza3XlXpRVblfyh0XHjakH8+GQ602BP6yJZz0KAhISv7ng5mutmZda6/w1Ts=
X-Received: by 2002:a17:907:1c04:b0:b71:8448:a8dd with SMTP id
 a640c23a62f3a-b7671703d89mr1045888566b.31.1763937891690; Sun, 23 Nov 2025
 14:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com> <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
 <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com> <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
 <CAPDiVH_-=DzPjyjDo34-0HG20feiGfrM4eOpkPt6bavrw2qWaA@mail.gmail.com>
In-Reply-To: <CAPDiVH_-=DzPjyjDo34-0HG20feiGfrM4eOpkPt6bavrw2qWaA@mail.gmail.com>
From: Matt Mower <mowerm@gmail.com>
Date: Sun, 23 Nov 2025 14:44:40 -0800
X-Gm-Features: AWmQ_bmVktkGYS0kZqT-zWoG9xcEYYl6ViCTjWaL2T9RdixreA7prDngkp_xLVY
Message-ID: <CAPDiVH-S404i1O7J4EUTohx27Mbo4EaKeHK6tgXs2+1_HxmVtQ@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: 1107521-done@bugs.debian.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Closing Debian bug report 1107521. I no longer experience these
crashes or loss of network connectivity with the following package
versions in Debian 13:
- firmware-atheros 20250808-1
- linux-image-6.12.48+deb13-amd64 6.12.48-1
- linux-image-6.12.57+deb13-amd64 6.12.57-1

