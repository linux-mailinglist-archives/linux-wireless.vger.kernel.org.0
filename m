Return-Path: <linux-wireless+bounces-21963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A311DA9AA04
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EBF46274F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ABC1C7019;
	Thu, 24 Apr 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eFqq6YnV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D4221713;
	Thu, 24 Apr 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490183; cv=none; b=qK4gJPWPumwYyChyazuhQqtrsZBB5Xy8wEycn5iG+FPQBmadUwti/ePnHdwt4DVTm+IbMBlFFj4Z/3IV2h2TOK48Ek4+UTfPL+XFNHmFWGucO+MmrWH+cVyWJynMFsVhEUVCwiLp9gAuj2tGzs3rt62dAw8dHtjH01S51sPfKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490183; c=relaxed/simple;
	bh=aYJR0YwEQEq/F2d4Hyv9MjrZWWwLmGtRacmF7WsvGuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jka6Rvqw5QhZgLr/jTQQvlBtnZ3bcPgEGc8B+AxcdEvpDS9GzpTd+VIWDXCzkfS1ytQ2vMLR2X+TlR8A3nrTOPR/t97nz0dShPnhgZWyXyHtpKPJ68L7jABn44UpoeB/Z9a4NN/baTzefpvk8TVcv9XrE7VSebf+oXsZYjMCx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eFqq6YnV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aYJR0YwEQEq/F2d4Hyv9MjrZWWwLmGtRacmF7WsvGuo=;
	t=1745490181; x=1746699781; b=eFqq6YnV990SmjfoUfOO6OpuPaur+SWSwuBm6k+I85dHG4h
	RFrx6b5/nx7SV+q0wzVX2DmRo6qBVgio1OeNyMuHSb5ZHrlGDVsTNzV1oomUP1pA7e+4qv1w2JdJ5
	fsEbPR9L17+wXZ9JlF9/9hiqtiaZ9vqFSE5oCJnQTMf7Tdt8Mauof9BT1TAs4kANVGEeo7BxjnDJk
	wB8A06ohzxvCSM96V/z5CkDImSIAc+r3HdjzplXPMEhi7HbTHc95J/Czxrmdb9UvM63KNc0nB4xec
	2VF0LIQMIgZtSP6giLckuMvskIBt6sgT5HbgNPhKUGwalnHZKlSxyarHylv9iP4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7tjP-0000000Gz2S-0VXe;
	Thu, 24 Apr 2025 12:22:59 +0200
Message-ID: <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Gokul Sivakumar
	 <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Thu, 24 Apr 2025 12:22:58 +0200
In-Reply-To: <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
	 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
	 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
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

On Thu, 2025-04-24 at 11:50 +0200, Arend van Spriel wrote:
>=20
> Looked at other drivers implementing this callback and here are the resul=
ts:
>=20
> [wil6210] wil_cfg80211_change_bss(): does exactly the same thing.
> [wilc1000] change_bss(): worse! it accepts everything and does nothing.
> [rtl8723bs] cfg80211_rtw_change_bss(): same. just an empty callback.

OK, though I guess other drivers being bad doesn't mean this one should
be :)

> If this patch means Infineon is (mildly) regaining interest in upstream=
=20
> wifi development let's not discourage them.

Fair. I didn't mean to discourage. I just think to meaningfully
contribute upstream people should follow the list. And even review other
people's patches. I've been meaning to make that more of a requirement,
since I can't possibly meaningfully review everything I now need to
merge.

https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e75671a57=
f494.camel@sipsolutions.net/

> I do watch the=20
> linux-wireless list on occasion but I am a bit lost on your remark. What=
=20
> do you mean by tree tags. You mean the "wifi:" prefix? But then I am=20
> confused about the "subject prefix" remark.

Oh, well I guess terminology:

https://lore.kernel.org/linux-wireless/ec3a3d891acfe5ed8763271a1df4151d75da=
f25f.camel@sipsolutions.net/

johannes

