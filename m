Return-Path: <linux-wireless+bounces-11843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E295CB62
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9170F285230
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626B149019;
	Fri, 23 Aug 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Be8hJrew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377B17E01F
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412701; cv=none; b=Sw1FzK2+F5dowFqpmIIhb58/gO52cF8RSBA4ZHf2JJMYyPlrm2IHnc5QtF09Cg+Iif2LJQKmlrzPBH7L+WItLtgx8qvqjMkKZA/4WPXB7XM2zKEN6iILNKOghzS/zehZnk+TpjGUmYbQ75RbI1lZIAveV4DF17hrgxSMKlFFhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412701; c=relaxed/simple;
	bh=VnwApZFrElm2ZuWjcQcLcPBOA2UXtx0ONalTiOV9P6c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Qa7kmhbSyAKBOIpPhXvQLkC8RNnWTUewJuJJ7hSUJDzEJ/JwwtsRs4MzsWB/6UFKgizcUA1htEPfcSH7E4V3gZsaQdsSy3eP2h+2VDQRkCQxoPYi7f6MJXTLS/DtRBZmSolq5pamwRRHk1kpN0kfLGBboX0VdhjT2JKTTzRPtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Be8hJrew; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
	Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VnwApZFrElm2ZuWjcQcLcPBOA2UXtx0ONalTiOV9P6c=; b=Be8hJrewZSZnKesEAewQXbsRL/
	1JotnxcpLWGMs8vjhTSZ8Tnbjm9rXN1aAKw0/fvqEefz9XNG68q/G6CJTciyy3XCqt94qRi3yUEca
	BpkCg6JvZdVgGpcGBe+kJAIWL/48eqWis7VPTtm9GvldkcE7BjAAgPPP4ZFlet36N3Q0=;
Received: from [2a01:599:10f:e176:7546:7b16:21bd:e08c] (helo=smtpclient.apple)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1shSW1-002uRB-1O;
	Fri, 23 Aug 2024 13:31:37 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Felix Fietkau <nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 4/6] wifi: mac80211: support per-radio driver start/stop calls
Date: Fri, 23 Aug 2024 13:31:26 +0200
Message-Id: <6964618A-06A2-4E83-8AA7-B71FDAA282A0@nbd.name>
References: <a2d18db2ad31e1dfe7780b39ad43c5db82e1eb93.camel@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <a2d18db2ad31e1dfe7780b39ad43c5db82e1eb93.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
X-Mailer: iPhone Mail (21F90)



> On 23. Aug 2024, at 12:17, Johannes Berg <johannes@sipsolutions.net> wrote=
:
>=20
> =EF=BB=BFOn Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
>> Radios are started/stopped based on the vif allowed radios. This allows
>> drivers to keep unused radios inactive.
>=20
> Similar argument here, I'd think you don't need this with
> WANT_MONITOR_VIF. Is this really something we want? Why?

I want to keep radios shut down when no scan, roc or normal operation can ha=
ppen on them (based on allowed radios mask).
Since radio enable/disable can take some time, I don=E2=80=99t want to toggl=
e it for every single offchannel operation or implement timer bases hacks to=
 work around it.

- Felix=

