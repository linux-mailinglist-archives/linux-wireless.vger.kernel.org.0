Return-Path: <linux-wireless+bounces-739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F6D81146F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 15:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFC01F2159A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCAC2E84A;
	Wed, 13 Dec 2023 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5kWkgKB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114BDAC
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 06:17:45 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-203349901d5so146897fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702477064; x=1703081864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tqc+qNcDFUuEzhB2fkHdqgjGsYz3lDNjBTl7uP60e3U=;
        b=z5kWkgKBSg1iGHmt32CCqLV37ba7TFpJKVDhPX9nC/9LPMC97zARtf8CoXFpajR8hb
         wkoWDWjgeZnjJSeBvpnPujhg9bUMTZXjuFHL5FrgLiqXLioA/a+4L4E2rJ9lOGAZSZ7b
         riorA4+s41aeabJMsU+g6bOeou4mbQqVOfdkteNWFdFi9+4nC3TIdzDa1DAT2cY9jHe3
         FgfsWHSd9LbaWd/xds3KMqALafDEr0r4MlhDZBBRmHjylrXF414a+YK7YrEa+QrZv0+l
         BCtEQTwYCHGljqnjQn94jh46NrQFPpOqCtyCTufP1ftnM44tXH9FPn1rWkZMkDAoDXeF
         d5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477064; x=1703081864;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqc+qNcDFUuEzhB2fkHdqgjGsYz3lDNjBTl7uP60e3U=;
        b=qnTI6o17VzJ3XOunrbGcPtV348EU83ZGxPYYeFrUo5yBsJyq2BjmzfW3EnTbakq1rO
         1ZJTXfqa5rWjkIopwNY6URkranVvZIApY/lF1leBl10o0ydVyy/fQJRL7fUtorTwCTbl
         2XxCTc9BGVGuEGvm6jE5gQ9BDcsJssmySRjJ0GnYudtXHXZ33QBXcAlBdjnTGfioxY3n
         k54Rd4X+Y8Joxljwgqs3PE/8qZGgJYKDfT7vBg752BS0rfHcdHZpWH1felsn9FOiRHq+
         NPitljf4P2LpcgmsuUM6UvWO0xvMIT527HGwCHs1GUdIQU0FuD8sCojH2sTrYv74ZEue
         n00w==
X-Gm-Message-State: AOJu0Yw1uhy1L2uqZpskBIMYxrZM3uDG0iab/qhgA1zXp04l3KVhwJDp
	V1oFvnOabzE5IGqf5N+VgKstBFBp91WkrQ7d5YtgTf801/XAD+s9S9U=
X-Google-Smtp-Source: AGHT+IGrRuBBP0VXscUJrKK3DezJlHwcMBbbaSID6Hu6/oNYQJngFBsVNxknC0Ev9yzXeyl/6xEvsu74C1tnxzzOgzI=
X-Received: by 2002:a05:6870:15ca:b0:203:c01:7d4 with SMTP id
 k10-20020a05687015ca00b002030c0107d4mr2465035oad.95.1702477064167; Wed, 13
 Dec 2023 06:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Dec 2023 19:47:33 +0530
Message-ID: <CA+G9fYv9j08=+-CpJdtAV1z9-8KYbYcH8YOvWjbz4TgP7pB2TA@mail.gmail.com>
Subject: next: arm64: gcc-8-defconfig - failed - net/wireless/shipped-certs.c:92:1:
 error: expected '}' before numeric constant
To: linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Benjamin Berg <benjamin.berg@intel.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Following gcc-8 builds failed on Linux next-20231213 tag.

arm64: gcc-8-defconfig - failed
arm: gcc-8-defconfig - failed

arm64: gcc-13-defconfig - Pass
arm: gcc-13-defconfig - pass

Good: next-20231212
Bad: next-20231213

Build log:
-------------
net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric constant
 0x30, 0x82, 0x02, 0xa4, 0x30, 0x82, 0x01, 0x8c,
 ^~~~
net/wireless/shipped-certs.c:2:34: note: to match this '{'
 const u8 shipped_regdb_certs[] = {

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Steps to reproduce:

# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig
                                 ^

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231213/testrun/21662494/suite/build/test/gcc-8-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231213/testrun/21662494/suite/build/test/gcc-8-defconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ZTTGLGEcQd1MiMrE1GgDyvdrla/



--
Linaro LKFT
https://lkft.linaro.org

