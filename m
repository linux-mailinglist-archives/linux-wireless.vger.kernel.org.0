Return-Path: <linux-wireless+bounces-11724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5B959590
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E46E2814CA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887B15FA92;
	Wed, 21 Aug 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp2vlwaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3581A2863
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224656; cv=none; b=K52ZcGZ1EzW3UL/CtlvADhhRdv+5uU2+DSqpvaomlRac3PN7ibTtbc8Ma1XmrsGm19H13gP5ICmunIredaUYxaDpwVg266cUKvO3g+EWkGt0etPg9SMGyES8PFlG3NS7rA4Se9OwfavPrWQwZ58uAL95qJQRofTUxxXo9HaWaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224656; c=relaxed/simple;
	bh=5IDNDBSvkcgPY48RnyyMMvs7hXOgVETS9ffNXnTIUTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I91SZ42+RAhc4+9+AR0gj6VRg7aiJFDNUVVSiasa2xHdS4DUFYr7LxJQ1ik4c+QCKb8BE04VpHGw6Ej8OyB7oenBCNR35OCAuAcBdJj2FxDMmejRFMRZ1GyIeZj0U9jgfS2BSonP0yq5bCHlTKgjWjQISJZqKGQyg82r+XkgFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp2vlwaj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-842fc587553so1738115241.1
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724224653; x=1724829453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IDNDBSvkcgPY48RnyyMMvs7hXOgVETS9ffNXnTIUTI=;
        b=Xp2vlwajv2i+WC7s0Jr1KMfhRXdQNjzNeZpcfaahQC4RHx084A0eT4eC+zxfehfJo+
         uZMmov+dJ0m9j01T7mfS/6ysdbnKBGlp0FCeT1WqLOWmCiv+7zTjtI32FJL5gBJ1PqGl
         AOh1VUG0VyCbd9/c+BfaQk+aHp6FtEnLPL5cyfUqnrzWc8Qud7w9JNE9v2c3GTmYW2cO
         L2Gf6MMnzIK0zvc2ntdMX3o/MfSBbnMHv5H1azWyLu+VK1aH9rmHxich6pCaLp32AGkW
         HgQCUGKv+yhSphi1FZD5ndDnEqUfqRl2Ukl0hoDVpb4ciCYUAXF0AtjAmUHN03QHVQQs
         ci4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224653; x=1724829453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IDNDBSvkcgPY48RnyyMMvs7hXOgVETS9ffNXnTIUTI=;
        b=gxwY3/4hyqDpamEAtcaoDXd8G0PuKM4N/VibXIYd7xEvTzQPziG8mKT1484WbLAWmo
         DpDr5jm1XVuZaaGR0dpC33E7IK3xCFQQkyOx4JA7bm5S60PzDmNb2uMWhamL51L9wI2t
         nU0M3qgJGi7NXFaEM5V8fARfndxTz8HWsN5y7hQDI1pGEO4arPnST8YB5RuTvyfrkcBR
         n29qyR0zD2g9Vhqb87FjS1a4tTdqDhf18DLnDWMmdb6Gy34wxr8Ww9yI6azY8E6duNly
         c4yQg4PnlgoLc/Mi6ejvsXaYgCrtbiuRDH/vBV8sQt0NdjmXEWmTdD/Uu7BXo06tK1ZH
         9l8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz/3isLmd1VTv+iHmgh0Lk56VnnMVV3HTD5p7UOjbgdp9OoyvSD7+KBlW2jIGIjx0Z2CL114mUK24xl2DQJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWrol5ettufVv6Xv/fySaqLMd1xY5kLVhXzBHajzFBKNeDbSF
	M8wVXUdluQIVmcqmiYJdPKuDnpq/m4Hdpe6wpx3WNK/J1muQrQplKH71vvX7Rk0S3TF4b9lN5uU
	FiA/ImTwHzfY+qvFGVPOj6dOZFIw=
X-Google-Smtp-Source: AGHT+IH5ubUcARe6qd+wSXwLbXUIMwSD2DrZLiNqjA5ELQoRjeZUK/Pm09Nub3SV40T2lW/Yme3d7JpCY5Hy6swT+uc=
X-Received: by 2002:a05:6122:368b:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-4fcf1ca9ba5mr1895694e0c.9.1724224653500; Wed, 21 Aug 2024
 00:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com> <b6fccaa0143a414a8513bc7c9276038b@realtek.com>
In-Reply-To: <b6fccaa0143a414a8513bc7c9276038b@realtek.com>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Wed, 21 Aug 2024 09:17:21 +0200
Message-ID: <CAP8xZ6n8utvFJCmTwnRzFccRkZZzk+R5Bf69UArbbzd4Ev9aRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting beacons
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sascha Hauer <sha@pengutronix.de>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"

> A SDIO user has confirmed this change can make SDIO devices send out beacon,
> but still have other problems though.
>

I am the other user. :-)
This is also a test message, sorry for spamming.

