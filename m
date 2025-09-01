Return-Path: <linux-wireless+bounces-26886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46AB3D7E3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 05:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E167AD3D0
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA32561AF;
	Mon,  1 Sep 2025 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MoTmeKmF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70422332E;
	Mon,  1 Sep 2025 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698358; cv=none; b=GW/lMnALSwJdDbzQMmXWnObwQsE29ogMNFkyBd5tnnJOzMRB0Mb0nXhh182vcx4BxYPX9LVmQ48nm/KH1asWJKhcHbAf5UbMEcx6DBLxx3Tp+BrSOonFLzatxqvK/G+ugeBYfm5wjTN0e90slujS5IGLa1gwKN/lvi9UGofdspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698358; c=relaxed/simple;
	bh=uxvZZwhTCY3iV99HKlWPirh8QVCrtS++UsYg4s6EO7U=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=SiBgwXgoVwxZPb8LcGVymNTxFYqJYggPh2eLSx60/ccrSfn8UAbE8ti1Ne2rO6LdkEb63kdUQwpmFdTYJo27/0gco+FG8UalucSMAF0g8LvQEz/1UzXFqK+YHiOt44RRc7G9/rfmXsFX3KbbgweKuQk1TiFk3775OpXzhvJ8qQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MoTmeKmF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5813jq8T3234442, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756698352; bh=Gwx6aiI6fLG3iG62EUd1krG3XrOgOkEPGqhmGuLVd8o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=MoTmeKmF5wKQ5lpEaFbEvtwqjdz9rYcAP9RVK84ks8DPDd00HCBGNEc9EWXVmLv6g
	 torGKFZ5pbquKUDJWy6D4D4oybi2SEnvJKGBJ+RhwhAZN5p54qo6MA+LdmN6SatK3D
	 d9tEFIJ5O5wS7TL8dFSiTRHwhdgbfyB5fh1GcTHkOfbaDRhyxDqnommQ4wxFemifZI
	 O/Vpo2WV2NK4IfgMuB00nfBCuF9RMW7qEIA/+qyBHOBcJLlaCT6ks7McSSjhwFlYwp
	 0f1mHqo6BJbI6GQTSQ0Tx/5lC2CXgDYAEi5lqOETMddydk/e/XjejLaU4z0Xb/XSHM
	 t79kF3/XdLtTw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5813jq8T3234442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 11:45:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 11:45:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 1 Sep
 2025 11:45:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Ping-Ke Shih <pkshih@realtek.com>,
        "open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw89: 8852bt: Remove redundant off_reverse variables
In-Reply-To: <20250828094717.599527-1-liaoyuanhong@vivo.com>
References: <20250828094717.599527-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ea6afec7-033b-4f81-9156-b1dbb6086765@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 1 Sep 2025 11:45:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> The variable off_reverse and its related code are completely redundant in
> the function. Remove them to clean the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

35ded83be0d4 wifi: rtw89: 8852bt: Remove redundant off_reverse variables

---
https://github.com/pkshih/rtw.git


