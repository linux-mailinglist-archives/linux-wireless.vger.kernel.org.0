Return-Path: <linux-wireless+bounces-8851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1F905042
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE51D1C20A22
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8315250F;
	Wed, 12 Jun 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S6lf2Rer"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A27145FE9;
	Wed, 12 Jun 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187500; cv=none; b=NYoFEzw8t7B5yWYpEUAQcT8bK/1ZBsDywR3n/3CKi5tdakRnpS6uHk0fQ130ekSHq5toQHCuM0LdVljoD+mcU7OH3MA6QsVpZld864ZzH/SqBkvuovp8Ytwb15GxYGJl4f6luW5o1JmKhBhgpg13yqXZKWcwpubNXfelI64ZRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187500; c=relaxed/simple;
	bh=QoKr8XZXzNuef2wlPvrF3LDsADwFdLosggnu1NKj0nY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjXo4EnoT9sLsdvrEzQvoljbBX7ZKL0oQhgqYZfUDBp0rNFGLqjD02UtQCw1/5l137zGbr3WFrQPCZ5oL9aX0SD3ZufSoU9RDgw0t1OZxei0oXJ72cyS34FPfsdaYRalGXI+VMlKGZKoqSOzzxYevpRDilLvBuU65Px+5zyyZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S6lf2Rer; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QoKr8XZXzNuef2wlPvrF3LDsADwFdLosggnu1NKj0nY=;
	t=1718187499; x=1719397099; b=S6lf2Rerhr57B3E4SyWP9OsbuVjPmt06eL6ecTfhRcAQx8n
	8ZMsuwtvZ/caoF5hGpINVZpvb1aXlTDR+bX8ljPsPmPWWXo+GkhVTQEkRToG8KqVS0v/qT+r0YB3w
	kkHU5drRrunxP3apGJ24KIC4zzJwdf+uWRPHVN4uY1RpcTF3f2d0D72y2aTtAnZkeGJTDjIo09Wc6
	WdZI+Dk+BFeTiwD2P5jCcTnShOQrEYG5Z9on7Sx8ZGYGzBcZQ1SzAF3Xpl18XZz+46nQ0ODXGqdcu
	pi1rXfYlfOWc83M9Oc6gbBnWg1nubtzKVSVNdhYn4jot2yyTero87mPKI8/4txCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHL3U-0000000A9cB-2LVP;
	Wed, 12 Jun 2024 12:18:12 +0200
Message-ID: <c0ad3896334014ba2f12a7978b912e9c49b30d58.camel@sipsolutions.net>
Subject: Re: [PATCH v1 2/2] net: rfkill: Fix a logic error within
 rfkill_set_hw_state_reason()
From: Johannes Berg <johannes@sipsolutions.net>
To: Zijun Hu <quic_zijuhu@quicinc.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 12 Jun 2024 12:18:11 +0200
In-Reply-To: <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
	 <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
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

On Fri, 2024-06-07 at 22:40 +0800, Zijun Hu wrote:
> Kernel API rfkill_set_hw_state_reason() wrongly gets previous block state
> by using its parameter @reason as reason mask.
>=20
> Fixed by using @reason_mask as reason mask.
>=20

Actually, this *introduces* a bug. I'll leave it to you to figure out
what that is, I'm not convinced that you're actually doing *anything*
useful here.

johannes

