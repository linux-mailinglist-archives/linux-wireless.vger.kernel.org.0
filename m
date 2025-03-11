Return-Path: <linux-wireless+bounces-20177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A092DA5C864
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCE4189ED8A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B525E83D;
	Tue, 11 Mar 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WxEF+wB0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8C255E37
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707500; cv=none; b=Qwv2E2tGxNomSjGh6paV7y0+lT2h3lRu0xeg+DDaZGRjrStBRuBema0bdcQqiY9yn6YCKoOjpd7q/rpdu3nvNsMplsNS8MlFS4u6Z+bhGYYyMnKEHsUWHQ23TY80rWZlOSXIQqscAkuapL2iP3QBzaVXbjf4Mc8xEV0lAAGH18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707500; c=relaxed/simple;
	bh=MElpULaXBYfUOo4VA5dJBEoVAixn+jzH4D/fwLs0A0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H0GCmJYLUGaRLURJM0enCJedkH3UKEByExg3MY56N2CePX02LYt8xO2RpAxr295p8dM8B9GZQT1U4nQHLzZ3eZDgoMcwzndhd8mDpCVl+MdLPusUUAJAY7fQDkX3LGK6QZMts9CJazMEMyizEE3lANApjUhkBslEeDNeTIXhNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WxEF+wB0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MElpULaXBYfUOo4VA5dJBEoVAixn+jzH4D/fwLs0A0Y=;
	t=1741707498; x=1742917098; b=WxEF+wB0zH8U2NnQ+RMF2pZ2Kp3Ug8l8JiPbeBc8/ugs+m2
	INjXdHazY17Ej+g7Y/E+gwqFeuxBWeXMMasnUGmhFKYJz4jZfUQVGB1DrzG1Cm+r9n5rPJvpsUg1F
	VS7sz1CLCp9uU784R+whuMTe589k/K16kyDaoLwkTxwPjmHFSBWVvIGht+lhpHWqo7LkwGVIxAGzC
	sgL0HrxGE5iGkqW1kWpQVtJK3lYFwM7bcAF/5O9XIKqPyFLTRC1EpR4io4dson1gyjlyEOExj72ZD
	isxMKokdGgpmUNBpZTaDK1S+SzO9BZiWXO6xQ9jMZE2zlawJda1uFKBbASnEzdZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ts1gM-00000007wqC-1x5e;
	Tue, 11 Mar 2025 16:38:14 +0100
Message-ID: <4e26e805776392e5ca8356d9ff250cad8beb63bc.camel@sipsolutions.net>
Subject: Re: [PATCH v3 wireless-next 13/14] wifi: iwlwifi: add restricted
 TWT capability
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, nerrera <nathan.errera@intel.com>
Date: Tue, 11 Mar 2025 16:38:13 +0100
In-Reply-To: <20250308231427.d58360cf4218.I08ecc8ead59e0869445b5802c13002dae99f68fd@changeid>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
	 <20250308231427.d58360cf4218.I08ecc8ead59e0869445b5802c13002dae99f68fd@changeid>
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

On Sat, 2025-03-08 at 23:19 +0200, Miri Korenblit wrote:
> From: nerrera <nathan.errera@intel.com>
> ...
> Signed-off-by: nerrera <nathan.errera@intel.com>
>=20

Umm.

johannes

