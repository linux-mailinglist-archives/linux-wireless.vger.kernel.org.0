Return-Path: <linux-wireless+bounces-6907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C98B2E32
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 03:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172FE1F22001
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC94430;
	Fri, 26 Apr 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndWFZIg0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC71C20
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093237; cv=none; b=JxGc7aL1H5dKqFlk/UDNqcXzcd81zvT+r+dmUG5FfzXOCGSGs+6HV7cxOHuhSg4Z7ndvfsR0BLhhmAIL5tmCDpx+whbgVRYKRvAd66d+IgTSOX1FDsYRJdha6jgJfyDtzZ1JZQNf3IFRMbmxxg9NR8nOIRJJNRBpsuve8zUO3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093237; c=relaxed/simple;
	bh=vaP98bHNI2EL8ADkLGZasqcIildzOGhlAde5WfgxUbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmvsoWsORtenXgm3LtRZvK+iq2H/Od/Mp2kSpkj26xEPztMGw4mvWT6cXc/ZhLzQetRdJ1UqvFcIIwibavw5c6EYcsNPZvVVvjoRM73KpgZFk8gxX1j7dhBEFxBodBCvQ0oCCDKc5z7CMS/pUcYrGZR+ZY9bhwJM8QPDqYYcVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ndWFZIg0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso19918611fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714093233; x=1714698033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS4hEfkYyZcUp2/3yo7BEAns+xnreNTWUG8ipJK8F2M=;
        b=ndWFZIg0W1DyLh67nMj7hBS0CE3v/3r71CDfmcGTS/etzDzNXbYR6/62B5lC7/2fPH
         Cf9XmrTydCTmMI7ro4K9pOWOaSu+qIG/h/A84HH1sRBvKhmPfX5Vakh2BOtfGhwG/4Z/
         N2KunNNku5EW8XT7X6WO/3NNF2kEWfcPCVP9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714093233; x=1714698033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS4hEfkYyZcUp2/3yo7BEAns+xnreNTWUG8ipJK8F2M=;
        b=Ku8svR0sFA58ssiC0DO9SHSTM6MnYZjqzRrgzjy5G0nVcSflXMd813wNmIzrpfcInt
         01y0O5dzI5hoPxbDdZzKJ2BxtAVmfkHVZ74pIq0VFi+lrwdTFMM14DiD6cMuRpJg+hAz
         MqHsp40A1jT4F9nAwCt4mGDzcRiiIXnJ99JPGCG6ifeJsqkUC/OSk8nY5HMDMNxz7Pcf
         WafHnw73udW+6ZAvH5S58vDPtCZLKGcrHwN0+BrV19eigrw+WecPjUH5HktjUBltQ21t
         wq7Ypz++KuzC8Zadf4oFXfJxDTtJ9c6utubZxkAp91n/JiE6ytKpjoYpY7cbzL7rpmO5
         LiAw==
X-Forwarded-Encrypted: i=1; AJvYcCUMDq1AT6g70qhZxNaXf+85Y6iXjYTDTxPw7NaMeEPe6dQ13QjLCIPz2rQdnms+tNgLszuIUoePtG4UXPkDkHiUL/CCPP7KDnMYZ4+SCCQ=
X-Gm-Message-State: AOJu0YwPHl08qhh5BYDC3wOatg6CpPf0FwrFLKPMufTqQrH0VTjlP9yd
	7QqRJBa7CKmI5z8HQh7gn5W2HjXnNKM+/bB+KipViIEiIdoXsuRx2j6FL7CuVwjfYUehH3YBMgk
	=
X-Google-Smtp-Source: AGHT+IGCb3kV4Amqg1wmCXCWIyPKsrBiUyy6CwHT0cIXwJdayWGjWdM+Tl8ZVxmkrdfdK+JharS86w==
X-Received: by 2002:a2e:9e07:0:b0:2de:4cb4:2601 with SMTP id e7-20020a2e9e07000000b002de4cb42601mr515494ljk.43.1714093233096;
        Thu, 25 Apr 2024 18:00:33 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id n2-20020a056402434200b00571fcfee3d1sm6096750edc.9.2024.04.25.18.00.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 18:00:32 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a55ab922260so220798466b.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6l72kul9OcgwCXnuQTdiJ725Jgw6keAGrO5HM6Z0IiArCVAEwUZUwEyKRWV48YyK3TiIjNjjcIpOH6IS+Mj33ojxNQzZX8DUzEiCs8mo=
X-Received: by 2002:a17:906:2a44:b0:a58:c237:bb77 with SMTP id
 k4-20020a1709062a4400b00a58c237bb77mr756232eje.54.1714093231535; Thu, 25 Apr
 2024 18:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org> <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com> <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 25 Apr 2024 18:00:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXODhWc2vhvScov=_vWyocbdks6HeMwKqRGacDogjX2=HA@mail.gmail.com>
Message-ID: <CA+ASDXODhWc2vhvScov=_vWyocbdks6HeMwKqRGacDogjX2=HA@mail.gmail.com>
Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host mlme
To: David Lin <yu-hao.lin@nxp.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, 
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>, "rafael.beims" <rafael.beims@toradex.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Apr 22, 2024 at 7:29=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
>         I wonder can patch v10 be accepted by you?

I took another step back to see what Marcel had to say about
external_auth, as I was not familiar with it, and it didn't come up in
discussion with Johannes earlier. If we have agreement external_auth
is inappropriate, then I'll revisit v10. That may take some time
though, as I'll be preoccupied next week.

Brian

