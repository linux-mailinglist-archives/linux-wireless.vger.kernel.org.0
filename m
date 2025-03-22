Return-Path: <linux-wireless+bounces-20691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0332A6C92D
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3F03AFAD2
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DB199FA8;
	Sat, 22 Mar 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D2tFhDDW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E31F236E;
	Sat, 22 Mar 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638841; cv=none; b=VmQklNIRjkg55s9D0EYJXDPhgv2nD1j1/rdWkB8fnT0JqGF64H6hgS1iUp81ugZuiHUKsmOhA+OY3+GCWHaiglW6K/A/nsuyiXnR3PDzORqPLSYKXxGFQEpKzn+8wYEm2a1EkEWZmZkifp84kRUsnnZD5GwvkQSmyQ+7/viGuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638841; c=relaxed/simple;
	bh=cp1oPo7ryv0hXZ0zKZ+Jf/Cwf+XFt5t/QCZJ7lczYrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qli6/ShwRdNcDWUDYlomB5YxJalO9InekX97jy3yLXiD6ffsZw3Z5Utiy1KWOJJHhWvPHCzQsgfmDOWATuOR3uzDX4eLw/4lP7eGJN4/bj5/9bmqpXaRYiXtWnpEyfgaAnn2dWJXpXgkP7efqI0A4x6Q5u0HoNdpa5KotVdR0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D2tFhDDW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cp1oPo7ryv0hXZ0zKZ+Jf/Cwf+XFt5t/QCZJ7lczYrE=;
	t=1742638840; x=1743848440; b=D2tFhDDWj/ur6XJiPNXNpT49rQDd5Huu+Ub+r+Ikdn9vds4
	RmaKAxvLLWt0gtYAEornkgr2OJxfiHH8yvrTizuIpXAH8WzkvJ+yPisb27LJi6/2cIAQq821mWgwu
	9H1bnORqpzO0+CnNp5XIEFWMHqbIGXjFOoWlXrWUP5T5Ke/d9Kw2xAkrP2GscP1v9Gax8EbNHllHg
	mRC5ycHcA6wxhAWh/ARHyyEYV2ORP6WnHsmHV4ZFECAvOvMiQlerYXt7N4zT9JAmGdiFMoRBhrLdx
	IKX0MPZ/dqY7gaHOaCYcK1hvIW9epdwmKP/n1z0Qru8rNLBLuYxf+5Jo6WDZqf7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tvvxz-00000001vlm-17Bm;
	Sat, 22 Mar 2025 11:20:35 +0100
Message-ID: <631977c57b2236edfefb8db7a28885ff6888c823.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Qasim Ijaz <qasdev00@gmail.com>,
 	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Angelo Gioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Bo Jiao <bo.jiao@mediatek.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,  Matthias Brugger
 <matthias.bgg@gmail.com>, Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder
 Lee <ryder.lee@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>
Date: Sat, 22 Mar 2025 11:20:34 +0100
In-Reply-To: <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>
References: <20250320201914.48159-1-qasdev00@gmail.com>
	 <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>
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

On Sat, 2025-03-22 at 11:01 +0100, Markus Elfring wrote:
>=20
> I suggest to avoid such repeated error code assignments.
> Can an additional label be applied instead for this purpose?
>=20

Please stop your "suggestions" on this list. None have really been
helpful.

johannes

