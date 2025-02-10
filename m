Return-Path: <linux-wireless+bounces-18722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED8A2F0D6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A1F16921A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5023CEEF;
	Mon, 10 Feb 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devture.com header.i=@devture.com header.b="I2YfSUjI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.botevgrad.com (mail.botevgrad.com [84.22.5.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B42309B4;
	Mon, 10 Feb 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.22.5.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199733; cv=none; b=bEZDXzH35yWMGcvfW4xMcW/gP7vDZGLAbhz1mE7QJjXQV8b2SC93wgJx3C/4GezfroX4LTGyaWN+O54wjY5a2r+Nrr07+Eq4nc/h69fbWVu7zo6J5iQDbk4oHNVUBHwQaeynPZ1cdsvj1fRdshMpfSeGFquYiYlobgoDiv4Kp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199733; c=relaxed/simple;
	bh=ZRCpRxJPB7pxYt7cBmQ9QaWTZHcy+ZoZBGEkQtHASYE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=swYpuY0ZCrMdnrVceFB5dQIf7/NbZtKkyje34vdgj3d+IGmSDzeL+diepb54+wWWWDrYR9nqgZCY3711clFPXWl1k1VHyrewsRMCqSgMXWmo+OX1mqqspmFK8CYXTZ9z0h3muwUaDQVzj+uuLkiPnDe5zUleh9Ruzu+qjeHkayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devture.com; spf=pass smtp.mailfrom=devture.com; dkim=pass (2048-bit key) header.d=devture.com header.i=@devture.com header.b=I2YfSUjI; arc=none smtp.client-ip=84.22.5.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devture.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devture.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FC226018ED00;
	Mon, 10 Feb 2025 16:56:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devture.com; s=dkim;
	t=1739199388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eUjZ6nL8w17oREQOvkvYBXo6SX9OZgpgfq7fRKD2fXc=;
	b=I2YfSUjIvFE6ccoGMTV1CoWbZTd8yX1YkdJVoW5eGKl4A8K8hRp7UNnJf0XZ/5EJ/uIX6E
	XcNOJJOFA82LYBJuA9AsFFUlLRJywrBnZsCL0Ox0KZS/rIdgR0ok0ztb46KToJ0aWQ+YW9
	yYWp6K+G0WZruJ8As+5uMoU+r7LHAKeClGacIHiiiuoAeOXyuai52PqmTVnNh3vQzSc4+r
	Hgqt2sJIDByucK57ExmM1b2XRYoF2Vy1FnKafZEYfNMs4f1ehsvqxyxvjfx41nUa99awm6
	KO0Vi8A2uY4RDd34KFVy1iI7NYxU1ffRTabQYGbvfruMjj25tb1kFrX8nsMerg==
Message-ID: <18be5ba2-6dc4-4766-9944-59cb46c8dfaf@devture.com>
Date: Mon, 10 Feb 2025 16:56:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Slavi Pantaleev <slavi@devture.com>
Subject: 6 Ghz frequencies always listed as disabled in newer kernels with
 Mediatek MT7921K (RZ608)
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu
 <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello!

This is in regard to Bugzilla Bug 218731 - Tri-band AMD RZ608 (MediaTek 
MT7921K) has 6GHz band disabled in kernel 6.7+ despite working in <=6.6

URL: https://bugzilla.kernel.org/show_bug.cgi?id=218731

I'm in Bulgaria and `iw reg get` reports this:

```
global
country BG: DFS-ETSI
         (2400 - 2483 @ 40), (N/A, 20), (N/A)
         (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
         (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
         (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
         (5725 - 5875 @ 80), (N/A, 13), (N/A)
         (5945 - 6425 @ 160), (N/A, 23), (N/A), NO-OUTDOOR
         (57000 - 66000 @ 2160), (N/A, 40), (N/A)
```

For testing purposes, I've also tried switching to another regulatory 
domain (`US`, `DE`, `SE`, `NL`) via `iw reg set ..`.

Regardless of the regulatory domain, `iw list | grep -A 15 Frequencies` 
always reports the 6 Ghz frequencies as disabled on newer kernels.

As the original bug reporter has discovered, the regression begins to 
appear in kernel 6.7.0 while it isn't present in 6.6.30.
I've done a bisection and the results are like this:

1. [bad] mainline (954a209f431c06b62718a49b403bd4c549f0d6fb)
2. [good] v6.6.30
3. [bad] v6.7.12
4. [good] v6.6
5. [bad] edd8e84ae9514e93368f56c3715b11af52df6c3b
6. [bad] 89ed67ef126c4160349c1b96fdb775ea6170ac90
7. [good] b827ac419721a106ae2fccaa40576b0594edad92
8. [bad] d1a02ed66fe62aa2edd77bd54e270ebc33bd12ff
9. [good] 3abbd0699b678fc48e0100704338cff9180fe4bb
10. [good] 5a423552e0d9bb882f22cb0bf85f520ca2692706
11. [bad] 56a7bb12c78ffa1b02e154b1d779ed2a1555fa3c
12. [good] a3c2dd96487f1dd734c9443a3472c8dafa689813
13. [bad] 089482a06b74a40d45773b1871182e8f04be026b
14. [good] fce9c967820a72f600abbf061d7077861685a14d
15. [good] c948b5da6bbec742b433138e3e3f9537a85af2e5
16. [good] 9585316a2aaf773a67846bdc8bbdd4df1e9622fa
17. [good] 51ba0e3a15eb1643116a93674e230e11b9499592
18. [bad] 09382d8f8641bc12fffc41a93eb9b37be0e653c0
19. [good] 4fc8df50fd41c2762d893211487be0ecb24c6a05

09382d8f8641bc12fffc41a93eb9b37be0e653c0 is reported as the first bad 
commit.

URL: 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux/+/09382d8f8641bc12fffc41a93eb9b37be0e653c0

Regards


