Return-Path: <linux-wireless+bounces-20799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68BA70187
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 14:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EB617DF43
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98F261563;
	Tue, 25 Mar 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkt2f92k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A455A95E;
	Tue, 25 Mar 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907792; cv=none; b=CdaGbCCGvXxDlvuOUnQ0B2UpL73stVotCcqDsv2ZXBPkUg6nw8rrDCzAsMtCnW0QWk8TOSiIbpfjdbwFlJ0ErzTLyJjEteRfSkalJfrL3VjTo9w5oWgIUd+5RrTzIOJ61UYrd1BMkl3G+g8EKbynNPoxcI9A4UNP0UDV5W81jVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907792; c=relaxed/simple;
	bh=NOtSZO6+mIJhpKmav78FIQ7+8EjmLGHsFa+GzKNPUZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg2zp2IWCtjFhTd+TXZ6O45CndY0BAF9BKSOKHIdLWBTUHXqMxD4A8+Pk2tmvYHIIv3xRK/64wko6/SFQ6DagCECAAQUFA4IryJWlIATRM3kRalc7zbfb9+766VHFME21py5Go3WSE5vtwML2T7JuTTAi/kyXDjSV3RMpIcdLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkt2f92k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111C7C4CEF3;
	Tue, 25 Mar 2025 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907792;
	bh=NOtSZO6+mIJhpKmav78FIQ7+8EjmLGHsFa+GzKNPUZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fkt2f92kJiGWhH8dgk17/UoRqdJx0EFe/3P/dy4V1s5KFOcQBfhFPknqCwMCrbm6/
	 xQjQOvggDEzDyOsIOE623THEpITveY2dRX8fO+8ia0MsnvPzH3VZCtioaeqCxzuBjy
	 JaoZsexlhO6gfrDEN2F6R84U7RTlY1tzf+2VXUZZvzGoGB4oL1cGPJnw40aRmZVpU2
	 N/M9WO1QdqSS6PBVtpgJQypgCL9UBhGszkA+cg0oNo1w2WVNHVRgsafoRthA/cgVJz
	 KlRJZSKbHbQrWjY9jRq12NqOaBRm8MvivREYHKVonSwAKmbUfLZQJ9B3ALN3qcs8ae
	 nAVXsi7XusNvg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso8674346a12.1;
        Tue, 25 Mar 2025 06:03:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4X3X5uabf4fdRLpBFAOBP91rSdxdhBlQ4V54FhgYfHLdB5+31LbK5+ksNOoBnQ0luNndG5qRGIGC1c4TRqJk=@vger.kernel.org, AJvYcCUPiKl7sGumk37Qo/LRDum9KYYbHfZhDIbC9xEAYDdXUGvkzcy10EC7YbxDYk1wLeXlLk/bmKif99FPf4gm4Q==@vger.kernel.org, AJvYcCVK06wdAIXemLnSaK70GvnDkFUVYa2kbfjKXRnxD4MrC0oSyobtzMI97pJxdHrqC37m+X0QfhnidtUfrw==@vger.kernel.org, AJvYcCVWyJ/1Sh8Fv9s4wLOUuAfkPFMNXSMXehx8awAI74DBHo9xV4SN96m16/ME1hd5lJj/XPy1Xw97kLv8Wc4G@vger.kernel.org, AJvYcCWwLqXvdcYzq7yZypByv3OGe3KWfoinL353dRklC0UbiWQWDEp32PV+f1MA3sVCuclikI5Vgh6BUgXvyDEVTiM=@vger.kernel.org, AJvYcCXPT1P0ZT44NE0qGLi4LpIq9TFCQHhjs31kWxIL3PLGVHjwxsIXL5QeVMnMouIkbK5+9kxKLRVI@vger.kernel.org
X-Gm-Message-State: AOJu0YzyiU3GODGyL4a/LBV4c+txrLdnizbVXq1kYMqpIBpTKnysNpU2
	01IkjShI/j3/6Tt14iRTQcc/cUBcEDUpL4+2dPk62niJyT61vYuUAebqdsLjYjYwnG670csdHPy
	OD4Ay0mesMKaJ0OYdjrAKkrecUg==
X-Google-Smtp-Source: AGHT+IE9YIgEdFy0C8MVlG0nopmhGsYdec5XnoCD98500ifVdHHqN4dUOGNkZiKuQcgs2ZSWsIpcRThQGaL/16F7l+4=
X-Received: by 2002:a05:6402:5189:b0:5e5:4807:5441 with SMTP id
 4fb4d7f45d1cf-5ebcd520049mr11476593a12.30.1742907790342; Tue, 25 Mar 2025
 06:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz> <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net>
In-Reply-To: <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 25 Mar 2025 08:02:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com>
X-Gm-Features: AQ5f1JriMZBTiF3C2w64Aagyvo_O56C7A0zRxATovzxB1bkU0K4BsN971bbnmGo
Message-ID: <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
To: Johannes Berg <johannes@sipsolutions.net>
Cc: david@ixit.cz, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
	=?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andy Gross <agross@kernel.org>, Mailing List <devicetree-spec@vger.kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 5:33=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Mon, 2025-03-24 at 18:41 +0100, David Heidelberg via B4 Relay wrote:
> > The Devicetree Specification, Release v0.3 specifies in section 4.3.1
> > a "Network Class Binding". This covers MAC address and maximal frame
> > size properties. "local-mac-address" and "mac-address" with a fixed
> > "address-size" of 48 bits are already in the ethernet-controller.yaml
> > schema so move those over.
> >
> > Keep "address-size" fixed to 48 bits as it's unclear if network protoco=
ls
> > using 64-bit mac addresses like ZigBee, 6LoWPAN and others are relevant=
 for
> > this binding. This allows mac address array size validation for etherne=
t
> > and wireless lan devices.
> >
> > "max-frame-size" in the Devicetree Specification is written to cover th=
e
> > whole layer 2 ethernet frame but actual use for this property is the
> > payload size. Keep the description from ethernet-controller.yaml which
> > specifies the property as MTU.
> >
>
> I have no idea what tree this should go through, and you CC'ed enough
> people that I can't figure it out either ... I'll assume not wifi but DT
> for now?

Can you take it via wifi as the main target here is wifi bindings.

Rob

