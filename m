Return-Path: <linux-wireless+bounces-12211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43ED964BBB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77281C22A25
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025371B3F27;
	Thu, 29 Aug 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxu5Mpfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEE1B3F1C
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949125; cv=none; b=IMkK21CCcw6itabGY7riuO5jRErSRPplPs6ZZsrMeLDqMTnvhngrK4G3+SSr/st4A1+ZqLHcIjGgg0XHFBWOpYoLQtt06L9bcJB2nksKdhUjzNIxsJp536ce1DLHpVhYRuepu5h9cyG2LTeL8DHle2I/Avmve9HIlTayjnKbUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949125; c=relaxed/simple;
	bh=rHblznT63KfmU6l7TU2UxEz/GxRrRcIbJAbnnCrzGB8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rDwVCZDvrqsv5kRFW7Afizqts3xrD2CuJfswC5N+7rEpehWnovclmMWyh74YRiR477CrznKnLaWWrBOBx1DE1K3sZXpMnJeqrfeeujH5nsguV17fXt16/heBsf0TwJYV9JUSmB/5P9x4pP+0YRbquJ6iZ8/DC0zoujxFmfvnjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxu5Mpfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC9C4CEC1;
	Thu, 29 Aug 2024 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724949125;
	bh=rHblznT63KfmU6l7TU2UxEz/GxRrRcIbJAbnnCrzGB8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Lxu5Mpfgm/kW1tUpxcRn5KxyMGatv6R7i2IH3b2zp+TjlvxU4ZEO8dOYiRqZFTtha
	 BmB77U/XVHBNPd8F1amkdehDw53TPBlcfOT+CRB2R5I4A9kytiu9IWkJRPEnwKUiaw
	 cRzbads9OeNX7i/DaAf7HyoF/+A8YoCW4hrInEQZxtJTgYY+eID2690cOk8T7JL1gU
	 8SBbSOoUjDRqr3s5HTFcboL7OcCF/UpDqm2UFaV8o00lDS8jN4Kgoie0rkvijQl92T
	 fqNyCqhEHg6vgaEAMvoJf4kTikdZiSE1+Ut3IQrDEWO32wRVMEq/KUfDkTD6dGFpnu
	 BB1JaC6DLdh6g==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Ajay.Kathat@microchip.com,  alexis.lothore@bootlin.com,
  linux-wireless@vger.kernel.org,  claudiu.beznea@tuxon.dev
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during suspend/resume
References: <20240821183823.163268-1-marex@denx.de>
	<a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
	<60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
	<63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
	<0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
	<5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
	<ae40b138-77ad-4044-9448-784be6964195@microchip.com>
	<12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de>
Date: Thu, 29 Aug 2024 19:32:02 +0300
In-Reply-To: <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de> (Marek Vasut's
	message of "Thu, 29 Aug 2024 17:38:12 +0200")
Message-ID: <874j73e1dp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> Since this driver does not reload the firmware into the card on
> resume, the card has to be kept powered on during suspend/resume
> cycle. The card can NOT be powered off during suspend/resume cycle,
> otherwise the firmware is lost.
>
> Without this flag, the card may be powered off during suspend/resume
> cycle. It possibly does not happen on the Atmel controller, but it
> does on the STM32MP15xx ARM MMCI one.
>
> Now, since the card does consume about the same amount of power
> whether it is powered OFF or whether it is powered ON but suspended, I
> opt for the later option -- keep the card powered ON, suspend it, and
> that's what this patch does. This also allows us to support WoWlan
> then.

Are you also taking into account hibernation? During hibernation the
device will be powered off. I can't remember the details right now but
wanted to mention this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

