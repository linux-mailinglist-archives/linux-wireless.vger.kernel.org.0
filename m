Return-Path: <linux-wireless+bounces-25004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA616AFDBFB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 01:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26334E61B8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1626237713;
	Tue,  8 Jul 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHzA3Flh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7518E3F;
	Tue,  8 Jul 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018852; cv=none; b=usKhsIY0quSSpCR97v+qXtCbea1I6rwE50Bvy4cBsWvpSLxju6arSpl/nGHzT6frPmkFgeVgPBzYuw+rIShpLt9Fnw8kCkKHKn+UO09FYvAFe4NSo4SHlhQssVHuZ2dJdi9i6+4U4SmKY3yibG7IyCzgVmJ8YrFofaFwhNJ6Lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018852; c=relaxed/simple;
	bh=0nMJ7C41R4YrKo0xC2/UiGGAaKAYM8CZRyHurLTLpw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/sCaKKoyjg2k+j+S0Gq3ihsuAadA8W3FwLUn817oBGWkzZvWBS+UBOT7We2tnVnSUmEe6MfnJTN2Bd9lxsFj98dVc4+feQPp8LZV6l9g5gaXeCx21hfFd8b8PvY1BlEdFl3qoX1dpCTEdKFdq7JnaRRx2EHcu+UD1R3sATfqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHzA3Flh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-712be7e034cso43931927b3.0;
        Tue, 08 Jul 2025 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752018850; x=1752623650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIpnI+/KkKYMz9Wfww8vVb4elUGSQP7L8IBvr/OnuBk=;
        b=iHzA3FlhmQ7njDGu0fb1TBx9yfWtGIZ6eCcAK/9INcXoXcPNDxr7I7OPaiLr1pobjf
         1DEu0wyj0dQL6UK/ca9XEtd1d1MLOpwBpzEbq2DlbT5A7IZCZnvFy5eYTdmLMmptrNbM
         ZXAYZdKC+vTBD4d2WXOO3DQ9gAKvqjoTv3tmtLPYGuk/FIhTOqYS1Z5xZm8K0v3mzrtr
         uK1aH1qYtzb4tODUt/aMQNMfqL1c537DOhJ4WcPNig+z+cpjhIwbNKoG48rH+QgFqpN7
         pcVPIOPeHpbrW5FtuKnfQeKaXoqV6r7N2smJSCG7ARkSm7S6zBY3caFp8CRCl4B47dkH
         XvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752018850; x=1752623650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIpnI+/KkKYMz9Wfww8vVb4elUGSQP7L8IBvr/OnuBk=;
        b=aIP+2Gem3xd0c9c7rHAUBSXnd0DXt86sgGlYZWeohub3L8McmXGCgZiJMwsQg0r//c
         iSIrIgjg/8R/qmFLpn/84u/0H3uCsDiemVb+P9BUIKD/IL2ON/8zYC373cPiXJAkKuxB
         RKCSnmYYxufIKPfXOBOPU2MxJK3wqjlSb4aYVoDcU+gq81IhMVBZQXNhTsq7jRrjxcG9
         3Wu8tuHCnhtQ7UKrasisPCELodGCF4h1Eb9qj3q/3Cv4CNbFDvEPMtoR95GBSzawkXtB
         lcxj5JdY/8+XIFSasdSZIkgyS1/E4VylTD/jeNreykifX96XjOKshi4m0KH+N8bXl0QA
         T7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUOvAaUbwpP7hOEWOAj4ZsM4ruN2+AFJG6rp6+fz4kWKDk2U6MyGuFUaXEyEFlq0G7jqJaTSs0eEqarCSB5gzw=@vger.kernel.org, AJvYcCVGaMwVxV0YPK9sKO5OHZlyC5m8I9vEg8ien7VqZYbkjv+dHee+5j9aj6QY541yOynM/B/cV+TZI6BjPw==@vger.kernel.org, AJvYcCViBIr1clX5w96w97Kl7f3T85GFpqFi/seRIxGKmzjWeblAoqitP5cd8/CNaEMHXFYdfiRK58ZtqJ/P2zYK@vger.kernel.org, AJvYcCWZnu6NaAYuf5jqNSiO/ZTmHs3pGY3sAeIT4FOX8tebY84Vnzx0J8H+W/WuJa/TOTPtKm5K0XXKzTtM@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXSznygmsWuJY5nL72lca/jjz3w8dRVbp94JJiah7Aqo/8K8P
	XobNSA7msH07V05EQ7jKwHnFhZdwejk6Ftja4krIVB6LzeeiWM6WOILrQLhzkZyvLFkt3ENugWu
	Y9EEcCKOEvDHu5w2amu0YE7R+CnNUdYlT5f4pPNTlnA==
X-Gm-Gg: ASbGncsGO3LvQlLaqg+wsvoqNH6AGgEfHGa3A+nQTTSHCpWtZIhFj8EI26IBnDigyR/
	fXtIBbkXnJQGz7mK6XT/TijggYz4/7bG90Z939QxnmE1qEqTM5cz/KKcATbQAKbAFOO/w82XNbD
	4YolOufwTpsTEoimK+6UAjFuEA/EgDuj49YsJLe5wpYNNYt622ZLw5rncEDqtUPE8ACuw=
X-Google-Smtp-Source: AGHT+IHHnkecJrTiDBVoCM7eM4g32Pk1c3raG4mqxUk9pSpJNW1vy947mDXE0F5WHjldRJe6WxHFFxEogzvUMtezeI0=
X-Received: by 2002:a05:690c:9c0e:b0:70e:2ba2:659d with SMTP id
 00721157ae682-717b19634eamr9861137b3.23.1752018850202; Tue, 08 Jul 2025
 16:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708201745.5900-1-rosenp@gmail.com> <20250708201745.5900-8-rosenp@gmail.com>
 <175201013411.1121693.17824456704959772294.robh@kernel.org>
In-Reply-To: <175201013411.1121693.17824456704959772294.robh@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 8 Jul 2025 16:53:59 -0700
X-Gm-Features: Ac12FXyerQ4XgpTDcxgbBtlk_P_w9tWTj-9IUlprsdtZUPLTaj8qf2lgKgQNTww
Message-ID: <CAKxU2N_oUgqdOymr6RRSe3KYQpXrUUFm0SvOYFogx7NOVMv5LA@mail.gmail.com>
Subject: Re: [PATCHv2 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>, linux-mips@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:28=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Tue, 08 Jul 2025 13:17:45 -0700, Rosen Penev wrote:
> > Add device-tree bindings for the RT2800 SOC wifi device found in older
> > Ralink/Mediatek devices.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/ralink,rt2800.yaml  | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/rali=
nk,rt2800.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/wireless/ralink,rt2800.example.dtb:=
 /example-0/wifi@110180000: failed to match any schema with compatible: ['r=
alink,rt2880-wifi']
ralink,rt2880-wifi vs ralink,rt2800-wifi

lovely...
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202507=
08201745.5900-8-rosenp@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

