Return-Path: <linux-wireless+bounces-15143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224509C1C8C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 13:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5F6B219A7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F51E3DCA;
	Fri,  8 Nov 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htmOOqK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820C38DC8;
	Fri,  8 Nov 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067373; cv=none; b=sg7uLl2Een8rCfG8YPCoF4+/XQrEsL0tc0DR7jN5lG2pWYYlesJnLWvqkg400Mn4ajwYc9zXM0dFMMKxMzxYxDbi/zNAKQS5k6JJNtYdy5WfgxMHq9MjmitTs+A3zyI4jz1vt24oumlwJpfcHla7U/bwGgPXneN8SIiO1YSn86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067373; c=relaxed/simple;
	bh=JXkRXJGHhVV7gzyzK41nZ/QxsLbtleTkvCKBDxkp4ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGnEEd/srb582Tki9d5wF8BhECdGMGi+0CoDy8SCDDRWoh6KTjqv7mIUnTrWbnSg47nQ+WvUs6B+jePQTgIEwwtlclbjWnj24frfwfz3IsTEAiZn71YL5br5BKBoZTEVCkEf/BghWa19UjGlMnOmZbpHvNlhGLDDqo4XLrIOzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htmOOqK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1008C4CECD;
	Fri,  8 Nov 2024 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731067372;
	bh=JXkRXJGHhVV7gzyzK41nZ/QxsLbtleTkvCKBDxkp4ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htmOOqK04UpQYRWMl8YSNgzP1M4JghBrHlMwIDD44zYV2z8Pyd+NJO1Lzin/D0so2
	 zGkgW5QlmrxwRlErwv6+jYrfXPdy+gBCcSzvU3R73h8PuhWGwU4nOJ+3rXjGCh/wpN
	 3rNgLTGtic3nIcS5iglSbYY89kizuDP9GRKPMtTOKJ6rrpOfdUNwMCeInNBq/Emkjf
	 AXVWNG8qkwg3ZLuTN9+SZZoE0jUUIceieAZYMg2W136zFLLcMqjJv3PCY9GhW/WUfP
	 mjAqQ/w4gY6O88jjZJiuabUuPKkBdsKNypWchbnfPxHPiHWd/9jMduYcYE5fEAUotI
	 YZ3uGsNa9KvVQ==
Date: Fri, 8 Nov 2024 13:02:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Nemanov <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v5 01/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
Message-ID: <y4ffzjekeccqg2tv7d54ilwbz3nhm4jkcq3fyg5tmpbupsqirn@dq3kjtwkllds>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
 <20241107125209.1736277-2-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107125209.1736277-2-michael.nemanov@ti.com>

On Thu, Nov 07, 2024 at 02:51:53PM +0200, Michael Nemanov wrote:
> Add device-tree bindings for the CC33xx family.
> 
> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
> ---
>  .../bindings/net/wireless/ti,cc33xx.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
> 

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof


