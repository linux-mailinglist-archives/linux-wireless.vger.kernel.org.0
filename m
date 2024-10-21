Return-Path: <linux-wireless+bounces-14265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030829A6558
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324691C222EC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FC1EF08B;
	Mon, 21 Oct 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BmKxA2Ba"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C21E32B1
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507813; cv=none; b=kzoKly5dMVHesGRA385WIZkjKo3It6gmYlqRM6SXla4OeNaNdl08Zmb2ZG1N9zPB3yVvZ9Jaa9p1hfnZJ4FyuL9GYxQNURngMJkIjxJnGxY6lbnvQJ59FvBmiQKdJl68hy2m2wW2D3Zl37y47+ptSRgNQTvQraXAFGZo5fAfjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507813; c=relaxed/simple;
	bh=x2SANA6AU0G7ZqNTcY5vC0Yh0od1Ilw4X0ZvFAXHTiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZle3y6QNWchrWUpg1P63qJlPVAArM9OtBwEifXltvyd5N3inVPzma9AoegrvO/KnKsqe5uyuc1VFaUthPVvgRCZfRjuLAHNBPRgi80f7omvO1BwiKeJFUoMM+q1WsLmO17VsoUa6UCKc5mZ+KcZ19la/IbDPdOnr4ObxuofIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BmKxA2Ba; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6WJfGH2Y347DqVrn5xfsDq7YVkpdG4UFDSvYC73SKUs=;
	t=1729507811; x=1730717411; b=BmKxA2BaucKRkkUbXafi8/JcFB8f4HH97QoWKoIyJVS1V4M
	3G4mF9eMI2QEzpggY+ObgjPUI3sH5sxrR66UbOcRfmghUUuK62g7sJ37yU+CIreyCYvqg4CWIYXOO
	DdpcesftTeHdifTyPULkUXuuLDW6mN/+Cw6m3NK2IQWfWeR6vt3Lx7TdHqqKgFTCbBfzbcv81ShvK
	98RYEXXvtj576gs82yZHhC6SH23OdwBGIPxenKZOG5pTSM4yJCHLuyTDUKwwQvLKnXx8P+I7lWeBH
	Q+Lzdb06LKrnYPtgQRhZpBsXGRskfdmMHMH9+dExtLDJ5SJtghFRNeyRt3Iyb+tg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pzE-00000000kv9-0bsJ;
	Mon, 21 Oct 2024 12:50:08 +0200
Message-ID: <bdfc2fb8d2d2d9cab7d53034b9f1a68d9e17d1f9.camel@sipsolutions.net>
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 21 Oct 2024 12:50:07 +0200
In-Reply-To: <ca085fd4-fc22-4c91-a571-7a55ac4f32d5@quicinc.com>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
	 <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
	 <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
	 <e96a1d4b63388e8d7e8a9fadfce31f408ae83ab2.camel@sipsolutions.net>
	 <96a7a24b-61e2-45cc-9c76-15552107976d@quicinc.com>
	 <1606121bda73a1295f934cff07b1ab52fcebaf94.camel@sipsolutions.net>
	 <ca085fd4-fc22-4c91-a571-7a55ac4f32d5@quicinc.com>
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

On Mon, 2024-10-21 at 18:48 +0800, Baochen Qiang wrote:
>=20
> 802.1X Authentication
>=20
>     WPA Key Data Length: 64
>     WPA Key Data: ac3e43897dfc934f8f84d58e6fa5bd6c26ae666a29892de0a30d43c=
7dc7a063ac6b5884718d8945274c0df6559e48c861efec804b5be920bd5550c43b0889ea0

Yeah, OK, never mind, we'd need to decrypt that with the KEK.

Not sure how to debug this. I'd think we have tests for this, but I
guess I'd have to check if they run on this device/fw.

johannes

