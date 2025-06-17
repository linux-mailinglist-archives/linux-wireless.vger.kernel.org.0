Return-Path: <linux-wireless+bounces-24174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A277EADC263
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C651895AFE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364861DE3DB;
	Tue, 17 Jun 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QL+1KHxv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2E27461;
	Tue, 17 Jun 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141910; cv=none; b=YF0iEpO3G00fc9zMZmYV3xnoRmdQAHgPW31Fvvojn1EPGqDGpmaVz5aHIygWBrtQZLA7fYI2lczIm4Osfv3JkdEfTUlHunjU7Zva9EmU4+GiTagsThySxpZSaDPvTkqit/A1H2ufahVTDmBauz7UeaP5/RjVjCQIkOFriq3V6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141910; c=relaxed/simple;
	bh=Ai7vF5RV57bV/NmagLGT4gN2aemR9Fwghr5/jJb67CM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iz2Chi7xqBKmK8nkuXMPcY8BX4FOKRiRfgF1d1SSm3CG+n945b57XFLNSasrQ3qk1cAi7KP382498O4afxJdIf8nNrt2zLQSXqvYp1Mc3EYxBoCRmOocjvUG/VAd3S3HoUekKhrCJAs1HFcyOTz5s9pCFhpYBXUity8M0G5owZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QL+1KHxv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pk2oPHCqJ/oLBd26Ay4PWRHlFgJzTH2Jf8vliD86dZw=;
	t=1750141908; x=1751351508; b=QL+1KHxvmAmxM6Ix61aUSoAEhm/APFvJBgsoo1dasgcsEy2
	rLqbTdZ81amqL0eUR7WoF9+knPOmSzWsZWdeQlNtV3GjNN6TAIKcEk5CNMR62Dg48d5DbAHhbX9AD
	/5nXbC7S4yFuVseCKRh4Tq9FV8K6T/lb16nscr0XCI/7R/q0U9TiiBr6umA/0Fc2y1E7f823JjiYm
	4Zb25TPSO1gMCaqv/rTgRwe+YPspmcnw+pJY1ueHQX14A8XQp8vdtFuBbsfOJMRsp2pk0pHLK4JIX
	xgCnO0xFInSGX2NJNRlZcD71i8fR9oQPYTn7gNXPFlt5oKYVZvzmg8YPlrsRVoOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRPqz-0000000DxKA-21pr;
	Tue, 17 Jun 2025 08:31:30 +0200
Message-ID: <86bbb07755d748c9b582c0ab234e8a4ce0314ce4.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix oob in ieee80211_rx_mgmt_beacon
From: Johannes Berg <johannes@sipsolutions.net>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Tue, 17 Jun 2025 08:31:27 +0200
In-Reply-To: <tencent_8DCFF079526DB42E796E5095C0E8E2EE1E0A@qq.com>
References: <68504add.a70a0220.395abc.01e7.GAE@google.com>
	 <tencent_8DCFF079526DB42E796E5095C0E8E2EE1E0A@qq.com>
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

On Tue, 2025-06-17 at 12:41 +0800, Edward Adam Davis wrote:
> According to ieee80211_s1g_optional_len(), it can be clearly seen that th=
e
> maximum size of variable is 4 and it is an array. Based on the above, the
> parsing of the frame control field and optional field is optimized.
>=20
> Fixes: 1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G beacon=
 optional elements")
> Reported-by: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6554b492c7008bcd3385
> Tested-by: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  include/linux/ieee80211.h | 2 +-
>  net/mac80211/mlme.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index ce377f7fb912..556ce95e0b0f 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -1278,7 +1278,7 @@ struct ieee80211_ext {
>  			u8 sa[ETH_ALEN];
>  			__le32 timestamp;
>  			u8 change_seq;
> -			u8 variable[0];
> +			u8 variable[4];

That's incorrect when those fields aren't present, and will result in
wrong sizeof(). I believe the correct fix is one I sent before, to just
make it []:

https://lore.kernel.org/linux-wireless/20250614003037.a3e82e882251.I2e8b58e=
56ff2a9f8b06c66f036578b7c1d4e4685@changeid/

johannes

