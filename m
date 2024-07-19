Return-Path: <linux-wireless+bounces-10395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C58937B02
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22D51C21CF8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674E13C689;
	Fri, 19 Jul 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xz9jjY/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383D2F30;
	Fri, 19 Jul 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406626; cv=none; b=oAIunjBQBeiB59WcUHxSZEQoY3phJ1dib0RzhFwEfVmRuQKgPMLc3y2iE9Pdb9K1Q0qHw72EuibqNGPrrmcFBBpPqY5rnOHAlvLTJTAbi19Y93/3q8jnRqiL0TJiAJMfBaqO+LcGQ2RcB4KMyJ56KeSB4ffPUYcsylWiK58LAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406626; c=relaxed/simple;
	bh=e0NVU5/QvWmtxtTLF5jE4+fsPTL2De984G1pyVqWgCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OfQik1vUB+sERJvEzld4eKPk3l6NWwzXcikuEMyoluUApqgddgfC/a//O+bB34DeLpnS8ccrwWD8XeODTSI8rfkuvffd45JTyjuIukwHXyOTxjRNQIXN20iq56T3wvEUc/CW6HzGz1Vx97Bmv5XnRw6mTky35hf/8savaPWwfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xz9jjY/h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TYVHuHtpoWicDB96C1fux2IstVVFjuVJavo44U+S8tk=;
	t=1721406622; x=1722616222; b=xz9jjY/hrJH08tD/FooMUe8vYwacv6R2NHZCAJkcrEzooGc
	qEfoi2ztv3ARETUl7ktcS52Ddij89C6nC0ausC7kIR5bFJ1xNbZgULRn7ywrEnCDQg/TZzUd6Sco3
	DQUeBPewGwHrNEHLRWpUutI3jiyzCUcZdrsijYNTBH2pASv/sHAi5S4CIw4xj/dXAx4eym0/7bbuY
	NyBdPhBpJzULKtLm8i37hnbjURfJeMj7mgG67gMKYInz32lXiO9yFZAV6DIHI8kzxW9tPcagH8SNu
	/k81IIbe4KNGfgJD/VKOwBnWIQyl76tXazCc653WY8Z0yAq/QIrD2PHDNB7HkPhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUqUn-000000041Jf-1yxc;
	Fri, 19 Jul 2024 18:30:14 +0200
Message-ID: <c9f8412dac004da0a192376a235ced2412299fb8.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] INFO: task hung in
 rfkill_global_led_trigger_worker (3)
From: Johannes Berg <johannes@sipsolutions.net>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Krzysztof Kozlowski
	 <krzk@kernel.org>
Cc: syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Network Development
 <netdev@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
Date: Fri, 19 Jul 2024 09:30:10 -0700
In-Reply-To: <15930e85-3b82-4119-b1ef-d899ac03fa3d@I-love.SAKURA.ne.jp>
References: <000000000000114385061d997d9c@google.com>
	 <15930e85-3b82-4119-b1ef-d899ac03fa3d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-07-19 at 22:59 +0900, Tetsuo Handa wrote:
> This is a deadlock which lockdep cannot detect.
> Please check which lock should be taken first.
>=20
> 2 locks held by syz.1.2508/23558:
>  #0: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: device_lock include/=
linux/device.h:1009 [inline]
>  #0: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: nfc_unregister_devic=
e+0x63/0x2a0 net/nfc/core.c:1165
>  #1: ffffffff8f8e1b88 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_unreg=
ister+0xd0/0x230 net/rfkill/core.c:1149
> 2 locks held by syz.4.2510/23544:
>  #0: ffffffff8f8e1b88 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_w=
rite+0x1a9/0x790 net/rfkill/core.c:1297
>  #1: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: device_lock include/=
linux/device.h:1009 [inline]
>  #1: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: nfc_dev_down net/nfc=
/core.c:143 [inline]
>  #1: ffff88805ff4f100 (&dev->mutex){....}-{3:3}, at: nfc_rfkill_set_block=
+0x50/0x310 net/nfc/core.c:179

Yeah, this is a well-known issue; I believe this should be fixed in the
NFC (virtual) device.

johannes

