Return-Path: <linux-wireless+bounces-9764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1D91DEAD
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046611F23DCA
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573756B72;
	Mon,  1 Jul 2024 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SN/zTMUJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C73C6AC
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835395; cv=none; b=JfQ8kpTAvErvEpmLQOexoaW19DWW2sgFvP7LVrmfboHmKIfsJdIIOZnD5dnWwH9SKBSj2vGWdZ0ItCyIYNTARoE8E5wrw+np65aBAC2AYMwthFlO11vN6GYgLCF70N42WzmQhdtFjQEt6ZH/zrxPIa5Gk7I3Ozcp7x9jlJAY9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835395; c=relaxed/simple;
	bh=nBQ1XtoUzKQksMbDvoTLQHpUaISIDA5XpxIzkYq51fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=in6j4M9wAz1RsyTEo4Al7/YuBJNtmhC8rrt8mp8dvh32NyggazHfkodn+OBVkOW6QgerHa0Ht5UXgBZ5rDVIX7VRGe/Yjej94qfNvIv7oIi2sKyM9CSMt+GbOLMdaFd5MEEyO2KXuIkeWStfD9SN+D/N2GZQfUUrE3IxCgWtPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SN/zTMUJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QfKHlJRFYAEBrpxDl9CAmo33xozCnPkEDxyFrV/CVMQ=;
	t=1719835378; x=1721044978; b=SN/zTMUJ1LXtxcRt4cQ+sNXaR4LdXC/11OHqx+yxoBs/LIt
	QNv+tGt94qoPafHkueTOIzI90S56CWUOsqmB+ss5j1p0eV4j6uNW/+vUT4bfqw80g3s5EU9v3NvWo
	a+utwRE5z9PiearzvZ3bMNoyothODienXu7RgtZ2tA9YIifZ6fmvJE1GQ5sH0cdUc5lJyXl2hQTGV
	a8/Ru9J7+aPirzlySVzdepifDjMAKqOpy6kPHLQnj5HHCPKL0py/wkzw9Glp0x7q2y+rE9urhf1Wu
	NWHQSa9m7nPywu/KGAAaQ47TBKEGEAxffp78DCyR7TFoebimFShYkFqGPMNeq1Ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOFkF-000000025rN-1cua;
	Mon, 01 Jul 2024 14:02:55 +0200
Message-ID: <36437e815634609f8319a2be1094a19bea3ff2fd.camel@sipsolutions.net>
Subject: Re: [PATCH v2 02/10] wifi: cfg80211: add support for advertising
 multiple radios belonging to a wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Mon, 01 Jul 2024 14:02:54 +0200
In-Reply-To: <52f91e3121547ec50a9ea1fa1b7f395a96da52df.1719733819.git-series.nbd@nbd.name>
References: 
	<cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
	 <52f91e3121547ec50a9ea1fa1b7f395a96da52df.1719733819.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-06-30 at 09:50 +0200, Felix Fietkau wrote:
>=20
> +	int n_radio;
> +	const struct wiphy_radio *radio __counted_by(n_radio);

As you also found out, I realized this cannot work ... Sorry for
misleading you on this.

> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start
> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end

This should also document their type (u32) and unit (kHz), please.

johannes

