Return-Path: <linux-wireless+bounces-24100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA999AD9901
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 02:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C4F3BD079
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C188F5E;
	Sat, 14 Jun 2025 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YwidgEfD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691645383
	for <linux-wireless@vger.kernel.org>; Sat, 14 Jun 2025 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749860037; cv=none; b=TvDYBlV2Es2G+5kdyHeb0xZsmW9EVsR7zz8NJMpgk/dzCNqKHTjPvzLI8tAe7qiu2qtpDCszEdnSvdBiJ8IpRt1kqKbvQvkRDdi59BCHgtYsuEKZevUnm+wP0H3byWIbm7nh15jGWnbTzNGJVpW40xeMYspl5aXw3wX2CR6qgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749860037; c=relaxed/simple;
	bh=lz5v4VB05IIyWzXV7MqGKH7eTgmtYa1xhWd9FsAXHc4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=om2j4uNhnh7ixpRUDvGjfS74WBJob8masZr4itTzZATORe/okNeGVOb56cAVMAwd0pNOl4zFW46i1/63n0WDj7HQYCFL/oEhyrysflpKPXMi7/21qUL9J2wkSCLEHaLSsvDIX0mgy9zfAqgK0B2hwt5TBYJDfcCWYurAYCNDadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YwidgEfD; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1749860026; x=1750119226;
	bh=lz5v4VB05IIyWzXV7MqGKH7eTgmtYa1xhWd9FsAXHc4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YwidgEfDG2rhGdrieHMbPq4OYS+HhxBbn41ZvoNB5VRMPYHqujFwCx8D2epyDm6XW
	 /mims/MlU+og7lUjLbi1MasXRhKnue3JRsqDouy6/gzfs8ARzVs31rqsNdGFTAJPB+
	 PyyzG3yu0UsXD417mfffCptDqdxg++4FfjoQngb3fHP34O/btTplv1o3PLUJNVuZyW
	 MDPRAfBJNOrpyAImREFF3OywckUgaQxOzltoEF9iDo+UqAj/LAtS2GN35S/LkIN7wi
	 1OhW9zH/OHgB8+3fI87C1EuKIeS0b7FVo4ciknraxqWbg24dyRFI2i7kOWlOnk1SgV
	 YBnWhJvuMNF6Q==
Date: Sat, 14 Jun 2025 00:13:42 +0000
To: Julian Calaby <julian.calaby@gmail.com>
From: Noel <ncniles@pm.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [FIPS][iwlwifi] AX211 not working on Ubuntu 22.04 with FIPS kernel
Message-ID: <sgC6Rf_mm2OjvJWPRWTJbz1Ai_RAput83d9CjgBPk2MR409wHWfaG_1RXMwB5lUes2KkW7f4GutAMjuilN3WSGckdUw6pmC8P9cUYU9m7q4=@pm.me>
In-Reply-To: <CAGRGNgUzk+8CpDU6gCMNjkOCgMT1UGnO-CStqQgM7y9UEMrMDQ@mail.gmail.com>
References: <fkI_Avg3J0a2I4RUHbToL_jANN_JCZNE_5ewsXqzltTRlHZ4gjxoYbKfdDpw1ecNApjjhjqDPtHW0fegPyx3lwIirG_swt6YxkXT3yz_OEY=@pm.me> <CAGRGNgUzk+8CpDU6gCMNjkOCgMT1UGnO-CStqQgM7y9UEMrMDQ@mail.gmail.com>
Feedback-ID: 140167733:user:proton
X-Pm-Message-ID: 8521b073e6d7c8c04b9223be416870a1bbda2aca
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This sounds like a distro packaging or configuration issue, not an
> upstream issue. Have you filed a bug with Ubuntu for this?
>=20
> Thanks,
>=20
> --
> Julian Calaby
>=20
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/

After further investigation I think you're right. The AX211 only works with=
 6.14+ but the Ubuntu FIPS kernel is stuck at 5.15. I'll try filing a bug w=
ith Ubuntu but I guess it just won't work until there is a FIPS certified k=
ernel 6.14+.

Thanks,

Noel Niles

