Return-Path: <linux-wireless+bounces-23806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96519AD00D3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51A13B14F9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4232874FD;
	Fri,  6 Jun 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T0LDODm7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960152874F4
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207276; cv=none; b=cJS6PuYBV5PMDwEF81SSBD4xB2Wi2PNuiEO6TDPiburqKsxxBnEWptyyVfT17s8UPp/84fnKl1jwR/go0I/juzkArwNhxe9Q1WsJwpNTMP1LviGGd/4mmz7u2Kpfsyem7DBLgwf0aMsoWOctCDmNEPrjDjHgHmvwIBwoCVMOdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207276; c=relaxed/simple;
	bh=Y7OolsX2yy0vS6SP9fPeVEaYLolGWQa3jMCS8TtLc4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCvTiguJv10/T9CCTvCd+d4mlCX27LJnjO4QyHmMspf0BEOFCvNr0hy3ENzebGVcN0OQaeAe0dDBGkLax+8/hkrFNtYb3B18itL+gSBrzh0thTAEHy370eOWcwVVujlR4Gpigu1RnbijyNUfFIwWyNXAoK77jtkhJ7eQcCW3mbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T0LDODm7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y7OolsX2yy0vS6SP9fPeVEaYLolGWQa3jMCS8TtLc4Q=;
	t=1749207274; x=1750416874; b=T0LDODm7Vhjoi/G19QjjEgX2H+NGwpVo3+QLICYCiNhT4XJ
	yTkf2t98m2DlVEQx1sZpiv/AVkOJ9AJrKE5dJ1lXQKsfuQu9e+JIuGwRRR4Vi9P53q6rIkuZNtRDS
	uOUArZMKaoKOkL0KQWn3pNnxFb2RfmCt9oOq7qJlrE+Eo4ZvMG3EMQYOUfy9hmFYP2xXx2ODp5kF5
	x9QLoPWR0fn1mb3SY4hLjqP5uZLChJToYujSo6sJcmD5nMcl4Pyzcqkq+gHtMUzuraXttWL4u6zuv
	x1YcyXf6S1B1g1izz9n15gVUr3KwMFxdg7ZIxHSbWpb7U/FXXEpVK4/+nLhdXYkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uNUiP-00000007wkJ-20h4;
	Fri, 06 Jun 2025 12:54:25 +0200
Message-ID: <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band
 capabilities element advertisement in lower bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Ramya Gnanasekar
	 <ramya.gnanasekar@oss.qualcomm.com>
Date: Fri, 06 Jun 2025 12:54:24 +0200
In-Reply-To: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
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

On Fri, 2025-06-06 at 16:14 +0530, Rameshkumar Sundaram wrote:
> From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
>=20
> Currently, when adding the 6 GHz Band Capabilities element, the channel
> list of the wiphy is checked to determine if 6 GHz is supported for a giv=
en
> virtual interface. However, in a multi-radio wiphy (e.g., one that has
> both lower bands and 6 GHz combined), the wiphy advertises support for
> all bands. As a result, the 6 GHz Band Capabilities element is incorrectl=
y
> included in mesh beacon and station's association request frames of
> interfaces operating in lower bands, without verifying whether the
> interface is actually operating in a 6 GHz channel.
>=20

This is not incorrect.

johannes

