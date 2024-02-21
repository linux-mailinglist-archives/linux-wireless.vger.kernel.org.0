Return-Path: <linux-wireless+bounces-3850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976785D407
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 10:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF1D1F26CF6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933A3D97A;
	Wed, 21 Feb 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WcA1EGKm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A33D970
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508553; cv=none; b=M8uMRzLp1ewkwsFaIlht2wJ4qF7CkkE3GH9Tr4iLd1KO8XmfuKokaKLbFQzzYmfRRLEzeqZULjEOrElCITq3CkSZKe7syK0uLxWzV9PbVw6BVuc9GPMmt8m5LM4/v7xxBeqwfeyM06G0ioC3vfmbXfHHaBQa1dnL2Ocr8BmaQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508553; c=relaxed/simple;
	bh=ImHsLWHro9bU+e7SDkZzp01u9pDizjcLNwjmPMsW94Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t23Kbi31l4OxAAdSTd4EJZlqQo0MhCT0ZkQZ+ETx7Ie7AINfXPOL2UJgUHvMvgp4bgFMMFojkcyB1C2RSd9RDRA/QWuh5mBVZSqGYzziU7wRurC+0c4qOjR74zGw8pd0whUc2FTDKOVbvIw6P3lGiZrMmmSeXZKrbvLdX1+HQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WcA1EGKm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ImHsLWHro9bU+e7SDkZzp01u9pDizjcLNwjmPMsW94Y=;
	t=1708508552; x=1709718152; b=WcA1EGKmOUvi8+NGWoZItr+FizL+TY7c5BRQCsRAur7tpSL
	TZAHZco+fRk+ZylhxkiKoAGlLNJOX2meJRBMPWQe6z+OaQ/QI0pLyFLq7nUMSgJB0rVNKPiYaYSUd
	c2pW1xfvIWG6Z7uiePzDMuAgRZLro0/yyBVFyl0Aq8CUIJcL+Id18aJJ3tN4qvRFfPySzgM8e8+KB
	pTT0fVMKlvPYofqRVrlKHVS4vkAOJjrXSZpNZLEXX4YBmLbvXoYBav5MIxMwBGpxfUiyp4ocXe3Tp
	HNhx18h8ZvnndJbiHzvm+pHatKHLofDU63RezDQCTl0MzUcZr9w8CV5KTPksUxaA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rcj7R-000000029bB-3leF;
	Wed, 21 Feb 2024 10:42:26 +0100
Message-ID: <df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@openwrt.org>
Date: Wed, 21 Feb 2024 10:42:24 +0100
In-Reply-To: <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
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
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
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


> I guess then for Qualcomm we'll need to just add an extended feature
> flag for "FW_HANDLES_PARTNER_LINK_CSA" and then hostapd can just not
> update the parter link templates, or so?
>=20
Or then again ... Maybe the other way around, since it works for
Qualcomm now, assuming it all works at all? Doesn't really matter, we
can call it "WANT_PARTNER_LINK_CSA_TEMPLATE" too and have it inverted
logic.

johannes

