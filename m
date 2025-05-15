Return-Path: <linux-wireless+bounces-23000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD7AB84B4
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1813174B55
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993CEC2C9;
	Thu, 15 May 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pJco7Zhq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E8297B92
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308307; cv=none; b=eZ/fgeGcvfhpiCZOOTvlz3n4y4wm4FP+7Q+4FXbX41cB0uoU5q7JchKzOEk3sslkAz3ro0SEgdqDdqodP6W7h+mufvC/F8geKR51vBkO2uvDJR5/UbBJPpNBkGa7uIKTImcfE1+joU0y97FtsGPxQd869V0dHRGL4iqU0RVBn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308307; c=relaxed/simple;
	bh=Am4X/CRCVyGZFowxWJ/NkWvkNr6ePxRxuWmSLRT5iIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NL3aRnBjUfmxsJXKTwHbI1hbaygAhcoJnfogqQIFTvMAQeSW1X3/LqTDJRZe89K/F6o+G4KkiR+gAyERC3D5NgcX5qlVuFhmVg0wHwdlEh2HwYi7LnQS0Cd7gYAOaz38n7UoK5RI7caWy17SzrFtYr3EHZgU2TflXbG6wdCM5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pJco7Zhq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2x95oBCIwPq6A4T5RtVra6IgFhqnVQ8nXdfEF3o21MM=;
	t=1747308306; x=1748517906; b=pJco7ZhqIAswzUCWxfBI2q0kMQE5IKFFRFNzOl5Zehc+HJR
	eQdLmg24HSYg7DDA/LLYYZyaO3CCeudVMRVMtWKiio36b3ZBnV41PczQjzJj5KQuV+9IHEHT3cBKW
	bjuUcuLnvw5i/EiwXAyE1AiiU/C8gk6nkQjlksUa3xfaHfeBD+HM6B3xV/h98/BgIQuOlABxXaANg
	yhxseIfg2B9P3p4PUYzw3bsIZslUG3OmQGMxee2H/76UtQA1fRVLXRpN/1ZNhXoRyOXSXvn+M4jnb
	nj16u8xB6Jc+K+uXks4ejvq93I4dfqNM5bbx5Fs6ZYGADGvXfa8G8odkt59QLFJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWhy-0000000B67b-0qEz;
	Thu, 15 May 2025 13:25:02 +0200
Message-ID: <b36a743e6d14d81c3d613fc1e6c413010405cf46.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:25:01 +0200
In-Reply-To: <20250515054904.1214096-4-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-4-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>=20
> +		for_each_valid_link(sinfo, link_id) {
> +			link_sinfo =3D sinfo->links[link_id];
> +			link =3D nla_nest_start(msg, link_id + 1);
> +			if (!link)
> +				goto nla_put_failure;
> +
> +			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
> +				       link_id))
> +				goto nla_put_failure;
> +
> +			if (link_sinfo &&
> +			    !is_zero_ether_addr(link_sinfo->addr) &&
> +			    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
> +				    link_sinfo->addr))
> +				goto nla_put_failure;
> +
> +			if (link_sinfo && nl80211_fill_link_station(msg, rdev,
> +								    link_sinfo))
> +				goto nla_put_failure;
> +
> +			nla_nest_end(msg, link);

This seems wrong, should be is_valid_ether_addr(), and
WARN_ON(!link_sinfo), and that really shouldn't even be possible after
iterating the bitmap. In all of those cases it also really shouldn't
build the nested attribute at all. (I had made those changes.)

johannes

