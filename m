Return-Path: <linux-wireless+bounces-22712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA464AADFD4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E499A075A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BD28642B;
	Wed,  7 May 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KDW6XAxy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513E2820A4
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622479; cv=none; b=rRQPgEH9dOQIp/yE8odVyElA8phbKaSlDGxj/x5ywun+w79Oxpz9WH1g5vM12Ir0yiw6Un0HH2QYjIu7u4r+bZ2TirTOiur8h/zjRJeIRPPBhzR66gtK3SYXMq72zqOvTjwzD+kvOZjhXNc7wqmor05arD/ggX4OHFmAfLZ146w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622479; c=relaxed/simple;
	bh=m6wRC4CCsP0zAVMEl1/yN2Odo4yEf2R+QTQx7UFMW6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqgrRIDyK7HdVGK4ImSbNeAH3RXtwu2plvp8GpdepAz6dkunW7H/f/m+ovuWpCYjswVDOI0Y06akWRIq3jUotgJfzyCaX6RmiO4SW7Mt63IwsWGRaQG+10L9fIAl0So/0t1NRQUAHLsZW8tibCw6gqQ2us349gh865ZOU6Klh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KDW6XAxy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m6wRC4CCsP0zAVMEl1/yN2Odo4yEf2R+QTQx7UFMW6g=;
	t=1746622478; x=1747832078; b=KDW6XAxyS2zpqx9TAddPwuqDpt5cAlTE2dIk2ESjRFD3m8K
	NsWoGIiBCYGvaMwHZxsmDCKP5Hl8EDTYI2Ooi3eGEmMXiJwKzDtqoiDEu03sQjxx3sZjFEUgUzINp
	by1GYcJNVLByR/w5fMkVLshL7mRtCRea1sX7BV4olqpbOJmm7EGqFqt1vlRdoxu22Sos7ZA+UOoVF
	MrIK75nnoFX2ndCkNnOTC0o+ebSlBjeFqlQ4CB494ZZhpvhzrAdNDyp5H1LmS5qC83Joz/+KGE8Bs
	3nUgewFKPw+biXmM2TaAcNSWSuRlkQkspAkUatoHwIj/pOWn/VqYPVZH0EoEQjAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCeIE-00000007yvV-3OYs;
	Wed, 07 May 2025 14:54:35 +0200
Message-ID: <3311a7a3afac8c9b5f5e5df16dec23c33df90af4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 06/11] wifi: cfg80211: add flag to
 indicate driver supports ML station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 07 May 2025 14:54:34 +0200
In-Reply-To: <20250415042030.1246187-7-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-7-quic_sarishar@quicinc.com>
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

On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
> Currently, while filling NL attributes for the link level station
> statistics, valid_links is checked. There might be the case when
> driver offload link station statistics and does not provide per-link
> statistics.
>=20
> Hence, add flag WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS in wiphy
> structure to indicate that driver supports per link station statistics.
> Set this flag if driver supports per-link station statistics and
> check this flag while filling the station_info structure
> for MLO and while embedding the info into NL message.
>=20

I don't really see a need for this flag?

johannes

