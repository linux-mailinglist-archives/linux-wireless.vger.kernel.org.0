Return-Path: <linux-wireless+bounces-30280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DEDCEE2C0
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C32C63000930
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0182DC332;
	Fri,  2 Jan 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NRELpimM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06A1EA84;
	Fri,  2 Jan 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349979; cv=none; b=kWyBGo2Faoh3JOQcMG/srHl13V2Am3ZeFLqvgTXuoh4F6s2x+Q5/9N0QkfexOMaMpQRxv0+LrumbKVYf8PhExmQR9yUD1Fwc+GHbERidH8LOjoGbJsFbE0C5nNalKaMGXTByjA9uTZDQo1ytX/qeL2scOvUUTDbXD5bVC1vBGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349979; c=relaxed/simple;
	bh=l6kXVypeOatRBlDTfopoRKd5ppk99ONs5dp++awqnD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2KfrYT2YNypl2RW3tu2vjsi2XG5ofkUCzE3UjDzm3V/vwAwSdiW+lbQMNm09LlfyWis01yCoyKXIEUwoi/+Z6m6GswKiwSc/ENjXIISu7nRKDT48NcAM+S4P7zwsVGLFkbo4eDaw+9fJmlsXbC2dCE58QYYdoW2UVs1hyezQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NRELpimM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=l6kXVypeOatRBlDTfopoRKd5ppk99ONs5dp++awqnD4=;
	t=1767349977; x=1768559577; b=NRELpimMOCoIY7B87bsbuufYmBVSsC2y03TBbXtS3IhhCAa
	9G2GwL2OVt4CIYvLHT256hRivQhnstwj+MbL03qZHlUe6VDuVjCJVSDHHGK53JaOpUGZQBUe+ab6h
	RYkTDVwTuhdBFjH0opSd/AFae/Uxgb7WXO+eYjMucfobpGfDjJKxXLI1iWkcr8sYDpD/amrtpDtBj
	k4PZXqhwyX0Mt6g3U9PGt0Naf5wo/rP/LOBU59K3X/7aSp2tY+1SrLjXZdjC7M009RPetRQBpKpVF
	ZsKa9O8NCai8m68t8pcc756Yyvf5Ro1ONb2atCKjGtTkMqNzlhUjNyh7de6zGgFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vbcSk-00000001HKL-1zR4;
	Fri, 02 Jan 2026 11:32:54 +0100
Message-ID: <df4e0ec6a08ed698d433008bd1012d5964d851f6.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in rfkill_unregister
From: Johannes Berg <johannes@sipsolutions.net>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzbot
	 <syzbot+16210d09509730207241@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 02 Jan 2026 11:32:53 +0100
In-Reply-To: <27b1ec67-cb85-4673-b6f2-00003c705b8f@I-love.SAKURA.ne.jp> (sfid-20260102_112841_797862_B3501DA9)
References: <6955cbd5.050a0220.a1b6.032d.GAE@google.com>
	 <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
	 <27b1ec67-cb85-4673-b6f2-00003c705b8f@I-love.SAKURA.ne.jp>
	 (sfid-20260102_112841_797862_B3501DA9)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-01-02 at 19:28 +0900, Tetsuo Handa wrote:
> On 2026/01/01 21:07, Johannes Berg wrote:
> > If this email doesn't wake anyone up, I'll do that on the next syzbot
> > rfkill vs. NFC report I get :)
>=20
> Is the next report https://syzkaller.appspot.com/bug?extid=3Def8f802abdb9=
a32343fc ?

Seems similar and related to the NFC locking issues. I guess I really
meant "the next email I get from syzbot" :)

johannes

