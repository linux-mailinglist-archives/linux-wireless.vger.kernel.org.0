Return-Path: <linux-wireless+bounces-2568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49683DB0F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 14:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3801F258CA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291C1B81D;
	Fri, 26 Jan 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="kXkR3aVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575417721;
	Fri, 26 Jan 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276347; cv=none; b=ji2tu3rELedoufqbNaKYSTcD0sCJxZyMp+C4Vd1NQxhzsvKSGOiHjfatoBjap1V3erTNfULxx9PhnvZdDy8so3djUe8YdMb7sfu+5JkAa4lNOamnV+Ep8i7OUmGPwHCVzK6Pl69yzh9X/hPCHnrm3YlvGRFWtNGCCMsR213pQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276347; c=relaxed/simple;
	bh=yCaDjzdWcbhK07CAVmR/ivtafOSKm96VmZfb+JZOqNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gizpW7SA64eU/4yST0oWhDxeE8xHjE1mIjY9QQs6Z7JQa/gJfxUgGuuJhdxki3yuRCpyMB1Ygtl8xZX5clvNqHH+5yqxOPuCXb/SisXgeqOuVv/l8bBnU4M8huVZnaNXTbgRYgpHf+8dBJfcIwKkgD4ntUv6frmlhgayPtN84ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=kXkR3aVC; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706276331; bh=yCaDjzdWcbhK07CAVmR/ivtafOSKm96VmZfb+JZOqNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kXkR3aVCYPHqL3cwfLaY4XComOmonvUBof4FaAZCDeVC14mTzh6KpiVGomGZV86g7
	 ERAs4ZbqJofzUjzL1RFRYT9X45hNNtrWDZ2mQv5AWn5PpOhKBg7OTWtld3PV7wL3UV
	 w0A/MW5WzmlIl3akjyV63o+ofWpjDItq7DLZig4hxQIISXJM+xW5lVpa6x+Y92/WlR
	 VIg9jsEHuiJ4iuKo/2YEdGlna7Hdxy/Ej3SRyIOdRjL5BzWxalVBNujBqYS+khJpHU
	 qM/whkSm+aSTE5ftNFHyEppO1pug4GjRZXjEjDHtXrI56HBoKfbx0xaDBvsGfse5Uu
	 l2IYilT7zigWg==
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] wifi: ath9k:  remove redundant assignment to
 variable ret
In-Reply-To: <20240116155452.2315351-1-colin.i.king@gmail.com>
References: <20240116155452.2315351-1-colin.i.king@gmail.com>
Date: Fri, 26 Jan 2024 14:38:51 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877cjw2p04.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Colin Ian King <colin.i.king@gmail.com> writes:

> The variable ret is being assigned a value but it isn't being
> read afterwards. The assignment is redundant and so ret can be
> removed.
>
> Cleans up clang scan build warning:
> warning: Although the value stored to 'ret' is used in the
> enclosing expression, the value is never actually read from
> 'ret' [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

