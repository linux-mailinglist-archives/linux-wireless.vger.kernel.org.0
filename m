Return-Path: <linux-wireless+bounces-30826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2222D206CC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B48D309A5C1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31289274B5F;
	Wed, 14 Jan 2026 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aPzG76O/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B150281525
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410254; cv=none; b=SWSxDmM0AKYYqokBNlMB/dknCtdMClkgOtew3DfTaf1Gv1oU/zCblc1SCqh2XoEMNKfegoZd/CUW73XKR+8baKNgYu8y3DPJPlWjfSBlusI3Q/zQXk1lm79WxOSdD2vEHzhUsF9DbfRg5BPXXA/kbNDlP5ZjQYFnGRIaffypvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410254; c=relaxed/simple;
	bh=Ec4DHQlvQi/V6wEE2VkFG/b1EOnQMCwqjaKCmQtU/OU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pd01jJzcJoIU3dbjVHPeuC1ZGFH3d7hWqqa7X9xxZNzWC29Ik4IByII5Yh55AYflsJuVzGc4fjj5FTZXQ5/FKemVa+Wh2IgDAh8RwicbI+wXLUFGHrstnzjeLV0lx+FQ6U9gfiQ5TOUnU05TT0VCmR+KdxCkr4AsogD8Pexqf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aPzG76O/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ec4DHQlvQi/V6wEE2VkFG/b1EOnQMCwqjaKCmQtU/OU=;
	t=1768410251; x=1769619851; b=aPzG76O/D9j+Mzr6JyqNbsZpKZy1wmqhdbFpP8CnzW08fd1
	N3eXs0gRhWmNcNYBBpndACDG0WYV4bRm3UBx0duS9/BMXcg28Zlw7mvlsHmI/9pu6hNRHxq+RMVtR
	lFp8dGDk8jmzEGnLb7oWav9T7FxGx/vqzt5C7yx0KIBlkIQq7wcy6Km1lt3bu5BkoufRdAoOISQnx
	e1PqB4ZKwFGn9vNB9S0IOO9nCXYvotIa1SNYQ/n+QOPjKftA9fhG49u3higz7daj/iTxp7gancpFy
	nA4VLE1ruBHrUQ4rbHYP5yXvmnvtKhAYvkTplVeNma7ORkx4+LfmVJcmgkDMqD8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vg4Hu-0000000Bk1e-25tl;
	Wed, 14 Jan 2026 18:04:06 +0100
Message-ID: <d0798e0f62405687c57eff59767ac77b25c1f330.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce computation
 for management frames with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Rohan Dutta <quic_drohan@quicinc.com>
Date: Wed, 14 Jan 2026 18:04:05 +0100
In-Reply-To: <0847363a-055a-4d6f-a9ac-b62f275e02ec@oss.qualcomm.com> (sfid-20260109_110330_952770_DDE2A220)
References: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
	 <5ff51b07b69284ca9b477dfcbe08890167c7ed14.camel@sipsolutions.net>
	 <0847363a-055a-4d6f-a9ac-b62f275e02ec@oss.qualcomm.com>
	 (sfid-20260109_110330_952770_DDE2A220)
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

On Fri, 2026-01-09 at 15:33 +0530, Sai Pratyusha Magam wrote:
>=20
> Hi Johannes, I agree that by maintaining a local storage of the A1/A2/A3=
=20
> link addresses before mac80211 translates them to the MLD addresses=20
> would make things easy, i.e, they can directly be used for the=20
> computations in the SW crypto. While this works well for the receive=20
> path, on the Transmit path, mac80211 would still receive management=20
> frames from hostapd with the MLD addresses, which again cannot be used
> directly for the AAD/Nonce computations.

Fair point.

Thinking out loud: First, I think we can afford to separate TX and RX
discussions.

For RX, I think we agree that it could be done much simpler by
(conditionally, when we do translation in mac80211) keeping the pre-
translation addresses, and passing them into the SW crypto. If not set,
use the frame itself.

Secondly, this all seems only relevant to hwsim. Do you think otherwise?
Few drivers seem to use IEEE80211_KEY_FLAG_SW_MGMT_TX, so I think
especially with MLO we can say that you simply _have_ to support TX
encryption offload for EPPKE [1].

Obviously we still want to have hwsim, but if this really is only for
that then I feel we can still fairly easily implement TX encryption
"offload"? After all, in RX we make decryption optional for every single
frame - so if the device/driver didn't decrypt/validate the frame then
mac80211 will. We also pass the key to the driver for each individual
packet (struct ieee80211_tx_info::control::key). So doing the encryption
in hwsim would be really simple if we export a function akin to
ieee80211_tx_h_encrypt() that works on a single skb (which has the key
pointer), sets up a single-frame struct ieee80211_tx_data and returns
the skb from that [2].

While this may sound like a bit more work overall, I'm not even
convinced that it's _that_ much more, and I it would also align hwsim
more with how modern hardware works today anyway.

Any thoughts?

johannes

[1] and, it seems, correct unicast action frame encryption?
[2] https://p.sipsolutions.net/154c5c86af7765fd.txt

