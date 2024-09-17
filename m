Return-Path: <linux-wireless+bounces-12915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571B97AF97
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 13:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581301C215B0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B922E15539A;
	Tue, 17 Sep 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpR2c6xf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584114884F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571894; cv=none; b=Exrj/f4Ez5ANjeKP3mwEp/t1heCmjeIMczRhMAQw5njaKXteBlSp7IadlQlC0NOyZWhO+MCLUYSeKs57ZkHpBlcYxRzBC2npS16P7atmlCs1jx7F9Yhr6+FnliLWoRskEQ62D2OBn8k6TcA2nMTJTwYZOO+3dxuYtjhMKvrFNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571894; c=relaxed/simple;
	bh=juqXg4Sm5EwoRb+w7z2ye1c9d9jKiPkIiyfpTiStrX4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=h6Thm69b95sH6Yzpv+69Ex8FV7rqij5FQVhM8L6dACwboLTGlXgwNdNTGzuzqm1lq0SGMAAbG1zoilrrzszGsmkvrU7T6V68IJxNlMgYSlGfMI9NSWZQbqHuuSzRJ9BRQMr6S+dkjEobnmKINaHVp90sEdQZCvMHqPbp3qVVt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpR2c6xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6E6C4CECE;
	Tue, 17 Sep 2024 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726571894;
	bh=juqXg4Sm5EwoRb+w7z2ye1c9d9jKiPkIiyfpTiStrX4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CpR2c6xfQOwOcsus0oy6LgfMjkwSw6Y/W/AaR5Oq5tiMaH1v7zhZJN1hkWle4EwqT
	 kS4wQiiSmXmO+HRBOZizDYndvMtNU2C8sekxGicPVc7acaNJzSlauB5u1xPiSu3xdI
	 WalYwliwpBCoDMtjYwU0mhSAUM151Up2/9vn9OwEMWC54z76mottL+GLZSWuUghbG2
	 WG3HPyrGS37A+etrBGLL4dEAY9LuimWzhD78EjEJEwDeUtOwCqFE7rHPjBOHzAFZQW
	 EVtGDDplHE3NgQvTMN9c7Eohf6EjYLDVd2u3RsgbhWlXct3lxyuq+R1JJkZtWtaggT
	 2+hKSSdpeNLEA==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org,  =?utf-8?Q?N=C3=ADcolas?= F. R. A. Prado
 <nfraprado@collabora.com>,  Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH] wifi: mt76: do not increase mcu skb refcount if retry
 is not supported
References: <20240917110942.22077-1-nbd@nbd.name>
Date: Tue, 17 Sep 2024 14:18:11 +0300
In-Reply-To: <20240917110942.22077-1-nbd@nbd.name> (Felix Fietkau's message of
	"Tue, 17 Sep 2024 13:09:42 +0200")
Message-ID: <87v7yua5qk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Felix Fietkau <nbd@nbd.name> writes:

> If mcu_skb_prepare_msg is not implemented, incrementing skb refcount does=
 not
> work for mcu message retry. In some cases (e.g. on SDIO), shared skbs can=
 trigger
> a BUG_ON, crashing the system.
> Fix this by only incrementing refcount if retry is actually supported.
>
> Fixes: 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages")
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> #Kerne=
lCI
> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I'll queue this to wireless tree and add:

Closes: https://lore.kernel.org/r/d907b13a-f8be-4cb8-a0bb-560a21278041@nota=
piano/

Ok?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

