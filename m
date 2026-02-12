Return-Path: <linux-wireless+bounces-31762-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBHfCRKljWlh5gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31762-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 11:01:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D67A12C280
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F8330E4438
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B42E06EF;
	Thu, 12 Feb 2026 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="fsFuUiTz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF562D592E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890306; cv=pass; b=TTVyOd1EtQpddwO31WLyqzHsU0UOWRxmR68GM+ORFRpI37jM0lKyKF+E4TXHvKoNL2LWVZVIGJ1oEUySjijSdt1SLFsaHKDgvT3lycjm+zilM/U8Q2aQ1bsVCCzP2J+QR6FtqSg/2GL857Si6OPpGtTwmeQhf6L5D4NOmBsXd+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890306; c=relaxed/simple;
	bh=koJDWf9hs38ZkZJN6pgN5bXcFumEgRCYgMJCIvQcMF4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:In-Reply-To:
	 Subject:Cc; b=bN8mYoZkcHnnF6XEZLp8i6g5OmTtGcwk/lmN7F66BggGPPMS0mFnr0hNcLf1BNVhg9ciAYIfFnqaz1/Wvm9BTesugcitNRXGudsBXteBqEeZcv+DxUrn7QASy1wSkiSG7ptXhb46pCP7uDJXt4xmmr4KX3sDYbvojhC8At/tlSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=fsFuUiTz; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1770890300; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OJ+vJJf5/xCfYPWmZooZ39lszY1M1NbbCsxmWDbhAd4ctqKmvHXP9cEYzEF19c3jFkSQbHFJzTQN4Rlnz5I3Inhq/MM8CqtgA8kSfP0j5h3rktR0A8ow8O1Vk27CMpTboDPyLpEzyoku3zok9tyLWHZrlqNPpFU9jCiKSoWGMfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770890300; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=koJDWf9hs38ZkZJN6pgN5bXcFumEgRCYgMJCIvQcMF4=; 
	b=T6RGK5/3axvMDrPcZnk1QMsKhNRvMh6rXCecw5LQ5wAFVaUnBE/xVu2FJc4yJCw/lCqiY0sMjZS8F0uILZYSxGwp3TXY5MXUP38CLHFQkpBoCf3/wsuNtoBl2fecs9vStzT//r+LpRvOHVyZQrdwHqGgQUF+wFEnFdaG1hqB91E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770890300;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:In-Reply-To:Subject:Subject:Cc:Cc:Reply-To;
	bh=koJDWf9hs38ZkZJN6pgN5bXcFumEgRCYgMJCIvQcMF4=;
	b=fsFuUiTzXqhzsRbjxuo1ordaDUO25Dola5g+iQF1aPPUj4QUmWxiZcmHy4t8MOIN
	w+XKeU4f+xELMB2LQ2Uz0ZHEZp7WiZpWLTG0fFFz2M2v/NyaM5cHyqTwQmIL7c+gGk7
	Hyj0f+NqLmnqnWgZZ1Y6Uj2yfOEbzP5SN4Uh5sHw=
Received: by mx.zohomail.com with SMTPS id 1770890298531966.2727473592782;
	Thu, 12 Feb 2026 01:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 17:58:13 +0800
Message-Id: <DGCW7TTCQC89.2G77C3IBE4SRC@xv97.com>
From: "Chien Wong" <m@xv97.com>
To: "Sai Pratyusha Magam" <sai.magam@oss.qualcomm.com>,
 <johannes@sipsolutions.net>
In-Reply-To: <20260212042601.2250514-1-sai.magam@oss.qualcomm.com>
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: Fix AAD/Nonce
 computation for management frames with MLO
Cc: <linux-wireless@vger.kernel.org>, <sai.magam@oss.qualcomm.com>,
 <quic_drohan@quicinc.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[xv97.com:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[xv97.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31762-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@xv97.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[xv97.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D67A12C280
X-Rspamd-Action: no action

Hey,
While adding MLO decryption feature to Wireshark, I noticed this issue that
mac80211_hwsim handles MLO management frames encryption incorrectly.
It seems that wlantest can also verify the correctness of the encryption?
However, I couldn't get it to work=E2=80=94wlantest keeps reporting 'No PTK=
 known
to decrypt the frame', but at least I verified using Wireshark that the
encryption of unicast data frames and management frames in MLO is correct
with the patch.

BTW, the changes to Wireshark are already in the upstream repository. If yo=
u
want to use it for verification, you need to compile it yourself because
the currently released version does not yet include these changes.

Tested on base commit 05f7e89ab9731565d8a62e3b5d1ec206485eeb0(v6.19)
Tested case eht_mld_sae_two_link from hostapd

Tested-by: Chien Wong <m@xv97.com>

