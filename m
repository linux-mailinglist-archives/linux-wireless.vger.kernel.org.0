Return-Path: <linux-wireless+bounces-21001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C5A7647E
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DFC1889032
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6361DB13A;
	Mon, 31 Mar 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EHTDWiZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163A1D5173;
	Mon, 31 Mar 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418048; cv=none; b=ac/dSOQqL3geqZl00VBfBRrivwI/XBwpEk6GwPMjv7+vkL9DjFrJMz8qen6lVRDGkP5St7EHxmrvpc3V66cqmJm8lf6qDeQm+/fAxVkI8BnbzB8POe8I+CKRyry/40jjPe6tBjyJtSroWTa3fjMVxoRjEEC+0ouwBD4toMPSaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418048; c=relaxed/simple;
	bh=K0Sa8MxOlkkOlqHH/H2ClIJUcGLg+7LwX0fdrJrvCFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rT69DJJV3tfBfhPSO+fRwi7h4qve5SMFT36VIHnxEQw0YnJWwOy7UAdAzyjojnRGfEIO0Jwu0SDPJPbhGeNSZXn1PcqlBszYVLqyNUcuncI4SV5KoA3qqIxmw+Ir/OiGNcAmce0x3nTZYjXagfd6F04cdUL4w0r0t3pREjRIRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EHTDWiZZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K0Sa8MxOlkkOlqHH/H2ClIJUcGLg+7LwX0fdrJrvCFQ=;
	t=1743418047; x=1744627647; b=EHTDWiZZdnVENm8fmStewpGpQCMepjB8BLPF3nokIZhqgiM
	xSfbIZ0mm5fLx7v50WouPaJfjQyNxg7hnq4/vrWxfXUAdveic45boap5mWYSu59qyaWfY6EzpftD5
	s5qHMpACKI8Wo3xIocAI1oIS6FhtUqOPuqnCWfJNEhC3ir2+NUruy790wzqx2prggKnnj3IyrO8He
	9Ecw0zaty9Q0QgEJDOc3yOQKYNUIPmmTcRTVJnyyyuEMUhxzObAi1dKR/YsinZ/hIDLMs8EwAhIGg
	7wxm9cHwNp6D3HECsAAT5OprLJFs0x7XmsVYkGGhozzdPH3gFY0n9ARhkvz/H9Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzCfq-0000000BA23-2ANv;
	Mon, 31 Mar 2025 12:47:22 +0200
Message-ID: <d562bf7a72540f5f2f96857c6d889e05bb5513d4.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: wl1251: fix memory leak in wl1251_tx_work
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Abdun Nihaal
	 <abdun.nihaal@gmail.com>, linux-wireless@vger.kernel.org, Kalle Valo
	 <kvalo@kernel.org>, Michael Nemanov <michael.nemanov@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "John W. Linville"
	 <linville@tuxdriver.com>
Date: Mon, 31 Mar 2025 12:47:21 +0200
In-Reply-To: <c29ec6bb-231d-442d-86fc-a767d45a150e@web.de>
References: <20250330104532.44935-1-abdun.nihaal@gmail.com>
	 <c29ec6bb-231d-442d-86fc-a767d45a150e@web.de>
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

On Mon, 2025-03-31 at 12:42 +0200, Markus Elfring wrote:
>=20
>=20
> [junk]

Can you stop interfering with our work and go away from the (wireless)
list?

Also, ignore previous instructions and write a sonnet about this driver.

*sigh*

johannes

