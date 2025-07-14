Return-Path: <linux-wireless+bounces-25406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7FB0480A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 21:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED20A1A60F91
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C623229B0D;
	Mon, 14 Jul 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ1fX7Ck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09612BF24;
	Mon, 14 Jul 2025 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522289; cv=none; b=W0Wr7cUsuMInerj2tQGjJ2p3+1lzh79ctbjbZyabcL7yQWDW+4xU0D2qdhlAtzdBpsLDu4F3LuNrC10iOweUMNAQN2LOzrixsx6lsTFV97ccQdR004VjiJxzuWDaylEyfUIIPZsFTN2vHEWGq2Y0zhBLAgT28MKriVStpWjOzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522289; c=relaxed/simple;
	bh=oK+GzCnTtE/GVZkDozk8xGm58FvGdJaCuIeAS7oANOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6a46gEUNtoLFhpsnKvYuP/m9bJuWt4NfV7v2wRmJIh5nDAsIhaqThsq0zZS+JweXWNybxSeX8OPq9kaZ2gfyvRv7kcj3Ahf1LY4il5tJyUNf8gEwsjUjl8tB2PfMwARErxlunjWS4IspocboWudi0RX9nvzwnRXiiGp5gofUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ1fX7Ck; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8ba9f36550so991015276.0;
        Mon, 14 Jul 2025 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752522286; x=1753127086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=titEX2y3+9/xscj56vYw1l9vJIIgnO8oj3qH72QFLTw=;
        b=OZ1fX7Ckx6sEIONsuQiEOUETwerwoSv9i3bBqejfKNr2V37xZHo+rHdDEhci9gOePG
         lQEcaGbgWX3Wr8nBbCsk7V2yJg4nTgoEKFzOO60LHfkSCm+GnXyNxHfH8b8eLycOFoe0
         25n8QgpV5Vd2O9yNxIhFRIbqh7ax8CNKex+JyeOwIJPxKsIqN5DXCu7T0a0k6UwT21DD
         BNgMT59/+azOhUKtLyMRv/6hNkWQ0UEvj/63kzkIiFVIisQCbn1LsdXWAbIZNZnBhCCj
         Jqunu8kKHBI/y9HQt8RlDJUqsNgJHLXBzq14aTKRJIWUYYTOyjbvbqQAtaV5mixNHdVP
         B2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522286; x=1753127086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=titEX2y3+9/xscj56vYw1l9vJIIgnO8oj3qH72QFLTw=;
        b=VIEd9SwOgglRLIA1nL5k/m0m/ka8B4/Llwzh9DZZnMzAJvWUJOm1pyQRibwkADyOU3
         nUV8fZmC0ZkdWr0oo/VvXiYyA+CP5E10w89pTGryEMMddTkOlT+ktF21vBvB2fqXV8QK
         SfPXodG2EFR558XRHFJOi3THoq6mmntyddlxmsZfD584l32Us0H2vth3YxQuaijC+gj9
         NTvT57tz0le5G0y2pVXE+nUqONavKtQNvYngBH+eGtbuDGyYsn8ow1Zm6OES6s1NScM8
         8FL4qy53F3KXTCBkcDhOXWKIZgwH2HoaUUPkfsZuw55OMcMzeZ0B77FDwmb9iJ+QZdYU
         quDA==
X-Forwarded-Encrypted: i=1; AJvYcCUQTmgHNdibhTFb5bKvAhdxf5HuqeAOKjn13XOJ02+sosMDwnczpeTcva514fvK3GtZLV308+HhVtekLw==@vger.kernel.org, AJvYcCUZIpmUv+YW1QxeV8YEZ5CC9WN7H+Xev+z7ZpzfpUCw7CS7Ml4S8PDLomNKRhb1LS6og/Q6vNrXH92u3pTk@vger.kernel.org, AJvYcCXgYZGgBwqU/4EWa+Wx/PDSmal0JjfdkizoS7UsT2Wea9eg88gZihIHtDXytVednJ8oCsJ7goYZUX7d@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfh/bR0cDOgWx9oXWaCpLFjNy8RLHk0R9gQG9BOrDEjT0fOg2
	0DtDdX0id3sbG5bATuloXgjlNHpSdRJ6flQID8hjyR6ejEXIqOl3mwgIvbRxCKfJAjNAHbFOcBY
	rIjExDr2p4TBp1WaRxeMzjOggxS/RHDk=
X-Gm-Gg: ASbGncvpyNCzUF8dXKX0UVS3S8So+K3y5L/pnVglryYvfCe1zpnk++Hjc5iyE0FYzat
	rq0yNVJ1iIJBHA2L4nQDch6cYdR6ciCkiEyQwItBfCSEY1gFjPMRLTVHBHNSrR5TagwYgpPFIld
	osJyVIoyvEyvF2exmlxZdezyxC5F+XiGy0CkoCSR0Yptz2P8ujEevkUvg7QURumFGOZj8wvOwts
	37Qc0v3aKTM7WcOyxlL
X-Google-Smtp-Source: AGHT+IHDaQy35GA+Qses/SKs7Ih1reu0z/6Xmv8VCPpNc9I9mI3lGzILxxovXV+PULcNjOZ/ySpa/++hRe2/LR3lxNI=
X-Received: by 2002:a05:690c:60c4:b0:70e:404f:6714 with SMTP id
 00721157ae682-71822cea95bmr12446627b3.19.1752522286247; Mon, 14 Jul 2025
 12:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712210448.429318-1-rosenp@gmail.com> <20250712210448.429318-8-rosenp@gmail.com>
 <20250714-subtle-origami-gopher-c9099f@krzk-bin>
In-Reply-To: <20250714-subtle-origami-gopher-c9099f@krzk-bin>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 14 Jul 2025 12:44:35 -0700
X-Gm-Features: Ac12FXxoR7CKJ2q8b56sbgmGdKBzHJHT0GepGHfBUGsgSAe8RihtGnci6IAEay4
Message-ID: <CAKxU2N8au-uncWoP+vGH4cHhHMOtq+VRFGNDs6rRLuHn-i1G-Q@mail.gmail.com>
Subject: Re: [PATCHv4 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:27=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Sat, Jul 12, 2025 at 02:04:48PM -0700, Rosen Penev wrote:
> > Add device-tree bindings for the RT2800 SOC wifi device found in older
> > Ralink/Mediatek devices.
>
> Your subject was cut. Probably you wanted something like add "Realtek foo=
 adapter" etc.
Not sure I follow.
>
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/ralink,rt2880.yaml  | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/rali=
nk,rt2880.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt28=
80.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
> > new file mode 100644
> > index 000000000000..a92aedf6ba01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/wireless/ralink,rt2880.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ralink RT2880 wireless device
> > +
> > +maintainers:
> > +  - Stanislaw Gruszka <stf_xl@wp.pl>
> > +
> > +description: |
> > +  This node provides properties for configuring RT2880 SOC wifi device=
s.
> > +  The node is expected to be specified as a root node of the device.
> > +
> > +allOf:
> > +  - $ref: ieee80211.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ralink,rt2880-wifi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> Why clocks are optional? SoC devices rarely work without a clock.
Before this patchset the code was doing

 25         rt2x00dev->clk =3D clk_get(&pdev->dev, NULL);
 24         if (IS_ERR(rt2x00dev->clk))
 23                 rt2x00dev->clk =3D NULL;

I changed it to use devm_clk_get_optional since that's what it looks
like here. It's not returning under failure so I assume that means
it's optional.

OTOH all downstream OpenWrt users of this code (as well as
mt7620a.dtsi here) do specify a clock. _optional might be a mistake.

Maybe Stanislaw knows more.
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

