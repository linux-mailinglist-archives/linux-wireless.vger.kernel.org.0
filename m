Return-Path: <linux-wireless+bounces-22959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE6DAB757D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 21:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6801BA6317
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDB28CF6B;
	Wed, 14 May 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3R3kIPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB728CF42
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249902; cv=none; b=HJgZDYz5m5TBEu0a3b8Ist+urQWFcsqQgaaALFLhX/WB2V5z4ylS+zQL6iM9EecJQfn0NQj7RkT/XVsoH2ytyF9TSREO16YVcDpTADwlX0TLnH13rowj/GEXiDDDsI3MvLoOsBEst6DsuvjatD4aS785JjzkbpFLTUtH6g00EtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249902; c=relaxed/simple;
	bh=bWXwQRwhLY00gNFVk6E6zSASXQx8fsQ/knU5EqqdmUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhXyyf2TrnJmcIVzBacOcpqkDx7H3dcz4hLfo56qguFmz05E9uibyEO4riK0mzRewvLuZOLRkTwRR4iWFMVpcCAVpIwl6tf9Rcj27nxoliTLBskKndDwTqAcQHJiSbzbGoix/xIraCPhCL13i35i/8dLHFIy7odoyvheYy9XsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3R3kIPW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54e98f73850so47195e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249898; x=1747854698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1cibp8BgVCmIM8RKKYLy2LVmvp9e8BHlrGO6hEIP4Y=;
        b=b3R3kIPWO5eRaP87Aef+j41xUUDl9mT075+cwqSyH3o+vKEegSjHwPeMxBraGgx9nA
         5tnlROB6A0aAeO4Wtw30LQA2gRncVI8XoVjDbp7NlEMn5nYf8Dsx78hXt5/lAvFPoZ8V
         NlJsejpP3lOdBEfWJx0MJFg24L+TtOxjj8M9zO4tRKLF0JQI+fYPXN3oJD7FZPuO8f4A
         fpp8shZwrpYBeRjtQCUzWSgWw7iq1PJEEoAiQlTpLgt+z9zHOwWm+I3SWUduNw0sn1Vp
         B5I5CJ8xSF2gy9jvjw642XGaysG/Yf0mDbD5x3ZnUzL/caS8BnGl0sI+pSSaxLCoQ/Rp
         TJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249898; x=1747854698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1cibp8BgVCmIM8RKKYLy2LVmvp9e8BHlrGO6hEIP4Y=;
        b=NGG7HsW6qiKOSEFHigUfCvnQnug1UCxBDwod51LXzQ9s+Hcd6ATtOshAs3YPS8hXfX
         yUnj2T3TXzmRKrVNST3c4aGktl77tSCKvSRb6Z4JxHtXl9YJdu2ubJ5fwmqJOCgi/lG5
         2y6Eh36R3q+tlQuZouPX3ObcjLqHkJTM2HbZcb1uIEJsG097QjGtHlXEdU5zErDWECY4
         No6L9msNhOrE/M/qvw85uHM46bDusHfnd4VGeRdXO22MZX1Wdd6yksb8dnva2xakMPXG
         5bJ2Te+sCvtkqZ3pAx8jMOlWuZBuB8psEpXqdU9wKy1BiposC82p0TELjjW7yofwrlfL
         cptw==
X-Gm-Message-State: AOJu0Yy/8Ao+N+vlDK72FnsImPoAfkTWOmSgRNu0aQeY9pxnt+uV3114
	o6mHzFe76b+bIIeFTt1Gy2Drgg7C0GeDjyo6eMeEsv0RHKD04kqIYEoLPBMG
X-Gm-Gg: ASbGnctpq9Dina1J4l3/89kW8+8lpv49cXUfIMyQgOUp+fspEj+ihq/u8IMjfeRTQpc
	7o/6cgjcM/PJq5UFoLPDpyn9wKfdBNz28XwE8gc6S9eD5ZjYq/Rs5ZusQBJfqDi8sLFHfteKLQ2
	l8vM2Dh22Wqip2fETwQCQVdfLtqbuZNdjEQfw7nhKinoYtZjmafFoIRmcdmhzCsFgUDcFecB5cx
	cdvgoPxc51nBmtV12VrOWB2fgntYeLGPDFUwwLenyTLSIZnEHctR4LytsDh4+EXVguC81Lx9JWA
	/9xSSc8/pDNB7jkWOKT/ZJ1+MdeR2ygfXliCmAe/wym0LUhl5fFc8KpI9Hky
X-Google-Smtp-Source: AGHT+IG41fGPxXvnI8fHWa62pe7oYm+w5hP3rrN+DQgqCnfxOyBOADt2aM13wVUNgg/oAR2Q+KUPSg==
X-Received: by 2002:a05:6512:6310:b0:545:ea9:1a19 with SMTP id 2adb3069b0e04-550d5f7c512mr1659375e87.5.1747249897713;
        Wed, 14 May 2025 12:11:37 -0700 (PDT)
Received: from localhost.localdomain ([193.106.59.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64bf8ecsm2347551e87.187.2025.05.14.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 12:11:37 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: elfy.ua@gmail.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: MikroTik R11e 5HnD monitor mode
Date: Wed, 14 May 2025 22:11:35 +0300
Message-ID: <20250514191135.375855-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250514180413.373876-1-elfy@ecognize.me>
References: <20250514180413.373876-1-elfy@ecognize.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional findings so far for the RX side of the problem:

1. Upon coming from a modprobe && iw set monitor && ifconfig the interface receives nothing.

2. The inferface starts hearing packets after coming of a reset (verifiable with debugfs).
Changing frequencies isn't required, just resetting the interface allows to grab a portion of traffic.

3. Judging by tcpdump timestamps, around 1.4 ms worth of traffic is collected before going silent again.

4. After a reset we have a 2.5 ms gap between these entries (full debugging):
>[23363.517582] ath: phy14: TS Start 0xc4268000 End 0xc426c800 Virt 00000000973829f0, Size 512
>[23363.520142] ath: phy14: Doing Tx IQ Cal for chain 0

5. Then the calibration goes on for some time and ends like this after ~1ms:
>[23363.520886] ath: phy14: rx chain 1: mag corr=-13  phase corr=0
>[23363.520891] ath: phy14: rx chain 1: iq corr coeff=fffff980
>[23363.520928] ath: phy14: starting IQ Mismatch Calibration

6. Last messages before the log goes silent until the next reset:
>[23363.521178] ath: phy14: New interrupt mask 0xf0000473
>[23363.521182] ath: phy14: new IMR 0x81800175
>[23363.521187] ath: phy14: enable IER
>[23363.521195] ath: phy14: AR_IMR 0x81800175 IER 0x1

7. If I apply the patch above, the ANI calibration timer keeps going past this point, but nothing else is.

