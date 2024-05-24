Return-Path: <linux-wireless+bounces-8052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BDB8CEC80
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1322819EA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 22:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510884A54;
	Fri, 24 May 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N8gWPnnw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65CA5F84F
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591312; cv=none; b=l+Sonjcy0dTEBf+0yIpja5UKUgSEpkFGMvfcT95k9mwg1VbQouQ5COTDh2zyDtVnZ/lcHBaeb33qs+FcC6NRsMAU2NcBnGNTaVKc6BXMBwjtSVsUSPSw2pPRFtK+hRgw9bJUKyIjRc/c+ui78+SkEgiN2KhV1YbIkv249VRayu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591312; c=relaxed/simple;
	bh=vFIQk8rk4nhAX1GMl30ET3KpsGu/hdAnGJjqSaqy4vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL8I+3L+PCBkvbqUKkejYFUm8YH5pdXQaq2Lrx2CKj6od0av31Ff2Io1UAsvE+nL8HvOOwdtEClCJCeNxx0/Qv5QNUUIcSWzaHqYyQHOZ1SsSGCCSWy6NBVSR8X1T3HTaiFvacNM1fmFkxBCxzkaltdOEBLfEnKXA15fLPN/4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N8gWPnnw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295d509178so1430091e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716591308; x=1717196108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFIQk8rk4nhAX1GMl30ET3KpsGu/hdAnGJjqSaqy4vI=;
        b=N8gWPnnwKwrp1nYOSPOygvMc60UP/ygxWE+ADcykYV/4C8/qWGfDb26PbK7NvNnI0C
         ekn44p2UzOLRK/DLIF5laPVSyKXvM3D3OjgbeIsq5VAx08tdhATDwSr0dhUf+AwQTyww
         hdfV84aiS1Z8FZQIy+mNGEuK+lM8WCGXD9w20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716591308; x=1717196108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFIQk8rk4nhAX1GMl30ET3KpsGu/hdAnGJjqSaqy4vI=;
        b=S6pwg1e7SmvYY9vVmzZrVIKJc100DxX/zROC2K5zYMt17sq9SiTXkQhRC3wiCQZ7Yw
         1LueW9HROVP0XG0eX9FXsujPpO9DeG1WVQ6XhaRDQolc863pN7ZKLzsZRcfvaejX7vFI
         spUsMm6edOMpxO0w44O+yGdx382Ekiwk5vjOWe3s8E+Gac5xB1v1nwJWz/Syu+nvLlPl
         mwtqZlOkIMNh/zRaKOwzShHxKzWcy/3+KyDbibZpqDDr+DLrBWToISZClwvnn+hMrKii
         aqmyHc9m8nlZ1ZW7ExuZyT+uL8f4gub3OJ1EBds2GZPE0pp8azLY1m8OEsX2+HOBg/Y+
         gwMA==
X-Gm-Message-State: AOJu0YyY87ZBEyXfMrj/dHIT3fDC4uiUAMOySSmiv3lI3v9eXRnmgxrp
	QnAT/reKMJglbujr5baNWDRzcBmKSNhzi6wzJqhjAg0B4r+zL8PNG3gAE9l/tIDWQSiZ82+x0yz
	nsA==
X-Google-Smtp-Source: AGHT+IEfMkb4a5UMjyG8EawCZvxe94YTubpP4wSbY+Hur+gI1141jEgHElzMwaU07NZFKnanWiAEPg==
X-Received: by 2002:ac2:4343:0:b0:518:9823:601a with SMTP id 2adb3069b0e04-52965f1093amr2930420e87.39.1716591306903;
        Fri, 24 May 2024 15:55:06 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4efb8sm186342066b.100.2024.05.24.15.55.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 15:55:06 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a626777f74eso161073866b.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 15:55:06 -0700 (PDT)
X-Received: by 2002:a17:906:35d8:b0:a5a:5c98:c595 with SMTP id
 a640c23a62f3a-a626511a554mr347429966b.61.1716591305542; Fri, 24 May 2024
 15:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com> <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 24 May 2024 15:54:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
Message-ID: <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:01=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> I think it needs time to support probe client. Can we put your suggested =
comments to the code
> used to hook probe_client() and add
>
> "TODO: support probe client" to mwifiex_cfg80211_probe_client().

Are you suggesting that you plan to actually implement proper
probe_client support? Did you already do what I suggested, and
understand why hostapd needs probe_client support? This seems to be a
common pattern -- that reviewers are asking for you to do your
research, and it takes several requests before you actually do it.

Now that I've tried to do that research for you ... it looks like
hostapd uses probe_client to augment TX MGMT acks, as a proxy for
station presence / inactivity. If a station is inactive and
non-responsive, we disconnect it eventually. So that looks to me like
probe_client support should actually be optional, if your driver
reports TX status? And in that case, I'd still recommend you try to
fix hostapd.

But if you're really planning to implement proper probe_client
support, then I suppose the TODO approach is also OK.

I'd also request that you please actually do your research when
reviewers ask questions. I'm frankly not sure why I'm spending my time
on the above research, when the onus should be on the submitter to
explain why they're doing what they're doing.

Brian

