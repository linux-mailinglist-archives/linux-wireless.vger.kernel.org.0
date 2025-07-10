Return-Path: <linux-wireless+bounces-25147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED4AFF759
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 05:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A467A6E09
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 03:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076DC22837F;
	Thu, 10 Jul 2025 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDZE3ylV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788D2236F4
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117150; cv=none; b=pRSMjZezIInYSPZDiTexsEAbDs5HEEBbnKrAv3lduuyAEsVDg9iiX/g/EGMqUxjZVyfp159RDiDBzAS64KJM3Ccg3N9harUN+me5SoCZa2kNAvqFuhvPhzUWWh7c1G4CmNuME3OZw2rN7Du+rIkeA7el0Q8D8wOm1U/rcBRNNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117150; c=relaxed/simple;
	bh=x9gEGEGbGMlzpDA9o371WL8DLUnKrs62R/dX/MKJvP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ombAcym2TaQEhsLNlXBd6TTK2pAvyOHIjPJNwp8qGjny8NR0M46mZTu5jZpMqkIoyLzMSPy6acKra/4EAn0Bk8YUx+I0I3Om464SubujE9OPxnfblwcXOvSRIzHGTjue2SYapApqXhHAqQZVoZtXPv/df3NGpULy4OdPF7yH/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDZE3ylV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7C3C4CEEF;
	Thu, 10 Jul 2025 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752117150;
	bh=x9gEGEGbGMlzpDA9o371WL8DLUnKrs62R/dX/MKJvP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NDZE3ylVhQdNq2CcVoaffQJyY0ZjKe/rKKpko1x7pjQroDngAQWsZ01c3zCNOdaxI
	 6nQeVn5HedffcfbGnb6cWBEZaWl+Dxc26+ICpn5saX9BvTIK5y3Zp8S5mgAthGk3OP
	 aS8hcN7i5C+rXbRYfvsnyvHOYvqHno1S/PYxfJchCSjMcUBU3hjRgtUdC9Aa9RSTId
	 JJEkTo2wU2qQovq7yJ55feo8lwCX6aNjZ5rTqt3BF+yUa8CKz9g0Eo3ytOCB65Ymk/
	 gytBECKx+PDFNE0x4mCKa0+XEXiSi+3tuUm/6Ksvc+CVdHZGHPl7zmcG6g6bBf8OAO
	 TYwAi7iBZu5XQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 4D2765F843;
	Thu, 10 Jul 2025 11:12:26 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250708113544.3557-1-pkshih@gmail.com>
References: <20250708113544.3557-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: update regulatory rules for Bosnia and
 Herzegovina (BA) for 6 GHz
Message-Id: <175211714623.3967082.14941797088374296053.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 11:12:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 08 Jul 2025 19:35:44 +0800, Ping-Ke Shih wrote:
> For CEPT countries, ECC/DEC/(20)01 [1][2] decision enters into force
> on 8 November 2024; preferred date for implementation of this Decision
> shall be 8 May 2025. Update regulatory rule for Bosnia and Herzegovina
> accordingly.
> 
>  * LPI devices
>    - 5945-6425 MHz
>    - Restricted to indoor use only
>    - Maximum mean e.i.r.p.: 23 dBm
>    - Maximum mean e.i.r.p. density: 10 dBm/MHz
>  * VLP devices
>    - 5945-6425 MHz
>    - Indoors and outdoors
>    - Maximum mean e.i.r.p.: 14 dBm
>    - Maximum mean e.i.r.p. density: 1 dBm/MHz
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: update regulatory rules for Bosnia and Herzegovina (BA) for 6 GHz
      https://git.kernel.org/wens/wireless-regdb/c/5fd8ee30bb6c

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


