Return-Path: <linux-wireless+bounces-22806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F494AB20A4
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 02:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB781C015DC
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B625D541;
	Sat, 10 May 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="S9bWXnik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E221EE7C6
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746838243; cv=none; b=AIF9kZFOosM+y9JHPfpWI9Z8UpnY7/hdNVGgj1J79D7jNm1rtkLqig46mk2ZsMCZ3GGJIAIhkYd4TX/4bHmKsNq62YBQh8cFp2Q9xGoCmskROzLaXJfcxYUeVe5/1w8pVbEkLophcRZBjxmO6qf3glVJK1hBATMHg53s0dM/tjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746838243; c=relaxed/simple;
	bh=oSI5TkwZu1SipjrBAY5bszOzL3hgYo58y6qBv/8sTqU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cdsei3HhQE0XmwcebFHPGr90T/KnnJ8mYpq4JJ+LahNQaukfl45Rn+ctv0fqrc67DON0XIO447gzFeZKHqp0S+r//7yUrjtEjt0pLnAVYHlED/QRS+QaoijxZT8xz9ntageZ0esQmCAvRIlnHYTWea2yNjWbxiWqQmlyDxOQH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=S9bWXnik; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54A0oaML31232202, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746838236; bh=oSI5TkwZu1SipjrBAY5bszOzL3hgYo58y6qBv/8sTqU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=S9bWXnik6FYIf58n83M3tcYG8TFHiMjzjqgToOvHaCjkRkiiQCIBrhkJjqjD63Xp4
	 zy1HQnRzs51gULB7GhwTmxPHgfgPbwtXlxtbSkxqc5JpotzOV2B3MFuumynbbxMw8P
	 7JMgr5HHmhdHvHc+hod+geZa0dJOxloFdExWrIi1HjhlyRf6KI3t6LATHclY+a7iBT
	 9g3t3eoY0wjFy2iGWHwxrhhh/gVaJom/PgNPo8j9Ji4CVSUFUHveLUdt6xuBVmA9UE
	 gGwSb6gdH0D30MA5w22x++skEnO8x9qY5xx4B64IHWZUYqAvvw1jadngX7CSdy9pIu
	 r4wOhcWdxGtyQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54A0oaML31232202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 08:50:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 May 2025 08:50:36 +0800
Received: from [127.0.1.1] (10.22.225.79) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 10 May
 2025 08:50:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yuuki NAGAO <wf.yn386@gmail.com>, <wf.yn386@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
In-Reply-To: <20250503003227.6673-1-wf.yn386@gmail.com>
References: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com> <20250503003227.6673-1-wf.yn386@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4a270533-3e95-4a21-9897-63c5e0c15028@RTEXMBS04.realtek.com.tw>
Date: Sat, 10 May 2025 08:50:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Yuuki NAGAO <wf.yn386@gmail.com> wrote:

> Add VID/PID 0411/03d1 for recently released
> BUFFALO WI-U2-866DM USB WiFi adapter.
> 
> Signed-off-by: Yuuki NAGAO <wf.yn386@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

b7f0cc647e52 wifi: rtw88: rtw8822bu VID/PID for BUFFALO WI-U2-866DM

---
https://github.com/pkshih/rtw.git


