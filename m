Return-Path: <linux-wireless+bounces-24346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380EAE3BC6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9BC3BCDC8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21223BCE4;
	Mon, 23 Jun 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="frzCpsbU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473523C4EB;
	Mon, 23 Jun 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673155; cv=none; b=mtsSUXwy+4ONJSq5/0qi66qN7/tEuA2WWUeFxr0Y2sBrTkYXatpdbdDrXTRkmBjFJr1ecVgSVE4TLuwjcTLpFimP36DmB/1uxeltIjd5psIa+v4zGcUSqXNAvpeq+CraWLPtWb5XRvV+jPcMlQ0Y5tdc/8ricsFfys5bTDWjqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673155; c=relaxed/simple;
	bh=mJsODAGPSoF3oPjRFD7iDvJ4j5DRmdr/CfzyIa7di1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjFZc6V9gg4USGwuTMOm/Qxmi4DgUAmDyGm7q0BN1f24+QrYDvbqAFaNvptlUqj8VrAru3xSFh1LShQXwicANyaaqWAR/DeMp1A5tw2yvISm4D56BI/HywIfLg2v/LONQtA2io9sVy7zAPxGPXCZ9iWd9R4oCHfrw8TBOi5oIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=frzCpsbU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mJsODAGPSoF3oPjRFD7iDvJ4j5DRmdr/CfzyIa7di1g=;
	t=1750673153; x=1751882753; b=frzCpsbUrOIkwzA7nT7piLrx5pMTd0ebf7KgbOCZ4XP99ea
	gU6a/4F4Dxi1TIpf0doaSvHN6jLJSr4k3ue83LFjWLANzSoXJyDm3yRVjsB6Md1MtpDSFbp+TlCLH
	qeDsdt5wm/1FvUzqYUCvMt/BrYEOXNX2B7vxR/MdGj+nkMUafek1l9tmkayDpCKiIR+IxrzzqupKG
	sKdT11mL6VvU/PrZ92M1HTYz305KF6nkxKBJzOv+0NdatMl7uD8kYwdu27ZUQgxRzgtFkKrDkA9o7
	XdM9B87GmRZNO1y0GaQGuoJ2Kv2gU0oXDNNTZtbVrC9wrCdjeHwgQ+9wOWqchOYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uTe3R-00000007c9w-0uaO;
	Mon, 23 Jun 2025 12:05:34 +0200
Message-ID: <aa5977435ed7de7183ed68e5767bfcc430379df3.camel@sipsolutions.net>
Subject: Re: [REGRESSION v6.16-rc3] Commit 83f3ac2848b4 breaks WiFi on Intel
 AX200
From: Johannes Berg <johannes@sipsolutions.net>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, Eric Naim
 <dnaim@cachyos.org>, 	miriam.rachel.korenblit@intel.com,
 regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org, Yedidya Benshimol
	 <yedidya.ben.shimol@intel.com>
Date: Mon, 23 Jun 2025 12:05:30 +0200
In-Reply-To: <61cae2d3-d4a1-4715-8b63-0738e9ad5353@gmail.com>
References: <1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org>
	 <61cae2d3-d4a1-4715-8b63-0738e9ad5353@gmail.com>
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

This should already be fixed by
https://lore.kernel.org/r/20250622235542.66160fc997da.Iba487b3addfad95e51c7=
d5ad79c962be3eab046f@changeid/

johannes

