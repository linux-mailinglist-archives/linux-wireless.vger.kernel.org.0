Return-Path: <linux-wireless+bounces-26577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BEB3386E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F40F17F3D1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DF280325;
	Mon, 25 Aug 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Iox7DYui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77D1FB3;
	Mon, 25 Aug 2025 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109075; cv=none; b=opn0tbl4Uxo6hbgn2zIbQFrmp3OekvnGux90z6idaknoAFFyufo6pqR+mYEERyBfK5mzaZ0zBzqUs6R052c0GmekPueujAYXUoQpQa8RmjwQZuPLZKxhm9pScWnFCyInhlC6WSP6f9MYYqF/419cKaFaKiAyIGPwSlZBcwniDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109075; c=relaxed/simple;
	bh=peNwNNw8JLZDy471vYW8nsDvVgGNgANo6uUwXbjULo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOvuEOek+YWga9DpZjFoOj/31ki01ygLxYJ6zELeh79WZ7STuTdKZ2ieLUSW9W8DX9HK4HujZHd+l6WZpmKWRBJSGeQayzoE1ecVQ1xxqXQ4t8cQ+U6HkL4+jnf9YDXqplGx0ut8dgME0fNjp5MT1F82/HrM/qOUxWQ23Tvy81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Iox7DYui; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=peNwNNw8JLZDy471vYW8nsDvVgGNgANo6uUwXbjULo4=;
	t=1756109073; x=1757318673; b=Iox7DYuiHcSOFj5pRibSvYMTDqpRjUO9BRqcR4l77l3t1Uq
	J6H8cfm/ffPwaIZ9buc043YS29mKKFfeXdvfoBOWLGWeQtld6zbiJUTKdT1VXbQ6XGbfzo65dYlag
	r+Z3g6vSLPKdj5YVUA56mWF2F+1sgePS91NdnfnwN9v2L3AD1eemP6KtMoCnOtT7av+t51XCzrHGr
	uzjsGkGtSfK0x+4QtCDxh4EYqvkLHR7OAUFJ0FLkchZ5xIhA1JX42jgPeyjTbArf2iwNn04Iu5LBn
	IZu4SMlf1YgKBk1iiS4DGKhlU8MktprDxeoVC2oDtJ3kqtB1dw5hS7CeRErdbU1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqSBX-00000001avw-1ago;
	Mon, 25 Aug 2025 10:04:11 +0200
Message-ID: <3a7022fcd18fdaf98044f8a3a21b09a2f7cba914.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Qianfeng Rong	
 <rongqianfeng@vivo.com>, linux-wireless@vger.kernel.org, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>, Avinash Patil <patila@marvell.com>, Bert
 Karwatzki	 <spasswolf@web.de>, Brian Norris <briannorris@chromium.org>,
 Cathy Luo	 <cluo@marvell.com>, Christophe Jaillet
 <christophe.jaillet@wanadoo.fr>,  Francesco Dolcini <francesco@dolcini.it>,
 Jason Xing <kerneljasonxing@gmail.com>, Jinjie Ruan
 <ruanjinjie@huawei.com>,  "John W. Linville" <linville@tuxdriver.com>,
 Kalle Valo <kvalo@kernel.org>, Rameshkumar Sundaram
 <quic_ramess@quicinc.com>,  Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Thomas Gleixner	
 <tglx@linutronix.de>, Xinmin Hu <huxm@marvell.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dan
 Carpenter	 <dan.carpenter@linaro.org>
Date: Mon, 25 Aug 2025 10:04:09 +0200
In-Reply-To: <486183c0-0086-4168-bc90-1df92bfbc1d3@web.de>
References: <20250814131536.231945-1-rongqianfeng@vivo.com>
	 <486183c0-0086-4168-bc90-1df92bfbc1d3@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-08-14 at 16:33 +0200, Markus Elfring wrote:
> > Use kcalloc to allocate 'adapter->chan_stats' memory =E2=80=A6
>=20
> I find the summary phrase and change description improvable.

We all find your behaviour improvable. Go away and leave the wireless
list alone.

johannes

