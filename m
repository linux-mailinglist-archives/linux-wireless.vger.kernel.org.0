Return-Path: <linux-wireless+bounces-24878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE61AFAF19
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879DD177076
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114E828B4E0;
	Mon,  7 Jul 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AbefW8JI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5528541F;
	Mon,  7 Jul 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878897; cv=none; b=sFAeSvl+rQSsdKrtS5TTH+sGFn26lq/GXu5g4UyG4yRDyNsEYdDRCXRBdMP1ke/9iH+R0lgqyYJuLYe4bPFaq31sf3LdvLSwgDIfwzUulR6DfPuCk0j/VRjwZRkxv/xvml89uzDp83v6VthRPe3tx5Jv7yA/d5UG/uhh7DpPchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878897; c=relaxed/simple;
	bh=Zixnfrpd6DQXKxcZgGTyTEejcbmE80/hwzHYGrQh6Zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZArcHjAs8yi14QNaKiOhZFr23SSm/MDWkTPlqVvBo3OhJAoox+wphpu09KDPJe6EwEP86hFB1TY6Ovelh75xZWiWQLIbB3DxVJQgIK9/xdfvkD9iV6k3B7kpjjbeawFCh0V+EYXOs8dLe54sNwajqPALAWj4XCOXB1OqDYo2HkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AbefW8JI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1az4yu7iqOsk7/laCMEVbA5WLFs2TsRctSfdyzrGEf0=;
	t=1751878896; x=1753088496; b=AbefW8JIkx+Wu6k1bN0BZGEz+CLKCnESDIpeLyrdHN4H/zG
	w2dLCEw4hdiOCBRePvvMgxi4NMhPsYyBseFiWJWoJlzahql97B7+WPWd0YNM3PCBgfnsJxORxLKYU
	TCaxEgzD7uy616rgoFjDhKdukFCC9dQcc8BDCU/DmNpf2MUgS8NzfKRXqKdlKB6r7q7+P/O3rHH3M
	t1Q+O5BroNTKCVXS3e04nWEH+6oKk0gLApvIhkzQHrIkswsUBG4ccJxF9emISLGtotai3MAMzdu+A
	p9mc0eMpgS5PMxzk/x98yM+wIuj0wJ63wcdZLHtiYqIvMiuWO6Fz3BmhUadlkHMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uYhiy-0000000AUYl-2sdF;
	Mon, 07 Jul 2025 11:01:20 +0200
Message-ID: <8c6f18ca47bf0dd78b6675d8b94000679b6c75cd.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] wifi: rt2x00: add OF bindings + cleanup
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: yangshiji66@qq.com, ansuelsmth@gmail.com, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer	 <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka
 <stf_xl@wp.pl>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS"	 <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:MIPS"
 <linux-mips@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support"	
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Date: Mon, 07 Jul 2025 11:01:18 +0200
In-Reply-To: <20250706214111.45687-1-rosenp@gmail.com> (sfid-20250706_234116_623750_4C5D292D)
References: <20250706214111.45687-1-rosenp@gmail.com>
	 (sfid-20250706_234116_623750_4C5D292D)
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

On Sun, 2025-07-06 at 14:41 -0700, Rosen Penev wrote:
> It doesn't even compile. Added OF bindings, documentation, and other
> stuff to hopefully this doesn't happen again.
>=20
> Rosen Penev (6):
>   wifi: rt2x00: fix compilation
>=20

That was half covered by Felix already, and really shouldn't do two
things at the same time anyway.

Also please add [PATCH wireless] or [PATCH wireless-next] prefix when
you submit patches, to make it clear where the series is targeted. In
this case, you probably should've split it up, but Felix already covered
the immediate bug.

johannes

