Return-Path: <linux-wireless+bounces-30310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C533CEFF36
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F073001EE9
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C02F4A19;
	Sat,  3 Jan 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QblgN0iW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0635246762;
	Sat,  3 Jan 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445529; cv=none; b=jcY/SPaGGDm8ylIhpf9gYva+s9Pklj+SDbfIl/w6UHFR//0MUW/EphRQudEHYdWTrEQW7zeWwLU165uu0kV0avEuL9r9MSFKkCPJWedriYG5vRzZWbGiNyTVhD1WoIrfnQZISiuZnj8jdDr/b8S9f5qv00bJjrpU6cTX628uksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445529; c=relaxed/simple;
	bh=ljhVWlyIzpcsTEWCqtSJLtuxw6WH53rf4m2/VigWrdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mRVokD6MkgJ7eECm8zVskR041fUqHPfP+BDn3FWFlr5+jTiRnfrfvbvdMSKEk2N0GQyNZ12SyPkXxPNA+gxswikf3tgSEttvF3IbOAqY74YlogXpjR4jCYq1XuoHqAfmuvJY3QrNQVDJjOB/2NJSn8KGimaQ/RA5N+uUF+WWsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QblgN0iW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ljhVWlyIzpcsTEWCqtSJLtuxw6WH53rf4m2/VigWrdw=;
	t=1767445527; x=1768655127; b=QblgN0iW73bDkWa22VRbfapK86CrjlvTuLTuUWAutWX4dUO
	b6VrpCuvUCuqajyZioLVE2s1sJfH1m55TGwh8k9czuFCtuoibkx/VXoavGIimvM1agNRskMId4v9f
	hJq5SFP/xP9Gcp/rO5lvV9EKFsXHKA7stg9mqwV+G8TC/ZjPZrinWQTjivLJXTGWzQoXnvyl8z7em
	8MRJvLjguCWuAWrtQTAaVeFR9JcxC5lNS3umD2xdq9L7gU7ba7VvJ39kF/CAPWkC73Lp1yJu7J4GY
	X+bF0lQTf3CJq6dpO6P634R/jd7YbN+16bTcl8GwgKizpCxEGnBUaQ8I8A2us0rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vc1Jn-00000002A78-04GT;
	Sat, 03 Jan 2026 14:05:19 +0100
Message-ID: <13bd5c0903fef7d27b4af2a2e43e92a380f71968.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in rfkill_unregister
From: Johannes Berg <johannes@sipsolutions.net>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+16210d09509730207241@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, Krzysztof
 Kozlowski	 <krzk@kernel.org>
Date: Sat, 03 Jan 2026 14:05:18 +0100
In-Reply-To: <CANp29Y6NNtie6ZTsFbYUfhubEYW2A-K44B0-TZC=b3+OZcz-Rg@mail.gmail.com> (sfid-20260102_230310_438801_8E58F90B)
References: <6955cbd5.050a0220.a1b6.032d.GAE@google.com>
	 <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
	 <CANp29Y6NNtie6ZTsFbYUfhubEYW2A-K44B0-TZC=b3+OZcz-Rg@mail.gmail.com>
	 (sfid-20260102_230310_438801_8E58F90B)
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

On Fri, 2026-01-02 at 23:02 +0100, Aleksandr Nogikh wrote:
>=20
> It depends on the particular case. It should be fairly easy to do for
> warnings (where there's just one clear stack trace) and potentially
> very tricky for task hungs (e.g.
> https://syzkaller.appspot.com/bug?extid=3Def8f802abdb9a32343fc).

Makes sense. I see now that there was a recent attempt to fix this NFC
vs. rfkill deadlock issue (and this report is on a kernel before it), so
I guess let's leave it and see what happens :)

johannes

