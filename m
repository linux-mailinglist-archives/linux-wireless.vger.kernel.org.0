Return-Path: <linux-wireless+bounces-15547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB49D4B2B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 12:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65959283273
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470FE1CB515;
	Thu, 21 Nov 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaNOzGy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C911CB506
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186852; cv=none; b=sbLVp8zzDsTTtAufbwdi52x+9Rm9Pb9t30JiXOwoozSrzOWDD3CztlTZvjIGWgNrdmBNG7OsbwwjUz6FGdkYd9oMp7NrIM197KuPcF/eF5xZd9kOmtwbO4bNtm7taJAxM9ZvvANYItH+SEHbpp5zJKzvOPoQ/lSEMVvtTxNeb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186852; c=relaxed/simple;
	bh=vkK7dhEzDZlHSoKxdWBYT5h9qXJXR4t0Gs/plAHsc+4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=md9cWjOnBEY3MBe0cDj7LQGLzXYSTJmh9zqkly9qmMsSHm0e7wxZ36vaB5u+ElRgMsQIrbheR3CK7KzbOxq4BWd887n3QuEjr1b4XUj3pGzBDxhLVAnQ4lZUuCAqLNiwemVZGV7dxo1jYm8usDRpNbNTDzHT8u4eQl6bsyppNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaNOzGy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB14EC4CECC;
	Thu, 21 Nov 2024 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732186851;
	bh=vkK7dhEzDZlHSoKxdWBYT5h9qXJXR4t0Gs/plAHsc+4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JaNOzGy68FJSCeakcLg0/xTX7H5o1PLXCVEsE0Eq0C1wZKyxCKnHz/cn99/FZtg++
	 8dtR+FWGXRMit3tCvbY0fvKtbc1G+MQGI3XQp+pGRrV9tOT0GE7ftjU1UYZ3OZv33n
	 8ATdjxdF0/zmF3QP2ADVGz8wIpS4UO5DELiEYvosMtsLZ+lHh6AAWZqeStcnmNS5wx
	 e5kzJOr4gOR8WiXgVgm78FThBaJaHS2emnHWSTmcJiQUb1TuGbXbrPjy0ykMXNbRyO
	 i+9SDjAp6scaLh1vrNaq94uoX0HIo5iOab7RKv9JbUDg5eHOifrrdu3dfxmQJQz1j7
	 uKwFCFKNXwWig==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <jjohnson@kernel.org>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 4/4] wifi: ath11k: miscellaneous spelling fixes
References: <20241111070152.85140-1-dmantipov@yandex.ru>
	<20241111070152.85140-4-dmantipov@yandex.ru>
Date: Thu, 21 Nov 2024 13:00:49 +0200
In-Reply-To: <20241111070152.85140-4-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 11 Nov 2024 10:01:52 +0300")
Message-ID: <87bjy8yhpa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

