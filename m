Return-Path: <linux-wireless+bounces-27181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B1AB4AD57
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 14:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255CC188C720
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE832C30D;
	Tue,  9 Sep 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RnfyzOEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506931CA5D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419441; cv=none; b=Lop2yD3CS92mGh/0dNgOjkHLSPk0Uf/cbC3YBztVCNJi+pkRR7Ts/5BOd0IOwlM/mod5aY2UUzi4C9ywhZ1RUPDLpOb73ayewMA9bUsjPAl7sK1hnbq/bqs8tr0iNRLjktmXYNBXFuS5QBlrYlxlTJ0eNmgnEzuiTl5tXvxG4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419441; c=relaxed/simple;
	bh=yX5zOTaOeDzIVPdBFraUXgJCYMcqXOoBy2Gk1EE2Tvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEbb7joBkbEO1Z5RzpKXWocjyWSZgwaaZO/8q5uLnJT5l8KhWinymIQhKfms+c4k+AGtVH4dzn2kd6lB61tS7+dNxr6lElhsvC9UVIdkT8ICFDSvxKdbrT46qIE+P6XvDPvzxySM2dPoUBjWPWxsP10+XVP0QtQ0obTDtnqhLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RnfyzOEz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yX5zOTaOeDzIVPdBFraUXgJCYMcqXOoBy2Gk1EE2Tvg=;
	t=1757419439; x=1758629039; b=RnfyzOEzR7XB2JmvC6B9bKfAtIFXJmHzPY44aUb+juQYaeE
	C8zJdJG9cnnCw4KzKyXYCs4JSSoD9fyW58TwhJ3v5bdsvV0HXxT8huoQJAi5eHOtbjAcEfxoSW/IU
	sBQhnMBY6gxDIm+dvzwzgUEtvrzMjSfd29g3YuajzEhUOhSnYxvGDXhm5MrsZw/64WrW+2KRnlzMB
	b/G3o9xQfFQYM2YskEDZkShjHK4VyCjn3eZCPwlxtqHk8W1sAOeiIwDoO9EICV2NosildFOa0UnP+
	IRUaZvb+yDrZ8QliirKFtCQwgsNjlQW5AIRgnVRzqiMxxRN94Vts9TDVsk6iJdzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvx4l-0000000AEob-1ro3;
	Tue, 09 Sep 2025 14:03:55 +0200
Message-ID: <48ac8a2f24666d84b2278959fe29bb11bbf4236a.camel@sipsolutions.net>
Subject: Re: wireless-regdb: Allow 6ghz in the US
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org
Cc: rmandrad@gmail.com, Nicolas Cavallari
	 <nicolas.cavallari@green-communications.fr>, Dennis Bland
	 <dennis@dbperformance.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Date: Tue, 09 Sep 2025 14:03:54 +0200
In-Reply-To: <CAGb2v66aOHxeHEEKO_XaBfufWPnjJk6RkTBo8e9D1T9ET4S1Fg@mail.gmail.com>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
	 <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
	 <ff6ad414457e4b1cb68e834978a553c3@realtek.com>
	 <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
	 <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com>
	 <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
	 <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr>
	 <001a01db8ddc$019e8890$04db99b0$@gmail.com>
	 <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
	 <14ab2a58e7603047354a17b2c980c143992a6782.camel@sipsolutions.net>
	 <CAGb2v66aOHxeHEEKO_XaBfufWPnjJk6RkTBo8e9D1T9ET4S1Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-09-09 at 14:12 +0800, Chen-Yu Tsai wrote:
> I wonder if it is worth bringing up this topic in the networking track
> at Plumbers this year?

I'm not sure who'd be there to discuss it with, I guess? I'm also not
sure who you'd even want to discuss it _with_, since it's mostly an
implementation detail and "just" needs to have something implemented, in
a creatively careful way not to break old stuff.

johannes

