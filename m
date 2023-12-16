Return-Path: <linux-wireless+bounces-855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4217815867
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 09:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D656E1C24ADC
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E714264;
	Sat, 16 Dec 2023 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glBY3Y/Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43714280
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e277b272bso305213e87.0
        for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702714609; x=1703319409; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcV7anTLIYCi4kf6/f5fzgC9vzxXu0sYcluoEeSDLXo=;
        b=glBY3Y/QJink8glCUqK20VuJaAMc7tprb+4nuQTq1p11UoHr9mGxL5XhLfZm/3nITX
         goBpt2DpfRQmtBGMLWh/dhR1BT6ub5xkR8wx+AjYqW1pjv4WZsKSn9feI3G8ZRUsS41f
         750rCL3YUU7/zE9wW58Phl9NXsLg9k+vZ8Z0QhP3RKaI1zfc3w25PZ2e64S4Yl6uwyOg
         YBM0Z6yz+sKlHw0cxY/0oFgip/i70C0udPCjYyOZ3pFIFdklvlFITQYx9GvGHNOBVshj
         /Cw4w0lquyJ9aCVP9uT2J0yLglGz0Zt1dLzyJDwvXao/qo37/MeIZoGOQi3kfqxuSILi
         Hm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702714609; x=1703319409;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcV7anTLIYCi4kf6/f5fzgC9vzxXu0sYcluoEeSDLXo=;
        b=pip47O/6L1KW0HJxNwwNYvYg5fAi6YEEcRo/tx+aehttXgkBUcAfm7wdt3ehnUlPAK
         1b6WIkC/jnYQR4tVP/MZrsLjp+STqLHuK0hz/eI7sdISnGQZAbd2WsbchwCWubr5eni6
         EUz243ICCBON3zztQs9T1xrgG7V67FCpP1bOpzYu+0Bd6/3GSo58zDlmTL5O0k8VlWsi
         qD4M0tUjBR6Fuo2+atMM6pRZH5LhW/NRkgWiGdXX62sF5p48GD+unZr3jJVG/XvNT8Oa
         PzcNpz/E7EMNyM0WeyRPi2J0J5sjIu6dTIzQShKswx5u6mZ5/6B/pCWHFo/T1m+B+xgY
         +ZDA==
X-Gm-Message-State: AOJu0YwHPsaAXF1kzFTkj9szPdVwopijCZUuucEFUeqytF/TReLQgGnu
	ctnT4hfe9Y47BJXOx8mwMqq8tU6um4uibBWAgnlGt8oWuus=
X-Google-Smtp-Source: AGHT+IG2UkYRjJpjq+B62+bJSDM8T56tpfiSMgV8UtNJ04xYMzKGXH35ipvI9uQQcbBQGq433mn6zFN1Jm0R1WyjYGU=
X-Received: by 2002:a05:6512:a8d:b0:50b:fc8e:a531 with SMTP id
 m13-20020a0565120a8d00b0050bfc8ea531mr7953000lfu.12.1702714608707; Sat, 16
 Dec 2023 00:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leonam Uerba <ghostdog0777@gmail.com>
Date: Sat, 16 Dec 2023 05:16:36 -0300
Message-ID: <CA+f0+YH_yAAvqz5_hPVwPHvWvK52cD10XjWye2=S5+OhLS-hwQ@mail.gmail.com>
Subject: Realtek rtl8723de load krn 6.5 but dont work
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Realtek Engineers,

In the hope that they can help me understand and correct why the
driver installs and (apparently) loads correctly after compiling the
driver (using the project: https://github.com/lwfinger/rtw88) but it
doesn't work in NetworkManager and dmesg gives me this error when
loading it via modprobe:

[  166.218608] rtw_8723de 0000:02:00.0: firmware: direct-loading
firmware rtw88/rtw8723d_fw.bin
[  166.219439] rtw_8723de 0000:02:00.0: Firmware version 48.0.0, H2C version 0
[  172.152525] rtw_8723de 0000:02:00.0: failed to poll offset=0x5
mask=0x3 value=0x0
[  172.152531] rtw_8723de 0000:02:00.0: mac power on failed
[  172.152533] rtw_8723de 0000:02:00.0: failed to power on mac
[  172.152535] rtw_8723de 0000:02:00.0: failed to setup chip efuse info
[  172.152537] rtw_8723de 0000:02:00.0: failed to setup chip information
[  172.167493] rtw_8723de: probe of 0000:02:00.0 failed with error -16

Kernel: 6.5.0-kali3-amd64
Hardware: built-in chipset: on Notebook HP 15-DA0012DX

I've done a lot of research and haven't found anything that can get
around this error, can you help me?

Best regards,

