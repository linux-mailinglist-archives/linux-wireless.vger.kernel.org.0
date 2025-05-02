Return-Path: <linux-wireless+bounces-22322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EEAA6E1F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7321717D4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA422D78B;
	Fri,  2 May 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="RGLEuT3L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211422D782;
	Fri,  2 May 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178172; cv=none; b=M/vEvDbkmZxyqT5ychsTn5sQOsdBF4L9s/ND4ImIjW512QPJZ9C5Rix33ZIOd/WtBgXYt+ivel2dEFydeY9rOgnJYXONo73upWo4PKPpM3+SLZrhmhgfpU3EtX6pMII9mxo4WJLLVebLPipDixXPB637rz4AwBpCvXZrbYEFhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178172; c=relaxed/simple;
	bh=ZqyGaEgoNmnGSL0sOtYTa2BStnKPZ/Mdro+P2b90YZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKXzUMQG2N1jXwLJ50GtPJYPQA11CxnMs8I22czczUp7RSbyvmLoVF84dD0tEuGl8Xf9mPF25zCVfYOuSB3AbMTU8+g5fNDCAigORddFt5jnREshjYJWXUnL7rUL5GNhm4Shwoq0h67YahkEuge/qRNFV7xJORspyYDTWh2tDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=RGLEuT3L; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1746178160; bh=ZqyGaEgoNmnGSL0sOtYTa2BStnKPZ/Mdro+P2b90YZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RGLEuT3LKbUjllZqSKO/pFwJaCTXzBJbz9ozEaCmGh4rtSzoAE0NzFGx05/5VuKtO
	 C4jC20rVPtjdI9pqjfYev8/FveF6Ht5UjxYAZiKbOXQwZleKCx9OViNOO1ToKeNxb+
	 dhH56WOrMYIAlNFLFBaSnMRpbu73AwLxdq6wldVp//EE/oqpkuONbtb6WrON2VnxUx
	 A3rofvLXf4dEOcgeZs1769zBkI7f+/M3fofl0+Eh9vhKq3+7XALapi52ldYvUv1HZW
	 6akQ/EAkeOGpbWtJdRlyEOFBbCUotxVud7oG125oHBZEmzhmIYHro4n9MzwLqXwS5X
	 pH96W8xXsa9Og==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] wifi: ath9k: ahb: do ioremap resource in one step
In-Reply-To: <20250421040044.44887-1-rosenp@gmail.com>
References: <20250421040044.44887-1-rosenp@gmail.com>
Date: Fri, 02 May 2025 11:29:20 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ldrf5pjj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> Simplifies probe slightly and adds extra error codes.
>
> Switching from devm_ioremap to the platform variant ends up calling
> devm_request_mem_region, which reserves the memory region for the
> various wmacs. Per board, there is only one wmac and after some fairly
> thorough analysis, there are no overlapping memory regions between wmacs
> and other devices on the ahb.
>
> Tested on a TP-Link Archer C7v2.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

