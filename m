Return-Path: <linux-wireless+bounces-11842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069295CB5A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C917283D80
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4918614A4C3;
	Fri, 23 Aug 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Yx14l0V0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432E1E89C
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412418; cv=none; b=ZmbAV9PIpiHEBpi1tSU/8M7RdH6SwdhWYo+/XOsiFa6QdfZ7mL4Oo1TcE2OiymG21e1bQxsjp9ZEdDO73Gecqq/Az+HydmU3vcsk6QA2Jcy0AJ6/Jlgt+H//J35fUcwrYXonBLNJNYQotb3XejrDtq0ABboahQWGFQ9/Fh4zIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412418; c=relaxed/simple;
	bh=lSyJjdXA/8Ul9E0E6IACazDaiXc6qqslQ5nDxNZQT0E=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QSZbrYGUZWW5LGEE7g65Mcbv0mVbzx/TY5bd8R5iqGiScgcUIbepUkgkwgyY3eJgUnuM/YpsUN01/Ujg0grIltgKHLY7rYHnk9sQEhwupSS9Sj85ywPt4SlBSU0sPqv9cZ8a91o+fOBayc9x+Fjp6tcIyqNX9nr/MU3lbxZt0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Yx14l0V0; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
	Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lSyJjdXA/8Ul9E0E6IACazDaiXc6qqslQ5nDxNZQT0E=; b=Yx14l0V0FGjm5OEXXasit3Eeh1
	swMVf8QTtFPZEi4CUV0SYZQZ4iC/PcnoJX2haX/QAxJ4x5FT81zivGgsZa6Rpd8PsTdaI6zj0FeB1
	rg75ehlbhp5vfXt2TBaLjhqq8hilADYuA4QMos/ZYAulNkdomX6Dyk52nCcxA/TMfzEs=;
Received: from [2a01:599:10f:e176:7546:7b16:21bd:e08c] (helo=smtpclient.apple)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1shSRP-002uHI-1x;
	Fri, 23 Aug 2024 13:26:51 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Felix Fietkau <nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 3/6] wifi: mac80211: notify driver about per-radio monitor enabled state
Date: Fri, 23 Aug 2024 13:26:40 +0200
Message-Id: <47BF11DD-ECD1-4314-AD1B-B58A99724DFB@nbd.name>
References: <8b11fddca38ea82b48ebe93a898582e698069f14.camel@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <8b11fddca38ea82b48ebe93a898582e698069f14.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
X-Mailer: iPhone Mail (21F90)



> On 23. Aug 2024, at 12:16, Johannes Berg <johannes@sipsolutions.net> wrote=
:
>=20
> =EF=BB=BFOn Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
>> This allows monitoring on one or more radios while minimizing performance=

>> impact on the others.
>=20
> But why are you doing it this way? You could already solve this entirely
> with the driver by setting WANT_MONITOR_VIF and dealing with that, I'd
> think? At least after this series.
>=20
> I generally don't like hw->conf, it just hasn't really matched reality
> for years with all kinds of new concurrency capabilities. At the very
> least you'd have to write more text here to convince me that we want to
> add something to it ... :)

I really don=E2=80=99t see how WANT_MONITOR_VIF helps. It seems completely u=
nrelated to me, since it only creates a single driver visible vif, if there a=
re no non-monitor vifs on the phy.
I want to be able to control, which radios I want to capture on, regardless o=
f which vifs are already active on the same phy.
A global monitor enable/disable status means that I can=E2=80=99t prevent mo=
nitor-incompatible offloads from being disabled on radios that I=E2=80=99m n=
ot monitoring on.

- Felix=

