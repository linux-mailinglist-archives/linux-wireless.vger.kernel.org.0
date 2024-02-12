Return-Path: <linux-wireless+bounces-3453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF18513DD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A9CB20A32
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C983A1A1;
	Mon, 12 Feb 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NGNk4kaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC53A1A0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742527; cv=none; b=q68XKrk+HN8Zp05Hee7RR9WEF7pByJ775H0PIUmaqNC/qPoeo8SfVzZ5LLrY5Z6UfaU5sVMIJ6WXfnXD/D/lELCnorUqoUrSeQWPrjSV/vYSVg99e4sp8eWyRSDG+n5/dGkHrxVwKil5US7BuExqTh8/MWm29DhyhrxT58248v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742527; c=relaxed/simple;
	bh=NcyMvNvcyCTlI+VYDF284bR9WOBwngEFgLv0/nu+Njk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxQ2uOuLI+iQmciYUdDQLhHKaDGAagY2eT7D/g9crTmwN9KhJiqS1hIJOwVszYHFcCAXODEYnnXLZRHqKER8LAiq22JdDWSLaiAEde8qjKws/AljKqIoQM9jJDb4szRBiV14SIeIgCCGTTQAzOQWNmAI0zr/3iArSRS9vOD/4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NGNk4kaA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BVdXI0ZB4vehiyivEttDZJn3E2Jxr6cD7AWAF2Ejtok=;
	t=1707742525; x=1708952125; b=NGNk4kaARZEGQ45ZYKTDxWyWzp6TrdQaXF5mEvmQZVevA3V
	j1/sGiOak9+rfDiZMoldZ2CZJmU/RD3tCWmzLMGLUOy/e84OOnrfWTEIT3zBPVFyUbOIGWldGxkan
	43Qb6yANt2PPFRovgnjjjLSde7Uq/wLyrqrNDwUR5qS689QvoUlSbdMaUBJRrwh8P7b/hNMuMmy1h
	LeLiu8A35pmUPn7YR9/WjT4Y9u/KR66ZzqdjH1n9Pvm7BGMJ94XGLlsDeTLSA+3AlNjtpE6sI5JFr
	H9toX+bJl1KLwEsau5KHCX+p0VcUkvJBqasPVrth4FsIpfkgiSg60F706bKLqnYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZVqC-000000066Hd-0w52;
	Mon, 12 Feb 2024 13:55:20 +0100
Message-ID: <c6192c28d7d30198b8b53f89a06c0c37d4ab9d0e.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] wifi: cfg80211/ath12k: Add support to rx retry stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Hari Chandrakanthan <quic_haric@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 12 Feb 2024 13:55:19 +0100
In-Reply-To: <20240212121616.3683197-1-quic_haric@quicinc.com>
References: <20240212121616.3683197-1-quic_haric@quicinc.com>
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

On Mon, 2024-02-12 at 17:46 +0530, Hari Chandrakanthan wrote:
> This patch series adds support to count station level rx retries.
>=20
> wifi: cfg80211: Add support to rx retry stats
> wifi: ath12k: Add support to rx retry stats
>=20
> Tested-on: QCN9274 hw1.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1
>=20
> Hari Chandrakanthan (2):
>   wifi: cfg80211: Add support to rx retry stats
>   wifi: ath12k: Add support to rx retry stats

There's trivial work here to expose them from mac80211, so please do
that. Also not entirely sure then why you need it in ath12k, but perhaps
if it's already done header conversion?

johannes

