Return-Path: <linux-wireless+bounces-36112-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLlrNMmd/WmwgQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36112-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 10:24:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33C4F3AD3
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A603007C81
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0692EF652;
	Fri,  8 May 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="5qKflZis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3FB33B95A
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228679; cv=none; b=e9+s3H8uC62F7ISz5LCZFYMu1sfrEi60/yK0aTaaS1jOV6xVq0nIs+njVjL3d8M15jFMcBnP/ATvui4KR30C5dV8f9Mipern55R71vBz9MjaC93LAcfI+S7+3TXtiZTVLAHd0pBLyBGdeuFgT3mEit6/8tBfGGy63nRvrcj/4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228679; c=relaxed/simple;
	bh=vTjQp6rlMig2A1jIfmnKzBhjsRG/HGtO3akeJift17Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7ZuWYcZRROo5fCRSF8TsjNiaDKCZ1RysQIio4akX1ng9BE38o0HD8UBGZlLbYpBlJB4JxA9rcomOMO3KTsHY+Qcsvpjc+K7Bizvl/wNVEkcutDxUnvmNbY1tDxPuRAviWclwS39w8HEybR8/lmXjaPVUx3lPb0rn124xffM7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=5qKflZis; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2w+ErWuwn4q1kVTPTcb6b/id1dThQ9f7/5RdUJiIMFg=; b=5qKflZisG1CRG35ASuV+Omcgc+
	CWeKzbo98TETtJoeDyM4AwJNQsTiEIgWU13M/M2u5gWTOQkZUHcUQ971sRT4BZw/F/9U/s0j0H3yd
	0K+EJagK6CmFdKqiYfJWbOc/ooagB5qfsNaSqgp0qXS3F/uJ8hm3wT3zFVvU7/hP8vE7Jj3LaxTsP
	YoMabeK81Iv7KtT2BlnXwCtMGGAjT+B7H6v9FHvYvZoRjal0IpXz/uAY32QkDFQ0DrUbJmUdOC/rF
	9yTSaVIAqotx00Zuo0O6wp+l+iZdrOnhy88eVL/9s499RGMYwqlqZ+a1ZjRZw3sbVvvXEIp00A849
	Wknm8uIw==;
Date: Fri, 8 May 2026 10:24:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Peter =?UTF-8?B?w4VzdHJhbmQ=?= <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: Add support for IGTK key
Message-ID: <20260508102403.4e2fb1bc@kemnade.info>
In-Reply-To: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
References: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F33C4F3AD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kemnade.info,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-36112-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kemnade.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liu.se:email]
X-Rspamd-Action: no action

Hi,

On Fri, 16 Jan 2026 18:58:58 +0100 (CET)
Peter =C3=85strand <astrand@lysator.liu.se> wrote:

> This change re-applies commit 2b7aadd3b9e1 ("wlcore: Adding suppoprt for =
IGTK key in
> wlcore driver") (sic), but only enables WLAN_CIPHER_SUITE_AES_CMAC with m=
odern
> firmware. This patch is required to support WPA3 connections.
>=20

I have seen this after this patch:
[  484.113311] wlcore: WARNING could not set keys
[  484.117828] wlcore: ERROR Could not add or replace key
[  484.123016] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardware =
(-5)
[  484.123046] wlcore: Hardware recovery in progress. FW ver: Rev 7.3.10.0.=
142
[  484.139923] wlcore: pc: 0x0, hint_sts: 0x00000048 count: 1
[  484.145721] wlcore: down
[  484.148986] ieee80211 phy0: Hardware restart was requested
[  484.610473] wlcore: firmware booted (Rev 7.3.10.0.142)
[  484.633758] wlcore: Association completed.
[  484.690490] wlcore: ERROR command execute failure 14
[  484.690490] ------------[ cut here ]------------
[  484.700195] WARNING: drivers/net/wireless/ti/wlcore/main.c:872 at wl12xx=
_queue_recovery_work+0x64/0x74 [wlcore], CPU#0: kworker/0:0/892

This repeats endlessly.
As soon as I set pmf to 1 in wpa_supplciant, once per second. Reverting thi=
s patch helps. Seen this
on the Epson Moverio BT-200.

Regards,
Andreas

