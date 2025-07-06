Return-Path: <linux-wireless+bounces-24861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBADAFA87B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 01:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA237AADBD
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2201E9B08;
	Sun,  6 Jul 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/RKlhpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A3F510;
	Sun,  6 Jul 2025 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751845925; cv=none; b=I686/nqYWtay3h8Ke2A4nSaMHHmc9F9PvVe3RW9zw4yLdkrc+RTUGqwSEOrRIhz6f2pc5oDWIud5rxrJMr0qlnbaeb392qON2ee0AQwZPwgXwzC2NDocHnk+sztI6j14J3jnTW8QUu5x+dZHBm9ujFZbpKp2y0R+aDuNZkBedyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751845925; c=relaxed/simple;
	bh=Gf1BtcZgWW1sIpUGKPzzEJETeKvs5xaSuw7T3VIHBTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5se0tK+4Gbwa+NIkgsOdjLJam4V8OMME32MN9W+gsp3UeImFRv/k0l0jT7Q7WQe1ryabnYos4b1vTRrmOe1SvuKQ8jO9biEBeyr1tm2/MkALpynd91rF78kp1RuDIo5omLMP3nseWLP/2XDedS4ryKDJnrRq/Po8KFWYnatyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/RKlhpD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7176c66e99cso11131477b3.3;
        Sun, 06 Jul 2025 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751845923; x=1752450723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+m7B0diOiXhfs636fv/zQA7WEVjYquVXLLYKJKTbjE=;
        b=d/RKlhpDtaDp9GDubbhyo3yxczSAYKbYJ4IYHvl4kFwwpHvTBebu7S+RaPsSw5SxnV
         rzTdf2yspmFu9Z5y536UmnEv/icLHiDDE/NWM07CSs8OlINLSIzkN3wwbFn4VoUP4kxX
         i7rEelotljDLT065i/rv1/MCj/9msfSK1Ydw12nYEPKgmzj9jsKZubr0sCHkn/p1V3yj
         JUeNhJc3zHG/4kgPTD4S80TyqT5GiaBijKHYgilBmsRBCB4mdCFNor9xSxD4c4UPY912
         LypHk2sFhbnciTKOcoq+l1OOtdikfxnYuua2lgv/H5/67gvQqbqu4Z8GwBzCsIPKNkN+
         gAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751845923; x=1752450723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+m7B0diOiXhfs636fv/zQA7WEVjYquVXLLYKJKTbjE=;
        b=l8thmD4LSt4uJJbHqFps0e9ahU0hgI9y4hJiOgZkfJBQQdTJniwdVon9aGynCtNaoi
         +kefVmC5ojd/FDWzObdiptaL89RTjrw8iAvVpKDr6Y47D+Xz0lwWlRm2TDngGJWkr6JB
         hE4pTdgVWFe0EqHkx6EbIdFgOW/M8uy5P50vKRenIoeLQGE9rKhT6uYQ9+qeC6MVPY+L
         RDMwAca5dNT7jf2l6sMHi/kVty4d/ik2K/cWshIw7KhVvGBI3FVMNSSwe7KXxMnRKfKR
         ySwQ6Xce7hjCgdSOhbo9Jrg0/RBjlToN2TRulbaXaM4lZ8qqkz/PRe83Y8r41bZVxwCn
         +ubQ==
X-Forwarded-Encrypted: i=1; AJvYcCW08VBf196rsP1D2sMAzlVEa9QLggWBmlQpesSy76dyyAmrljEp3KAoWiBU0E+pYW8+wrTdEkziu7oL@vger.kernel.org, AJvYcCWR0q6qVX7XpGvilqf+UVm0j9PBotIMcQ3T0TMfaOGXJYPDNNbKGZ6MWCrHd0drzZR7AjEC2lyPo0MyWNnuCKs=@vger.kernel.org, AJvYcCX6WyRu4BMmY1aqfyR0nsKJPNUsKL/16qVm3E3QsLuM59xSqCtDzPOb1+iyrRgAHOMgAfO1WTfNhZdSKO7v@vger.kernel.org
X-Gm-Message-State: AOJu0YyqAklRqZrLDR2kqZTRQF4/5PsJWgG+f+HQXNJZNUgJvij2pV+E
	cRYnGVxfq2p9tMeWVlbhXPIDIAn/9/jvULnPWBJAkVcHLLBPBE4gcLYBz4OxbETQ4GQZgVZUqAp
	7jAJzztngrll8Yf29N23JQP5J0YQ4x3k=
X-Gm-Gg: ASbGncsQkyLG1UZOO7gfnFmhkHHIQ6KZMXS8/035taf/GxOorrPwQREACMUW4FIChpo
	71mIlka1svKnaI0N26rRKp2dQIZRKRsTrcHQG90oBVGzQQwNn87NhwLH8sGSjltyaS/9gqpnmZA
	ln2BYEP6ssdf4768EQuwiVoyrqf8zYnW7FemvkYAzG/A5ziX1hZgbkfRW5
X-Google-Smtp-Source: AGHT+IGu33ZcXT4Q2qak/JrpD+2hFPhuRT5IYYS4i7palcZ3fTaJxZJQdYShxp5sOWjY0V7f4eKKvGCM6HpyE/MpNsc=
X-Received: by 2002:a05:690c:61c6:b0:70e:6333:64ac with SMTP id
 00721157ae682-71668d1e097mr151850977b3.10.1751845922931; Sun, 06 Jul 2025
 16:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <20250706214111.45687-6-rosenp@gmail.com>
 <175184098772.672740.2328928098872646704.robh@kernel.org>
In-Reply-To: <175184098772.672740.2328928098872646704.robh@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 6 Jul 2025 16:51:52 -0700
X-Gm-Features: Ac12FXyEdEOs68iBa0GWZ6aV7SXltB6qi7ZK7vbmauFADvR3IvntzZnjx5C06UQ
Message-ID: <CAKxU2N-912DUV6_zSxVOeegR03U39WzHo37oN1EO0rH++a_QEg@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: net: wireless: rt2800: add
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mips@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ansuelsmth@gmail.com, Conor Dooley <conor+dt@kernel.org>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, linux-mediatek@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, yangshiji66@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 3:29=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Sun, 06 Jul 2025 14:41:10 -0700, Rosen Penev wrote:
> > Add device-tree bindings for the RT2800 SOC wifi device found in older
> > Ralink/Mediatek devices.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/ralink,rt2800.yaml  | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/rali=
nk,rt2800.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml:43:5:=
 [warning] wrong indentation: expected 2 but found 4 (indentation)
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/ralink,rt2800.yaml: ignoring, error in schema: examples
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/ralink,rt2800.yaml: examples: 'wifi@110180000 { compatible =3D =
"ralink,rt2880-wifi"; reg =3D <0x10180000 0x40000>; clocks =3D <&sysc 16>; =
interrupt-parent =3D <&cpuintc>; interrupts =3D <6>; };' is not of type 'ar=
ray'
>         from schema $id: http://json-schema.org/draft-07/schema#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/ralink,rt2800.yaml: examples: 'wifi@110180000 { compatible =3D =
"ralink,rt2880-wifi"; reg =3D <0x10180000 0x40000>; clocks =3D <&sysc 16>; =
interrupt-parent =3D <&cpuintc>; interrupts =3D <6>; };' is not of type 'ar=
ray'
>         from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/ralink,rt2800.yaml: properties:interrupt-parent: False schema d=
oes not allow {'maxItems': 1}
>         from schema $id: http://devicetree.org/meta-schemas/interrupts.ya=
ml#
> Error: Documentation/devicetree/bindings/net/wireless/ralink,rt2800.examp=
le.dts:19.5-6 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/binding=
s/net/wireless/ralink,rt2800.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_bin=
ding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
forgot to run dt_binding_check. Will fix in v2.
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202507=
06214111.45687-6-rosenp@gmail.com
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

