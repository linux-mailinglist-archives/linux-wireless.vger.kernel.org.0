Return-Path: <linux-wireless+bounces-24915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94657AFC677
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3854A824A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB02153ED;
	Tue,  8 Jul 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ch3f1i1o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318B29AB10;
	Tue,  8 Jul 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965244; cv=none; b=jtnuDV6LI5nLxbuBpl8EAgknPOihLaq2WUNVGlV78Q32uIwIIWab/3u9BjpchCQY5392DH/7OwUuB4prGbJOukUjDCoNsmpoGmZFeYKHO32SpVCgesh20dcS/kF59YLD6tusfezRzAoV7Jr8ssd/TTCwFfwCDfpesZJmP4mte+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965244; c=relaxed/simple;
	bh=AO8MKYY8Dg76ox7YAhRwEp6Y+8e9fQtwlhcBD+6wZH0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNZkgvf+HL+sEpjUtyPb/+AQiRRBscMUXmcK3lM2dL0vMMr+wfIOC3rMGfLo7VCGawidbPl/PYulTimSNG+Lwhi+7Tk4xMKLIOajWUr0SX0VQCQPM2Aecqvl0UPMurz8mhH8Kjj9VH2RZRKtirkLIBlsa3yC0JYpq0uF7im8ckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ch3f1i1o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AO8MKYY8Dg76ox7YAhRwEp6Y+8e9fQtwlhcBD+6wZH0=;
	t=1751965243; x=1753174843; b=ch3f1i1oeQFOqcXX6E3ssTyV2ZdPJGrQzTqNsY82fHH0qJY
	angIUz93Uq7CVKc4K9lDlDsyLBIXCWUYmVe2Q+tJuttAUrltyfh9ZTWtclMYP+258AK/TKa9mLoYy
	tkBlV2nQ3Fdebzr55gy96k/ptmkZN1n8gfUO6XdUw7CUK/Peg7QtCB+T/81+WIaSfXwUb+fguSaOM
	YOqhgNkYgZ/pzuzHlABt4jfE12ic6hHcxxrWHnZUOFaqQ2wVefSV4JiWpi2OFqmSyTfCzTsDnD8ey
	Y7C5IBsy2Vza1Ct83dLExuNeMCp/4wXcJEsjL8GDY86HdmZvC6/H+ajXLXvDajyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ4Bg-0000000BlDQ-46Co;
	Tue, 08 Jul 2025 11:00:29 +0200
Message-ID: <4d50e8de5750cd6b915f209b9d3ab26f34efda99.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/3] Allow non-MLD sta to roam between MLD
 AP links
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:00:26 +0200
In-Reply-To: <cover.1751057146.git.repk@triplefau.lt>
References: <cover.1751057146.git.repk@triplefau.lt>
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

On Fri, 2025-06-27 at 22:46 +0200, Remi Pommarel wrote:
>=20
> To fix that, the first patch of this serie does not report management
> frames with a link id (link id =3D=3D -1) and let hostapd do the freq to
> link conversion to respond. This relies on the fact that hostapd knows
> how to do this freq to link conversion which is needed anyway for the
> first pre-association scan. We can also do this conversion in mac80211
> instead if it is deem preferrable.

You should probably send patches as RFC if you have things like that.

> This serie along with the mentionned hostapd patch allowes a non-MLD
> STA to successfully roam between several MLD AP links with hwsim.

Maybe so, but does anything _else_ MLO related still work? Surely it
cannot, given you just unconditionally made it no longer have a link ID
... And indeed most of the EHT hwsim tests no longer pass, and even
crash the kernel.

Since you clearly were running hwsim tests, please run the existing ones
too :)

Also, I suspect that https://lore.kernel.org/linux-
wireless/20250630084119.3583593-1-quic_sarishar@quicinc.com/ might go
some way towards fixing this as well?

johannes

