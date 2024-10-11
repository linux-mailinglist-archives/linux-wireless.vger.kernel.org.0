Return-Path: <linux-wireless+bounces-13884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A2499A41B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A49282753
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729420FA9A;
	Fri, 11 Oct 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpeA/kCN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FF1BE857
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650584; cv=none; b=U+AbcqUcXQFP9LA2r8tdj2uOL/of2HhL6B5qWTa/8OOkiLsUQetGiUqEVcoRMtufoW+VNtUTfgjherEpRveJTEopVA3Q3L+j/YM/S/PpyAR/GL1bbb8XXO2ml/RfqjUmXckkfs+4cS+KoR9orJS1Unq/cqKaSRfrPPKQH6WBXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650584; c=relaxed/simple;
	bh=X4vWrBDLb7wW2hElauotsUzHjZ4rmsf3/cpTjhTGcWc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bSOtwwFJzZ3ACXL2EwC3cokgzAVC+5FiyFgLdLdN4lnILGAV7YuKYQOqWTqkKCqj5sJgQ4UM1OamzeeX/stggpzZp24vCLskmvUe25Ya4+M7JZTJGUST/cSVYvB3pI8F70jpiCE/qCFUf2cwtzPvpJyilDe+B8nCUCaGGEYsank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpeA/kCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067AFC4CEC3;
	Fri, 11 Oct 2024 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728650583;
	bh=X4vWrBDLb7wW2hElauotsUzHjZ4rmsf3/cpTjhTGcWc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BpeA/kCN/fyjo0h+Hd5Rp/3DA+lMnaN5hTtFRoqdQnxaGFFqefPyWyYlAY4T7XaP/
	 hVWv+Z8GDmGzCMFlOOuOvZ2nPNyYZY0xFF/HQHCPqurUtLE4MwwO+ksPNtR0sjEdPb
	 yuribzVW3nOMALb2qa9vvowOUJeFCmRJKxtEgcI4DFSJHfWVVBIUpAqZU1akIdApuX
	 aHDqg/RgOgoCO4HZ9248henKhoSrzxGcpUzULH/JjW+J2kvna4dksmjMwT8AHDnyuN
	 MZViORPh7qTvuLapEQ7ti4FJmT2KtjygIm2au0sRH6OqZGCUaZOHgQC1YsMj/dpTf3
	 +Nde+0sBEJPIg==
From: Kalle Valo <kvalo@kernel.org>
To: Marcel =?utf-8?Q?Wei=C3=9Fenbach?= <mweissenbach@ignaz.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on
 specific PCI hosts
References: <87a5fs81pq.fsf@kernel.org>
	<20241007122524.Horde.2JAdlkKXx-zqmJFI4TBIqZH@ignaz.org>
Date: Fri, 11 Oct 2024 15:43:01 +0300
In-Reply-To: <20241007122524.Horde.2JAdlkKXx-zqmJFI4TBIqZH@ignaz.org>
 ("Marcel
	=?utf-8?Q?Wei=C3=9Fenbach=22's?= message of "Mon, 07 Oct 2024 12:25:24
 +0000")
Message-ID: <877cae3j56.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marcel Wei=C3=9Fenbach <mweissenbach@ignaz.org> writes:

> Hi there,

Please don't top post.

> just wanted to kindly ask in which Kernel Version this patch will be impl=
emented (given it is not yet).

This is not yet applied because I have been busy.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

