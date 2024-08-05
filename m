Return-Path: <linux-wireless+bounces-10903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC09947350
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B961DB20C63
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F033FB3B;
	Mon,  5 Aug 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIds6SVH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E39812;
	Mon,  5 Aug 2024 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722824439; cv=none; b=JzNaYLys0MZZTUs3ZqRDWf9zmdqlNLC6DDfQlpxzJNEbw/meXWF2NCuSuCfQ8N2maMfTZOLI9zKi5SSOcncx/N4rfScFIULuXSf+uA0DwmwB8h17GSAYAnsavlySYU29klfkiTzL+ImaV+KnIRGl9Pq4dJQJ7PRvphsDSUH2YBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722824439; c=relaxed/simple;
	bh=jT7CQvRhW8taPMY4BcCMX2qVxPHm0tLcFeBHgunm6IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8BKHMKXfmOgDlIlGp1/PEDTTiml21+u6db+LHOEneDgBHxoEjlf8KZUjqrYDHnpV+0pDP4pxR8kv3/0PIoMPWou3UauSb4LmNKPMJq3PcKhbDRbq1yRRRUy2BLbUm0VYU3/DL2qBdMvPa1HWOF3hdJ46qJ8yht5FAo08n+snCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIds6SVH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso6161237a12.0;
        Sun, 04 Aug 2024 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722824438; x=1723429238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT7CQvRhW8taPMY4BcCMX2qVxPHm0tLcFeBHgunm6IM=;
        b=nIds6SVHl5uIrAYwyNy9V/jb1l+s1ExMXTW66MIBmCt4rsbr9X4mHCDdPqVdM/o98E
         qOvQmTaNUlBWQNjTkx5/vgl/b0dEwHlyIop1fzNnun2VqRsbTJFRjZ2OqavMTDo6aWL8
         76sj8jmEwCuOWleUGrbng/61OikSpMFr7g5wA0GZ8TOGEEE7h53moWcq7vc1jEOpYv9V
         e2CgozrZkuyaaC02QrkFVXlvX+vzDpwBwkuSO/fvYRZHgz8cOb6F65iUHkiA+6mHtmC3
         gvksrnQIB3KFTW//5jQDay7tHq6aDDM5gxH9e2v1UpuCNzE7I15tbzLM/1HOe8/GCNTE
         9STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722824438; x=1723429238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT7CQvRhW8taPMY4BcCMX2qVxPHm0tLcFeBHgunm6IM=;
        b=KE2u11w6kGR3P0O/0dS+wls/H5Yie2ljeILIqNxOSxC0X1kAKNR5wdkYmwcz5dU6Db
         ohsBUz/a+U8Py6LuiQtViaGW2AbdJv+iGQ8ODd6PUmrFuZo6gwIxTlSeggbYqVi4AzHy
         SFibLuYTKvxxFqNrLyxZDq7F5i2Efdt2LdX28dRuAhnRQZwaMHtYbDoR9petxEhZqafD
         Hjr6PYBlsmmoyBBJ4Bk66i/ciGyLLbvWzqI51aTPUwdiGJF27uCQ56bcHwlC6ODN6IYg
         775i24wjuDU61PIvVFbrFvWPXSF4keYypk19k7D0jSuHF2lQeCIQf2RF6HPS0rrHR0s3
         +1YA==
X-Forwarded-Encrypted: i=1; AJvYcCV70wbcblgSWmEStVvnlMhHvUgf3HTpgjNC6j7KlDsp+t9uzvREoJ+dIU5yqrjjyLU5M51bB94MoPLW5zs=@vger.kernel.org, AJvYcCVsINfABA3HP4/Ya19m0kgrK/LZwhU/9kof/HBUf81F/Y6dQAn+mKTiiWxYMv5dUp7y09pSoYgXP8nzxMPi5X8=@vger.kernel.org, AJvYcCX/a38To8lExnqEbbZU/nFAzr6MCB7GoRKFMfdFy4k/zzMMoAsKQWMU4JKcWC/wGLU6CTyuOWiqXCpG@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyDgwWzK/xSM8wVWr1QHwvn9lpqahhRn6YRSvBGwb7oUA88B6
	oovbgat8f+OXiB5ruvB5azdMdaiQdSa7aD+Oiupu5iQuGq+3aa4=
X-Google-Smtp-Source: AGHT+IGaNBNIXKw8rJ5fjuTVpYZVgVWhAw/BnGHUx2uaUWs/TrUW/4cTSgeStZg7EmZVz7GKgvJtFA==
X-Received: by 2002:a17:90a:67c8:b0:2c9:5fae:4f7e with SMTP id 98e67ed59e1d1-2cff941b319mr8954950a91.16.1722824437549;
        Sun, 04 Aug 2024 19:20:37 -0700 (PDT)
Received: from swift.. ([123.117.167.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45c3afsm9138698a91.33.2024.08.04.19.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 19:20:37 -0700 (PDT)
From: LidongLI <wirelessdonghack@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mark.esler@canonical.com,
	stf_xl@wp.pl,
	wirelessdonghack@gmail.com
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer Dereference&Use-After-Free Vulnerability
Date: Mon,  5 Aug 2024 10:20:30 +0800
Message-Id: <20240805022030.1929100-1-wirelessdonghack@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024080359-getaway-concave-623e@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

We tried it, and after configuring the udev rules, I can run the proof of concept (PoC) and reproduce the previous issue without using sudo






Best regards,

