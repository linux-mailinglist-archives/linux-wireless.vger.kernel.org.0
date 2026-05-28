Return-Path: <linux-wireless+bounces-37045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEdfNzyJF2riIQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 02:15:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6160A5EB31B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 02:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05068310DD8F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D52DDCD;
	Thu, 28 May 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Lc2L3Ws4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876264
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927109; cv=none; b=OVrf+I2/ydS87iREaGaXgIVYSpusySJnkym0tjC330Jtlz02JaeLKhdu2H5EPC/80UAce2+rzmFv/K+B2YQt+49d7bLxTf5di8NAZ4BnTHfaMRZGKeGAcKMFzXMb3j9MKCOhlUxK8ZUs0eL03naQy01xbs+xrVRAT0ZTDEfvB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927109; c=relaxed/simple;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=KQ1jnhQ3faTRXTWY7QqiMkSvOE17UbHAY0++FI/eaz0HiC0EJ8sU1pSExha3tQ483SGreDFbGHXmUJJNyUJyzSwcV5Ubdfg3EP3wuJLH0/OZi/rjypRXDs9IbgfHcyTfZYy0SMCX6f3xDHLU1o9LhyeHQVs1FZWAQfrhxQPa+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Lc2L3Ws4; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ur5oonuorvfmneqhgdfn2zzcji.protonmail; t=1779927096; x=1780186296;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Lc2L3Ws4AXjRxBOwZ7K7i0T7YY8SLfc5BHx/HAT2LG/FJItwf2zMwR50Jj4THlN74
	 63xzSMv8mCL6Cts4/YkxERvjhQ5OAosEJzClnavaTQdwyQvDd2T+mKs5iz8rWLJZK+
	 TCRawI2j3WC2rXLXGzREhyVtmBkdM1Dof/mSsi6aDRiLZxt7lyvAYVKJdYrjfaTKlH
	 IlfXUrX3tv8yDZ0uENjdNoSx8DKxc8GHbaYC/+PYk0JMdeFh5VzeIznezux3gmnZFp
	 e3Q86+UXyM8hcbcLi5wqw6JBQ/hbJ0hjQ1Eq9q9GDnTfLS7lFFzvOZUxgP4mBAiWQX
	 k0AqdfoCC/IZQ==
Date: Thu, 28 May 2026 00:11:32 +0000
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: "lito.15" <lito.15@proton.me>
Subject: Ongoing instability and connection loops with MT7922 (mt7921e driver)
Message-ID: <g0rzR4jg_FQlYYJMmNjUY69DXWhunpEaRP_p1ulrzt46nHTxG-idwc0j3TspagcFIwD5uRdNglRAhCj0CsMrZ4qfkrtiqnWGwPNLhoX9cVk=@proton.me>
Feedback-ID: 141744165:user:proton
X-Pm-Message-ID: cea0aae40daf26f6089cd02bf0efdb173aed5a14
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=ur5oonuorvfmneqhgdfn2zzcji.protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TAGGED_FROM(0.00)[bounces-37045-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lito.15@proton.me,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6160A5EB31B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Empty Message

