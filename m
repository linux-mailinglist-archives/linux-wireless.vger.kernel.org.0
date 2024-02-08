Return-Path: <linux-wireless+bounces-3337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BB684E2CA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 15:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048051F2422C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654EC768E5;
	Thu,  8 Feb 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GDaLk2GR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722E7640C
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401130; cv=none; b=Pi5efTs1DfmDmE9slgfuKlY8fggolfjHN9sStNDlhO/P78VNXlN1NPMMU/l7cfaLGN1LBnuRUvHzl96V0Uxq7KEVNQfJkZ02/gkC2qiP+G6g+UF0/Wva0eikRGIJ2V3DKSDfLZ2NjVEnasIl+0jL/Rb1QE10jHhj2kJ6JtgX+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401130; c=relaxed/simple;
	bh=UUcXPuhgiNVUCdZOaqlo0TbkZ0D8b9eMPnr0WdaE684=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ca6nZ1Q3xCRRWdS724LdB3ZXaPtL8e+9q120ncruE3hG0qhm/5ufMocepa8GAxBZLEgdEV1MMyNXkE8McfhvWGy1gvPYChDUaIR66XL4Oymlh6SIVqF2MzJ/a/k4d+XYQ/lxEbT0WMbG9QEnJpQ+tvLhQQP/qpgCbZSXvGqBcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GDaLk2GR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UUcXPuhgiNVUCdZOaqlo0TbkZ0D8b9eMPnr0WdaE684=;
	t=1707401128; x=1708610728; b=GDaLk2GRykjL+ljdVXZLDHwtisvjHoQZ9y0R1MtIC272dga
	kN2TiQPQsrV8B8xWfiDnbqxGnDgptjQNbzZ2/jmXXxhYe+YuawPlvbNBRzr797Mo9nLuWZyoLTucm
	3NGtQeV28tbgPEWO2ixuu2F9BqOPRYUb6rYViUPmdBFnPnNKUsaL7FJD/mCQ4TH9xTnh/oxZVEKl+
	K5IWNmTV59v7M+VTd5XEvYIBuYka4ClzIpWV2qpWHAqhGDEsXar0h41Fq7cKtO9ogKYJ9mP3MJF1m
	J8zsxk1sicO53vhitav+93nwPllcrqwZMZmIgyZEUb7z5hUHpKKSlvo16e//onTQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rY51o-0000000HVfa-3dHF;
	Thu, 08 Feb 2024 15:05:25 +0100
Message-ID: <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 08 Feb 2024 15:05:23 +0100
In-Reply-To: <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
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

On Thu, 2024-02-08 at 14:48 +0100, Johannes Berg wrote:
> On Tue, 2024-01-30 at 19:39 +0530, Aditya Kumar Singh wrote:
> > Add changes to start a channel switch as well as finalize it on link ba=
sis
> > in order to support CSA with MLO as well.
> >=20
>=20
> FYI, this had a number of conflicts with my other work - please check
> the tree now.
>=20

Also here btw, some hostap test with hwsim would be nice - though again
don't know how well hostapd supports all this yet.

johannes

