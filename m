Return-Path: <linux-wireless+bounces-30077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B64CD81E5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 06:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AFD63018D68
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 05:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9E2D6E4B;
	Tue, 23 Dec 2025 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AWFS3JX/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FD26C3A2;
	Tue, 23 Dec 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467319; cv=none; b=FQ55z/cFDaQ1XF7sNG+C/J406XodL9cMKc4qgrxDTpSQakXPgup40T2T3TEEGyJRVB2XDeGEtQmXSje2oy9UgP6uRrNctxDJrubQVscTS4VDno0C9Vwt+Fc2wi9a5JEHl4QhEKhkMH9rohDSyxkURLI/Tg0nkB63+/DxQajnW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467319; c=relaxed/simple;
	bh=53GiWNyuPYeyWrRR1V7qF4xiiNrXc2xMVlR0ZqCEFk0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=tTidJvnw/0DSxeELLUOC29ez+K6Ng37A+C3sLseGSpC3uOqFpqWlPbhtYPeEpTNwf91MYIo91sWjWGVRfxfEVK5YU4ShMDeOojaLdAdgG9OGOL3cXarMKSz5UasX5qe0pS17IfTByYoRcFGaQ6tBAMLZvR4qGm8Cbecxqd31m80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AWFS3JX/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN5LokpE750607, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766467310; bh=Gg96kcePPYmpnaTmkdreIgfCH5aIgwRFgk89iNk7DBo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=AWFS3JX/lV5kXcqLrbCdO2KZvRE2gZgVBM/QkheNC9qo1pjCmNIX2lXv3RlPEFtTu
	 Yx9Rsr+ZJRoXBIstjkKUXEqYDEfWenzForLcodsMdkIqGGBcK8Gl5OZv0BVEjhynuV
	 SjEp7CD9xp6Kfn4QB2vIofipKWagA+sn9l2JsHn/gbSbrkw8A/eeeKNQaori+EGDGO
	 zp4hWEt+0CCOruVXLGVchyX6lbjTixMSfdIyxxYIMb4X0MFYkZx6W3BMrZhXK83gTY
	 rtuvzo6Ffg9LdZn1lUzo4B497gQ16m9QAXeh5nddDZ/JaZI/cgntNLMq4zWo1JfV6h
	 02LytZjMOV9MQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN5LokpE750607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 13:21:50 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 13:21:49 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 13:21:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 13:21:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Les Boys <lesboyspp43@outlook.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next v5] realtek: rtlwifi: remove dead code and ensure unicast is always set explicitly in every iteration
In-Reply-To: <SA2PR10MB4460B6485B1104727C02701BA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
References: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com> <d664a966f7754e879948039189aba8e8@realtek.com> <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com> <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com> <731806e542f245b3b3ae6d2429c499e5@realtek.com> <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com> <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com> <SA2PR10MB4460E7C842251428DB9D253EA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com> <77827732646345698e1bf133bbc87494@realtek.com>  <SA2PR10MB4460B6485B1104727C02701BA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
Message-ID: <9970ffba-d3b3-4df1-bc2a-06730549fb01@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 23 Dec 2025 13:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Les Boys <lesboyspp43@outlook.com> wrote:

> Removed dead code and ensured unicast is always set explicitly in every
> iteration to ensure the unicast of (n-1)th iteration will not apply to nth
> iteration, the previous code checked multicast and broadcast but no any
> logic if the state is multicast or broadcast, this patch removed them and
> check it is unicast or not only, and removed the initalizer of unicast
> because all possible path will set unicast.
> 
> Signed-off-by: Les Boys <lesboyspp43@outlook.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

I can't apply this patch because of subject encoding and patch context
(might converted from tab to spaces). Please resend this patch by
'git send-email' to avoid format problem.

Set patchset state to Changes Requested

[PATCH rtw-next v5] realtek: rtlwifi: remove dead code and ensure unicast is always set explicitly in every iteration

---
https://github.com/pkshih/rtw.git


