Return-Path: <linux-wireless+bounces-28726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FCC45729
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89034E9637
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF02FCC17;
	Mon, 10 Nov 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tn+fh6di"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D42FD675
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764687; cv=none; b=ZtpuOtj1SP96u4RAgUVk7c+haKukKzhnO2sdfB1ChsQtEc9tvNQLUx4fBlWobfu8lXgtdefIw2WjBeS5M+zCRtLj5oEt0oNYqYbvSYUa0RJv48r6EZwr5NuWNEM0KkYH6tolGhcSvm2i1V/qLTiszEKXESRVMDbVhhrT3iPWcxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764687; c=relaxed/simple;
	bh=raeBOOk0TTpoVB9uuSsYpg1Mnm6ZJnglXkoAzRVQfSo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQ/TdsfkFbYThY5m+J7axNDM9CiknjLtxz4SoyW18ggkJFnmZHrKuZ7XlBi/skVw6bxw679HNYz7xd+u8JskzoX2KGUl9mXA1ezfXn9yyWl8Dt0fSliWCmGAe4WsK/xYEcWamPCJe8wJDIwiXUoPCqGrWkC4xXejgizqq6KXCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tn+fh6di; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JsBg7Fomzw2hhZlYsWScf8tl2YCFk61lw45pRYIsOnU=;
	t=1762764686; x=1763974286; b=tn+fh6diVYfy3kSxC6NUqCx/zPFrpH9OGL014Fbf8BZpQG1
	X2DBffsCnKhhq7oCMPHVqzZ6L+pc+oIoEcDdfqSMV9NJYd4OISHWShEbZbSsUghvRgt+VlhRG5plp
	k2sw8xcS+Dg5r5ZRRTfiKw6VA6nqZW+IyJcPJ1QrxI/82p1FDNsqosKNbGkkgBHOTkINZUTI7C4lj
	b0dHtvXmYMOhJCW+zlM7hdyouBEG+7acbJ5l1dCno2xsNe8xkkfS6SEL+4D/OSx1O4oE3fHNvl/GX
	lMkNrfIbDvSMZ+Zn5B5wAQKfMr24ffZpfle4a2IRO0k/eWdehxEoCoybPIaiMnJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vINcR-0000000B306-3FOH;
	Mon, 10 Nov 2025 09:51:23 +0100
Message-ID: <abc1ad3e6451dfab3d67371ec18f699bd43cfe43.camel@sipsolutions.net>
Subject: Re: [RFC v2 wireless-next 4/4] wifi: mac80211_hwsim: background CAC
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 10 Nov 2025 09:51:22 +0100
In-Reply-To: <20251108192239.2830459-4-janusz.dziedzic@gmail.com>
References: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
	 <20251108192239.2830459-4-janusz.dziedzic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-11-08 at 20:22 +0100, Janusz Dziedzic wrote:
>=20
> +DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_background_radar, NULL,
> +			 hwsim_write_simulate_background_radar, "%llu\n");


Why would that be so specifically "%llu" when the input is ignored?

johannes

