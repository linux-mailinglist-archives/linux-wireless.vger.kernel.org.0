Return-Path: <linux-wireless+bounces-35129-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO+nBn9a52l87AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35129-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:07:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3E439E8F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3EB4302E33B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED623A63E6;
	Tue, 21 Apr 2026 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lDKNjX+h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970872DC32E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769534; cv=none; b=mBeQhyHU0QrbKhX/DfXlyVtsjHnG5SBLZM3xK1Ova7o2BjVIP5ZqvJM1oPcjyGEDT7UXrZohLjVuGozzonRBEv5SxLYKA6hfVeJ8HxIilNKgHiFP9/r+16lbnueC8DuHQ6eDB/aapIMjwT9bL+Eqx93nCKEzD5GUQ3oU0wUwPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769534; c=relaxed/simple;
	bh=WHVcCFOb+TrymBKkGJrjd+wp68SFWrzE7bdGROEaC9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9ANwCFjrx5EhKJ2UslUMKo06QyIAp4b8CJ3QVPEBIgOSbyTvRVjV1hSfLbNIT+uGFO+O/6iAufyQHPqUwI+Mvg1qobgYlOZ7EaO685wUuYpIQe/ownOSlTalryy+sW2gjWCdNiy96LCw4y3vS9WK2mNaAoEs06H9FPvGpuydWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lDKNjX+h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ncT6Y42vkG0nRCivJoRoCvRGB8C1TEI/kjT701oVAQw=;
	t=1776769532; x=1777979132; b=lDKNjX+h2yfYwX5iC3NOBtjzZFNmuukmsMrBc5fpCO4HCKy
	0dZqJeqlaB6UDUTHzWydQHK1mLvK6sBWs+Eu3VGUIWePygVlxjpQKAchlB8ph0/f+DU9vJ9ZVdfsz
	ToXfEIXHIpQvc+5GU79INmV8Ze24hicguK8Qlrt+7zchblDk4qA8Gozup8CQCc+6/lGJe5i1MX9BZ
	jmNuufHLchuTv1TTin3D4XADLoeiBl0gV+WUJTpO2Za/ofpK7taV9H4oxNRs4zH9NFkow18/w3ker
	DQFNjFS3hH2BDKT2T8gLdmKOH1nCtJIxyJPK6JYDciZmceu1iWzHChFl40oF0Qtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wF8v4-00000004wv7-0ByR;
	Tue, 21 Apr 2026 13:05:30 +0200
Message-ID: <5160c46cda019dee1a01406fbd13cc0b9b02b3e2.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in
 link lookup
From: Johannes Berg <johannes@sipsolutions.net>
To: Tristan Madani <tristmd@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Date: Tue, 21 Apr 2026 13:05:29 +0200
In-Reply-To: <20260421110133.2957818-1-tristmd@gmail.com> (sfid-20260421_130137_392604_8BC916E6)
References: <20260421110133.2957818-1-tristmd@gmail.com>
	 (sfid-20260421_130137_392604_8BC916E6)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35129-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66A3E439E8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 11:01 +0000, Tristan Madani wrote:
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -6435,6 +6435,9 @@ static inline struct rtw89_sta_link *
>  rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
>  {
> +	if (unlikely(macid >=3D RTW89_MAX_MAC_ID_NUM))
> +		return NULL;
> +
>  	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
>  }

Also, I have no idea how you're generating these patches, but please
don't do whatever you're doing.

You have "X-Mailer: git-send-email 2.47.3" in there, but there's no way
git would have created such corrupt patches. Also the "index XXXXX"
thing seems to point to some (fairly pointless since it's just hashes)
post-processing.

Please stop sending patches until you've figured out how to generate
patches that can actually (and reproducibly) be *applied*.

johannes

