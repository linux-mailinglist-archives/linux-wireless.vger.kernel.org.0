Return-Path: <linux-wireless+bounces-18512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E5A286FF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653A67A4BA5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8272288CA;
	Wed,  5 Feb 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lcz2I6Lo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A322A7FC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749154; cv=none; b=UgP/81E8mzKB0q6Ttn2grahpcUCzekNv7vNqKmihz/8qNe/ccdn9cMc5/noJzg2aRtFHPYyWi3/nZQNSeDulJyc+NxSrBjs8aUOAtwXHFC9BeAykRIQV03X8YwVSe1xapzWSqU1m49vPNhXHVWBDWYFtAH4UzMDcCdTZnSYJZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749154; c=relaxed/simple;
	bh=faM7LaUiUOle8r3D/LQXWz9r/Ik6bHq1/qwghU/Wj6w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCQ6DOptSH0IhwWBNyvn9EUpVoAcpSZy5+lPEjHTMuVOU5kEyp5z1NfP3XxISBPCez3DYt+Snlx+1K5fyai3mIyYyqN/8fd6BT8iWMlW2N9xIXF1aMTwe4U12IRmPtkSlNPiRKp+23AhldHF/sPgyVcJaXcwEPj/noKqRJffxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lcz2I6Lo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8iV6p+wqlr1UDEb3vEg8o78xDbTD4quneejDz0KLwHI=;
	t=1738749152; x=1739958752; b=lcz2I6LoXUpUP0ezmIZ5ESKNDLFGLzLClvWkniAyN/cSeUd
	BqNl3TLSt562rvXKGH8brpTaMskezcia1edivBzCLqEUNZRznVwF/tYUCCqbKr2IEAjzJ2oPfIniZ
	//+o4atQWR+j8UtYcy+G69U2G34Pjjcv0Ek9a4HAZbE7FSO0EcWtpUDXpQDuQCF22drjrfZILP3cS
	9leJMDkIIcMUOtmzFipfmB9Pt/Z+ne4Zp5QVBcqYj2kN1SZTSps7bPfv95IOxAaunCGnFiMz6x+yH
	7VcVH6S1UgAl+DgdLOBppwosVpFpJHNSj6s3bDxm07dRNsmWmWCLJdeUMdSgBG/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfc57-00000003lvf-0dUR;
	Wed, 05 Feb 2025 10:52:29 +0100
Message-ID: <8a12209c6536f1c3ba7c9be5dad4b37423e1215f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 11/13] wifi: mac80211: Migrate TX to kthread
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 05 Feb 2025 10:52:28 +0100
In-Reply-To: <20250127162625.20747-12-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <20250127162625.20747-12-Alexander@wetzel-home.de>
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

On Mon, 2025-01-27 at 17:26 +0100, Alexander Wetzel wrote:
>=20
> +static int ac_has_active_txq(struct ieee80211_local *local)
> +{
> +	int ac;
> +
> +	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +		spin_lock_bh(&local->active_txq_lock[ac]);
> +		if (!list_empty(&local->active_txqs[ac]))
> +			goto out;
> +		spin_unlock_bh(&local->active_txq_lock[ac]);
> +	}
> +	return IEEE80211_NUM_ACS;
> +out:
> +	spin_unlock_bh(&local->active_txq_lock[ac]);
> +	return ac;
> +}

Could use guard() here, and simplify that, I think :)

johannes

