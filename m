Return-Path: <linux-wireless+bounces-19366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFAA41948
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6523B1D57
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322ED17C7C4;
	Mon, 24 Feb 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RwdNCw0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8978F2E
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389695; cv=none; b=rFzmf+TWvDlLyhiBRjB/nG6ZKfucfdmnVLke7ya3q9FgOdFUfnhf45UE2glK1uFFSmhEoVYbmdYMXWwZC0oj6gXvymGgixQXjw4htTUs7oXFjY7qV2dJEiJkaPZutolIE+ogWovh6qTt0bAZnFQWy9cMwzxEaVApnnEbhjb9n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389695; c=relaxed/simple;
	bh=CJO7xG3EAN70VUq1R21jk906E/iuANyww0uJF+3Xzdo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDHDWKx5RuW7eDecPs84o+kcDtiF/wfAqT6pvwIpuhVMrfMt33A21GsacNCcV8kyIdz7T87AJftZDjLp0X0jTsi8P+tH98c0RZ4QChCGoxCaciMfK70VzG5bCQgutp3qvLZ0D+naONpmGR8APRUOfIWNdArFaqv/XL7xjIz1GL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RwdNCw0w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CJO7xG3EAN70VUq1R21jk906E/iuANyww0uJF+3Xzdo=;
	t=1740389693; x=1741599293; b=RwdNCw0w8V0c8HZiVrghcqlgyvv8KEXwgy6ifmSg1in1Ycf
	WEXeivBqEL55DfoeEK5CT9wm/WPsWGAj5g9hum5FRqqIlsGhsExcN45DoNNmsPDaKEcL8CK0HTaoP
	j0nfLvYt11vOceO+5faSeUYSzyCU0+UzIP9arYikoFRBPWlJ22sFl9NTOlf+vW/d/A5rEOyiCD2Ta
	k3Z4zUeW9ojFAZ6eBPj24isXoANTcu4Jp407s0MzlnHGeSpVBjem1E6v6uce31ML/RjQeUPaohwIU
	nxoKrI1RTbSsheCltbHBqZwj+edx63q97oOc7zBzJBkF5A3i6fbaK5EvB+/82yXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tmUqi-00000008cye-1PaZ;
	Mon, 24 Feb 2025 10:34:06 +0100
Message-ID: <eab28c11ea4cc4249c01557121b4741e19cf6a83.camel@sipsolutions.net>
Subject: Re: please use tree tags in patches
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Mon, 24 Feb 2025 10:33:57 +0100
In-Reply-To: <a5451ef8e9534ed4b2223f50c3ddda14@realtek.com>
References: 
	<ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
	 <a5451ef8e9534ed4b2223f50c3ddda14@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-02-24 at 01:18 +0000, Ping-Ke Shih wrote:
>=20
>=20
> Thanks for the automation. I think it will be very useful for me to detec=
t
> patch errors earlier, so submitters can fix problems earlier before I'm
> trying to merge.=20

Hopefully. Right now we still need to get the [PATCH rtw] tags into the
patches before. Perhaps we can auto-detect somehow later.

> I have created rtw branch as the fixes branch, so
>=20
> [PATCH rtw-next]
> https://github.com/pkshih/rtw rtw-next
> (clone from wirless-next/main; this is for regular development)
>=20
> [PATCH rtw]
> https://github.com/pkshih/rtw rtw
> (clone from wireless/main; this is for urgent fixes)

Added both, I hope :)

johannes

