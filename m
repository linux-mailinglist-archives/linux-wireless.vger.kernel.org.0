Return-Path: <linux-wireless+bounces-20430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90EA64586
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 09:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E866F7A2E74
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39822191499;
	Mon, 17 Mar 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ogopq2bf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0E2629D;
	Mon, 17 Mar 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200306; cv=none; b=fvWXYfgmQabHPT3cj59aD9VoM6Au0UJfunk+aUaStBLH7ZMAyc5HAFTycwpswqOFC6vQfwaX73LGG0OXK0ELhyWl/T2rrzdiYL6+QMfiqTJcL1T5/irSUFYViGIvf2XqTxX0aNn3Q/m32LtLhq/8uTW+E8qoqS7tm4eNVAvE5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200306; c=relaxed/simple;
	bh=mcePzaeHG62fPZF0B5RXx1e8Oc29Vwx9OnkzvKzSyQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKaf7bjad0oMxr8ohntWJr4RlUk9fket5B5SqXDWcefrlrlOHwMj8U2IUM1blSDGUIb2bd8lChJ9U84H+nXWC5YbeWrSjqgxkz69h+8EMgaKupiUjzkdLwGPA400o5IxyX8QynMYCbu0HZcZv8/bax3eK6UmixUuFfRr9VhIXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ogopq2bf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=opEu1g9nkTKwESNSsd8VNcoAAm5+Q5EEa+H9fZ5SvvE=;
	t=1742200304; x=1743409904; b=Ogopq2bfVSRZZhTIP4x3Pf4X10fGE5ek/yVRCLvE3mpjzLN
	+MjRIJi0xhByxgYdd4zElR9v52HIVXu7gmadMqTzDItIXDHwK6gHNovsMaLJvFXI3eMHK5URppir3
	z1O40JSpO+X6U+0vDg/W1gf1P7PfscMsS2+zUJxRrntccfHMg6v3cP/uBzdQe3r6DEzZqnhzENYJG
	/NMyKr8O5uwh8K7D9RyuurB8N2iiJBEefTPwpAfe3AM+17HHAcFl3ZYyvxQzmSUkI2TUhJzgp4wQ7
	Zje8TwZrfmJpBIQAKevi33gQUz6x5Atef7QHxSlLpypmkj4770uWvPqah8R6VX0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tu5sp-0000000E3EF-39Ci;
	Mon, 17 Mar 2025 09:31:39 +0100
Message-ID: <8c02c4f7452f2fbb41c8bc0517af9588c25ca7b1.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: minstrel_ht: Replace nested min() with single
 min3()
From: Johannes Berg <johannes@sipsolutions.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, feng.wei8@zte.com.cn, 
	linux-kernel@vger.kernel.org, tang.dongxing@zte.com.cn,
 shao.mingyin@zte.com.cn, 	xie.ludan@zte.com.cn, yang.guang5@zte.com.cn,
 yang.yang29@zte.com.cn, 	ye.xingchen@zte.com.cn, xu.xin16@zte.com.cn
Cc: linux-wireless@vger.kernel.org
Date: Mon, 17 Mar 2025 09:31:38 +0100
In-Reply-To: <f6dfffc0-a9bd-4a5f-9d83-f3a4b7918010@kernel.org>
References: <20250315111254625RMIKeUh51j1Xk9CWuu2LT@zte.com.cn>
	 <f6dfffc0-a9bd-4a5f-9d83-f3a4b7918010@kernel.org>
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

On Mon, 2025-03-17 at 09:30 +0100, Krzysztof Kozlowski wrote:
>=20
> > +++ b/net/mac80211/rc80211_minstrel_ht.c
> > @@ -1010,7 +1010,7 @@ minstrel_ht_refill_sample_rates(struct minstrel_h=
t_sta *mi)
> >  	u32 prob_dur =3D minstrel_get_duration(mi->max_prob_rate);
> >  	u32 tp_dur =3D minstrel_get_duration(mi->max_tp_rate[0]);
> >  	u32 tp2_dur =3D minstrel_get_duration(mi->max_tp_rate[1]);
> > -	u32 fast_rate_dur =3D min(tp_dur, tp2_dur, prob_dur);
> > +	u32 fast_rate_dur =3D min3(tp_dur, tp2_dur, prob_dur);
>=20
> This is automation-generated junk code. How does it "simplify the
> statement"?

It's worse. The "minus" code doesn't even exist upstream.

> Can ZTE slow down this flood of automation or research experiment on
> kernel community?

Please.

johannes

