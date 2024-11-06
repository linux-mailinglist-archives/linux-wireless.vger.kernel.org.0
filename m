Return-Path: <linux-wireless+bounces-14973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FB9BE41F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBDA1C23175
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66391DDC0F;
	Wed,  6 Nov 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut/+8wcH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581F1DACAA;
	Wed,  6 Nov 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888415; cv=none; b=RfatBXdtdWlCrDxNll7OyNw9MmYL5cDVa4wyG0CU1t1bEmrQQ9qEYbnOEt8QyIk+ILWxoxS4Ny2Ap60sSF/Npb1iNBXsr3LW6cY8WFkamxWODHQqzUcbPzNxMuQSqOTUa/rjaX2NKJQStPYi2l6t21ws+h504OYUwBMenXGEny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888415; c=relaxed/simple;
	bh=lXpB45YEiKcKgz5mKJKvT1SzNckif79TOWmyG/tgmZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnvX/RsHuudM36dCB5xARYo568rxcPNOzEObuhQkkEcR6sCjAkloUnw+Ly0sqORsq+WapDznOD7THE+5HsMkX+oMUkjY0AOfFmdxarPrGQ7/dgKKLoOw6Qia88O44qRRkITyhmRGv/hbdmWiGFb8Pze1O2uEphqSc7qmsOYUkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut/+8wcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91CCC4CECD;
	Wed,  6 Nov 2024 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730888415;
	bh=lXpB45YEiKcKgz5mKJKvT1SzNckif79TOWmyG/tgmZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ut/+8wcHMoHlEah+z1uEA09kuKP1PPJjtCkUptqxPo+CPvuPAm71BTxkR945Ht+ZW
	 xL7hMe364LooETN3T87cqFTEYhAL8mEJy3X+Ql4+i3yHPYN9FD5MrCTIb42tKHcBGV
	 tIGJORhucoV8CjDu/K1VBOTn1RLjnBmjqghYD4PDVbYLx2XlewK2JoT1IqsM4xMF5T
	 uccr0sQHILtsz9FpxP/WuMnI7K0FyMQ4+YmP1ClURfsom3qDTkCUUJyXYY7Zjxu4Bd
	 PhdjzhpkKnDZ7DPAqU9ngWAX11qJaLd8t04UCZsF+YhBNjgNJvdgEtSPKrBl/A8qO9
	 TDiZ3YgHQd4bw==
Date: Wed, 6 Nov 2024 10:20:10 +0000
From: Simon Horman <horms@kernel.org>
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v3 12/17] wifi: cc33xx: Add scan.c, scan.h
Message-ID: <20241106102010.GN4507@kernel.org>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-13-michael.nemanov@ti.com>
 <20240809160355.GD1951@kernel.org>
 <33f3b6a4-f907-4374-90ac-d81a81700936@ti.com>
 <20241102120030.GG1838431@kernel.org>
 <d9640623-4b93-4fce-991f-f881a230b143@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9640623-4b93-4fce-991f-f881a230b143@ti.com>

On Sun, Nov 03, 2024 at 03:09:22PM +0200, Nemanov, Michael wrote:
> On 11/2/2024 2:00 PM, Simon Horman wrote:
> 
> ...
> 
> > 
> > I'm a but unsure why you see that, but what I was referring to is this:
> > 
> > $ ./scripts/kernel-doc -none drivers/net/wireless/ti/cc33xx/scan.h
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'scan_type' not described in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'n_ssids' not described in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'ssids' not described in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Excess struct member 'num_of_ssids' description in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Excess struct member 'ssid_list' description in 'cc33xx_cmd_ssid_list'
> > drivers/net/wireless/ti/cc33xx/scan.h:149: warning: bad line:
> > drivers/net/wireless/ti/cc33xx/scan.h:177: warning: cannot understand function prototype: 'struct sched_scan_plan_cmd '
> > drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Function parameter or struct member 'u' not described in 'scan_param'
> > drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Excess struct member 'one_shot' description in 'scan_param'
> > drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Excess struct member 'periodic' description in 'scan_param'
> > drivers/net/wireless/ti/cc33xx/scan.h:269: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_scan_params'
> > drivers/net/wireless/ti/cc33xx/scan.h:269: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_scan_params'
> > drivers/net/wireless/ti/cc33xx/scan.h:295: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_set_ies'
> > drivers/net/wireless/ti/cc33xx/scan.h:319: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_scan_stop'
> > drivers/net/wireless/ti/cc33xx/scan.h:319: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_scan_stop'
> 
> Right, fixed in v4, thanks.
> 
> In general, all of those structs are internal to scan.c and not part of an
> interface so I think I'll move them there and drop the comments.

Thanks, I think that makes sense.

