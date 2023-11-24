Return-Path: <linux-wireless+bounces-65-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E007F83E7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2746EB271EC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5A35F04;
	Fri, 24 Nov 2023 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XmXVFFZo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E99172A
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8DIHyweclQbJ4h5g+XKByqFNpo3ZcJDyd/ewovAteKY=;
	t=1700853425; x=1702063025; b=XmXVFFZokTQtQdYFa0UCtOCTM7F+tQ3ol90TruVfkpccExJ
	KT6etH+N0QvJb8SmWWkyBvteUBe8jO1XsxNzpSo3TdHiZYZ6mpxC2pEgxJ96YfWiXrXKqKMqT1fcn
	75vChzwNA1iOwT5UkbIDPxUzwWhQuOY171cVkbOU3ZLWVKWWTA7tMDP7cmqgmwTVUndWd5ZJ4pq/G
	yYqZU6I0hYMXU3xPhjVQPQM/HebUm96vvURMNRCNtDA7mL5yBC6LslHdl0Yzqy3wR8K+CcmI1CKFv
	IBO5A+5douIA2t380vu7baSag3tpnEYPynUrhVOZoXZihTjfwaXvAoon1cHqJLBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6bfi-00000002jot-4AiG;
	Fri, 24 Nov 2023 20:17:03 +0100
Message-ID: <feeb5fc1ec52fb7bb85f9242d351bf6ff44b315f.camel@sipsolutions.net>
Subject: Re: [PATCH 6/6] wifi: mac80211_hwsim: Add custom reg for DFS
 concurrent
From: Johannes Berg <johannes@sipsolutions.net>
To: gregory.greenman@intel.com
Cc: linux-wireless@vger.kernel.org, Andrei Otcheretianski
	 <andrei.otcheretianski@intel.com>
Date: Fri, 24 Nov 2023 20:17:02 +0100
In-Reply-To: <20231113112844.560597906f17.Ic285ca7a4728e77a4bea1394a6a52cf286fbea22@changeid>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
	 <20231113112844.560597906f17.Ic285ca7a4728e77a4bea1394a6a52cf286fbea22@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-11-13 at 11:35 +0200, gregory.greenman@intel.com wrote:
> =20
> +static const struct ieee80211_regdomain hwsim_world_regdom_custom_04 =3D=
 {
> +	.n_reg_rules =3D 6,
> +	.alpha2 =3D  "99",
> +	.reg_rules =3D {
> +		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
> +		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
> +		REG_RULE(5150 - 10, 5240 + 10, 80, 0, 30, 0),

Didn't you say that could be 160? But that'd need merging with the next
range or auto-bw.

> +	/* TODO: Add param */
> +	wiphy_ext_feature_set(hw->wiphy,
> +			      NL80211_EXT_FEATURE_DFS_CONCURRENT);

Hm, yes? :)

johannes

