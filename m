Return-Path: <linux-wireless+bounces-16584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B09F77E3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 10:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED689189482D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E301FAC4C;
	Thu, 19 Dec 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s59X0PD8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02775155756
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598892; cv=none; b=Yt7HOofnL7063D2HLaeH/gD+e9bzy+kJ6FFjSmXYY84gfFPWtlSMAJWG14rPllz5WSqD/q1Iq46Y5gqmoVLd+xvCjacrhZ2aD+YlR2WsmQGM0ekIBk99BwyfGQVicgyiI8KoTFUcgQFIe1DI2o4KXetne5F7JjMER+caW5RUd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598892; c=relaxed/simple;
	bh=HNF742ELVj2QciV6EKQ1lCDcjuP86tiXpilwSUAf1WI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/izchooOm/nKX5mKby3O+8PmOgcAYxRXzhu0gbAK3DEAg480yUJxMGb0r+y4NgDuMXjg17DfdN9/YvKr0DEBKros5zhDD+myXsFsyh/89L3rL618TjSlCAOetU+DsnISvikwFjOHLQgXIGq6vuMniuPOajVikqckNJ2Lr9hAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s59X0PD8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HNF742ELVj2QciV6EKQ1lCDcjuP86tiXpilwSUAf1WI=;
	t=1734598891; x=1735808491; b=s59X0PD8aGUZ26TxsobXThbTL4INub8T0XVr5lHO1yeFpFc
	xwfNu/qr+PtsfN1EhfAMvwDIp9kd6BEQeOloSGDJS+ZGtkKQ4/USVEDidnfLDe2GTtp/ihJeE9KrZ
	sZ7AL3mWm6yjq0AWnhl1QYkpNx8dzeHcsfYoD14ED0OdOK+SLc8txfu8r0/4pN4+8+fAwo+3cUyK1
	RyOPMmj4gKPGd1vWcYgr81of5+tgVyLcd0jn+miAwnxrj9kN242BUHflKVgU0E067gsYsIcXYAoFi
	0ZAo0JPyidQPPDgtGHhQuNVxcb4O061JKlri2ypzYSX0JStZHQLwM57fMKuFV6ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tOCPO-00000004Anc-1DMH;
	Thu, 19 Dec 2024 10:01:26 +0100
Message-ID: <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: linux-wireless@vger.kernel.org, quic_mpaluri@quicinc.com
Date: Thu, 19 Dec 2024 10:01:25 +0100
In-Reply-To: <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
	 <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
	 <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-12-19 at 11:35 +0530, Kavita Kavita wrote:
>=20
> The for_each_subchan() macro will not work for this. When sub channel is=
=20
> null, it will terminate the loop, but in this case, we should continue=
=20
> checking other sub channels.

Wait, I'm confused by what you're saying here. The for_each_subchan()=20
macro should iterate over all enabled (not punctured) subchannels, so
why would it not be applicable here?

johannes

