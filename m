Return-Path: <linux-wireless+bounces-10160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48692DB27
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 23:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF2B1F2263D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9D13B59E;
	Wed, 10 Jul 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="v+/yzzXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263213A868;
	Wed, 10 Jul 2024 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647749; cv=none; b=nI/OuE4HwCDPDjL5jtXKiRkk6czq8RgHeDTdPIJ/Zi0+O7Gw5q8biuxBU8sE0QcVZJCJUg04eiX+Kh178EQJ+KvkzJlHA5zCack/D1zWCt6id6KTyH1WNT/GAz/Wz307TGV0C6gzrZZtC/D58U7OfLVjqvSECjbRNneO7yaOoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647749; c=relaxed/simple;
	bh=biBKAa4cbhRKMUtwt4EhA8ucoPVc1aFoBFsOxZt2pZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I/iRl5Kg7aZTITsEdmHiDIwbho0OsiolSBDf3HZjRLNyy7PMUOPegtTpyiyaTaVOA9p3l8GrjdhlkbxeqjEjcxvUiUtEMBQ0LVx8Y5kWTGTijwceU+OBf+RNnuHs8ofAAvmV6areBHTul0bI/I0ZpbpqvRqjKzbfcCll3rA3kgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=v+/yzzXT; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1720647216; bh=biBKAa4cbhRKMUtwt4EhA8ucoPVc1aFoBFsOxZt2pZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=v+/yzzXTnlkAaY9Fma842bsUwHQAWG2VPWdBxROV9QhM/qi1x4+J4/pDgLCfYitHG
	 sMn9V0esqVixHgVQsDrpFurzIRD5Nm4EnK8v/yWdPzjr5sC3fbCJraaHTzStrSnIwr
	 j+aoSxQ6J/2xWh+hfzaKZ5sbtVTxuyLTFfcsTit/l99qx004jSIEoEF7IqfTbviiDN
	 FfelbYmvQaMJwIkXEWlhakyKn6EsdjU6H118ghNp+Pgmoacf/GfaHdpbndICyht65v
	 JxlqujhglDj0yNb/u8zGRJmXkwr8bkr5+naDUN3x+O+LFXZxKC8UlKxr6zBuhGUbD+
	 fJFDvB3rPFWYw==
To: Thorsten Blum <thorsten.blum@toblux.com>, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten
 Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] wifi: ath9k: Use swap() to improve
 ath9k_hw_get_nf_hist_mid()
In-Reply-To: <20240710185743.709742-2-thorsten.blum@toblux.com>
References: <20240710185743.709742-2-thorsten.blum@toblux.com>
Date: Wed, 10 Jul 2024 23:33:36 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87msmpylsf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Blum <thorsten.blum@toblux.com> writes:

> Use the swap() macro to simplify the ath9k_hw_get_nf_hist_mid() function
> and improve its readability.
>
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
>
>   WARNING opportunity for swap()
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

