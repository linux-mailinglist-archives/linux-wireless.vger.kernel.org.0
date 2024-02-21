Return-Path: <linux-wireless+bounces-3839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998E85D231
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE5B21E05
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524063B199;
	Wed, 21 Feb 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KlGuwcKa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE013B198
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502986; cv=none; b=A80EVt5mQTt3L0G+YQcg8LmrK8M87QGOtQo65om4CQSQHEn004LIOhbtaRghtfgE+1Aut1bxAopLYoXnBNbYCE4lCrAbvxA/bxdWLbpkwNTV+kwtFbAd9WQglpr8EwKqCVIyNonGcCHz0LGX0+y+YAOpSME1M7rQ4OcimHgnIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502986; c=relaxed/simple;
	bh=SN/NG4vfKesvE3/4cqlGCd8CJXuP8EIOUTSfH6NnspI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/SGskeZWkfC19StOEKf8aZXcjRul/Q2wrW4tGVSOkUpbXI04c8Rk8AvEga2iRryXDkP5+WbO98OzvXKCqNdxofnlCCEI2ZHFBkqOOijv8YentNID3ZqlUgnE7Vpzx+n3YEGOqfO1zpRhqyWW/azs5x8K1QCtNUTNxW4HVcnZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KlGuwcKa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iHgA1aA1jSPE0AgHrX/IWjOPw5DKqvvBrG0Mm6iAI6A=;
	t=1708502983; x=1709712583; b=KlGuwcKa9qOp75+oLKDVe7QxU5bpcPL9Fa22psSeruRv+EN
	uXO+ApOnGqSwfiOBqJ1Hlx5JLG0rBMiPxPhK3FUAIhPuhAy9wBm+5ngr51yA81coTGde9sJiezzjN
	6tHNSbERxW3N/TIQ5x5gVeNb5sfK0wicbPlUdS1WAFCeaDCJBYzKkA1KcoI+vrgic1bWobF+aBY0v
	8uZ18oGqrabQyy081ssoFAC4zYNMehsp8ClqI+gW//DdSs079H5wYYHrILEtTSJ0mnyModrZhdjJk
	Ki5GNHYdxRFcCKcx4TXkcd6QjrZFgVKp9Vkf3YzJA7HwesxQjL/7rw73cQy7mpIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rchfX-00000002621-3tId;
	Wed, 21 Feb 2024 09:09:32 +0100
Message-ID: <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@openwrt.org>
Date: Wed, 21 Feb 2024 09:09:30 +0100
In-Reply-To: <5a89e63fb7644d12be72154c90c96199@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Sorry for the late.=20
>=20
> Realtek firmware can update partner links' CSA/ECSA by given offset of
> beacon template, which matches the conclusion of this thread, and Realtek=
 vendor
> (out of tree) driver has verified the firmware interface. So that will
> work to Realtek WiFi 7 chips.=20

Thanks!

I guess that'd also apply to probe responses? Or does it not send those
at all? But we discussed before that maybe we don't have to be perfect
there, so I guess we can find some solution to that.

So we have, so far

Realtek:
 - uses offset in beacon template to set partner counter,
 - requires host to set CSA/ECSA elements

Qualcomm:
 - copies and updates CSA/ECSA elements all by itself
 - btw, not sure here about probe responses, does it do that too?

hwsim:
 - personally, I'd prefer it works like Realtek, for less complexity

Intel:
 - not implemented, probably not going to happen any time soon, but I
   think we might prefer the Realtek way too if we ever do this


Mediatek? Broadcom? Anyone else?


I guess then for Qualcomm we'll need to just add an extended feature
flag for "FW_HANDLES_PARTNER_LINK_CSA" and then hostapd can just not
update the parter link templates, or so?

Thanks,
johannes

