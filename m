Return-Path: <linux-wireless+bounces-19072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E8A38B0F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1231318926C8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C46D22B5A3;
	Mon, 17 Feb 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXk86ekM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFE17DE2D;
	Mon, 17 Feb 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815688; cv=none; b=S/82n15AHw5tNS131cCEsp/2+/ug8cyP3afvUw1ZVOjcdl2rHhS/ssUQkXQmkJnoX7v4RsHn87/73Bd5En04HvqLRvVM7FRBLpZUQAb8QH2ILF+s+yQY3NkXmsUKAcgvkebiBe95t+12Lerc6gWyHuGqMk7GvkXwMRmNnHZaOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815688; c=relaxed/simple;
	bh=0cgiwHdJUiqDd905XAXqkQAM/6cAJN9rNptm0Rl0Vog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T6vicPkxbPQaREHwyhxmENGjrXMpHSjTw2SJ3DPYpEpSLVtKcQPYlaSUtAcTS6RcvHOHwHS0UhYP6AKhznf0BO5o6HB4QjPmzxirOVCGdZzO33jny43yNhxgGtjz8Pd0ZjtKrEZmSv/BVuQTIrCZ6kMvw+P9TGNd8sVdR2vaLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXk86ekM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so28290255e9.3;
        Mon, 17 Feb 2025 10:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739815685; x=1740420485; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjBgXZkOH3whhpyjfxwclXrAjddu2E5bK4wpZeedqEg=;
        b=VXk86ekMLeeafrM0xi+lPrCMdM0hQu602k45bP48TGTddDBfBuz6ib1n2GWKzQ3vlq
         u9pbmanYLDCHgUgysrTjXJ8h/BKGuvcifUe5thJ8JNnlsga4wJ0b8a32ge/10AXrTSAZ
         ljtFS5KErhZKEK6PfWrZrLPlHc1Snk+6aD+O7W927IPiyb83GyzRIiGYP7rKcORsiF3x
         YbIGFxe4tUId8edMHx+d6Hi3dmOIAzUy71Zcw+hdIFufaoxlYezMNEA049dNmIECKr3n
         9cF2jw8D8TGFM6mkG/SqvKM3TFVn55RxOv9oQCY4Y6ziaG0xQsvq/ogb80huhJlQm5X/
         HGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739815685; x=1740420485;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjBgXZkOH3whhpyjfxwclXrAjddu2E5bK4wpZeedqEg=;
        b=jl6+pX03KlHlQjzwvCjbvICOzgYe3Vuw2s/svRVM6X8tDsNHnB5RKrR/QZFK4JRPzU
         tAgd7AcT1bs4t0ZEquNmDwH6aaLGqNneJdPL+SzetTZJd3bTqSl+E4UVcp2ouAa1R4h9
         A21xj98Zkt28m0vFt140M9gohOVugr64aM/BJiFhd1qPdvzyr4/CluSS4QmNsbWBgg1l
         1PGbj/iVOU4Hyzui+tLTpzBcEuqDv3or5a+ZxMkGH/9C419vngpdfr/dkUC38c4elygo
         BDq6j5dpcvB2vvZ0wu4oVy6GQJFBM8anvngHxzSql3oz6fOkTDkLPlKBV2SCBTI3/nor
         a++g==
X-Forwarded-Encrypted: i=1; AJvYcCVjIFtgVzNLYz44389BIakaDxRjGXmMVI7TLQzHqYx51b3Uz/ecyAFdvU1+pT8dXOGFw9s43ObQ3/4HVH3mYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBjkliU8oAoDdmMm+PnVvK+rWBEX6GSEvylwWt45IvCaasNps
	VK4/mY4l/0rR8mIrlTHphG29xAHjIIpF0DO6OdCzdYLirzl8kUwlFtW9XA==
X-Gm-Gg: ASbGnctXKVfsJ1hP03TseVvhaUB710oNodVgoX+XHwTAz/j6GGFt+ikGLf2ax66EPvQ
	vVLmWsWAU/DfuI1jURG1Ar6Iktt0GsnKxwQeynVoqRjGOqcG22fkUQPhJtIcbbibFGST82pFIBO
	1h4ztTOewPvVkbqBRHGxbqRTQMPj1LNe8epLGj2+MCQO4fD6jOX37Wavg6tEW3KD0UThdAtAj2F
	Us3DBFoOY6bsqx0UR/2NUWlDqUPWUkchKDoZ4hnCI42YlnvGCM7UbjiWecWaf+8dHM5UJjlZlo2
	+tuhkiOUF0orO8lY
X-Google-Smtp-Source: AGHT+IGVVM2BqVoNfvQ36nc2E02wxjyOaOlr3JaZKfNm3XH15asvLolOrMOVBHPAx7AiQHGsADj2tA==
X-Received: by 2002:a05:600c:5125:b0:439:44eb:2d84 with SMTP id 5b1f17b1804b1-4396e6c9315mr82494435e9.9.1739815684676;
        Mon, 17 Feb 2025 10:08:04 -0800 (PST)
Received: from Red ([2a01:cb1d:894:1200:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm160267705e9.3.2025.02.17.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:08:04 -0800 (PST)
Date: Mon, 17 Feb 2025 19:08:02 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: kvalo@kernel.org, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: unknow Network controller: Intel Corporation Device 093c (rev 3a)
Message-ID: <Z7N7AvQvv8k4OY-o@Red>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello

I have a thinkpad t460s laptop with an unknow network device.
Since the laptop does not have wifi, I suspect it is the wifi card.

The laptop is running Debian bookworm, and I tried to update pci.ids, no more information.

lspci -vx give:
03:00.0 Network controller: Intel Corporation Device 093c (rev 3a)
	Subsystem: Intel Corporation Device 2181
	Flags: fast devsel, IRQ 255, IOMMU group 10
	Memory at f1100000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [40] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number aa-bb-cc-ff-ff-dd-ee-ff
	Capabilities: [14c] Latency Tolerance Reporting
	Capabilities: [154] L1 PM Substates
00: 86 80 3c 09 00 00 10 00 3a 00 80 02 00 00 00 00
10: 04 00 10 f1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 81 21
30: 00 00 00 00 c8 00 00 00 00 00 00 00 ff 01 00 00

I see no loading problem, nor firmware missing message in dmesg.

Regards

