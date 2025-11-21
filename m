Return-Path: <linux-wireless+bounces-29227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA78C77B95
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 38A1A2CC29
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE9335BC6;
	Fri, 21 Nov 2025 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkxbNQNr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9743339704
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710855; cv=none; b=SGOfrfiB9tRLaYeY7m/Pj6w9BipLWwjxDiPC7MIxbP5KYl3hgxURm+EzvXYmBN0szY7+et231AobYhOAOpYap6U/Q4fGLZB592RFK05TTh/mNDz44EhdkocTXFwVTB/9t7rClNjIeBtc82cZTb7uS8He++S4fZEKofAAarPtw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710855; c=relaxed/simple;
	bh=PjqUy3HIu621rOJsOKx5iJtgEMuqBXdd5fGqyctYvrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4VdDuQt1U19Q0oM24ehKsCYAAdnrMMWi8AmPNNoyOp/aL4Zs963ZhYoCIJSnoSPj93n1lADN7AI6aKhMFCQvie3x76g8w7Wsn63Au286hzEET8V/TNiRmbKg98cHBc6NkVEe0bMQqBxC/f4Kp+x4Zjmo/dbDys92XdPJaqL5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkxbNQNr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so2165719a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 23:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763710852; x=1764315652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjqUy3HIu621rOJsOKx5iJtgEMuqBXdd5fGqyctYvrA=;
        b=TkxbNQNrj5MX1CknmmnxhvHfJTOk33XVZpKI8GaTaB8NyS1XBCL/IdAAhxfvkDnB3Y
         XtegQ4ZG3UAQ9EHv510OTj0RhTSXTm2Que2/g/9PFuveZjzUSj2YWKPLct4DVBF9WZB/
         jjXgkVhS0elHpL1VH55UEE3g0KP5vh0vX4uAJV0+C9qNjziU0d1VA7S8jfQs8DyBNFrr
         cM3ISFqW4/3ueTd7PsuqdK3IhK0TklX5+j4aR+CKa2nX6riluXHrrN94zozHNKGrNwUO
         X6Jja/ubPyQ9QHXjrGkECadtJIWhnzyQwh8cBYR7zM0kK4ng8ujmYsalmotn/9Pd/sHC
         CKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763710852; x=1764315652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjqUy3HIu621rOJsOKx5iJtgEMuqBXdd5fGqyctYvrA=;
        b=g9wUGtxcAMRIGbm7zhORsHLxOHStku/xKBQ0G9kHsCIYygAIYcDcKesCqb/8VrCdCQ
         nWcQ0vxNSpFEbS2BLlA6HuIR/sOvWqJErmJ88NHO/yBS88JfE48+EDTwCLL9CX0PQY7U
         0Nt7RAMp7/UsKE97KSOS6QcvszIF7zhIqovgDU1yarMiKX+CaVPTkXc2EZFe5fW6iIlp
         qmferziObCsv1dcYT64mF+oiFyUH/8KDy3kea5XGUtdET4SNrVc87tlfBTXipBHX1iMv
         lUBL4kfn7bt9FY/elULeFPHyAO3tyLClXZi8qlnF/7KS1usO30ymQ6bB4T97dW/SdT2M
         bwbA==
X-Gm-Message-State: AOJu0Yx1JWdV8T/xqVbdOAPr2DGoEl2cqBtL4Yb6jKiE6ql0yHZ67NwC
	J+HtG/+algEF2mODoZr33XT240J0K4SaYttubT1HKaYWSkiprgAbpjfEzJ4r1kLi/tfz3H07PUj
	OvoG/KJYvK/vKr1kCqFnXsq4IwO+HU+8=
X-Gm-Gg: ASbGnctGUVrmH/dtNLpWvt3DWNVAaQJJg7zYOmZ43VAv7bevV3bFKnpddlBoL6+rtP7
	Unp88Dfjyd3FzAqIbTBOH9mQS786ln3DKaD4lxSsVPiT+8g6jFwpePCKNNWTKysNORoPVJEPQ9n
	YCHe4LRZPxz710BBU3LxicYVLKIpoDkWWJKvc6OqpXAWuOoOZ8E4E8NDGpeD6Em2Wj6jhBsZFF3
	I6Lm74iwKkBZRY7UmzVEfqSaMCXlvnsKm/V1fJA54lQ4zhf9wA+PIxqAKc6/Sfo4HB2EFGFU1B7
	MQcGfJE6Y6ucny803aXJBJGvFL8SCg==
X-Google-Smtp-Source: AGHT+IEFACD3LB+yy86RlgNU+OIL7NeggWLiKXaWlPrPCzllDSzTrAX1is7ovCBSQmCCQp/qygHdEOONMuS+FDnepf4=
X-Received: by 2002:a17:907:72ca:b0:b73:16fc:d469 with SMTP id
 a640c23a62f3a-b76719f90f6mr118046366b.51.1763710851876; Thu, 20 Nov 2025
 23:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-aheev-uninitialized-free-attr-wireless-v3-1-26e889d0e7ee@gmail.com>
 <DM3PPF63A6024A9184DD38E41273FC35C7DA3D6A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <5d56bba8cc4b48ad61042e9ab7063be856a6565d.camel@gmail.com>
In-Reply-To: <5d56bba8cc4b48ad61042e9ab7063be856a6565d.camel@gmail.com>
From: ally heev <allyheev@gmail.com>
Date: Fri, 21 Nov 2025 13:10:40 +0530
X-Gm-Features: AWmQ_blvb03goS9OMcLPpOIxRqn4aXsxA88eGKvazNZtgIG_FzuEzGmqJuiMmu8
Message-ID: <CAMB6jUFRsQSgN2wmJeMegyLtyY0+aqJBHfRCVSD6Cktu2Qtgeg@mail.gmail.com>
Subject: Re: [PATCH iwlwifi-next v3] wifi: iwlwifi: fix uninitialized pointers
 with free attribute
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 12:45=E2=80=AFPM ally heev <allyheev@gmail.com> wro=
te:
[...]
> Makes sense. I will wait a day or two before making any changes. I
> think the current consensus is on making the initialization and alloc
> go together?
>
> Regards,
> Ally

I think we reached consensus(I see no activity on the thread). I am
going ahead with `initialization and alloc
go together` in next version

Regards,
Ally

