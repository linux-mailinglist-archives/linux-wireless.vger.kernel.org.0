Return-Path: <linux-wireless+bounces-172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E517FC300
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC8E1C20BA2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC741C67;
	Tue, 28 Nov 2023 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IKl5a6XW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9CF137
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BCXc20s1plcFTytV/cegq28ifk8bqegXX0VUq1tziks=;
	t=1701195802; x=1702405402; b=IKl5a6XWBjUA3EP3sy41LBrLNFIHz8UVRZjflJzTHqL3wSO
	GdVaMEKRGHEHlCyUlpaiPrH/6cmrSLpDrRq9KLQYkZohYSzlgCSLo8niLRrcJbvj5PH4kqcdQoHPY
	mpmyQNZ+s1AUdeS0pmUeEI4/3NTZkZwq3dgpZScggv10alpPhDWmo+seyi8z5GKP/IkwVWmsIVa4o
	U4sfpt0qoULnfUvTLK+cfze7vFaL9/TsDiyFfSifjYiXlNAUbxx8rn48rMCAqUDmYeRAb16O2Gr3N
	pygYlXp0txoWtoZeS9I5WwVLK76mXh8XT3mgpP3B20X/V84HXu9jbYcsbp9G9BXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r82jv-00000007bYl-2JEZ;
	Tue, 28 Nov 2023 19:23:19 +0100
Message-ID: <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Walle <mwalle@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Max Schulze <max.schulze@online.de>
Date: Tue, 28 Nov 2023 19:23:18 +0100
In-Reply-To: <202311090752.hWcJWAHL-lkp@intel.com>
References: <202311090752.hWcJWAHL-lkp@intel.com>
	 <202311090752.hWcJWAHL-lkp@intel.com>
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

On Tue, 2023-11-28 at 15:44 +0100, Michael Walle wrote:
> Hi,
>=20
> > net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> > net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound
> > 18446744073709551615 exceeds maximum object size 9223372036854775807
> > [-Wstringop-overflow=3D]
>=20
> FWIW, I'm getting the same error with the current next (next-20231128).
>=20

I actually forgot about that, but does anyone actually know what this is
trying to tell me?

The code seems to be

        if (n_thresholds) {
                cqm_config =3D kzalloc(struct_size(cqm_config, rssi_thresho=
lds,
                                                 n_thresholds),
                                     GFP_KERNEL);
                if (!cqm_config)
                        return -ENOMEM;

                cqm_config->rssi_hyst =3D hysteresis;
                cqm_config->n_rssi_thresholds =3D n_thresholds;
                memcpy(cqm_config->rssi_thresholds, thresholds,
                       flex_array_size(cqm_config, rssi_thresholds,
                                       n_thresholds));


Or does it just want to say n_thresholds shouldn't be a signed variable?

johannes

