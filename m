Return-Path: <linux-wireless+bounces-15546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1069D4B26
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 12:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1671F21218
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948C1CC8B3;
	Thu, 21 Nov 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzxKa/Pe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D51CEAB8
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186804; cv=none; b=RhXLoyzviRPjM2tnPfIdV2kh0V9CSW9i0b/xzaZlCf+jNGzm7F9YiXhbjaDsaZncVfT3SNjPJUq3tesMJrAc/n3deSA/bK3WaRT82ACszBldTlbn8tz+YA0ziETcFDqIQtTCMfezc0/fPZPM2fB3mVmScjTYbaYtWXO6fWgzcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186804; c=relaxed/simple;
	bh=f/43QzehujPcbsQhIGSMhRy+9gJFgqsbw5YlCcBeeZQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FFUrKZPN+mqFrlN77h4vcA7Oz6s7nlAjpd0uDXSwWw9Xsy4WEWWYh5kMOWwo6ryEl3Kc96ZMrGeZ06dK4FPfj20IosZKApbbGSVzhurc6O0bH0bhCyG0SIUyh3cuuA+/5JvQ4ThWvybK94GIPBLvQXr2pYWHagVDQ947ytcrhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzxKa/Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E161C4CECC;
	Thu, 21 Nov 2024 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732186804;
	bh=f/43QzehujPcbsQhIGSMhRy+9gJFgqsbw5YlCcBeeZQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pzxKa/PeUVNJRXke5bX1N35Tc7GXlJdj+1k3xidUNpFiSYK6ZOC/F78ktAZ+gNgSJ
	 fOlFAbuuGeyu9kyModEsYIQ6RfOr8Ww5QHKseKnozr6r9InYcX0mn32JcHEhqJqtYG
	 VsoE14XXYmG+csGyVAJd7MTLeOV+sGhVUwvRXzJfLHTxaikBhQSvQEC37F0yagjaGT
	 E4APCuSc7CF5SkHDnYidwOdVKAlYbgbQGtM0Nvj1pjFOP+uKyo3QDaKf+STTfLjBNR
	 fICZNZByq+eN21DNHQ/D7l/RNP2mMU7WqDMWaqwFFwWWBBorr1jG9U39JzIZljPj8o
	 irZmaMw4+3I6g==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <jjohnson@kernel.org>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/4] wifi: ath11k: cleanup struct ath11k_mon_data
References: <20241111070152.85140-1-dmantipov@yandex.ru>
	<20241111070152.85140-3-dmantipov@yandex.ru>
Date: Thu, 21 Nov 2024 13:00:01 +0200
In-Reply-To: <20241111070152.85140-3-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 11 Nov 2024 10:01:51 +0300")
Message-ID: <87frnkyhqm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Remove initialized but otherwise unused 'rx_status_q' member of
> 'struct ath11k_mon_data' and adjust 'ath11k_dp_rx_pdev_mon_status_attach'
> accordingly. Compile tested only.
>
> Fixes: 67a9d399fcb0 ("ath11k: enable RX PPDU stats in monitor co-exist mode")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

