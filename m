Return-Path: <linux-wireless+bounces-24128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6869ADAB5F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BF4169C8E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DFA1FDA;
	Mon, 16 Jun 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZLUKDSUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6FEAF1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064563; cv=none; b=su2VmZ0IjYhjLh2yNDeVCDkYc6jD4wqUHqihokWT2f5AO7S2YJdYJrvRCauxbF6RPCT+D8DxWh5CokSLh2zY0eb0Dhc9Tw2oj+/l1Psqucgyz8qmsCB0GZk5JkAHEojgGcqyjzP16mYgdLPdVLy+4G0DSG2nTLUVn+9L/8/FmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064563; c=relaxed/simple;
	bh=g3uup0zERDSRcyqYqJ5QQywVX1FutmemgQopbVZ9mYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwwyxFyq+4Ys7gW/9SLiar5OwM4G4pKq6k4yz7WMcdKlhSs4VQPkPGStL4UElhwkqSQGcEheJNPd5SHDbmHaJhyhQL2STU8/ea0gQn65ok3affaJBoDWVYWPbe61ioz8/62jmWdqxeqHwEuUJdFhJ96PNLK6kzp5P2f0CZV7TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZLUKDSUZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g3uup0zERDSRcyqYqJ5QQywVX1FutmemgQopbVZ9mYQ=;
	t=1750064562; x=1751274162; b=ZLUKDSUZr+/avWRorQ414ucifvmjJlAh6vSijW8WM/8JUdX
	IG477bsbZOqPHXQOrtx8iQyrTFvaMP94BLPFmyB1x8MmhyOTN0qIEOqPlesS3hQE2y6wiw8PhYqBm
	Sv9vXaDDLeiPzG9nPTka2cYT+fbgyRFTpCIWPzDf4AGraE0VQNzhJwsYWVCV7aivx9kVzhBakSSSp
	zLfeoey6Gzw7oZ5MgeWG3kXtmtOyCcA6BliY7bLCwczdD8A1xj5ixF2PGbVRfmcU4Hf90lXkzIOt3
	zCQb9ZykXup8L671xt+2id7ooPe6Gv8av2DrmHBGZ2oogjycaTpNBbw7KqWg+8iA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uR5ji-0000000Bz9u-1eaR;
	Mon, 16 Jun 2025 11:02:38 +0200
Message-ID: <6290a248adbc1208df293dc22b85fe5a33963239.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band
 capabilities element advertisement in lower bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Ramya Gnanasekar
	 <ramya.gnanasekar@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 11:02:37 +0200
In-Reply-To: <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
	 <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
	 <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
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

On Wed, 2025-06-11 at 09:59 +0530, Rameshkumar Sundaram wrote:
>=20
> While this might be appropriate for a multi-band wiphy (i.e., a single=
=20
> radio capable of operating on both 5 GHz and 6 GHz), it may not be=20
> suitable for a multi-radio wiphy where each band is handled by a=20
> separate radio. In such cases, the Mesh BSS could be running on the 5=20
> GHz radio, which does not inherently support 6 GHz capabilities.
>=20

I think it might make more sense for _mesh_ to do this, and honestly
mesh probably doesn't have much 6 GHz language in the spec anyway? I
didn't check now.

I don't see why multi-radio would behave differently, sure, something
else could be occupying the 6 GHz band but that's also true for a "non-
multi-radio design", after all that doesn't mean it doesn't have
multiple radios, it just manages them differently.

johannes

