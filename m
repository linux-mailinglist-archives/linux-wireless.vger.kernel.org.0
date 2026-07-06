Return-Path: <linux-wireless+bounces-38699-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3/eJZbJS2oJaQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38699-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:28:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B8712956
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rcpassos.me header.s=purelymail3 header.b=Vf6itBlK;
	dkim=pass header.d=purelymail.com header.s=purelymail3 header.b=MSCw5BQP;
	dmarc=pass (policy=reject) header.from=rcpassos.me;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38699-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38699-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67ACF308F33C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46501384233;
	Mon,  6 Jul 2026 15:07:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA33383984
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 15:07:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350426; cv=none; b=F5wWKy5sE+/w/mAx6MxPelchLv2j/LjEz+HZPpOlEOx5nhomwSIUzKxxmOiSZelxcmuWQnZbYwHZoK7fnlQngGdOf05gM82HTzCffwoxmgJhWWUlYyuep1YVynGvL4ENK65MQXC7yhNCgfMvnaagHr6SxSRrx4yyC/LhRZJZEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350426; c=relaxed/simple;
	bh=ObC9OwRxOMV1pm3KyljcyooxBRThvnIdSuo4lp1vHn0=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:Mime-Version:
	 References:In-Reply-To; b=XurknH5cV7/NBZBsXmmR6j/aFw+H9FWWFUfRlFNVHyoYL8a9z0IUa4AtjTi4/dR+nsBkuiUH59oGT2NfT6Xy34CMzCpREqI+1npfhvs/MJlAPIs3/FMj48KbZSli9oGHA67QpkphlkgOR+OSxhZWyCR2wH+p9NwVy4Zy9Hi9bE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=Vf6itBlK; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MSCw5BQP; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=Vf6itBlKxB6l6Us3jkVkauWXmLtgJRnbJ9tDT+Vv/54zNAdQpf54yjhOjlmp7/paoN1Jc79WG/tYAI0X5pB1GCDSRdAZPxqmYTGProrS8PnVxu2hklsA2BFtOztuwDO15ZL4InO+EbmHOIspfYF/3AS6gcbVhrNjbkV0JCBPvzvNM+5+nZLnAjuJHhbe/eEA0nh2EJNQqpIKxOBbdPTm1bMgz0o42XcDHTmZO+nF17ehb9hVyKK4xiJFe9jm5+ybHUyrdGsINA17RKcWdujWsSR4NMxUUEHNJfRyHFhK13A90OvSH9A10Bawqgyq8uWH9NtPfNKE2IiLDcQ7UeDJkA==; s=purelymail3; d=rcpassos.me; v=1; bh=ObC9OwRxOMV1pm3KyljcyooxBRThvnIdSuo4lp1vHn0=; h=Received:Date:To:Subject:From;
DKIM-Signature: a=rsa-sha256; b=MSCw5BQPA6Mk6wZnqLFNiT1f4+lYBoM8eot/AnknIv+g9XQ/s5OnQCMYiO5u1vAZzR4rHT+S4DYgVbDrjQLYKTSt3CktupbZ/LV0R7qFPnEGMlY/OiaqrxJCZ4P11RrQQIS0H0Ts1TiC+70/iMCGKCU5qwwyc7G/JmyS4eA12HnlQoe7qJzGU5OYqTzyUxnp9A6TF/MaMgFhAtLBi40kvJSzC+mKVOJGX4Har96I1azlbgY2FhU1eCcJJYbnMi4ASgBOPTrZJx+a4z3g27/v8mJ5kcVum8yOzOQGfjiCyZV/hor41nVbXOpxU2Ui7usVKw37ZhyWHKx72XTOr48jRA==; s=purelymail3; d=purelymail.com; v=1; bh=ObC9OwRxOMV1pm3KyljcyooxBRThvnIdSuo4lp1vHn0=; h=Feedback-ID:Received:Date:To:Subject:From;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-wireless@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1093595095;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 15:06:57 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 12:06:54 -0300
Message-Id: <DJRKYMIBYSWD.778JD1HG7W7S@rcpassos.me>
To: "JB Tsai" <jb.tsai@mediatek.com>, <nbd@nbd.name>, <lorenzo@kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7925: Fix unregister deadlock
Cc: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
 <Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
 <litien.chang@mediatek.com>, "Fei Shao" <fshao@google.com>
From: "Rafael Passos" <rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260630090610.586954-1-jb.tsai@mediatek.com>
In-Reply-To: <20260630090610.586954-1-jb.tsai@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rcpassos.me,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[rcpassos.me:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38699-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jb.tsai@mediatek.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:fshao@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rafael@rcpassos.me,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rcpassos.me:+,purelymail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@rcpassos.me,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purelymail.com:dkim,rcpassos.me:from_mime,rcpassos.me:email,rcpassos.me:mid,rcpassos.me:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E3B8712956

I was having issues with the MT7925 on the ASRock B850M with Bluetooth.
I tested this and other patches in my investigation.
My issue was a platform bug causing a failure in USB enumeration
before the driver path (unrelated to the patch).

I can confirm this patch does not introduce regressions on this platform.
I tested system power cycling and suspension, BT/Wifi adapter enable/disabl=
e,
and also modprobing in/out mt7925{e/u}
Patch applied on top of mailine (7.2 rc1).

Tested-by: Rafael Passos <rafael@rcpassos.me>

Thanks,
Rafael Passos

