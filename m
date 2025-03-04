Return-Path: <linux-wireless+bounces-19758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD523A4DD7C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C91D3A58E0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5361FAC50;
	Tue,  4 Mar 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EYrfYFgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B01FF61E
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090045; cv=none; b=CygigdJaEzj7E0ijdFbjQo9/pcgTTlGlnSO1wY/coDdtK2g1p0yPZYorbfmXYmz7ocsvY7ix478Zvhsm3w/TTSYvAH8ldIP9JPHlzsleSxe9Pd77kNCtIq3AbqRU5OxMnMtrIcMkNynIiOxW/SxyoM1NPMmxMshBglG+Lgo5GKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090045; c=relaxed/simple;
	bh=Zz/RVO+UU78p74IVuuWlzljZhOxdKKKDgn5akDCPpQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfkaPgzCxqjjeUlC/C7mTP+1UqfVKUCYKJ89/0rvc1kO9IjORBCm7IGwP37LSlIH9Dx6HVsHtYC4Saz1tDub+O5CrdcbkdImWQ3tYpBRz/379SZ9FTy7b4/iFKeqot11xHE350/76Y3oa4QNWY4xTGncfL9HJoRDts70QonmO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EYrfYFgn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fcBCAi5ZPYODtL5S1VlGHDcYX79DQdoHNVkZdP48u8M=;
	t=1741090044; x=1742299644; b=EYrfYFgnmi/Or07ONLl2VMH4Q1NEZO3RMB/aITumQedxm+h
	jP3x4j4ZuG9KKCa1Oh9bqP6M+XW/bcAbx1pOw2g62BkuXex6beklqMUUtD5LUsjJZBBpsBi/gWZwE
	uBS+DPSH3WcwYX+WavfsemLz5b3+JUKE1rc2KCG7x2NUDq7byvw+w3/q6thtkmYgHp9lwsZac9HLE
	0AJSV5mBq4DOGo9gOO/OYJNFCBaJQ/QEyKuSEqOIVMWRCCM2O5BiMh/GqQTB9qYQRLrkhW7FjHuY5
	PB8hkX9/SfDf23FYMeUH1dV+dTxje2SbWcSVXJnIo84Oa/+Qr7ncEF1r5j9bsA/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tpR3L-00000000g12-1jW3;
	Tue, 04 Mar 2025 13:07:15 +0100
Message-ID: <e558d3711868e342e63c7bce77864c587e02e1e5.camel@sipsolutions.net>
Subject: Re: [PATCH 42/42] wifi: iwlwifi: mld: enable the new operation mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 04 Mar 2025 13:07:14 +0100
In-Reply-To: <20250216111649.980c4a14b7ca.Ib58a6d779cb85a52868f7dfb5f28221f35e5aedf@changeid>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
	 <20250216111649.980c4a14b7ca.Ib58a6d779cb85a52868f7dfb5f28221f35e5aedf@changeid>
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


> +config IWLMLD
> +	tristate "Intel Wireless WiFi MLD Firmware support"
> +	depends on m
> +	select BPAUTO_WANT_DEV_COREDUMP

That's wrong.

johannes

