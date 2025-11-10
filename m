Return-Path: <linux-wireless+bounces-28725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55304C456F3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269E3188ACD3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E924E4B4;
	Mon, 10 Nov 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s58F2D9v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACC2FCBF7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764590; cv=none; b=SQotCLVVouLEwWfL3bnQhrEw1XaNRi13m/BH75Jzh06zYQ/pdIpU9sHlAA50i2duo+7pia3CiVxp7JxQLMQPBJhb9NVSrVXC0mElbP+aI1aba2TnpvKb2VzFz2/uCvQTV6tntgndiJ1f3KE/G57Mjo7a9Zr5ErvLKXxkChf2gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764590; c=relaxed/simple;
	bh=MXnD8E++6AFJS3n5NfNWW/tSGBBjtrLz1SwSaXE9LsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knO/1VF0HDrZV7Ps0VPdVjYcTAf60nEM5QTehXPBiGUCm6An4KpuOW27Wgc6yKkqGFjzckPx8dw764XbUOPfiXDn8NeDvwBulLakfI2zKJ9ujA8EY1mBkQUir5I1K90ZcGTOPYlu8yyxAGSQ8ldLxg/4A3jo2WveNzzAQU2dKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s58F2D9v; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1/pz+zC4gNj7aaveYOZM1YQ8paxzEyga6VoaoSEwK9c=;
	t=1762764589; x=1763974189; b=s58F2D9vm35/BXoXMp33gKrZIStyvong6Gezh771LoHAOif
	Bq/M967Bard6gbZQ+t3CsUwac7DbxTvZUPIymw58HPCVKLou/5J/w3jh3XyCmtX75DBPd+fT12V3E
	QucOyxZ3QN8I8JNuQSg8s6MpRseqPQMBbbZpPMd2POgmv/LemgMN32VzbONMR8ni4gaNsMMuVfEXx
	j6na7Udl6b/HlbtaHCbROhNZKybbOA7l3krf5yeJ7VBdeCzeqOa4JRG+I1cbsxu9QFVItDj4fAWiK
	Vhxvcu6cC6NcLJJUP1Hsb9Z/Ky8EJ0lR5NplW16770qoRN5QIzwQLjv/DBwc3URQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vINas-0000000B2lB-3Vdm;
	Mon, 10 Nov 2025 09:49:47 +0100
Message-ID: <8226f9acf1546d39947f06c0cc3b9cd3beb65a4d.camel@sipsolutions.net>
Subject: Re: [RFC v2 wireless-next 2/4] wifi: cfg80211: set and report
 chandef CAC ongoing
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 10 Nov 2025 09:49:46 +0100
In-Reply-To: <20251108192239.2830459-2-janusz.dziedzic@gmail.com>
References: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
	 <20251108192239.2830459-2-janusz.dziedzic@gmail.com>
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
> +++ b/include/net/cfg80211.h
> @@ -188,6 +188,9 @@ enum ieee80211_channel_flags {
>   *	on this channel.
>   * @dfs_state_entered: timestamp (jiffies) when the dfs state was entere=
d.
>   * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS chan=
nels.
> + * @cac_ongoing: true if CAC is currently in progress on this channel
> + * @cac_ongoing_time: timestamp (CLOCK_BOOTTIME, nanoseconds) when CAC w=
as
> + *	started on this channel. Only valid when @cac_ongoing is true.
>   * @psd: power spectral density (in dBm)
>   */
>  struct ieee80211_channel {
> @@ -205,6 +208,8 @@ struct ieee80211_channel {
>  	enum nl80211_dfs_state dfs_state;
>  	unsigned long dfs_state_entered;
>  	unsigned int dfs_cac_ms;
> +	bool cac_ongoing;
> +	u64 cac_ongoing_time;
>  	s8 psd;
>  };

Do we really need to track this here? Double-accounting is always error-
prone.

> @@ -34,6 +42,7 @@ static int ___cfg80211_stop_ap(struct cfg80211_register=
ed_device *rdev,
>  	if (!err) {
>  		wdev->conn_owner_nlportid =3D 0;
>  		wdev->links[link_id].ap.beacon_interval =3D 0;
> +
>  		memset(&wdev->links[link_id].ap.chandef, 0,
>  		       sizeof(wdev->links[link_id].ap.chandef));

Unneeded change.

johannes

