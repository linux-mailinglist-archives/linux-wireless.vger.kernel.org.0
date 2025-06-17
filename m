Return-Path: <linux-wireless+bounces-24204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA34ADC7AF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2ED188E573
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A82C08C4;
	Tue, 17 Jun 2025 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QSN30ksR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A72DF3CB;
	Tue, 17 Jun 2025 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155076; cv=none; b=J87DvzkSoTym6NQohPJ6swmf4f85b0G3rRlAyqgq61CkP8N+QMg3jv/YYcUb6vvaXp+ezV81cHm1xDyeMywh7lo5gwbGETjsDcC3nG4Brv1MpMiT0hZILq2T1mC5+tk00rTOew5nOxHRLfZ8ZSfsZbFrJNEWHcxocoY1avAEEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155076; c=relaxed/simple;
	bh=cUKbbU/oS3Cg7lShc7Ki9J5+9Zrxia79qJwxm5GCJsY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnCFN/mAsuzSAID55b0F7SBa5vKsAMDR7m2nrvfnLRritfhKIs9OJAXzBJJnSEd4gUUZ5PttLElFLqWEsn9jGpyCV1hChclyeC5aYr0oCx+nkZhr3a5VM+DdA6GbKF+O47w+uegyndGqA1Wlux9xW/QDvQRZgkxuhHpee6pkOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QSN30ksR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cUKbbU/oS3Cg7lShc7Ki9J5+9Zrxia79qJwxm5GCJsY=;
	t=1750155075; x=1751364675; b=QSN30ksRHX52XiNxPdbhNT+9X62W5FKMYdv+ReNrXwdTlN0
	9QZvJp9qfx5LGJvXSvQwTnSgUPB5aGsjsT/TH8VM9GIwc5Ms7Z9ltOJh9wWweWffBy6TTRAlZZ8wI
	F6N6R8jxGXjHS994+S7FcVVci2embCOnuhX4rGuGDy3Nvgm4/g3GPjoVwYZt0dS79RS6Q+TESLjGc
	1xVw072k+pne4c+y98Mp8o05mSljUvlFY0WiXEmNFZzqKMtBDxbGnpWTCgBgkpxp/BJNoWwb82SwO
	qrOAhzvNnkkeJvqx1lWrL0oX1lPmvLDitUsPFaEdJrFLeoHZEE/dhFTSIPHvYweA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRTHT-0000000EGoc-3uts;
	Tue, 17 Jun 2025 12:11:04 +0200
Message-ID: <67fa81579ed1e4bf289235863eb5728b243a58ba.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] INFO: task hung in
 rfkill_global_led_trigger_worker (3)
From: Johannes Berg <johannes@sipsolutions.net>
To: syzbot <syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Date: Tue, 17 Jun 2025 12:11:02 +0200
In-Reply-To: <000000000000114385061d997d9c@google.com>
References: <000000000000114385061d997d9c@google.com>
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

On Fri, 2024-07-19 at 06:15 -0700, syzbot wrote:
>=20
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D50499e163bfa302=
dfe7b

#syz dup: INFO: task hung in rfkill_unregister (3)
#syz set label: nfc

johannes

