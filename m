Return-Path: <linux-wireless+bounces-9872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25C6924738
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 20:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47911C22E3F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AD91C2310;
	Tue,  2 Jul 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ry5Q7izp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD171BB692
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944528; cv=none; b=ekTGWub4L6dsHLE73SE3EdQKhukmmos/P+tD3XBycg1djjM9g/l3V+seLG58vUq2A0NVP0qP825sks+qgR4ZZQ6xCz94rjjs2SvOn7d7GYNC88vIoU50kN0NivK6kQbaOYYNesl7kKlcCKXK/jh0doVtCrRJY2erEJRCBOoN/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944528; c=relaxed/simple;
	bh=E2J2QkQQsRJmh3/tlADcUy8VsBpOGKquPnoZlertLNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+zkrieIP4PUWdY6MYtuG/3uFhqNIAfRoFpIp7MFF8phROIfSy/dCOJ/PS+TWDJCmvjTUCPZo3QquKHXuuU/yGmDjzJ3GCpUKzsILxC65C7kcZqDN0zqqTtyQ1xymTToPSeKgL9p6EbUEUhkOEBnjH59vO4BVSmrrdx2f768O0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ry5Q7izp; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so45610951fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719944524; x=1720549324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2J2QkQQsRJmh3/tlADcUy8VsBpOGKquPnoZlertLNM=;
        b=Ry5Q7izpTH4+NNPS2oYUY4w7pO+teqnbGK5a64T532AOhNFA4rXBOEQM5O/yOjnmBa
         usoic2JpCor1kAVXSZWOlL90o5nQBXsVN8xpBGD/vDMUIo7O1n+2bE1CvymIKHcqBP9S
         nHbWj5aaZVflMKobHhEbijt6BEPFJR8ja7FCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719944524; x=1720549324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2J2QkQQsRJmh3/tlADcUy8VsBpOGKquPnoZlertLNM=;
        b=JW21Z8vhhbvBltkBSEsyJgvVeiGlP5PaykffFuyYoqb9riJMuFM+SmIMcj1aiCcJBD
         bSpph0SsDiqAQ4yw3f5pejm2C1i88uvi6//H71JY+iDTmsNP9XtTsUZoPy/3rLoE7Sd3
         Vzs294vnP9snKXWo9z/+6E8Kg/vCCTLdGGQkc1xMNeNfqBmif2ZIeWw97dY7rWWHRkoN
         LFkyXr2FrENOzNgFdmFbzSojhOTcvbXwEFYPJT6z+35GcbrrC5UwajJ+GJGjHzh1iYMw
         +4e6oHL5yz3teiFjAO8qVYz1mdH0tfniMoHIpwVD2xj/N1aycPkYP8hrt98bx4oz+Ni2
         LZ9Q==
X-Gm-Message-State: AOJu0Yw9Imk3nelX+wlP9qkN7R2ajVGSjpdCasT1ueuwjZrnm2dBhzly
	3lKIfFvx90rUSUfogwvR0D4o187jmyHvCQ2sdmUWXk5fIEXKxVU205Wr5w4dap9d3wxLZ5udcUM
	85yDR
X-Google-Smtp-Source: AGHT+IEIznzX9SXTqaNYSfCZr4Q0rhT0TcC7N3qbT+Yjussvfs3pHVYjTZUFYQ1DThdC6w3oAD2A3Q==
X-Received: by 2002:a2e:9617:0:b0:2ec:50cc:6c20 with SMTP id 38308e7fff4ca-2ee5e37036emr60359621fa.21.1719944523424;
        Tue, 02 Jul 2024 11:22:03 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee51680278sm17258651fa.75.2024.07.02.11.22.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:22:02 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd87277d8so4755661e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 11:22:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3056:b0:52c:dea8:7ca0 with SMTP id
 2adb3069b0e04-52e8270faf7mr5904357e87.55.1719944521845; Tue, 02 Jul 2024
 11:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZnRsfiau_JSWBXTZ@google.com> <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638F352F7026C4DFBD8C562D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXPjT1DywGG_7vVVKfRM-JCO8pBq0jm=yRGvYci2omnkNA@mail.gmail.com> <PA4PR04MB9638B0940ED592CB80A883BFD1DC2@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638B0940ED592CB80A883BFD1DC2@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Tue, 2 Jul 2024 11:21:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPg86bzZDVeXRz+021RpbhzDm0zg6_Uqpoo4AJybvMbTg@mail.gmail.com>
Message-ID: <CA+ASDXPg86bzZDVeXRz+021RpbhzDm0zg6_Uqpoo4AJybvMbTg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:23=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrote=
:
> I want to confirm with you:
> For patch v11:
>
> [1/2]: Carry your "Acked-by" tag with following comment put to the code
> used to hook probe_client().
>
> "hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise, it
> requires monitor-mode support (which mwifiex doesn't support). Provide
> fake probe_client support to work around this."

Sure. I never actually acked this patch, but you can have my preemptive:

Acked-by: Brian Norris <briannorris@chromium.org>

> [2/2]: Carry your "Acked-by" tag with the modification of mwifiex_mgmt_st=
ypes.

Yes.

Brian

