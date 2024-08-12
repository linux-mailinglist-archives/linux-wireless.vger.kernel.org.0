Return-Path: <linux-wireless+bounces-11296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5817C94E861
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234221C20F33
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864781509BF;
	Mon, 12 Aug 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5apwCG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC01876
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450812; cv=none; b=S3+4slWUOwNeodanZPL5vyMUxm19HCu7rz98XlgpRnTE4r8oOlPIecGgk3k8SgGMPLzXD49TsoLFF1rQXQzsVri9Q4FAVDE/ks0cqMzMAWT+ZUJ7UqL7OWkPELHMAuWibGy/pSxiBMWiAgpVV9x1XS79C8CutqaFIuiernoOGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450812; c=relaxed/simple;
	bh=s5jMo9MoASZgQylfsCywNpAm1BWdY/yuWpBkzyquKNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZz8wwCw0c79Yd0yWyvHLDwww0I5QiPRPUfsPkxlLkfe/Xlne1VUfokHu3jemSHVuNEsoRa3yr2SLJ0k6/dLhojKy0P1NhZlQmR/p5jQwwaEUl1+wm5MBQyVP/tzVMO1Bi3Rod8xOna2W/JBYprArBMqDSZCnOIW2GA2MDjHFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5apwCG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB35C32782
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723450811;
	bh=s5jMo9MoASZgQylfsCywNpAm1BWdY/yuWpBkzyquKNM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=U5apwCG1tAp7a2vSi2FxrXTsGJQCeXx6BjwI+nu7QirvRTQQkv/rCCdh9Tzn+/siM
	 WWY7aV3Gtn0P98yAgIN2iOPD0tf0Inc0zp0terarc3YMi5mGPaw2rZr+VBqRcpHP9Q
	 1VwfbL5PZty7BUgONtul8l90xBo1WxB9Tm4OzOM2xyEeIKJGg0E/tAHw1yjfbljsQT
	 taOODELlDwT8XecVh2Msb6j8q1BDzCsPJOInP42OPzXHqQV69eBlh3YQgw84rW8J5F
	 l9S9LOCVjJYdXg3Kwiyx11aE63czEsaHozmTCZuOAQFCK8rC0cpFrDh6cy1Pdp59ck
	 hG45F0ji8TxUA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso41755401fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 01:20:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyAxqnaxEwJQpqNFs98DcwmrPP7HNoGNeMetjGCu8dH0qw9vivu
	gGTfSS+PRvMgqVv4ifehLLG8fCns8L+B3TiQAbfQw6IAp+1rsuM26x5uwu4yyI2fguTa6M/sx5j
	cGJUno6orsBcboikZf8cyJc8IICQ=
X-Google-Smtp-Source: AGHT+IH8e7Uv2FhQyAiEU2Q7gTHPagluPC525O45aq42hiX8RLm9Li4wgGi+PmVJCqbWLqDMtOUDYOjq0FO4EV8w38A=
X-Received: by 2002:a2e:9f4f:0:b0:2ef:392e:e45 with SMTP id
 38308e7fff4ca-2f1a6d32166mr55195271fa.33.1723450810197; Mon, 12 Aug 2024
 01:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45213523-32f6-4e82-958b-6271e8b7e366@gmail.com>
In-Reply-To: <45213523-32f6-4e82-958b-6271e8b7e366@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 12 Aug 2024 16:19:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v64OsGpERdrojMgfbQspk_vwsm-X16Nj4ntvN+1azaEM9w@mail.gmail.com>
Message-ID: <CAGb2v64OsGpERdrojMgfbQspk_vwsm-X16Nj4ntvN+1azaEM9w@mail.gmail.com>
Subject: Re: wireless-regdb: Inaccurate regulatory rules for Brunei (BN)
To: Nathaniel Chin <thegamingorangutans@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 6, 2024 at 12:51=E2=80=AFPM Nathaniel Chin
<thegamingorangutans@gmail.com> wrote:
>
> Hi,
>
> I've noticed that the current values in the regdb for Brunei do not
> match with the Brunei Darussalam Radio Spectrum Plan (2014-2015 version)
> <https://www.aiti.gov.bn/media/voqau1jw/brunei-darussalam-radio-spectrum-=
plan-2014-2015.pdf>
> and the Telecommunications (Exemption from Sections 33,34(1)(b) and 35)
> Notification, 2018
> <https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2018/S039.pdf>.
>
> Which both state that the authorised bands are: 2.4000 - 2.4835 GHz at a
> max of 200 mW; 5.150-5.350 GHz at a max of 1000 mW (2018 document); and
> 5.725 - 5.850 GHz at a max of 1000/4000 mW (with the latter requiring a
> license).

Thank you for reporting this. I currently cannot open the 2014-2015
document, nor the underlying website. It seems I am blocked.

Regardless, the values you report align with the 2018 document. One
oddity is that for 5.150-5.350 GHz, the 2018 document reports two
limits: 100 mW and 1000 mW. Do you know what that is about?

> Additionally the 2015 document refers to FCC and ETSI regulations and I
> don't see any mention of Japanese regulations?

This is from an old change that added DFS-JP and associated a bunch of
regions with it. There was no reference given.

Without access to the 2015 document I have no idea what the DFS requirement=
s
are. They could also be under some technical specification that describes
the test methods for compliance.


Thanks
ChenYu

> Best regards,
> Nathaniel Chin
>
> P.S I've had to resend this email because initially it was sent as HTML
> instead of plain text so if you've received two copies: sorry.
>

