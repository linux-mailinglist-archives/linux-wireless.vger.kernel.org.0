Return-Path: <linux-wireless+bounces-25971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1B7B10140
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F3CAA40B0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43686221736;
	Thu, 24 Jul 2025 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WIm5UVYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427B220F23;
	Thu, 24 Jul 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340604; cv=none; b=FkpXA1eIItO6v+xYmTB/ixK1P3Fb6l8Ya4FPRGaT6p6mjJoPz/+UsHzQwlHYVzN7m6zeVH/yjeVy5aYxZV5c1QRA4IEhkpaKRpJTUewpS7ELp/WHPND+VudBQjz1f4m2PZ6B7YhYQXdBFBhB6sr226OkQr9kdRLte1pAF8RZOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340604; c=relaxed/simple;
	bh=gYadsHpg+feIxWSf/YMoSeguhqFQt6V/x3MllKu2pXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDgtVr44AvLdu6oCbijEHPL8a0+C4haj1WbwloLAD2kD3lYJj/VALdaXLotcfu8e3wM3Ix7FS4xumXtQ6KxjSt2Yjdu6cCPGGuhvJMkWPMZWgXjygWwkchoUaeeEgwUT8s9+ScDcIvw5xhxvmktJTDYcTmhNUrhclKDtxf8kStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WIm5UVYL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gYadsHpg+feIxWSf/YMoSeguhqFQt6V/x3MllKu2pXg=;
	t=1753340602; x=1754550202; b=WIm5UVYLu1ICIptFI4U/EcThOSm27m0uTvLBhiZO5yRrmjh
	ZaQrmDuWR0fmwgRJ8WmMMZESNrcnvGlOB4CiPLpEgbLJ9KwnulD1w5tBOV8LwIrXY8JbVm7cZ4bZe
	ylMnOzm64wBWnkFWefVFQilQE6iLmO1SNkhzuhhgc9eAJoSMAecqgrwm2i7qK21iBMb4QCg/pxTy2
	loWlD47GROQuMUqxAKb+xB+wMILwWjoqcPP/c5dZ5uKK07bIM78Cgvm1iPbtMQfFAPpHpFpuDDohr
	1fT5WlMGENBukm487LFGEcafUav0HrgIScy2RhXoAJ9znPvsF1oE6i58bvxxklvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uepys-00000005CAW-2bNs;
	Thu, 24 Jul 2025 09:03:08 +0200
Message-ID: <881bf7877b72ad05098f50262e546d3cfd87fb55.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] wifi: Fix typos
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
 Helgaas	 <bhelgaas@google.com>
Date: Thu, 24 Jul 2025 09:03:01 +0200
In-Reply-To: <1d5f27a4-5407-4cf2-bd52-1ee75a4050ef@oss.qualcomm.com>
References: <20250723201741.2908456-1-helgaas@kernel.org>
	 <1d5f27a4-5407-4cf2-bd52-1ee75a4050ef@oss.qualcomm.com>
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

On Wed, 2025-07-23 at 18:41 -0700, Jeff Johnson wrote:
>=20
> Even better would be to split out the patches that have dedicated subordi=
nate
> maintainer trees (such as ath.git for the ath5k and ath10k changes) unles=
s
> Johannes wants to take this entire set.

I'll just take it, no point splitting it.

johannes

