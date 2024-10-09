Return-Path: <linux-wireless+bounces-13822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458839972F8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 19:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46F71F2108C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72D1836D9;
	Wed,  9 Oct 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="hYHnBebe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD748CDD
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494611; cv=none; b=gffdWUfd0kdKIburUGPYxJM0OjIw+VX2DfbYjuOl7NeiEA7Rp+aQ/nuc+4v3Fu6VBfinzQ0TtJxClo8MqDv58qMGXldYW5PMhLuRLA+7h6TFr2FsVnxqI7qPGhiRinO6323bbkKFfYIzxH5kJMvitibbpGr/BB3KVGmEV4YgMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494611; c=relaxed/simple;
	bh=s4GHVQ7KrTixTRaKc4+xhzTo9XR1p+JtnSJS8zslaVQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=E3+2r0zzx82vgChWR9CWfbdIQEHdbh/djVMCD6axXWlaFdf4FVJfbXLI9Ur2TFGCovQXvXAJ9xMPjSyh4w36Jfc+t3F76nh+w4rVT9+fRGeZuT/BsYvhO2r9vZYSxXAI7T+fOMmgtsqzvU0r/reLds3PwBgPBSV+Tah9PgrfYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=hYHnBebe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1728494589; x=1729099389; i=frank-w@public-files.de;
	bh=eoLwY9alRedsCYPnuiD5CtfLiZIf2xHE4cOKKcZfTTY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hYHnBebew1qHjATUvOCjqBBemV5rNvc3I/6pY28I+dklGCCgh11C8xo+FYG8WhJP
	 Z0hnCECgONfOHQzK+VQsQOCoYJti0v/0JwCMfzfREl9mupRs5BcU80fJgcOJb8Hfi
	 gYbNfMlf09uNz6JLEAytZR0G0m3nbpp7kwxAbvZNMDH6SVeYsrbK5A5xBwMEgy4FX
	 BflIlxlPksfLvAdiZZ9XV7wEHnGo0g1GTeaD8NSlwz6Xd5QWPBFsW50WIUqrQtAam
	 kiCKhdAA0otKGOXmNs//txyvX+e9d5v7ZFOcwrN67I0dH88+wooEiQEG8Fhqyt9qn
	 vs2CRuhPKDqQ6kxyhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.150.182] ([217.61.150.182]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Wed, 9 Oct 2024
 19:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-67c63297-52b5-4d2c-bcdd-1e86936c4b26-1728494589152@3c-app-gmx-bap26>
From: Frank Wunderlich <frank-w@public-files.de>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau
 <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>, Shayne Chen
 <shayne.chen@mediatek.com>
Subject: Aw: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface
 combinations
Content-Type: text/plain; charset=UTF-8
Date: Wed, 9 Oct 2024 19:23:09 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20241007135133.5336-1-shayne.chen@mediatek.com>
References: <20241007135133.5336-1-shayne.chen@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9iHm18CmHe68E+8f7Hz8U3kI/dYdyrVWNgGZASQ1PCW/cxaRZHw2vTLjOqpCfYhqNyi/W
 gIP8H9h/6nq9XOc1DmNT2yglBLTwdcXLsAenuZoYUV7mSUiXAzPp2PfsKeA5ROMqT6hTrDa4JIOM
 4P9RTUqDk4ycmPN1qTsBVw2gEW9XApicHap1kHmn+4VhJNyaB8p4Wt21+lu7DA29EwyCSOdO4Vbv
 XKxV3t0CDDmsUjU7Q33c72qOH4TVKP3lGA0cWnzLEMa9aMSXBvtpY/I45XA4jddJPBOjLOEnhwcu
 Vs=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l8TrFdzR4Oc=;RiQXHB/z0Ptxlxl81pXNru1rbRy
 wE4r+6nVBrmsUPa3xCWCikeC4+1JXAtXCY8NTMHlos42SJ440/aEhhqsHwjBexVeu6dI+PQ+b
 9aeq5JT9exXQH/TLMrSKo975mYZNLw7noaQSVCo4KTnbNk12rzJQ/l2riLSydW6oUd0Y6TlHl
 rQNB1MyR35uJ0moeNZ5+dqHC8iWlPssbpMfuYXQG081vecPTzij2cYQbcr67JLFoQ29wCrVsE
 +pIO+UgBmRW78ILtLIrUQ5zSo1U4ayTHuO6eB5bvrKAmZfj7FWVpRyAld3f1dVC6qeGDhSijj
 dZO8af4Zxkii+qRTn8hWfCleyW6ddbcJHO2ggG3oF8fRgjYa7762LzBSCatwwk+9uM0Ow5zNT
 F3vcaX02XHRPt/ZbQTlmSsO++LiVmUJaPrV2qJPRygslEQFBiwNP1SR0GegU9revyVC49dwg0
 TQMS5L0VVYCUPJJbr/xUEuKN/rqvAeLIYpDLNQ3uhGt2JdmtLVaZwWtLCME3kJznIWe0W2tB7
 TJrrRFfhnh9tZUjfT16Rdl0rxQLSABRvTpeknbTmkGSwGbjjKB9F5aGegP8y3ZO9WUSY43T+w
 /dx+c/xA9bCL3Ec8ivmld4dmk2wR00bc1rrvOs+STbyIoryiTuSJYEGhweCzDc3/u2kHxSXYw
 e2zX4fA5IXHV0EwHAm50Qheq7KP1V8aBGl9mEqy5bQ==
Content-Transfer-Encoding: quoted-printable

Hi Shayne

> Gesendet: Montag, 07. Oktober 2024 um 15:51 Uhr
> Von: "Shayne Chen" <shayne.chen@mediatek.com>
> Betreff: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface comb=
inations
>
> Setting beacon_int_min_gcd and NL80211_IFTYPE_ADHOC in the same interfac=
e
> combination is invalid, which will trigger the following warning trace
> and get error returned from wiphy_register().
>
> [   10.080325] Call trace:
> [   10.082761]  wiphy_register+0xc4/0x76c [cfg80211]
> [   10.087465]  ieee80211_register_hw+0x800/0xac4 [mac80211]
> [   10.092868]  mt76_register_device+0x16c/0x2c0 [mt76]
> [   10.097829]  mt7996_register_device+0x740/0x844 [mt7996e]
>
> Fix this by removing unused adhoc iftype.
>
> Fixes: 948f65249868 ("wifi: mt76: mt7996: advertize beacon_int_min_gcd")
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

thx for the patch. I can confirm it fixes the issue/trace.

regards

