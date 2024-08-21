Return-Path: <linux-wireless+bounces-11755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D215195A3C1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC1A1F214EC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254781494D1;
	Wed, 21 Aug 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yRfk3/aZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AF1B2EC5
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260811; cv=none; b=QTI4nKLHLmMdgfZF+W9xt0XQg4IVWnSjWxzggJLjKuBL1fKU+cdzw+9ve21zqWha9/Whk1a/IgLBdIcX3UDP4I3nZ7B/gVutj/5+3yXGZzN0vKA6MXPX8pb5HWrKgAfyb4xhZQ7K8I2vu4US1qCqfkoaRGp4aQ2fMptjTlTvAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260811; c=relaxed/simple;
	bh=X0fRHqAIwPrPoseC/nVXINOpetMAuF+hvY/6MX6iIWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKNZ+jbzCe0IdPNfnZ1SzwkNY9463bJY1XRhmvSpikDKzscUoRHYUnWkUeq6D6hF+jJxD/xJTcCxpJP2Aw34qEhyvqEJ+WpDUyB6PDZ9gYdPxMJo/mhntyBxDZiaKeBr26JuG7Y+8eVOU9RJAcAXd/SqsV61QpiMzlkURrvGvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yRfk3/aZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JrSqzDct6naNhYKkMWoPVa7Redj5XZraa4GKg9pZnL8=;
	t=1724260809; x=1725470409; b=yRfk3/aZ0W6H8uJ+FmZfzUnvfZOuENi/y0WVsujYOf9x9B7
	mcSYSAUGode2k54hLadcE5Tj0lm0eW8WGbfkc+jcmXBOM12/iyiuh3Q73QfLbTarQJ/VjjMnNYZUK
	EdzIRN4Flnhv00Z0WtBglG2FtxmN3KLMuOW1QtBGIvI3D2k72FOV5/3bVg2FSKs7ajuxAbdJJysYK
	XOfh3tYHJmBqoDbmQ1DhDQDo0vo2cAF9UCxoxdt/eUWmacu/HodBUYNCJPT32XL4s7DN7YSN7del/
	Y+aQ4spHFQ0TyQ15zL+yJ1MHEtWmb90n6i887+F+jh0zCi6AlxbjZLH/CHFNYOzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sgp0A-0000000BDCq-1sxc;
	Wed, 21 Aug 2024 19:20:06 +0200
Message-ID: <1605f1b7d2267444370af84c37a3856f6b158c71.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 2/4] wifi: ath12k: cleanup unneeded labels
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 Aug 2024 19:20:05 +0200
In-Reply-To: <20240821153728.2121600-3-kvalo@kernel.org>
References: <20240821153728.2121600-1-kvalo@kernel.org>
	 <20240821153728.2121600-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-08-21 at 18:37 +0300, Kalle Valo wrote:
>=20
>  	/* TODO: Recalc radar detection */
> -
> -unlock:
>  }

I guess this is the sparse warning, but I think this is an error at
least in clang without removing the label or putting a ; after the
label, so you might want to fix it in the same patch.

johannes



