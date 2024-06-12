Return-Path: <linux-wireless+bounces-8847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1290502B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C463281ACA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF2916D4E8;
	Wed, 12 Jun 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ik5aaidN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51416E876;
	Wed, 12 Jun 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187070; cv=none; b=Y7/r4DjAXNHF0SbYGA6XoiYy1YDqG429oeUsbrwq00ASWU44GOKOA8t7gsSvuufpZAnNCrbuZj54hYQbB1xXaSSjsojO6LsLTDfWcX6Z3dvn2fbc3QKxWhmNxQkQ8cS3r9BIzmi5RFjSL60I2NOlNL2Ko++B7mOb7yPXK3vudd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187070; c=relaxed/simple;
	bh=qVHAhWuj32KXJ7kyxZOwVuH8j1imYFQRPeHMdoRksBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkyBrWJWUIvTMkRcmiYcVPWU5RYHp7dORtVpT0wfYEcFO8M1i8l2Nnrd540bySEgNS1UlJrVcvIIIGcbn622J7Madas0lvtdp+zDs+ELvh3O3W0VfztmSzt3PokGXGkPNuMoIL6BLlVqQ2mZf0C6fuYjCEBK2m6G7Q4B3nb0br4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ik5aaidN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qVHAhWuj32KXJ7kyxZOwVuH8j1imYFQRPeHMdoRksBM=;
	t=1718187068; x=1719396668; b=ik5aaidN/Z8sTfAfwst748/yRUH/h+94CZVzOQqzGY2c/JO
	Wq2potPI3DfAdXrrfLf15W1E9Tir3C8NTPqEoMwR31eKfxZWJGCbfFQmEJZr+Uh094e1toZyCMgDC
	b7wKYN9UTKwxOwJLBrp4IKwijCJIOUftxOQ/k71Msdez+J5rn2Y9u56aNAAy1GIGm5rRHSGJTKLa8
	w9itM6WawbBNJ2enAaV5qVSJMKXjYkWuAwHk10NOyFlQWvEhDhkBJgcWo3GBawaJBLj4K7vzwbhcz
	IWLtn2g3W2pmEKl5tRHKPPsTqLySU2DHD4bpQhpfkiDUf7iQSdvF9mrLUknkbq5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHKwV-0000000A9An-27Fe;
	Wed, 12 Jun 2024 12:10:59 +0200
Message-ID: <044e2d411333d3b81a6853d92a1c77a1aee0e4d9.camel@sipsolutions.net>
Subject: Re: [PATCH v1 2/2] net: rfkill: Fix a logic error within
 rfkill_set_hw_state_reason()
From: Johannes Berg <johannes@sipsolutions.net>
To: quic_zijuhu <quic_zijuhu@quicinc.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 12 Jun 2024 12:10:58 +0200
In-Reply-To: <b8610296-f8cf-4b61-9b64-ffb52b7ab251@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
	 <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
	 <b3e0a55f0680b590537133bfb02cd1bbfd61a56e.camel@sipsolutions.net>
	 <b8610296-f8cf-4b61-9b64-ffb52b7ab251@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-12 at 17:43 +0800, quic_zijuhu wrote:
> On 6/12/2024 4:18 PM, Johannes Berg wrote:
> > On Fri, 2024-06-07 at 22:40 +0800, Zijun Hu wrote:
> > > Kernel API rfkill_set_hw_state_reason() wrongly gets previous block s=
tate
> > > by using its parameter @reason as reason mask.
> >=20
> > Using reason as a mask is perfectly valid.
> >=20
> > And checking that the bit changed also seems valid.
> >=20
> i don't think so as explained below.
> let us assume @rfkill->hard_block_reasons has value
> RFKILL_HARD_BLOCK_SIGNAL which means block state before
> __rfkill_set_sw_state(..., true, RFKILL_HARD_BLOCK_NOT_OWNER) is invoked.
>=20
> @prev should mean previous block state,
>=20

no.

johannes

