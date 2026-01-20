Return-Path: <linux-wireless+bounces-31010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE2D3C226
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 09:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E002C60143D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FA3D1CB1;
	Tue, 20 Jan 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZD7WRlCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EA3A63F1;
	Tue, 20 Jan 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896757; cv=none; b=CpoYWnrYMtTYFemWgFAfUm8Hsu/stNrOzxpcxFEXtMQsoK7RGN7nA3GNcoIj7nlbqAgAfGUlIi6cFdWjkj9N6i5lzBchg065teBTrgCWT4G8tUk2VfTUjKttbcDWx7beEv2PMOs4dQPB67Wh4ll+tKU0peeG+NBCNzM3vBAO3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896757; c=relaxed/simple;
	bh=PT6mZhuCrSYblI3h5qXU55P6G9Ktq/aLX/t/ucL6RPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnlqZPPZ4b1sN2SuPskoJ++fZH6ckbj217xd45XpLGQiEMufomxUJN83A1wHZvsbc4/7FV5mNSd+43Lt9jXc0GvTqvSO/n60e+3g39IiwsGB8ptAZrwt+4p0FMglTLN958fUyxbki4wgBPJUvwGNpFypj9+In6ENc9iHUQI/6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZD7WRlCk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PT6mZhuCrSYblI3h5qXU55P6G9Ktq/aLX/t/ucL6RPU=;
	t=1768896755; x=1770106355; b=ZD7WRlCk196HlnQo75/aomHiQC5Qi5ulGLIHR1oOcB2UEs5
	CegOixUeXChb2A3tbnRfO3hyGDlxrUTkRiIOVZEcJDT1At+8S9gCmHVXW+1qQAPtjV4HpwKSSSAjG
	6sqM+lzWUhFKIc7+atOsLhwzmpqOkpyO9+JmwSVmkpSAirSW/ihbEdZKlvDV5cU1AXuU7DxOxLtYb
	AWEu6Fsg2UVAvSMj07IeMbzl0i3oX4OF84lHDA6n1WVCV0H3Dp6tGew4YUZH1yChscfaYqJwZlCVf
	M3qu+GDWLDRH4vpO5JAX1w0D0PQBADPgcyeKuHBooNNHmtXZzoH89cFCsN169RZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vi6qm-0000000Ghct-26ZE;
	Tue, 20 Jan 2026 09:12:32 +0100
Message-ID: <35581fc687d151b2b4fabccb6952d567cac65240.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix NULL pointer dereference in
 ieee80211_mesh_build_beacon()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeongjun Park <aha310510@gmail.com>
Cc: linux-wireless@vger.kernel.org, 
	syzbot+81cd9dc1596563141d19@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 09:12:31 +0100
In-Reply-To: <20260119150031.201832-1-aha310510@gmail.com> (sfid-20260119_160223_485174_E37F681D)
References: <20260119150031.201832-1-aha310510@gmail.com>
	 (sfid-20260119_160223_485174_E37F681D)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-20 at 00:00 +0900, Jeongjun Park wrote:
> NULL pointer dereference bug occurs because ieee80211_mesh_build_beacon()
> does not check the return value of ieee80211_get_sband().
>=20
> Therefore, we need to add a return value check to prevent this.

No we don't, please try to understand the code, and why it can even get
here when the mesh interface isn't operating.

johannes

