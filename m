Return-Path: <linux-wireless+bounces-18128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B17DA21B38
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F013A5D3A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973741A2392;
	Wed, 29 Jan 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TcJs/YsN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B8192D63;
	Wed, 29 Jan 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147745; cv=none; b=ny4PWyTodQHZFCBTbIVhlaTOxPelml7t77KT2AcIE6xM1cZ8q24Byl81NNSsL9B77aH4MDWxT+YhqK1XoCqygGL3K16j3fsx89m3xATN6SNnVnyHvqpLj4bkaqLvAWXq4XZsjpDlIJVt5ECFQzf6Qg2L0hM2JzifyTMX0x+RP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147745; c=relaxed/simple;
	bh=PZPDbyCkjDZOGSTjDsPutxm18cRY4El2Uxthk2pAnxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZx0S53GfaCdnmqPZObNtcvZhkstU5vZfFjhO1yGEIxXnLJVGtEehh2d606Bi8WBFVQxFdA8yq/lYelxmHTZbJGMiMnrrf994rK7x8Gho3dynw3L9VHqn8JEqPgx5JJE4PW5/wR6WlD310zm2WooTbIyNRCN/IHCFp+8BC4/f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TcJs/YsN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PZPDbyCkjDZOGSTjDsPutxm18cRY4El2Uxthk2pAnxw=;
	t=1738147744; x=1739357344; b=TcJs/YsNOLEVjQaioQLUSiHRqn/AEOgahIiujfwteu6pPrj
	48PubBhUZXv+iYOjD0ooTnXa86k8AM3643Iky7NG6rPmzFnXnQejhvUotNocaq4jHOMmKkAx3Htm3
	/a5WZIQWNrBn+HKHS4KwQzMFW81KaT8Dwe8TRn0cr81UnluBGa5zmoVrshH8Q3hqLp0zST6E/9PDU
	HHJz5R7c5YhOOdo56gPXANiNA+52Tqintbhvesvuuiko3ae7adPspeY9QaeYk0R4SSOvatGW2T+oI
	kOS1RFJ9Pzlf9yO6GHsKTTmxydE5gab+39BAV2rXQicyE4BdXlkd6649XTVIQImA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td5cu-0000000DwWB-3ibq;
	Wed, 29 Jan 2025 11:48:57 +0100
Message-ID: <1bc323264d3118434fa748efa59ed4da9dba6157.camel@sipsolutions.net>
Subject: Re: [PATCH 6.1] wifi: iwlwifi: assume known PNVM power table size
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>, stable@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
Date: Wed, 29 Jan 2025 11:48:56 +0100
In-Reply-To: <20250129103120.1985802-1-dmantipov@yandex.ru>
References: <20250129103120.1985802-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-01-29 at 13:31 +0300, Dmitry Antipov wrote:
> In 'iwl_pnvm_load()', assume that the power table size is always
> equal to IWL_HARDCODED_REDUCE_POWER_SIZE. Compile tested only.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> I would gently ask Johannes to review this before taking any other
> actions. This is intended for stable linux-6.1.y only in attempt to
> avoid possible use of an uninitialized 'len' without backporting

I don't see that there's uninitialized use of 'len'. Maybe some static
checkers aren't seeing through this, but the code is fine:

If iwl_pnvm_get_from_fs() is successful, then 'len' is initialized. If
it fails, we goto skip_parse.

There, if trans->reduce_power_loaded is false, 'len' again is either
initialized or we go to skip_reduce_power and never use 'len'.

If trans->reduce_power_loaded is true, then we get to
iwl_trans_pcie_ctx_info_gen3_set_reduce_power() which doesn't use 'len'
in this case.

I'd rather not fix this non-problem in a very confusing way.

johannes

