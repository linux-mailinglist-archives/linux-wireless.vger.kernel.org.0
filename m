Return-Path: <linux-wireless+bounces-21190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5096A7D713
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4503A170203
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB511A08A8;
	Mon,  7 Apr 2025 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="As1S7mlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06935968;
	Mon,  7 Apr 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012900; cv=none; b=raUVbauODRv0Dw84BClNBYp2qTdq4KmhzREGjqks+lqPDojgo0n/U1hIdNQO78N5stHWGyjG9zRCttrY4NbB7hEpaSry5XmFLCLYxLwL4WohvTDw8+jm0cLl5NATZTQtrvgm3jgY07rrv4XnPbbOxMgpmDg8buHMwcdQlgBrYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012900; c=relaxed/simple;
	bh=vPULkuol+Ic13d1hOHO533ytujPHPGoJFOaw2W/s/9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRLMbemcBk/oMGrl/5BtXm0ZbC5u3ZL8tgG9m7Ww18ac9K/5Xi+3ZFgOiv46DtWn2Nwyg7tDlWwVf3GAcX6Tkn2G9mwPu+NwnRgIcQWQHOrigMzuG7WMS3K3UCZO+z0/zkA4yOf8lE9WIrVdeDC79Nb5hDVaXm7K7OnGwjrKrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=As1S7mlQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vPULkuol+Ic13d1hOHO533ytujPHPGoJFOaw2W/s/9U=;
	t=1744012899; x=1745222499; b=As1S7mlQckUP5h52OwbBDzC09pZxamxT7TRhQh0rkvM5ftA
	G+7xEVeCANxu5uqYF9vToPpBUCfWt0r4AKzQeWeSKpcCORFzHUXcx8I7AjuRMDajqYv+hskCvfYKo
	LBxk0MxCFPMCpSrE5zdMhNYiFGHWiyzPlQnKkvy5/LEQftkcn/JyfgyfQfGJGga4MILPw29SVJu6E
	X+/QcWk91QYOLTQcPVBOHw2LS0Nxp3xuzSSMbIvJwmANEzxc4HtT4uK1pYQT7d6kFwqKOPmWlKNj/
	Js7l6ukgcO+TnUa/UGXa3KMyK/+ptAtjsGjib4t2oAMyViCUBlLY0EUsG+qfYxqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u1hQ9-00000002E8o-03C6;
	Mon, 07 Apr 2025 10:01:29 +0200
Message-ID: <e26c752637c133290858d4acb6e5141a51181f8a.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: Fix null-ptr-deref in
 mt7996_mmio_wed_init()
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Henry Martin
	 <bsdhenrymartin@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Angelo Gioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Peter Chiu	
 <chui-hao.chiu@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi	 <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Rex Lu	 <rex.lu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean
 Wang	 <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Shengyu Qu	 <wiagn233@outlook.com>
Date: Mon, 07 Apr 2025 10:01:28 +0200
In-Reply-To: <b429eb4d-514d-410f-8443-7e3f40709951@web.de>
References: <20250407032349.83360-1-bsdhenrymartin@gmail.com>
	 <b429eb4d-514d-410f-8443-7e3f40709951@web.de>
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

On Mon, 2025-04-07 at 09:50 +0200, Markus Elfring wrote:
> =E2=80=A6
> > Prevent null pointer dereference in mt7996_mmio_wed_init()
>=20
> Would you occasionally like to mark the end of sentences with a dot?
>=20

They did one out of two times. Go away from the wireless list.

johannes

