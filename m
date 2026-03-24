Return-Path: <linux-wireless+bounces-33781-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJzqByywwmmRkwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33781-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:39:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3F31833C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4DD131B755C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432540245C;
	Tue, 24 Mar 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b14Pkza7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149C402459;
	Tue, 24 Mar 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365909; cv=none; b=RkR2f33IrXC82NHJkBXWI9pIJldMhw7EzKXjqe4ePolFjvUg1iR1GZnzsm5IU7umt90W4BTPNe8WzqLnpvzfs047/pXWX0UFiLM2+9TKBmHMg+dVfz+utPiW4xQ6RESIjrdoCg3KCOjgsXLTUZFnXRGpRTxKIEfMrphl4Nr9rFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365909; c=relaxed/simple;
	bh=JNyYFA76J+jQHcBV1rf+dBeWcK1puB0zpjFH0YPVt7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWY21vJYx+3VrYCIy9UeKB1KxYaSosR0C+naoUq1+ZBLS4w0fwMH+xk871XWHFHXW59m8MIr+es0F3yp0tt66rOzbrj36B4iWdGs5pmq+wtEl25W70U/vgUgHdfcwckPu7OvuvAUBbyUw3hKx901Xs74WbZ2PqovOm3ok8n/St8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b14Pkza7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HnMY1RSwhTCYvBir6obZ+OuRp6EWJUCF7twCrDHIGWw=;
	t=1774365908; x=1775575508; b=b14Pkza7uhSf3cGA/sCfkuipU5d9DMuPWIW8VEWRBEwhwGG
	3mTXQfM17WnxK356BQkH/6eC47P1/gEvW21SQWUmOPhLs3nUU2drWuNpJyoYTH58L1bUULkcwOm6v
	SuQq5oSfe9Hmd6Wtrc7w7hy15ug+26a5gEYVIkKim5nsij54xIBmty8evrAGarSzWLxnXIZEFwLXn
	9vnmRwr6VRSIORIOkRn68nxb7n9Ud55LrtpkD7pGdnhyLX/OcWniRwdSVj7j8dpp0/IBFHDxOKmbb
	kwmm/uGHTkR6hI2Poof+uUyZZ82cEXMt2W/cXi5nvOjngGpAr+ml4Vvsb91GKB+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w53co-0000000Azl0-1BAa;
	Tue, 24 Mar 2026 16:24:58 +0100
Message-ID: <3d2f9e4d3f06f93e8eb191ade69f4b43752a36bf.camel@sipsolutions.net>
Subject: Re: pull request: mt76-next 2026-03-23
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Date: Tue, 24 Mar 2026 16:24:57 +0100
In-Reply-To: <bf6858fc-98f0-4523-bca4-8da7ecf3738c@nbd.name>
References: <bf6858fc-98f0-4523-bca4-8da7ecf3738c@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33781-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: AEC3F31833C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 10:33 +0100, Felix Fietkau wrote:

> The following changes since commit 9ac76f3d0bb2940db3a9684d596b9c8f301ef3=
15:
>=20
>    Merge tag 'wireless-next-2026-03-19' of https://git.kernel.org/pub/scm=
/linux/kernel/git/wireless/wireless-next (2026-03-19 15:30:20 +0100)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/nbd168/wireless tags/mt76-next-2026-03-23

[...]

>        dt-bindings: net: wireless: mt76: add mt79 PCI devices
>        dt-bindings: net: wireless: mt76: clarify backoff limit usage

OK I have no idea what happened here, apparently Ryder has a super
messed up email setup that ended up sending different versions with the
same Message-Id, so the lore archive is a big mess ... whatever is going
on there, please fix that.

But given what I _can_ see about these patches in the archive, I don't
want to pull this now unless I get a clear ACK from DT maintainers.

johannes

