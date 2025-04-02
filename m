Return-Path: <linux-wireless+bounces-21061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F4A788D0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2119A7A4B9A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8451853;
	Wed,  2 Apr 2025 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aRlB/WGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340341A08AB
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578690; cv=none; b=grT46QOUZ8rQMS/PP+hVttsCB3oSyptkjQa0ZDwewkxxpsZ4CUTqf5qmBY1bMBBFEtbIaO5IUXPJvLoAAd5MWP7QhFoVqLLnmNKLYVbDpOQYUDtWKbnefrTImKYXHCK+BhVqjTuuE1/zT80mslE1QEYcUnPCgCXHS53qJFtCmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578690; c=relaxed/simple;
	bh=4NEHoNR1U+YH6DfJR+IIsCMN1Kp3cCHF9hpnB5MIwec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/O0ZPwuAPTkQdAD4ug1G1zOu30LIczzwMmQaLtyEHhu8xdHskaWyTgWknxTY5cUXr4wTePC7gfDNBkm/aC+S/bOvkkr/9/wPpuKgQVVTLqX8o0kurPkT0IHgLSFZoWpirBYVqFVKc8iYBo8AeCuyu8PWK1241N75dgOtcA9jBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aRlB/WGo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4NEHoNR1U+YH6DfJR+IIsCMN1Kp3cCHF9hpnB5MIwec=;
	t=1743578689; x=1744788289; b=aRlB/WGomkU6ek0vdm9v2F8O+mzh2Ow5tdPleO/qKLzD09W
	sANfRPVOshb68VQcdFR8MlDZVJ+0jpxtxmByfo2wD9HMdvaF4WDPw7vpywvi4HlpWVzT7ByMZhfvE
	Ji0AOSJpENGyC/UxYEdM2a4BKStYVmXD3jgd9TRmatN50SuO1/cObRhNvZwYENwq8Hxq1QqCZy8qx
	+8JdURSr28S96hOYfbqyTqqPerVKrMG9/eT5q20k13HdIfwmF4Cxb+WNdmKuR704v/Ac61+o5y9sj
	r33t5BBA/Y9WT2rPBX1jKbsCDPylbZQb/VI0cnDO012IPv1hFEst6kye+cZshyQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzsSo-0000000DFXq-3NDG;
	Wed, 02 Apr 2025 09:24:43 +0200
Message-ID: <abf1538df6f224e38b1e42b66cc71b76c2645288.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 0/2] wifi: allow tagged control packets
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc: linux-wireless@vger.kernel.org, j@w1.fi
Date: Wed, 02 Apr 2025 09:24:40 +0200
In-Reply-To: <CAFED-jm3Ot3urZuDnYaWE1vyXuAMDvw_W7vuxUOjQtRqN-y0uA@mail.gmail.com>
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
	 <9481e6a3844f897d03f8f4bfef335092f4ac76da.camel@sipsolutions.net>
	 <CAFED-jm3Ot3urZuDnYaWE1vyXuAMDvw_W7vuxUOjQtRqN-y0uA@mail.gmail.com>
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

On Wed, 2025-04-02 at 09:17 +0200, Janusz Dziedzic wrote:
>=20
> Just do minimal imp/check and share RFC, while don't know this
> approach could be accepted.
>=20

What choices are there? What's the alternative? Go back to sending the
frames via raw sockets? I guess it works but it's not great?

johannes

