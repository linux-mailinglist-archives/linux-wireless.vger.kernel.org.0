Return-Path: <linux-wireless+bounces-14462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36129AE3D7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78060B2269E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243B1CF5C6;
	Thu, 24 Oct 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mEF7Txeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E31CBA12;
	Thu, 24 Oct 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769385; cv=none; b=aqj8hph4Ff1KDrGxvEKwpXEKk9erbOr7UJVJESyZQDTOOc93znvimL9iyQmD4sEf8UO7TQD4kZSX8Elq3Y+/CN/G9a5+laY0KqdlEYt6C+2zK5DASO+N3i9mWIol46Rc2Ew9odwsAhpKU0/KqLaDbZ8riBp38/yljjMiPtIOVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769385; c=relaxed/simple;
	bh=M3SPXFxd0M5Pja/l4U1rx9aMurEI2UhSG0xevsZsJpc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ID63lom4A4iBRyrKWPLnhuZU63WW/78JEg4FDRKllgNm19tYi89hrK1BdP8Ri98GzxQI0wBRzeb9LUkxDW2JkJiMRGa6vCQfo1K83mGDyuDtIiIgqWmPfXy9roc9TjlrCJKeG6fqy1fhQ/DP/ZO0W461H+cbJ+qKF+1VSGp9Tg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mEF7Txeh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=M3SPXFxd0M5Pja/l4U1rx9aMurEI2UhSG0xevsZsJpc=;
	t=1729769383; x=1730978983; b=mEF7TxehD/uUEV7IQPjovjvSv0aNhjS8pNf21iznjCEEt9M
	2PihDETtdXQr0uVinquR2ZJWkl+b+JcGoYZwHtkoxgWxI9yCWCeQgfet0UnevIbE+O1k05xu81Dqu
	mYN/NwTe0fr2EHYMaJlke8K9XLZwxgDYoSPKqXRBUHGKEGv0ltAjIgtBar2zndeCh3hzlfTuUHirP
	ZhkzuTHWJfWTEmNmdXUcv7iRFia7h+eH7jvC8aBEfl/PRj1nAnBgq3AvJkue7IO3ByInzgX/EnFgk
	rSXokbaHl0T7Gv0zsWYNc3mRPfTruDZMmfAogRD6D3tjR78Hx+SJWTvADg/mjxMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3w28-00000003c8g-47nV;
	Thu, 24 Oct 2024 13:29:41 +0200
Message-ID: <997febfc4f565bb7fa101c582ab5604d8021c6ea.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] net: netlink: add nla_get_*_default() accessors
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 13:29:40 +0200
In-Reply-To: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-24 at 13:18 +0200, Johannes Berg wrote:
>=20
> +MAKE_NLA_GET_DEFAULT(u8, nla_get_u8);
> +MAKE_NLA_GET_DEFAULT(u16, nla_get_u16);
> +MAKE_NLA_GET_DEFAULT(u32, nla_get_u32);
> +MAKE_NLA_GET_DEFAULT(u64, nla_get_u64);
> +MAKE_NLA_GET_DEFAULT(unsigned long, nla_get_msecs);
> +MAKE_NLA_GET_DEFAULT(s8, nla_get_s8);
> +MAKE_NLA_GET_DEFAULT(s16, nla_get_s16);
> +MAKE_NLA_GET_DEFAULT(s32, nla_get_s32);
> +MAKE_NLA_GET_DEFAULT(s64, nla_get_s64);
> +MAKE_NLA_GET_DEFAULT(s16, nla_get_le16);
> +MAKE_NLA_GET_DEFAULT(s32, nla_get_le32);
> +MAKE_NLA_GET_DEFAULT(s64, nla_get_le64);
> +MAKE_NLA_GET_DEFAULT(s16, nla_get_be16);
> +MAKE_NLA_GET_DEFAULT(s32, nla_get_be32);
> +MAKE_NLA_GET_DEFAULT(s64, nla_get_be64);
>=20

I obviously messed that up completely, but you get the point ...

johannes

