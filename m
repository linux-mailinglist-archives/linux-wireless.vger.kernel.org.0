Return-Path: <linux-wireless+bounces-13276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D509988F0B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359BC1C20B8F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE823B1AF;
	Sat, 28 Sep 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO+Fp873"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A392770D
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727522388; cv=none; b=mJd02nSNkZxXI0x3VTBnuOrWmEER70nZwSF0hy/gF89qqWovi7I1Pjl2cC3ZxplY9AZjU7oPG18lzM93x5Z1I40bXhPTLocI2rUCnBJ2m0WvEBisZ3UcfLI58/kaZiy+ZouYtFcIryPRoYMOU0ZBZc3h++Vm0GHFCCNK23/fncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727522388; c=relaxed/simple;
	bh=d7gC2T5/v488H0fRsPg3tEt883j6exwjHEhNhggae4Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qlk2bKNTfPGtKcR9/fNjKsGMeXqPTGhwzp66BDvJnIUi8LIW722XB55OSmxjBGmKGGZRrlmYQy0Xs8dkpg4yHPJWs/fRt3OG38YyLy91+vlPlfmko3hLH2ucIQjwkRpAQbYIbrJpJhrO3Tu+Z8Efd1Uo7JH4PpTiJ24lOxEVPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO+Fp873; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E94AC4CEC3;
	Sat, 28 Sep 2024 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727522388;
	bh=d7gC2T5/v488H0fRsPg3tEt883j6exwjHEhNhggae4Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uO+Fp873LITxTuZD/+9se0WkxBnwYlBbZ9ii7KOIukL0W0EDlv63rmQIQUGzr4H4/
	 9A4rfpBJWD0GpDduTpCJZO01Ymmw5jmYmT8ScDkxYmhvEibt7QSE3+9hPCGvz63oIF
	 l/GJBw4fa5qXxrRPOgxjhU23MF6B8S3WB8w8qaikG+fHLxHlA0VMmDYUY3FiG94Mc1
	 6XoFy8loL9sDccTWd8Utln3fGEoCu3EXdLoSnmxGrxNunFv3U2ZtwgI3iffYDfWc3B
	 jukPKoSUiBFhmcvoNgUhcqQS9DutXiQlejsVxn+liP+AxzZ2KvxCTVe7cjQBfATEka
	 Z1wbNOuaJ0i/Q==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "mweissenbach@ignaz.org" <mweissenbach@ignaz.org>
Subject: Re: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on
 specific PCI hosts
References: <20240924021633.19861-1-pkshih@realtek.com>
	<4f8451a8dfe043d08a208e52f8754283@realtek.com>
Date: Sat, 28 Sep 2024 14:19:45 +0300
In-Reply-To: <4f8451a8dfe043d08a208e52f8754283@realtek.com> (Ping-Ke Shih's
	message of "Fri, 27 Sep 2024 01:34:14 +0000")
Message-ID: <87a5fs81pq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping-Ke Shih <pkshih@realtek.com> writes:

> Ping-Ke Shih <pkshih@realtek.com> wrote:
>>=20
>> The early chips including RTL8852A, RTL8851B, RTL8852B and RTL8852BT have
>> interoperability problems of 36-bit DMA with some PCI hosts. Rollback
>> to 32-bit DMA by default, and only enable 36-bit DMA for tested platform=
s.
>>=20
>> Since all Intel platforms we have can work correctly, add the vendor ID =
to
>> white list. Otherwise, list vendor/device ID of bridge we have tested.
>>=20
>> Fixes: 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
>> Reported-by: Marcel Wei=C3=9Fenbach <mweissenbach@ignaz.org>
>> Closes:
>> https://lore.kernel.org/linux-wireless/20240918073237.Horde.VLueh0_KaiDw=
-9asEEcdM84@ignaz.org/T/#m07c5
>> 694df1acb173a42e1a0bab7ac22bd231a2b8
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>
> Could you please queue this patch to wireless tree? Because RTL8852BE bec=
omes
> unusable for some users. I assigned this patch to you in patchwork, if you
> don't think so and have other suggestions, please let me know. Thanks.=20
>
> The user has reported this patch works as expected [1], so add his tested=
-by:
> Tested-by: Marcel Wei=C3=9Fenbach <mweissenbach@ignaz.org>
>
> Also, I think this should Cc stable, so
> Cc: stable@vger.kernel.org

Ok, I'll add all that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

