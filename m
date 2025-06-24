Return-Path: <linux-wireless+bounces-24430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D716AE66A7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4289179FE2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975B2C08A0;
	Tue, 24 Jun 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EowkTcGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2A291C16;
	Tue, 24 Jun 2025 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772161; cv=none; b=fkNMm5GTciPWxrt6ZNeVKBIjRPyMSs5Dajc26/frIYZB8ElIa4fQoppMNWRjsknq1o5UpFYgJe1EYFwSRwsfC3iJpOxxEA2EksGAZb5MQOnMpGigSyg5dpIvIYoQgXrYgWkniCcWtuL7QP4KYd3wS5jwAFlyE6lsiCsQEbU2xYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772161; c=relaxed/simple;
	bh=WMgPqwWNGooS2on5RHUN/crTZkEr4pBbRv54KtcQLL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krKjOtLd9Jhya4YYG/2UKq+PdqI7vKdB7nb7QPjeTowL0NrwYgDEzyCxCQed246h3HcHLzKTRh2z9pFlOqF7diMAeQPciHE3bBn5DR0+WkgaPWhVCN1j/llNGdwOu3hjOktfjVmMeKAvwO4yFqIh82MeGQ4/tfnUkaDKHVkHjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EowkTcGk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=n8C/vPKKTuaIjOs0cw/MxpZIz0SU+4HBNS9FPaA6jJ4=;
	t=1750772160; x=1751981760; b=EowkTcGkoSEzICJCmMo2bdu6zWwIGpUWTH4d6Gjx/wZe2E1
	EFrzpIS7dO9ysMQ4CZZQ3bPORlofnlNjGXdHmK+ADiUmCnt8ULKv6a+FLIoXxktMj05s+W4nRZdQZ
	giR6+b/RtWLndx28zu2FCbGRyjcFOkp3nQA0Y9LNKlP2muBsxgFsTlk8yLcYUU8afy0Pg94OMZHZw
	/UcaEJ4+WmOWMzgaJKAkwPsfrJsigZyN7rD4cxuBVbmC8c6lBy2PViHr41ncXzjLnJVgYJm7jYrcq
	iS7eE7tqpLUGnBc2Eflsr18FxrsYAGEsF2jW6aS1r/lwVShjh35wBK1UE0ULlNRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU3oZ-00000008s2r-3Zaf;
	Tue, 24 Jun 2025 15:35:56 +0200
Message-ID: <89dd111db62029f1575f7a7113e2a0cb5a1a8d5f.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no
 AP is associated
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Date: Tue, 24 Jun 2025 15:35:55 +0200
In-Reply-To: <5e378fe7-90ec-4453-b549-1106f9d0cfef@quicinc.com>
References: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
	 <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
	 <5e378fe7-90ec-4453-b549-1106f9d0cfef@quicinc.com>
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

> >=20
> > >    - Remove WARN_ON and early return in ieee80211_report_disconnect()
> > >    - Change the return type of ieee80211_set_disassoc(). If
> > >      ieee80211_report_disconnect() uses the frame_buf initialized by
> > >      ieee80211_set_disassoc(), its invocation is now conditional base=
d
> > >      on the return value of ieee80211_set_disassoc().
> >=20
> > I don't understand this change ... surely syzbot couldn't have run into
> > an uninitialized buffer after the WARN_ON since it has panic_on_warn. S=
o
> > why all these changes:
>=20
> yes, syzbot couldn't have run into an uninitialized buffer after the
> WARN_ON on **patch v2** such as:
>=20
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -4433,6 +4433,10 @@ static void ieee80211_report_disconnect(struct=20
> ieee80211_sub_if_data *sdata,
>   		.u.mlme.data =3D tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
>   		.u.mlme.reason =3D reason,
>   	};
> +	struct sta_info *ap_sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr)=
;
> +
> +	if (WARN_ON(!ap_sta))
> +		return;

I think you misunderstood ... We have this WARN_ON since 687a7c8a7227
("wifi: mac80211: change disassoc sequence a bit"). Therefore, !ap_sta
cannot be the cause of syzbot complaints, since WARN_ON would panic it
before it ever gets to the uninitialized memory use.


> "You're adding a WARN_ON() that's now guaranteed to trigger, no

so now it's no longer your WARN_ON, I guess, but how did it trigger? I
really think we need to figure out how it triggered and fix _that_.

johannes

