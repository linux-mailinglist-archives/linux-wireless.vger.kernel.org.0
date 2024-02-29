Return-Path: <linux-wireless+bounces-4250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BE86C80E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 12:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600D128693C
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4126CDB1;
	Thu, 29 Feb 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRltwKpw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE67A709
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206320; cv=none; b=X3mhyRpuaMFeBu2EXQHX5WrWlAoTVim4Tsq4Y4vjYn3JF9eaM8Rp+iVEF2KDAi5e3xQKM29cHet/JMfl7KqKqFtz8ZQr8tNmL6Lv/6CgpwbIFpMa6874cULBvD83alUpib6G8jSyy59RrwpT1j4CznpAW1hFSSaGvQNn4tK+jvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206320; c=relaxed/simple;
	bh=s7MLclfoDIVbXMZQyAvYlIU4wj/BA7BWBB/EQnbj5zo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FDR2t/rfNxBK2teuvNpQIKj6DTCvfcaCngA2kZ7ZCYJRMbJip9v18kABHr3OU0aL83hnd3CkSSFaJrcx6UvBZSDffhwbvu3deIpZYODs8KyqwozQrjXTpwcnkexxiRd67uIaceLTc6XIta3esutwy9hJQ7lH5Sp2MH1ftULjbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRltwKpw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbff00beceso1222075ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709206319; x=1709811119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7MLclfoDIVbXMZQyAvYlIU4wj/BA7BWBB/EQnbj5zo=;
        b=fRltwKpwODQ8hoJzxU0uaIq0bO4+8MzYCqqzA/N3RzjX3OAWwvCLhgbG18+16SCPwt
         N9JaJNcx4DtqGGYjDXHe8jsZ0ifmJRCAQs8ScYoiwuw9ZuvzpzSOvBwmC9P/WjJ+WpGl
         EltHqqICByzkynrY0zQVuHE9y989JH1F396Xuexmfd9WpVD3wYwEoSPY/C6U+83ynJo/
         2SyzA3RqH4xQd35IAiQLUFCYszEp0MRe74PY2GOstwEi6hNfgl28DSXtUTB52XZB5prM
         r9l1lNd4S/2NVEUABlvsCwogH5aKOxPwrj86y0oY3YeKHuNSwz4/1DtHdxX+FqMrIwHv
         gY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206319; x=1709811119;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7MLclfoDIVbXMZQyAvYlIU4wj/BA7BWBB/EQnbj5zo=;
        b=CIafhlapcbw28zYEgtn7+nvBn4vMLfC92+KYNfMZOZOEb+OMs5x8PECqiy5cZnnVrN
         qx2ouZ73ghlrcXm4ypTHJJRqhry0QwjXPzOiWW1/Z8zxFIaB7G9drfMqFc0gVwsXjgd/
         zB/RVGpHjN+gCtxOVjN/OKXfVHvBk2+k2jDzORl0dkhQbq8yBWoKt6U5RyUXiyFAIq/K
         9WG+/+K9L6+xsiruVQ+2D1BMfzvlKo3KUO+dQdDzZniNdM0D5XE5R2GxKbP9kJ/1qRGC
         3j6g1MFiy616BregWRJASalHTNsO2rARlrb3tPcT040EtbGm2StM+Y/TQYApGjsJneeD
         reZg==
X-Gm-Message-State: AOJu0YwQ3SEs6DMoimqzDdJ3iDD5o+iqIcxyXaeHxCZ7KbcTmgIG/Zno
	GWou6NsBHGJ7KG08dCmzcK/jJHlEdRj49xXC52XgNZhwIouteu0/p61rNpph/nv5iTZaGcGW9L4
	11BdEz9XNRgorLMnt1V/GkPsEwqfkU3h7Lww=
X-Google-Smtp-Source: AGHT+IGKBgZiJHXaoYjiVGAajg5vJKu8fB3iA9Oh09PshO1+77bDZiMoNH5zobUkoOoryTmG1mGk70XswOocpyK1NYE=
X-Received: by 2002:a17:902:a708:b0:1d8:dcd2:661 with SMTP id
 w8-20020a170902a70800b001d8dcd20661mr1727959plq.5.1709206318888; Thu, 29 Feb
 2024 03:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Feb 2024 08:31:46 -0300
Message-ID: <CAOMZO5DqMjMj_-ohuNmKvWu+i1pN8LHXnG8fGYKrk=OH+mO2BA@mail.gmail.com>
Subject: wl18xx: Error when using the latest firmware
To: shlomii@ti.com, saurabhnarang@ti.com, guym@ti.com, 
	Nishanth Menon <nm@ti.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am running kernel 6.6.18 on an imx6dl board with the WL18XX Wifi chip.

I tried using the most recent firmware (8.9.1.0.2) from the master branch of:

https://git.ti.com/cgit/wilink8-wlan/wl18xx_fw/log/

but the following error is seen:

wlcore: ERROR Your WiFi FW version (8.9.1.0.2) is invalid.
Please use at least FW 8.9.*.*.58.

Then I used FW 8.9.0.0.90 and this version is accepted.

Should drivers/net/wireless/ti/wlcore/boot.c b be changed to allow running
the latest 8.9.1.0.2? What is the recommended wl18xx firmware version
when running a mainline kernel?

Any suggestions?

Thanks,

Fabio Estevam

