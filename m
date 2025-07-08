Return-Path: <linux-wireless+bounces-24940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B7AFCAAD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC467A4647
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C42D9EDA;
	Tue,  8 Jul 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jqa6qZg/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E7881E
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978554; cv=none; b=a9znk0ZXlvD68ANbI5x5xIlM7z0npeyUudALIep9jODdLAZWRhouCWC2u/72njDt3BnG7TS6YPkiqWNNKMY6Ye3I2e8FS+NxCtCaMflTb++T+LSPMQ78eajsPLYzOj6JYqlz6dNCKvk8mbTEYwzz/jqnwGjITfCOEa/jgc/FtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978554; c=relaxed/simple;
	bh=NpcPIpplaMs2pDuxlSvTXOSqDhLONSc3j8T4+4jL+ps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKVay+/ktmhbpRWP1Oq5mM/LURkdZFOENLtEcddkdigl8jFbvWZE3hf3qMv4Hl7UrlHxBzEChx3sMQdtS6F/cFhsLPNvgGM6yDII41YrBg3cXk2XV5sb/ySHKAG1efeaBfR7S+NBC8y7woR7EsWE7nYVHS8WMvYLB/qOpdI9W4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jqa6qZg/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uoTNOHBso+SWXiovbNJ+fGQXh8hpDVDGMW0Ph+s0P7c=;
	t=1751978552; x=1753188152; b=Jqa6qZg/BlvLBGU65rPrFhyJEnDs67fcaD1yu6M1JZk2EEW
	yy+y/HSnypNmqbDStFkfWBTOgJ9eyE7Ak+DT3eeabgxbj6WEaTtx9ip/4MUl6p/XWjegls32fJGd8
	ll5SBvrIIBcN+oQ1eK0KMkSlPWC3mD5gxYnTmtTydlacNiZv6ShHBm3lB6eKKFfpCY/AvyeDywyf3
	OYdYS0Y4/m3a808/5eMP2ysPn0Y2mkr82dgmHBHSNYlKq16pjk1CTrti4lYgVeRWTs3F1u/HixFaz
	XoM4y6TzHeUwzFF6bupDo76huvvmoc+aLVGLvCMYRypYhOmokOmCdVVusUCGDe2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ7eX-0000000Bt6R-22WZ;
	Tue, 08 Jul 2025 14:42:29 +0200
Message-ID: <027eb3041693ff54acd16fb4885e5621ff81a973.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] iw: Add Support to Set per-radio attributes for
 each Radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 14:42:28 +0200
In-Reply-To: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
References: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-04 at 14:19 +0530, Roopni Devanathan wrote:
> Currently, setting per-radio attribute like RTS threshold and Tx power,
> changes the threshold and power for all radios in a wiphy. But, in a
> multi-radio wiphy, different radios can have different attribute value
> requirements. Modify the iw command to handle per-radio attributes for
> RTS threshold and Tx power.
>=20
> Rameshkumar Sundaram (1):
>   iw: Add support to set per-radio Tx power config in multi-radio wiphy
>=20
> Roopni Devanathan (1):
>   iw: Add support to set per-radio RTS threshold in multi-radio wiphy

I'd kept these around for when the kernel changes land, but I don't
think they can build now, and I think anyway they cannot because of
NL80211_WIPHY_RADIO_ID_MAX.

Please resend an appropriate version when needed.

johannes

