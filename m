Return-Path: <linux-wireless+bounces-24929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE6AFC91E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57330168109
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5461C84D6;
	Tue,  8 Jul 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dvEY5MhO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B7221282
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972543; cv=none; b=eI4DXZ2IcwwcVhAT7/WQqXxAK55Am/dgE2Z5ykpVCCcILDV0pSLlDfzReQhSmGDHWuiaYbZ6QI4RMi33s8O/hIBwLdWWF2yWQVFZPz74f9CGvf4JJej6pk9vahCsHjKMaxGKU73W1H/9DBJpNR+PNJOScfFFQ1ru1o30c98kELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972543; c=relaxed/simple;
	bh=6PkQZbF6cmJhte386rbNMxvbrbYDC8G5JxkCpX+Af04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ERNys7OE0qwy4ir5fFdZ96oDaKLxqt2Dqv2ATeCiN4d/BqStpGvBlHXmXbzTO5lbepWP2v1nxZqmeeALAwidrGxjacuyt/oNQA9lw382/EyOhPG3nXZeh19xtHBv7DP6badWqF3gc5YLFTd7YiR0nbzm6eogSLh+mcZGOlQD49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dvEY5MhO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uYD8pzNjhdXACfo/o21Qea52ESe14vuOKbXvqOx6pW4=;
	t=1751972542; x=1753182142; b=dvEY5MhOJntGG/Va61VJHLvJNw2Xaq0uZOCOEy6aqG1b8Qm
	b5bKzirvEPiwd4Quy16Z3y+Gz/f5aav5AjgZPyTJJeyMb9RxShN1Mrakcoa0/6cAUilG7zQudeFcN
	NeO+kgu2T6YTrnNAH1gYbzNR1udMCYHXFtIi6+cppqutFzIeKRwTRwQ3fXfYMOELv5fpFa/YAvlxX
	O2jSZb4XLhyKgpsYQVC9rzdRktFPQX2d89pQRIbIk6VdFV/eZlR7xjV6CrpjJ+gAWmjmAuHm6gyhk
	8Cb4mj2PHDGyFL2c0Qu3N0oVnyMi89dm1TamZsRlglatY4FIwIHL0hfsAXEG3T7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ65b-0000000BpgN-0BqX;
	Tue, 08 Jul 2025 13:02:19 +0200
Message-ID: <ee3286c8e7d869b066e1f39cf7707f2186cd45cc.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/2] wifi: mac80211: extend beacon
 monitoring for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 13:02:18 +0200
In-Reply-To: <20250626160713.2399707-2-maharaja.kennadyrajan@oss.qualcomm.com>
References: 
	<20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
	 <20250626160713.2399707-2-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-06-26 at 21:37 +0530, Maharaja Kennadyrajan wrote:
>=20
> =20
> +static bool
> +ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
> +{
> +	/*
> +	 * In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
> +	 * the links.
> +	 */
> +	unsigned int link_id;
> +
> +	guard(rcu)();
> +
> +	for (link_id =3D 0; link_id < ARRAY_SIZE(sdata->link);
> +	     link_id++) {
> +		struct ieee80211_link_data *link =3D
> +			rcu_dereference(sdata->link[link_id]);
> +
> +		if (!link)
> +			continue;

We should probably add for_each_link_data_rcu() instead of open-coding
it here, even if we'd only have a single user for it now.

> +		if (!(link->conf
>=20

I pointed out elsewhere (possibly multiple times?), that this check is
useless.

johannes

