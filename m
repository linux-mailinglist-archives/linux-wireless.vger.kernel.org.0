Return-Path: <linux-wireless+bounces-38527-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDBPCVxsRmrqUAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38527-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 15:49:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752E6F882B
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 15:49:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Bl/bEdF0";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38527-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38527-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A42AE30074ED
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8834A3402;
	Thu,  2 Jul 2026 13:43:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22C4A2E16
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 13:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999796; cv=none; b=PWB+IbMaVzoy1lCgcP460pxTHPd51nhfTwQdqSd0Hb3u7PD2WXjpQnhbZbxXV4T+0JL1vmcNuKT/Xe6g9TbGgo+NRWicsOp/EHFCWWb+seml5E/5Jn9b8Al33JmJ0M2hRXIt1wsJvcQJt+7af8AUXIj4QpvMHfbG3WzyjPrvwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999796; c=relaxed/simple;
	bh=lnIsV8wu8Wpkp+oh12mCGa6Zdv58CtR2DlfsY94Roz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8qeZpLREPIPqUIahlDbZSkT9xXm0Wk3awHUd/F/M+EEQPjYTx9rVmx9sg3ijcUdguY/ZiWZMd+2Rt0LR1H2ALM98Ik2qyQ1kvM8D7j/llqu71VBdV8GsnvCfp+bC1QZVLlD+MjJzP8IXMWzn1eOI7LOQCvZ3Jwr9T33X+4+CPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl/bEdF0; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782999794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnIsV8wu8Wpkp+oh12mCGa6Zdv58CtR2DlfsY94Roz0=;
	b=Bl/bEdF03ZTBdih1ROKGnW1ymJ50HeJzY1UdwvStTfXoOVNSn1P+VbgLH3XXpyyHyhM8iE
	pT9kVDq+RSJT5r7qRUUmYR+hYBz9JCZTx3V/+li/Ygf4Vzhn0/C0+dJyiUMk+IOWJVBu7y
	wSr8szfIKO8XniIbkmoe7Ox8evKGW7U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-JXIDLPRIPSm4F_U0l_Rqng-1; Thu,
 02 Jul 2026 09:43:07 -0400
X-MC-Unique: JXIDLPRIPSm4F_U0l_Rqng-1
X-Mimecast-MFC-AGG-ID: JXIDLPRIPSm4F_U0l_Rqng_1782999786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D061944CC9;
	Thu,  2 Jul 2026 13:43:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5AD818007F6;
	Thu,  2 Jul 2026 13:43:02 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: johannes@sipsolutions.net
Cc: jtornosm@redhat.com,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7996: remove beacon_int_min_gcd from ADHOC interface combinations
Date: Thu,  2 Jul 2026 15:42:59 +0200
Message-ID: <20260702134259.1052418-1-jtornosm@redhat.com>
In-Reply-To: <0723f2f3ddb22ce4b9a1c2d075126c8987031a6a.camel@sipsolutions.net>
References: <0723f2f3ddb22ce4b9a1c2d075126c8987031a6a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38527-lists,linux-wireless=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:jtornosm@redhat.com,m:linux-wireless@vger.kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9752E6F882B

Hi Johannes,

You're absolutely right - I had the wrong commit title. It should be
"cfg80211: disallow beacon_int_min_gcd with IBSS".

I've already sent v2 with the correction.

Thanks for the quick review

Best regards
Jose Ignacio


