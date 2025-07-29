Return-Path: <linux-wireless+bounces-26045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D225CB151F2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505387AAB0B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F52951D9;
	Tue, 29 Jul 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A/DP/Cth"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3819D8BC
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809313; cv=none; b=BUXvZph0qemN6c2vcPsk4IcGiFZRjxOrfY5hEJCrevX1rKcnHZFS/yTtHeviAf6gxoagcx+4YWH7iat/CFeWDX7IxoxDvKIiW/TpC/665wxB9KyXA9HROLHP4mPbm67PFjIoQMqko4a0BGyLfGd4ol0HFtNjsClwSwQEYV80p1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809313; c=relaxed/simple;
	bh=sFrB3DO1ZN97yeNrGQP6cxyTfwbzjwo3LgKKdUFiyOM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUzk0nmFSftkBWtHjVp20iEA9K588EtQNCFiID2EvhJLjXrKzrZZuOmz8Jy99HljV/eW0G1A3qxjss46kZMwxeCpj5/AB8LMkGTEizaD0MZh0viPwtwHXopQdLmlYmHeou0VOCUoV9d8AnS6LyM87j02wzCa33JtRdU6/d1g/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A/DP/Cth; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sFrB3DO1ZN97yeNrGQP6cxyTfwbzjwo3LgKKdUFiyOM=;
	t=1753809312; x=1755018912; b=A/DP/Cthwe6Nnebox5DBpaE7Ajqy4lXAS2ebkdwm7z4iVYk
	sbfbcQeKiHvDsFqkhDfpVshPE0Ei5RD/vGHE9xwb6cA2Y0iIJHgpCCLlFRaH3Qf+3hChui5AxPjIV
	KWXBOpCnyU39FrOp8K+U05Bmvjo60arkARCAcYD2S9uQTRsO2euypuwmuLC3Lk0V/Mr8SGSqIxEFa
	/+ufgDqUqZlRUZ6LI9kwm8Jm2rUsifc6xlsXDoLA1o7VL2KMjXs8nU7VV1ejzlwSixOxqyvup1BBn
	qm8NNaevSWnogM4EwEq8faMbJmuvVAIpbz5zYz4pcIGmn4e3b6ahLoPFYadZil7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugnuu-0000000EoyM-1eLo;
	Tue, 29 Jul 2025 19:15:08 +0200
Message-ID: <3c90ae9c1234f19f8506cb277b7e09bdce5b477e.camel@sipsolutions.net>
Subject: Re: Question about flush_sta()
From: Johannes Berg <johannes@sipsolutions.net>
To: Castiel You <hujy652@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 29 Jul 2025 19:15:07 +0200
In-Reply-To: <CAHGaMk-S4SZgcLczH1ntBvYJCk1vxJBfxzN_FSpGANC+-P0p1A@mail.gmail.com>
References: 
	<CAHGaMk-S4SZgcLczH1ntBvYJCk1vxJBfxzN_FSpGANC+-P0p1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-29 at 23:21 +0800, Castiel You wrote:
> Hello,
>=20
> I have a question about flush_sta() behaviour.
> From reading iwlwifi which is the only driver implemented flush_sta(),
> it looks similar to flush() with drop set to true.
>=20
> Is it correct to assume flush_sta() acts more like drop?

It doesn't really matter, but dropping the packets is faster and this is
during disconnection, so there isn't really much of an expectation that
they might go out, and in fact the connection might not really be viable
any more anyway.

We'll probably need to rework some of this for UHR though.

johannes

