Return-Path: <linux-wireless+bounces-94-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D677F9B05
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B30280C4D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C49DF57;
	Mon, 27 Nov 2023 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngDGGge4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0917C0
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 07:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053BC433C7;
	Mon, 27 Nov 2023 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701070319;
	bh=yLp1JcuOdJe5gHRSub4HJF4UrVwP6kHxoOFHEWvht7A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ngDGGge4mQxQ+e9BShADqKEIoAk5rbVaS5M3WjNvUoJe2G8vN6yvZ2fQbzdXk53rZ
	 XaSa0ZCvRwtFN+qO+9dA+3ZOB2ZO4T9gM3FQZnLysQ/4s/RTQSkZLgwjJ+VS92xf2s
	 fNExaV80kIrMBKxuZzi1KVC1lBR3Z4UOyZf3BpuA08DO4obcoLy44090v/0vVc5pLg
	 usZZbb2nUedOoQRCBKSEzRJldn9dQCKZsNyTzI6A15ywIDHd+f1qeVXJgyZdXZF7aK
	 jwV3WvFdva9EwMFqDTmBK6SIGzwMrFqWnUoUVefZUM7zi8qCg6mx21+OGUlNYJQxcv
	 E/AtgTSAa9iGg==
From: Kalle Valo <kvalo@kernel.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
	<20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Nov 2023 09:31:55 +0200
In-Reply-To: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com> ("Ilpo
	=?utf-8?Q?J=C3=A4rvinen=22's?= message of "Fri, 24 Nov 2023 11:09:18
 +0200")
Message-ID: <87a5qz7itw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Replace literal 0x7f with PCI_HEADER_TYPE_MASK.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

I couldn't find the cover letter. Should I take this patch to
wireless-next or do you have other plans for this?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

