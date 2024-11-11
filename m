Return-Path: <linux-wireless+bounces-15173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF79C3BB6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 11:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0ED1F229D3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A0156256;
	Mon, 11 Nov 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="WOZfEVnX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821C149C4D
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319897; cv=none; b=giiPeAK+fmqKEiQecNCs5cyp+Gx3bZ2QGzy2nYKK9qfrYYoqDfOQMuWIFxL4MMUlP1uuIXqEl0nj+rJYAtakrOxgHmGgxKFKeLdD31rBIfln8N//39fjXQwSYsTAcRdNYCVjB7Ygk/4uIDVA/8a3agjxKqdYum9xejDfB30VW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319897; c=relaxed/simple;
	bh=Q9dKD9BlXG/B9H9Ft1xWYJEI5joL5Y4ixWCShWfyMJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n1euq9DB/Mr26xTrnGYYQ8jAOl/6qqLF4Q1mbdgKrU5FAIriUOQHYgNTOS164uNKmbzLAxQj0uBDsMiYvXxwQXzWZUsRvZZS1GNzDfHzeIzkM3oGUkB0pim4nExEX+sZwYOfpdb2SoQvuEqangy8bseBvdzm5gJPm6xVaJ6nSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=WOZfEVnX; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1731319882; bh=Q9dKD9BlXG/B9H9Ft1xWYJEI5joL5Y4ixWCShWfyMJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WOZfEVnXwWYJvc60Mo23chd1PoZnPbtxrf+B6zyqWbteAfbkgl7snLxu8y8VX94n5
	 hsPH8uWRKH9pFCaAunfOA0umTfgFunP5lV84SpQMEuxRDJ3+eSy7vCcY98mtDDAEHN
	 iWE+kbbVMfxVBDO8Mnjy0oQOUNpn3HOlmqI0KCLstF+iShjxwmMmSY2kicr05ZyUNR
	 c5AeIfQvbgFHS0lAijH/oAYuc1aNn6Ew2cDi03Eo9L61U0h2IN++VzKAo+Rq2u6gl5
	 Q/03UkKxPE7jWYbW8jB6Dx1K/8jjJ5tZ4d94sF7tzAmWCfT2JIwUmr4SqjwyRP/Qvu
	 zQG9VFl2a82EA==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: miscellaneous spelling fixes
In-Reply-To: <20241111071157.88296-1-dmantipov@yandex.ru>
References: <20241111071157.88296-1-dmantipov@yandex.ru>
Date: Mon, 11 Nov 2024 11:11:22 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87frny5bcl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Correct spelling here and there as suggested by codespell.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Thank you for the fixes. One nit:

[...]

> @@ -2544,7 +2544,7 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
>  
>  	pCap->tx_chainmask = ah->eep_ops->get_eeprom(ah, EEP_TX_MASK);
>  	/*
> -	 * For AR9271 we will temporarilly uses the rx chainmax as read from
> +	 * For AR9271 we will temporarily uses the rx chainmax as read from

Here we should also s/uses/use/ - please fix that as well and send a v2

-Toke

