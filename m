Return-Path: <linux-wireless+bounces-17996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D02FA1D138
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998037A21AF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8F1FBEB0;
	Mon, 27 Jan 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCEC+elz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57B1FBEAE
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737961671; cv=none; b=HnqmF5MumvyMGCb0CIuKAHTTg+mx4GOvhfXXNRx/ch3FzAPN3R1g3pa7EikWEJQ1U97CSoOFKYZ79Sj79YhUDO2YV6bn6Likw06CDLG/X34SgFOd3DAcPe/VNpeMfud6pzW2CvPDg0MVxNnSXyYzyg76i6h20xii1fcdzu1n2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737961671; c=relaxed/simple;
	bh=KD4kyqPouOmUkv3WddUXdqITfDkJwtj7Ck9nQWeDCZU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CqsfEzmWkeMuUUfV7kx3PFDYKrH6yKK1Pn81IXW36hG1bc8x2RvzzsfScAk53YJ//gkDcXy0iP+TR+5ItsDVHvMZ7IcfQScze7QTuWLdaZSwIG8wpuO0vJaHGKSoaPrGodwXIQwduKX3IY+BSYLkv3Zz90/2w6YyoDP0xAoGiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCEC+elz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43675b1155bso46705915e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 23:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737961668; x=1738566468; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD4kyqPouOmUkv3WddUXdqITfDkJwtj7Ck9nQWeDCZU=;
        b=XCEC+elzFQBjjSTd+2WqszamQcJGtfhkdmTvRSmEKsGZAslu/f4zx0wqwfq2zC9zD4
         9WL/va5uj7ltJrSGXtsOgPgiZZ3N00ha0DpbOB7h2X3Z+k/FwXUhMkSKtrlBHojW/ozC
         sfe+82vut+moA9ghs0rika8LHenuDIfG2h6ki8Vmk8b4hRdeUWfy5vIPOcLrLgwkeJYO
         TEmihMM9/cmLFUWvk6gtdsMFurE3Izhm20VfQVslRePn2ejLeXwLztiJXFPBtZMZJqn/
         UuEoEpFSwgULcNJxsnBgGcJ/4mhT0wD4e7Kt0Y1mBCv9SqyFKxpCTdyzI8hJAaOY0WN3
         Hu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737961668; x=1738566468;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KD4kyqPouOmUkv3WddUXdqITfDkJwtj7Ck9nQWeDCZU=;
        b=gshOTn6HgVOeIxOUOsgYzw+hIzK9abHfeznxswDzmnczhTL0IWFYmk4wnye12xx3RY
         Whpuygw1vsTI73HoH2Fe9fgPOjPjCj2K56LLZcKtk7JklHyjQXi+ZZQ1tIlKyFVkFP9k
         1sKeDG2nO3wj2MzumOm+3DP0yUreBd64Pl81gLp1d2DAUGI7GsIrbJGDSEijsZ45jTux
         lNgrP+KEV9XcYmkJbu85qjCajZTZJNcLX+U/SoJAG++qJm2re6G9zvnHiJBZMmSqh1w6
         dsu9RGw/ystVVpeGtM8yaDpXqN1vtfvJ7QexgM9HaoPBBC88H5sOWaYrqAfmJYhtFojj
         5jgw==
X-Gm-Message-State: AOJu0YwmcmFBYWdPdOull7u2miVbUH9Yhho9AIi6A/dCFd1AMWSOfU7m
	GDYPdKKf+ME2EocD1nfOD3lQRb3DQmhRyCh1jjgJV3aU2cbymwka
X-Gm-Gg: ASbGncsbvmXfM1DN99Vctn9BrYDYiHQdBwUkCPCX2cNZl+ChMxdxt8M8i8pGzkQ1+U5
	r+dYbkq/PasL3HqWcDPzTlDlzBSY1Lh7oK8dzPV1YUO3YpQHMtsdyC4Ve+OJVXAFNiJjPTbfjyx
	KstGMuEz2MVR59bKNiMWk5LmIP9KJ8aoS5waix/ywOHCChnK0YRv+OWvIIrdOBQSNUXDSSMu1zp
	n78uaPf07Ooxy94o1zF6FGSXQiEwg3dYp8QqisGXrjAtnxHFzTB28FXabXwyey+eFIZEuE1hk3p
	I2AS0zQ0Lwnxwm86QvKGMVr1tuHX/nR+qA==
X-Google-Smtp-Source: AGHT+IFOPnV6eg4/EI+Rko3jvtnrVjmrQCAEaaNUSykSMgz6DJj9K7/e2xe81AYlKsiiP23KpiIYHw==
X-Received: by 2002:a05:600c:4e93:b0:436:1b81:b65c with SMTP id 5b1f17b1804b1-438913df89fmr355619255e9.15.1737961667721;
        Sun, 26 Jan 2025 23:07:47 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm121287365e9.21.2025.01.26.23.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 23:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jan 2025 08:07:45 +0100
Message-Id: <D7CNZQS09N54.JU8UK370JWNZ@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fbx: fix
 ath12k_hal_tx_cmd_ext_desc_setup() info1 override
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Vasanthakumar
 Thiagarajan" <quic_vthiagar@quicinc.com>, "Karthikeyan Periyasamy"
 <quic_periyasa@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250124113352.93638-1-nico.escande@gmail.com>
 <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
 <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
 <18b47227-6b77-a029-2e80-04a0455ac091@quicinc.com>
 <D7BFM42HW2NL.2IZS207VTCTJN@gmail.com>
 <23d62bef-2393-4232-93ff-82ca4dbc4524@oss.qualcomm.com>
In-Reply-To: <23d62bef-2393-4232-93ff-82ca4dbc4524@oss.qualcomm.com>

On Sun Jan 26, 2025 at 7:16 PM CET, Jeff Johnson wrote:
> On 1/25/2025 12:21 PM, Nicolas Escande wrote:
>> So You guys prefer I remove the fixes tag then ?
>
> Yes, please don't add a Fixes: tag if no current upstream functionality i=
s
> broken. This may cause the 'stable' team to spend unnecessary time backpo=
rting
> the change for no reason.
>
> /jeff

Sure, no problem, I'll send an updated v2.

