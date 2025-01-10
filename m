Return-Path: <linux-wireless+bounces-17302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45920A08B09
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9451696F0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74B209691;
	Fri, 10 Jan 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY4+8LdJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC7206F06;
	Fri, 10 Jan 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500447; cv=none; b=Fvc0Rj1H1+8ULQLlkYQ5oFLYeDyKKZpUL6sig+GL/t55EoS0d43WaXTbY6rCPc4xtTf9HBHzL3h4Asd8BLwz2C4+/4s+caR5Qd8+x74fdxLh5XJ5Vnw2JVJT6X+jsTqajaT5FlOnrqiV2qTn8U/2icnfOKzgSAXD/1BOmG3gYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500447; c=relaxed/simple;
	bh=bTb+Hv5dd65gTmFTMoGmoxuUTsLgAnIzpNiXYBrn/No=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VDCWUjBU0CEyI4yQHBgj+SXB+1JP+7YqqxJKYGW4D5UIj7Wkv0d8Wru401RER65js/JPT1rA3U6+GnEGR4q9UTNcpLpaftL/oiHnRddJ4ljS4THtS0hR9PRRfO13ngwVEyvpX/fFE4fJa/ti3cXTKZw/qvaasDOG60zWoxTTK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY4+8LdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB2FC4CEE0;
	Fri, 10 Jan 2025 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736500447;
	bh=bTb+Hv5dd65gTmFTMoGmoxuUTsLgAnIzpNiXYBrn/No=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mY4+8LdJ/dLWVYJ/nrLMS/GRbnBhb1f+0H3LKNOJ5KwMUcjF8aR4BpkUE/gwvo+MC
	 BYecpo4l5Az8XN/tAy4fzue6NC5UZVo0pvFpDrOBHG45N+guiYDOq5UF+Wv/lifuMy
	 0NnmiR4U+T6cqRz82OF5KGi+3Xpnpygscjx/SBmyqng5jyFBual3Gd8+9pMOy88Lqt
	 BZxqbdsv4Ix1mhkNDaAb37YuMXhJVYXZVjOBWcBA+lOe4VbqhWSJwoqEYM3Z3hzwAk
	 aQjRv1m2IgUUR3l80vqVHu4j2HhPyuNhpmLiFwhfJvQHgGDJt0qvEnvSCCpkxaPy8O
	 ahrFW8GZWcaWA==
From: Kalle Valo <kvalo@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew+netdev@lunn.ch,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  robh@kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,
  m.felsch@pengutronix.de,  bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
References: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
Date: Fri, 10 Jan 2025 11:14:02 +0200
In-Reply-To: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
	(Catalin Popescu's message of "Fri, 10 Jan 2025 09:19:01 +0100")
Message-ID: <87frlrowth.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Popescu <catalin.popescu@leica-geosystems.com> writes:

> By default, rfkill state is set to unblocked. Sometimes, we want to boot
> in blocked state and let the application unblock the rfkill.
>
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Don't rfkill patches go via wireless-next, not net-next?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

