Return-Path: <linux-wireless+bounces-9600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CC9180BA
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDEDB23879
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F384417FAB7;
	Wed, 26 Jun 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BH/md7+6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD721369AE
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404117; cv=none; b=HhqHjLq9d79emST3+PuznNSwePU6dYA28Hfo1vtn7aSDI2L+xFJaB2M+w6KS8i328JT4evrZ7z+Nd2E91AhaZnds3Oh1Dlbg0ftK681yGoPhHzpZqjOy8Tnf0q+0FEJTLglFEhi9Rw6tchdvsMotgFOeJW6+LjUFZJ1K6pvrAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404117; c=relaxed/simple;
	bh=GiZLAAHb8A4PR80BqeLrFF+FdYlL2rTVhDtOu2yKW+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ri9TtxUx8iwLgjNzvDolmPMKSy9PkiEyHuAtb0XS5zWYQT2GpH8gr9wH/cR5vVH5QHcFtVTfAkKX17Kks6TUAjCbsJPdHh/n1yvVsQE51gY+4lKpjGiD0bomT48jmm/ARtvj8xCR/Z/nXjyAlb6esdghQPje1Kn6lQcskzxUf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BH/md7+6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Aw8DkRfkS+S6ptg6UqyWbfnLCwtn65iOSXqRTLGjCcQ=;
	t=1719404115; x=1720613715; b=BH/md7+6MtrxIiW9AqwSwTpeKa9XXSKbz5FUOdcB+vMezSk
	an3TMRlFFjvn/zWviiGEeCTpue9noa0d2abg7lRbZM/ruKTrtkutLbKYCRjGBJn8PGi29kxxjdgdC
	Jf5JkPwDhBLLavc8fqt07l++JS60sLxORmgvbwYkK+bmpUo+hbinEPo+YqgVIcGkz8EC18TDLyY4g
	BiFh2s5A77oMlFUfkbALWP/MGJJTBGEt7zWpQu1nzlTjOHrrQ5xbvVyFvYnX6jxhqGCPXucfJeKaA
	vZnl+qHsQLRBxF+F0GU0Qdp53uo8QxW7Ea2ZflkZxSjs0s4lvz7dS7q6MrvlzlcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRYO-00000003ZhT-1NWO;
	Wed, 26 Jun 2024 14:15:12 +0200
Message-ID: <dc5f37a389d05881f2b2120e0ccbb60aa64c6490.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: allow MBSSID Tx VAP bringup without
 MBSSID IEs
From: Johannes Berg <johannes@sipsolutions.net>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Wed, 26 Jun 2024 14:15:11 +0200
In-Reply-To: <20240621074038.3938005-1-quic_ssreeela@quicinc.com>
References: <20240621074038.3938005-1-quic_ssreeela@quicinc.com>
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

On Fri, 2024-06-21 at 13:10 +0530, Sowmiya Sree Elavalagan wrote:
> From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>=20
> Current implementation of MBSSID configuration parsing mandates
> MBSSID elements for Tx BSS (index 0). However with ML link addition
> it is possible that Non-Tx BSS'es can be added at a later point in
> time after Tx BSS is brought up. Hence allow bring up of MBSSID Tx
> BSS even if no Non-Tx BSS are present at that time. Later when new
> Non-TX BSS are added TX BSS beacon can be updated with MBSSID IEs.

nit: I tend to think we should mostly use "element" instead of "IE"
since the spec changed (subject and text), except where historically we
have variable names etc.

I'm also not convinced this actually works without further changes down
the stack? Think ath11k/mac80211 for example, where
ieee80211_beacon_get_template_ema_list() is called but would now return
NULL because=20

                if (ema_beacons) {
                        *ema_beacons =3D
                                ieee80211_beacon_get_ap_ema_list(hw, vif, l=
ink,

but the list is empty.

But you can still set NL80211_MBSSID_CONFIG_ATTR_EMA so it would be an
EMA AP, and have config->tx_wdev set ...

So I don't think this can be correct?

johannes

