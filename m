Return-Path: <linux-wireless+bounces-11981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D160495EFD7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FB1F24269
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B671514E1;
	Mon, 26 Aug 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTn9Y6b6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174F1482E3
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672171; cv=none; b=MZxioCs5GlGQp1BisewYvn6iGmPFdggyDZfk+c4dGRzWuFljucXzDZXGunZUJgeemXzWfF8DqE+7bjnDhhHceZgLYoU7s3yYt5nAgCU1llgje9uA6O8XW7PbmRgOuX9WSSPA8gXY+UIT5kZdhJCqVLMYQvtHgp6VhiSJ4piYeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672171; c=relaxed/simple;
	bh=M7ZVeTt31TPfn2NErj3fDSYNlMiUS0z1Vu0MbXHiCKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjOVt6GlQ24nGeWMmZLfjQ97Ym7i4GbtRBwHtwJzOZUpyOgrj8opg6jfrEI24icd87OVDU9GRqpGMcRWaUn69AhRhTFhcA6rocYKBwECaIxCznVet6i7fGyEiA9iyTOzYJYgv7vTdHWGaO1Kzu9/rye14E3Q7PDSZEnuyPvIU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTn9Y6b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C693FC4AF1A
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724672170;
	bh=M7ZVeTt31TPfn2NErj3fDSYNlMiUS0z1Vu0MbXHiCKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=pTn9Y6b6l3UpurD57lkbr9W4WUOgbgA3cOJnQwxzSjVJpuP+0aZSG+wfeHHD4E5TR
	 iqvqh+MIAQkuYxoRJwh+3WjFOuUE0c8PkF2BuD8N2z0CRsfwA4Pj+9fABL0N8GLCIb
	 PlrahQ/gq3Z3hm12TN9id+GNrtw0a0pUrKxJbYar8aP21Mqasd4cujFVzbGxMSAU9u
	 nuFbJ51IHt7BZ5s2iLF1ix3pv0S2rWADEdWq12LE7+hdj193//4zwd6NRbbIzwqQUM
	 vayxcPo1M+CcXRw4JQeZahN3+mKuq5+yfjrijG4vbmwXiZJBCzYWQLF0VTgxbozoje
	 yOR6r4RA+5KMA==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690ad83d4d7so37729367b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 04:36:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL6YuWP7TCMTC7yI9SGaEO9YK42aoVHXu/MxGllLQdYD+BPcYx7gShuWt+58Rw9anonECWzrh5Ah5vWWPI5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQx5CZQHdQrRda/jNTQYyZydWoN1B2gWZv+7CrozgQ5rNDe5FW
	JL3KLihKzjqY+j9q0lEvR04Ws+Pz9cPCQ4RpM9EsryFR+iage61Dyq68PENXG/nZlkhwYf9ax/6
	GxpG0196AVmje3AwUpwC7OUv7jJI=
X-Google-Smtp-Source: AGHT+IHNMXnVy2xDsaV6fk55VXC+drYHKaO2gGo1S+tjUmZLFFbZ+OMylNWnPlYG7pyvPuU/XAN12WXsHsSvPpS+4hI=
X-Received: by 2002:a05:690c:87:b0:64a:7d9b:934 with SMTP id
 00721157ae682-6c62576b18dmr99768727b3.16.1724672170033; Mon, 26 Aug 2024
 04:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5079de6ec52bbd97fd0deaf2df58f8b13e364b7.camel@realtek.com>
In-Reply-To: <f5079de6ec52bbd97fd0deaf2df58f8b13e364b7.camel@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 26 Aug 2024 07:35:00 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7xrSXQb2pRntPbHY3+gL4rEHCHf0jeBDwkiiv542BuRg@mail.gmail.com>
Message-ID: <CA+5PVA7xrSXQb2pRntPbHY3+gL4rEHCHf0jeBDwkiiv542BuRg@mail.gmail.com>
Subject: Re: pull request: rtw89: 8922a: add fw format-1 v0.35.41.0
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Timlee <timlee@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:32=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Add firmware v0.35.41.0 of rtw89 driver for 8922A.
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit 2cdc11a7b3bf06042f1fb179fa1775fde38149=
1f:
>
>   Merge branch 'mt7925' into 'main' (2024-08-23 11:31:09 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-08-26

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/282


josh

>
> for you to fetch changes up to 80fa33b94a91a1e45671e8fcd8e80b9efed47834:
>
>   rtw89: 8922a: add fw format-1 v0.35.41.0 (2024-08-26 17:08:00 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8922a: add fw format-1 v0.35.41.0
>
>  WHENCE                  |   1 +
>  rtw89/rtw8922a_fw-1.bin | Bin 0 -> 1583434 bytes
>  2 files changed, 1 insertion(+)
>  create mode 100644 rtw89/rtw8922a_fw-1.bin
>

