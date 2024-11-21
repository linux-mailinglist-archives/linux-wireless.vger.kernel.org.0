Return-Path: <linux-wireless+bounces-15544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB59D4B21
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A240282D82
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520B1CACE9;
	Thu, 21 Nov 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUWGp/EK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D61CB9F0
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186759; cv=none; b=CdB3ZM+vxBZI9yIipB++SmSKPkL0MjH2TmxiUa5bd6WIhNpKDB+kzNGNH7YAk7FM4U6flP7pvibN123uoPfkZEElEFZ1Z609suAix1/x8gcAc7unz/SwoAeZpCLi0DgzL6x6oTyAHGSlByC31GBuyhJSXfYkZWE/Et127SrfiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186759; c=relaxed/simple;
	bh=91G4dCwh8mKy26Z3P/fUzZl/SEjBepOn7g6X8McNNJE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JFC4se3c4Vbbz6F/I15mMVzJpKNbj6WYDcEzdpQQrLQHkN4x8/kggYUjclzVKq+/8DytTcejLq9CPObqL1S+gzIaneVDz5SYqykOhmuIoFT/1ETQszGkHbHxueXI5WDqVEVJJ3S0x3mHYvaBYjJrL8LjOJ+XPO1wkhTvKvadgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUWGp/EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32262C4CECC;
	Thu, 21 Nov 2024 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732186759;
	bh=91G4dCwh8mKy26Z3P/fUzZl/SEjBepOn7g6X8McNNJE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fUWGp/EKqJ8onqzByUvTjg6QP0v+zBzkbH23u6I+wDHCkhJD6v6VYl54PeONSaDgK
	 9s6g/P8bhRymJ+yFhoL1kwApHyxcyajJbDil68QFb1Y7Im+90NBDlbuiIYuZWDsaCk
	 Y1UZb5ZcfHLwk0r8GIhJ0xOxIKJMuuJkQPNj7m/XM7OJiqo1WACds9RerrRfYAsFxA
	 CyM2hVLXSYW0In+LbE2QYsXpJS675nPEVUvywZkJXkt0YHcR5VallrRmFkVgOGPlwA
	 MPUBkOAZzG9uKXXGEu+G/9RYQIKDUtB3X9lnHDO+aQwV0oIP9H6VMMA8zcn5Ek3AYu
	 +IWnQcQl3j0aw==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <jjohnson@kernel.org>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/4] wifi: ath11k: cleanup struct ath11k_vif
References: <20241111070152.85140-1-dmantipov@yandex.ru>
Date: Thu, 21 Nov 2024 12:59:16 +0200
In-Reply-To: <20241111070152.85140-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 11 Nov 2024 10:01:49 +0300")
Message-ID: <87o728yhrv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Remove set but otherwise unused 'tx_seq_no' member of 'struct ath11k_vif',
> adjust 'ath11k_control_beaconing()' accordingly. This field was actually
> unused since an initial commit of the driver. Compile tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

