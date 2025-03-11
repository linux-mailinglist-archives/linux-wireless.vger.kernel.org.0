Return-Path: <linux-wireless+bounces-20155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36FA5BDE6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C06188585B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43F236455;
	Tue, 11 Mar 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e62/HE7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527A236453
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688987; cv=none; b=mwUwBaXewc8cQFuwk2Zp4YepFh5yO92QbrDqPXp5HFd6S244s7bB/3BaiQEaf/WIAPpyh6n5LXnIzfan/jfTfeFO20E0IxZKnZ0W/lejl5vCgtQxinQgObrZ9eV6YeI7rQmoZNEKFazoRVJA4ZYsgWBwzPS5989KivDSTZ6PswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688987; c=relaxed/simple;
	bh=MxeRb+u7TAKi86t3pDvAp/LUu3YvnhuNxk3ePMSRvpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwyxE8CP7JDulHvtubtkPgH658QMwSAO1TnRbO8t6pFzqnHKZ8A1qSOPCWscsSuzqDzP8IOkwsjakegmoAWwVFmTzivvHAMi5f/EMdSbT/j7seM/i6Qq9ZXdgL/1fsjcbzDD4wJppY+V1ibTzgiJjOAKXZS659A2lyrbFw9zXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e62/HE7Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V0Ntxt71E1Xi+1JRL9zdXqqtXKsKpbbIHjZBJUzV4Bs=;
	t=1741688986; x=1742898586; b=e62/HE7Qz9qo5WX5GavbpYkdfIphVkGWEtbcxY94OVAlvio
	xDZPu68GLBbV3WPJ+TOeSEkTXqtjAsZBNEXHeIqUA8I8m6iVRJ8v0+FtQGgNnQqqhLmoDiRRuffpS
	vpIxZ4GD5uqmmzGrMcPMTqf/ETSTlLPS9yFN7gmhZ78f0XwXFiW6O83olcbQ7Y2E+vo9U4+njxK+e
	t/hHVAMO6yy/8nY6/EMTW19+OYc1KBiZe7/ODRAiefUvtGCD90tFXoybkg3Or7vG91ccJ0N5QL0C0
	PS/cXP0J4vgGT03V6MF+NsCx9DtHMiquu3zAzlMl7No/O7mqymPcT/omSy2CPtUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trwrm-00000007nWA-2RB2;
	Tue, 11 Mar 2025 11:29:42 +0100
Message-ID: <6bd5a19c9c87b671af6a0c05a47f5167d032f30e.camel@sipsolutions.net>
Subject: Re: [wireless-next v3 1/2] wifi: mac80211: Create separate links
 for VLAN interfaces
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 11 Mar 2025 11:29:40 +0100
In-Reply-To: <20250310223528.3528897-2-muna.sinada@oss.qualcomm.com>
References: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
	 <20250310223528.3528897-2-muna.sinada@oss.qualcomm.com>
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

On Mon, 2025-03-10 at 15:35 -0700, Muna Sinada wrote:
>=20
>  		/* no need to tell driver, but set carrier and chanctx */
>  		if (sdata->bss->active) {
> -			ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
> +			struct ieee80211_link_data *link;
> +			unsigned long valid_links =3D sdata->vif.valid_links;
> +
> +			if (valid_links) {
> +				for_each_set_bit(link_id, &valid_links,
> +						 IEEE80211_MLD_MAX_NUM_LINKS) {
> +					link =3D sdata_dereference(sdata->link[link_id],
> +								 sdata);
> +					ieee80211_link_vlan_copy_chanctx(link);
> +				}
> +			} else {
> +				ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
> +			}
> +

Can this not use for_each_valid_link()? I think
for_each_valid_link(&sdata->vif, link_id) should work? If not some new
macro? I don't like open-coding this "if (valid_links)" etc. everywhere.

johannes

