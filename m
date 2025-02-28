Return-Path: <linux-wireless+bounces-19589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C5A49ADA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E63A29AF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BAE26B960;
	Fri, 28 Feb 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S1iBgVYO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DD26D5A5
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750297; cv=none; b=OMHIKRJ+xqlvrQovFeHO1Ez/moHKj3OupLl2FLAAZcMdSeVWEAyCV5oMcOvjAyVCFS/fgc/uGLN4WHWSTApbpnFVrGWJIBdeOptniGg3RrO7Qn9NeAz1leksB5wc+zu13HkqfXDDaXPMDeUyT1WBbZWLqVMn8scu//QrbAVy140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750297; c=relaxed/simple;
	bh=dQU9ds8ZPymkLjIf8R6HK9Sc4tysHd7uSDtsEIDNfyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEzdfH04r6CVzpEKkpVYehNR89TGHZLGrL/qRtBM2AKEruSRJKWZo8IanWs46zYlfEUvSif0emQL4Wubw6EBT0XqFBBWFKK0XtH2WDm/mQ8s97mZNZGH7DpoXCe6gC0XZ6PG71ykLQuSdvCk3TUw+6Nh8Kkd8jchYJ/t7/n6UAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S1iBgVYO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lg5hPU/uY1qyK3mZY+dAoRZXvu9zhz0vOaPCxWh92mU=;
	t=1740750295; x=1741959895; b=S1iBgVYOVpmVTxnvScaisY3myk/hGMiiJRGyLVoRBINQXrR
	HBPSnFlM1xpuJDQS75OXQSp3w7fY3I11RyPZnbKv2I8/XNrsEGVKqBirQGM0b1UYOvSCJIwsrQh8s
	DT1C4hdGPS7VTsRkHpNj9V5ovUi1wIaee2jLPnEYH5OYlyXf8cbSy3MVocrKrFLWL+ZuqWMuvSJ5l
	A/UQa4xMr1H8UrI86Tzn+r4IE6TenyKr0J85WMqg0zVZmxmbX2qI7cqkC1WGQTb6xaf8U+SMS/5Yf
	SDy8rbjw4uIurPCR8lcI1PhqNa8ID0DIsN3kDOZWSNw9yYWgfuHkZO7ofbxpzgyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to0fb-0000000Dm6H-228K;
	Fri, 28 Feb 2025 14:44:51 +0100
Message-ID: <e38f01b2fe15902770cc11de24e82fcfed1aad5d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] wifi: mac80211: restructure tx profile retrieval
 for MLO MBSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, Muna
 Sinada	 <muna.sinada@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 14:44:48 +0100
In-Reply-To: <20250213225036.3118133-3-aloka.dixit@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
	 <20250213225036.3118133-3-aloka.dixit@oss.qualcomm.com>
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

On Thu, 2025-02-13 at 14:50 -0800, Aloka Dixit wrote:
> From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
>=20
> For MBSSID, each vif (struct ieee80211_vif) stores another vif
> pointer for the transmitting profile of MBSSID set. This won't
> suffice for MLO as there may be multiple links, each of which can
> be part of different MBSSID sets. Hence the information needs to
> be stored per-link. Additionally, the transmitted profile itself
> may be part of an MLD hence storing vif will not suffice either.
> Fix MLO by storing an instance of struct ieee80211_bss_conf
> for each link.
>=20
> Modify following operations to reflect the above structure updates:
> - channel switch completion
> - BSS color change completion
> - Removing nontransmitted links in ieee80211_stop_mbssid()
> - drivers retrieving the transmitted link for beacon templates.
>=20
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.co=
m>
> Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
> Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c         | 20 +++--
>  drivers/net/wireless/ath/ath12k/mac.c         | 33 ++++++---

This probably shouldn't come with so many driver changes in the first
place, but in any case the changes don't apply on my tree.

johannes


