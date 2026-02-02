Return-Path: <linux-wireless+bounces-31455-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBttA4iPgGkl+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31455-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:50:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B98CBEDD
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F50303E48A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51753356A27;
	Mon,  2 Feb 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uUqpZLrO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C4364037
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032776; cv=none; b=aJEr1aEw5mXb7Sl1fjfYpRIfTKOX7d8xAvgggRV5CyhpB+H4wYWKZ5n3ZC2Ap1TBpJ/NmwN1zwNstBu9Muoe0XoJY8oT/p8k9gv3A1tlDgXNOrlN+uwKD6xAVwhB48VmmNqtu68t6ZpXn8nEC3lg+gJD8ambDgPKVYig4gRNKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032776; c=relaxed/simple;
	bh=jPm6BjDd61B05/hcvtCJNk1OntONvb4+WoR4F+Z/gj8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUF6Z/Vam1MjIT9+Fw2s5JODZe7tK1ADYW5STABcsWSjcVLDB4BzCfalJcpuQtHPw9pU8F7P44NMrSnVB5LE7D4DJTeE3fn9Z2xLWC3E/cZx4h28BdDYw7A+xG2RX/g78SMhlct8vfiy1PwTvSXU09pPBZQ6HxO6C5PgY7NE9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uUqpZLrO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c30f68f0002c11f185319dbc3099e8fb-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jPm6BjDd61B05/hcvtCJNk1OntONvb4+WoR4F+Z/gj8=;
	b=uUqpZLrO/g5AD1vpXB1qxKTIBGEYnZhrf4IRYHqDOCNP8sFdXNL/l66eJ026LHAEIhvi+OMZHMY8nymuMhIMZvLTAy5mzKRYskUAadWKNFV3CGU7NoXncYM/73U8MYo0ynTtg0cboPcX97QRd2J9+j7viMIheGPKtzN5evk4zLk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:05145afd-e8e4-43c9-a0fc-194a94b97dba,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:faa27e7a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c30f68f0002c11f185319dbc3099e8fb-20260202
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 750171615; Mon, 02 Feb 2026 19:46:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 19:46:06 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 2 Feb 2026 19:46:06 +0800
Message-ID: <1d327fad53675a7193c81e9c0ae2e91c2aa4e74d.camel@mediatek.com>
Subject: Re: [PATCH 1/5] wifi: mt76: fix potential deadlock caused by rx_lock
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Date: Mon, 2 Feb 2026 19:46:06 +0800
In-Reply-To: <e785fe7c-eb3c-4697-9ea6-705c8c9dcfe1@nbd.name>
References: <20260202075311.365673-1-shayne.chen@mediatek.com>
	 <e785fe7c-eb3c-4697-9ea6-705c8c9dcfe1@nbd.name>
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
	TAGGED_FROM(0.00)[bounces-31455-lists,linux-wireless=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7B98CBEDD
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 09:52 +0100, Felix Fietkau wrote:
> On 02.02.26 08:53, Shayne Chen wrote:
> > A deadlock will occur if both of the following conditions are met,
> > because they each attempt to acquire the rx_lock:
> > - mac80211 receives an unexpected BAR control frame, which triggers
> > =C2=A0=C2=A0 a BA deletion
> > - A transmission failure happens due to an abnormality in DMA
> >=20
> > Since ieee80211_tx_status_ext() is primarily used to address AQL
> > issues,
> > avoid potential deadlocks by restricting calls to
> > ieee80211_tx_status_ext
> > only for data frames.
>=20
> First of all, ieee80211_tx_status_ext is not primarily used to
> address=20
> AQL, ieee80211_free_txskb handles it as well. The reason for it is tx
> status handling, e.g. for management frames sent by hostapd that
> require=20
> an ACK status report, so limiting the status calls for data frames
> seems=20
> wrong to me.
>=20
> I don't really understand how the scenario you're describing leads to
> a=20
> deadlock. From my understanding, if something in the mac80211 rx path
> triggers a tx, it should end up calling mt76_tx(), which queues the
> skb=20
> to wcid->tx_list and triggers the tx worker. So the actual dma tx
> callls=20
> are expected to come from the worker kthread.
> How does this lead to a deadlock on rx_lock?

Hi Felix,

Thanks for the explanation.
I've re-checked the codebase used by the customer when the issue was
reported, and I found that the wcid->tx_list structure was not present
in that version. So yes, this problem should not occur in the current
codebase.

Will drop this patch in v2.

Thanks,
Shayne
>=20
> - Felix


