Return-Path: <linux-wireless+bounces-13000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5997C4A3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 09:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61A41C21F19
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DA1917E3;
	Thu, 19 Sep 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ILMwySEk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2225383A9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729587; cv=none; b=bbcwcChoRTzu8oYfavp1RdN0XzDqjVxoklD20AOibAdJ0k9rbM1NL9MKbUsxvIt4uXzrvL3ufgqruYdfgpdZNkI4NEmF2dVoNMo1CxnahrlOeFzLlSWCFKc7LJApmKJnqGsMAd8ZfK4Ntc5cytHEGcKBY857MZYXirk+N8VNXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729587; c=relaxed/simple;
	bh=jNMlN/0gdNMwdZq7fVwvvNHKYd6/WVMzUP6n+AM1+oA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BXbX4k4pNKYkPZySnFOLna4qNT6Xprjk2cYoRPOD0XkiOchh3r1bsKp2EHFB7akX5HLeADKycJ7rggSzQp3JW41ZkMP62Zh3g6gvCbxCT3HD1c1fsQekUt9xKsSobGPFAM6MW2HECbEZyt+ay4pPQFLZdLIwfny9Le0m9OQ8pbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ILMwySEk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QAcwBEQlh8BzPu5oyXiEdaBTUkwwQtlV8qpAo1Ux/0A=;
	t=1726729585; x=1727939185; b=ILMwySEkYr9YE1WGZ5G4omfOmRpUJdLrh5h5uNc+2V1p/RO
	ftY1Tc8i1Y0PEVMUaIv/Gtll/d5RWPlHsmecNMKPD9TTxO2bOKjVppsbF4PkFgJJ2ChlBcUzzxsxd
	k/7AUZvJ4r4+R2DPsl2EDg8zsJbA7bu3CF59axLRkW7x4STWIlDWod03d+m01XZxm/CvoCEVjVwX0
	l5Ux5551ffOkXvS8elgm8rGvYslWqsbRGx05azto8ygB5Q7sPdF8hTGjbNLbe7kWEmjQ9WDEVpCGD
	zkeql08+G2ttdcrn+v1Bu3QQ+r1XaQo5C48usMgNT+oFUKhYHL5rtIQyQxDnEKUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1srBF8-00000003Qm1-0Qv5;
	Thu, 19 Sep 2024 09:06:22 +0200
Message-ID: <33ea3a62b4257b6ef789c30fa8f7bf7e9f1865b5.camel@sipsolutions.net>
Subject: Re: [PATCH RFC v2 1/4] wifi: ath12k: switch to using wiphy_lock()
 and remove ar->conf_mutex
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 19 Sep 2024 09:06:21 +0200
In-Reply-To: <20240918181042.91891-2-kvalo@kernel.org>
References: <20240918181042.91891-1-kvalo@kernel.org>
	 <20240918181042.91891-2-kvalo@kernel.org>
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

On Wed, 2024-09-18 at 21:10 +0300, Kalle Valo wrote:
>=20
> There is now a new sparse warning, but to keep this long patch simple the
> labels will be cleaned up in following patches:
>=20
> drivers/net/wireless/ath/ath12k/mac.c:6635:1: warning: statement expected=
 after label

I believe this is a compiler error on some compilers (in particular
clang), so you probably need to combine patches a little bit.

> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -15,14 +15,14 @@ static ssize_t ath12k_write_simulate_radar(struct fil=
e *file,
>  	struct ath12k *ar =3D file->private_data;
>  	int ret;
> =20
> -	mutex_lock(&ar->conf_mutex);
> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);

I don't think this is an issue here, but I'm not sure if you're aware
that in general, locking the wiphy mutex in some debugfs file handlers
can lead to deadlocks, specifically if those files are later _removed_
while holding the wiphy lock, as is e.g. the case for station, netdev
and link debugfs files. For this, we have wiphy_locked_debugfs_read()
and wiphy_locked_debugfs_write() [1].

[1] you are not required to understand how they are implemented ;-)

> @@ -4310,7 +4301,7 @@ static void ath12k_sta_rc_update_wk(struct work_str=
uct *wk)
> =20
>  	spin_unlock_bh(&ar->data_lock);
> =20
> -	mutex_lock(&ar->conf_mutex);
> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);

Baochen already pointed out that you seem to not remove this later in
patch 4, but in this patch alone you also introduce a bug (that lockdep
should point out to you), which is that you cancel_work_sync() this in
ath12k_mac_op_sta_state(), which clearly holds the wiphy mutex already.

This causes a deadlock. It's fine after patch 4:

>  	/* cancel must be done outside the mutex to avoid deadlock */
>  	if ((old_state =3D=3D IEEE80211_STA_NONE &&
>  	     new_state =3D=3D IEEE80211_STA_NOTEXIST))
> -		cancel_work_sync(&arsta->update_wk);
> +		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);

since for wiphy work it's required to ca<ll it with the mutex held./

You really should remove that comment too though, and perhaps then the
code can be simplified by moving this to the later code also handling
removal (none->notexist transition).

johannes

