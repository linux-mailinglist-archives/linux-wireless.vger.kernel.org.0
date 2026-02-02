Return-Path: <linux-wireless+bounces-31456-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGf2EQqRgGkj/gIAu9opvQ
	(envelope-from <linux-wireless+bounces-31456-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:56:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE6CBF50
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C502304BCF5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73E363C45;
	Mon,  2 Feb 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qDiIljQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DC2E764B
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033161; cv=none; b=tESGRZ6rORO0TxMQp7N9KGY9LzP4aBgoNVDWjhtn1HNe3NGq5Be3boJsBAAUJCffGKu7xbf29bhxbre04ddjsMqbyVK8aonH9EXrvENNK7UKfPecNyOV6vAOV5yJOS7liOl6r4BTXWubekmmcRBOcZTaBB9i34jFSotxA8tihck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033161; c=relaxed/simple;
	bh=YehUUsjtuHlyhxJTWORrwLPRmBeZ16UED5xESeEXaBo=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhiWzdmAH/ufWnwtcmIESrRLqi5GWfQPY67Jwz5FgtxCfQFw1X7fRnQTN64nsvPXZzNl9V+J7RETDOtkTp2IrxsNb9rkEl64bcdv3U13hT1b7yEncV4VPRDouruVx3qYCYy5i7k5enD+Psvm3mF45ZxHwAQP3PkXznvkGZOcx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qDiIljQz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9e02efe002d11f1b7fc4fdb8733b2bc-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=YehUUsjtuHlyhxJTWORrwLPRmBeZ16UED5xESeEXaBo=;
	b=qDiIljQzs43D5ENNDx8Wnbs1dXTkZnqXToP0zCeqRAIYj5HPheKYDiwJ9U7D7mCY2Y/uBnIp7eXdKRBCQU/m0hHd53wdNqC2aWzisNuX2578Ra0s1rIuPmXkzXXNrQyq0b60JEPQhD8RPLIuT9zlUqvuCx8rFxCas53KaO2X8bg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:26896cca-6a6d-4438-9603-ff1948a3031b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:c9413cf0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a9e02efe002d11f1b7fc4fdb8733b2bc-20260202
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1742537747; Mon, 02 Feb 2026 19:52:34 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 19:52:33 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 2 Feb 2026 19:52:33 +0800
Message-ID: <41b9111e696c0b0a9a3ad4d8728cf9819aa64708.camel@mediatek.com>
Subject: Re: [PATCH 5/5] wifi: mt76: mt7996: fix queue pause after scan due
 to wrong channel switch reason
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Date: Mon, 2 Feb 2026 19:52:33 +0800
In-Reply-To: <fe5bb9ed-7dab-4cd5-b2ab-e5252713095c@nbd.name>
References: <20260202075311.365673-1-shayne.chen@mediatek.com>
	 <20260202075311.365673-5-shayne.chen@mediatek.com>
	 <fe5bb9ed-7dab-4cd5-b2ab-e5252713095c@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31456-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28AE6CBF50
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 10:01 +0100, Felix Fietkau wrote:
> On 02.02.26 08:53, Shayne Chen wrote:
> > From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> >=20
> > Previously, we use the IEEE80211_CONF_IDLE flag to avoid setting
> > the
> > parking channel with the CH_SWITCH_NORMAL reason, which could
> > trigger TX
> > emission before bootup CAC.
> >=20
> > However, we found that this flag can be set after triggering
> > scanning on a
> > connected station interface, and the reason
> > CH_SWITCH_SCAN_BYPASS_DPD will
> > be used when switching back to the operating channel, which makes
> > the
> > firmware failed to resume paused AC queues.
> >=20
> > Seems that we should avoid relying on this flag after switching to
> > single
> > multi-radio architecture. Instead, replace it with
> > MT76_STATE_RUNNING.
>=20
> I don't see how the conditions are comparable at all. I also don't
> see=20
> how this function can be called with MT76_STATE_RUNNING unset.
>=20
The condition is used to prevent mt7996_mcu_set_chan_info() (in
mt7996_run()) from triggering TX emission.

> Maybe a better replacement would be to check for a chanctx on the
> phy?
>=20
Will do some tests on this and send v2.

Thanks,
Shayne=20

> - Felix


