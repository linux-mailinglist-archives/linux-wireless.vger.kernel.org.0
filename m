Return-Path: <linux-wireless+bounces-13734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DF995873
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 22:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232E31F24E32
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C94215F54;
	Tue,  8 Oct 2024 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vFnILbbI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD53215F60
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419230; cv=none; b=qI656F534jKOCTLJLsjRRJqCl7HaWft6gzu5T7wSrz4nIv5yE8vxwkd72mXkL3cRndjlStF31CYJ8DgHj4GXYs8EEUVShsgirQOjzZarDhKOztZK7uPOs+W7eGLk7Gsaw2woO9An8akOX60BuAkyMrS41OYl981eeZ6t1E9BTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419230; c=relaxed/simple;
	bh=XtVL7OGPeKXcChKwFV8DXwfOv0RcbhXShIi99txHwOI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGPrA61CK2g2aiLr8hrhpK8WeT8E0r4fSp+rb0kyS51cqZfiC3pvNG/HwiqE0GGAWFG3aUZnjfgo/YVwTQCUVfDms6PyF5dup6IH3/9G+TVZJp6++AZzAAMlP3WiKQ+tuv39+QCcn7M+PEENP2zU+cQbmlooDyBZCxo67Ps66Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vFnILbbI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V1+qQxTeB9KYTAvmVkD8MpC2QDnRVdMZ4LsxqiDZejc=;
	t=1728419228; x=1729628828; b=vFnILbbIeg0gSle91vHhzrSQwHLagucH5lrDDPG3m96hevd
	1AZbHfDXC1QI9DGGbOUwyiR3dKShuiuxz3n5fzFINgdmNQq5vN6F+njraj7xE8DrdEEgPN76Zl52q
	nGJk1Khin9+n+s5ey2YYq3w613PeFNEw2OqNaycJvTSeCbxyZcO1keJabJcAi7PbrGmVFNG0UfoJF
	JTf0D6foYcVoJEMBgFnU39INAJ12g4hnBD7Z4LW0EAJ+gkehVRNwIwCfH+Bt/Ndd+WpV30ICivcE0
	ySkj1MxV4uP4epz/0ifdFn24YL+1RoUex9cB0OFHf4pFsgH9GpSARBCaRUAcBg9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syGnR-00000004NkT-3lot;
	Tue, 08 Oct 2024 22:27:06 +0200
Message-ID: <996285f760182fef33a7133752ee23e06e64477e.camel@sipsolutions.net>
Subject: Re: [PATCH v4 08/11] wifi: cfg80211: add monitor SKIP_TX flag
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Tue, 08 Oct 2024 22:27:04 +0200
In-Reply-To: <29ec5fdc9a25a6081337348b3af53b1e02adb492.1728372192.git-series.nbd@nbd.name>
References: 
	<cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
	 <29ec5fdc9a25a6081337348b3af53b1e02adb492.1728372192.git-series.nbd@nbd.name>
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

On Tue, 2024-10-08 at 09:23 +0200, Felix Fietkau wrote:
> This can be used to indicate that the user is not interested in receiving
> locally sent packets on the monitor interface.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/cfg80211.h       | 1 +
>  include/uapi/linux/nl80211.h | 2 ++
>  net/wireless/nl80211.c       | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 4dd537da0873..de6c585fb1c2 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2278,6 +2278,7 @@ enum monitor_flags {
>  	MONITOR_FLAG_OTHER_BSS		=3D BIT(NL80211_MNTR_FLAG_OTHER_BSS),
>  	MONITOR_FLAG_COOK_FRAMES	=3D BIT(NL80211_MNTR_FLAG_COOK_FRAMES),
>  	MONITOR_FLAG_ACTIVE		=3D BIT(NL80211_MNTR_FLAG_ACTIVE),
> +	MONITOR_FLAG_SKIP_TX		=3D BIT(NL80211_MNTR_FLAG_SKIP_TX),
>=20

You forgot the documentation for this.

johannes

