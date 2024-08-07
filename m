Return-Path: <linux-wireless+bounces-11064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEE94A198
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 09:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2051C20EC3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935F1C7B81;
	Wed,  7 Aug 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA1snIiW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED521C6890;
	Wed,  7 Aug 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015457; cv=none; b=mW8YEQXL1xLiSz6mKtK/8CM9NJgAZeTf53E+szPhg9HQCGldvUvYgChDiuvc2s1/0r4RnjjSKqxbqj4e2Iv7V3QzuwacZbAQUiZ9DhIdiZ7QtD6bTQ9/qJMibfJZUtVxcabG4LdrV0yB/RgYWeNZG19EHVJ9chhWZJ1Uhc8J6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015457; c=relaxed/simple;
	bh=/1ACmVmn+d0im98aAJLAH949L5nHjlBCDiUz+YcaGYw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=G0roEflG+TsRs5wlZ6z+KKyTWU2IlbmUBZTeScN0PPFxaF1uB3l+/7ATxD5fqulHLiWR/1kRMj9FVu74EoRRIDFPWqANSj68pi1opRPndhWGtY6vbtoqsd4bXncOW+RvZgxPYa12CcdiBFMMLHksh+A4lKXmlriydu3kWh4HO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA1snIiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C1CC32782;
	Wed,  7 Aug 2024 07:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723015457;
	bh=/1ACmVmn+d0im98aAJLAH949L5nHjlBCDiUz+YcaGYw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GA1snIiWGJeW2K0zNHnTIHKgRwj3cHXuukxEc1jkxmflMX/py5bm6ClUvC0ISq7Dd
	 HIOsZ+HCd4JdIk2du5vXHlZC6GDjKqkjwVAkS/JI1GGFwLn+d7dU/R19UEiP9479Il
	 nfJ1KC/T+f0gAShaWDbrM3WkIhkqyHKtRmMkmD0K06S1OSuvjM4FF3Lx0LdoScCRoN
	 u+RkcvcdYTyWH49YmntHXJUQWAzipJxV0BeN4sD5YbVKYkXwBM3RNedSt3Bj7PTAfA
	 pV5qWA/RZIYdqHoMwyDVFNTxMRrs4JfKtYCS6yw9M2yXpWAka2VlTGhpaseKsmAhAw
	 Zy1Zwb1QQrtEQ==
From: Kalle Valo <kvalo@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: Simon Horman <horms@kernel.org>,  hhorace <hhoracehsu@gmail.com>,
  johannes@sipsolutions.net,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,  Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH] wifi: cfg80211: fix bug of mapping AF3x to incorrect
 User Priority
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
	<20240806090844.GR2636630@kernel.org> <ZrIDQq1g6w/zO25l@debian>
Date: Wed, 07 Aug 2024 10:24:13 +0300
In-Reply-To: <ZrIDQq1g6w/zO25l@debian> (Guillaume Nault's message of "Tue, 6
	Aug 2024 13:04:34 +0200")
Message-ID: <87ttfwiyn6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guillaume Nault <gnault@redhat.com> writes:

> On Tue, Aug 06, 2024 at 10:08:44AM +0100, Simon Horman wrote:
>> + Guillaume and Ido
>> 
>> On Mon, Aug 05, 2024 at 03:17:42PM +0800, hhorace wrote:
>> > According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26), 
>> > AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4 
>> > and AC_VI (Video).
>> > 
>> > However, the original code remain the default three Most Significant
>> > Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
>> > and AC_BE (Best Effort).
>> > 
>> > Signed-off-by: hhorace <hhoracehsu@gmail.com>
>> 
>> Adding Guillaume and Ido as this relates to DSCP.
>
> Thanks. The patch looks good to me (only missing a Fixes tag).
>
> Just a note to hhorace: the entry for CS5 (case 40) is useless as CS5
> is 101000. So the value of the 3 high order bits already is 5 (in case
> you want to make a followup patch for net-next).

Minor clarification: cfg80211 patches go to wireless-next, not net-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

