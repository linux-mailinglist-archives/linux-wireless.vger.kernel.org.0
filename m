Return-Path: <linux-wireless+bounces-5372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E35988EB1C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 17:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEACC29C890
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5D130E3C;
	Wed, 27 Mar 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb6cps81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E386130AD9
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556706; cv=none; b=R2L+GzFMBRKv7M4LvzLiWLL1Zrfob4IMapdVUa/palx1x+7eiBXXPpGf4TnM6kFRNREsid+m1oEZJZjbnzpYdhGcQflHjydkKw8v4/DlcmGSuHB04FNuNvZWSxrvz6Kt3KudaPKWlgtSkR1n+nr1FYYklz+6F+AreaRotkY4UwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556706; c=relaxed/simple;
	bh=vEeS0T+9oSF7LaLYATmLCGsqoYTcCl1u62o7KNQ1PD4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JeWTMKEDLOM2VQDfEFw2/GXujTwWdE9Ephi+95GF9w/Mi3lJInT5UuREntr7hjeLFejY0zmKW8RSqhtlMD4cd3iQDpGv3lkL8WaeNrydzePYidAXETERnzSP5/X6kH1rl1EpcJOtqeFODFwLJH1OtCk0rPDzHSBBaHgPDyZayqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb6cps81; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6d0bf038fso3339a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711556704; x=1712161504; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvLMMq6An/dV3xRL7BAobHZ/G4zYgll+nZ5HKsJn96M=;
        b=jb6cps81SJ4ytftPMo+CYq1CcaZXD7xP7TyAUQOZPq7KqoGWpjm0iS/ivSD+nRcnZt
         i4Qi52lyyGvVcJmH0UVC8u5rE8N1dlaVzIv9JCTOZ7aq6nL0EYksEEvFLIJCin25acKj
         ReNuZKKw0DCLRO5O0IIhPRfM7c+56NA0VDBF6/2yFrGU9rRBGmMaCFBSVFp/+lPgx6Tk
         HjeRcARmDvMjscU61UmOuZZF7FgIQfj55sFnypLDAjcPW1AoW4yflPE+u/zRmdi/Krwq
         X03k0w/kyklu7UkFb5kv04yDiWi0mhRcAVE6eaXNwrOm27hVgIZne1/2TzEv+EqRTHEY
         lKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556704; x=1712161504;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gvLMMq6An/dV3xRL7BAobHZ/G4zYgll+nZ5HKsJn96M=;
        b=SYDgGv8XTpZ0tN0KvWgtMfm2yiR0gtI3VeuODFXHN3PwbZV5hPf3lLcWNj3KsJo+2w
         IvG5/xCInaA3Bz7QW4mwwJpOBcHtnfx3B08KX8NjeUVR+oRMQ1QU6PgUFmoOpsYFzpW2
         HDOpBBbJC+JYxmLN/a3ahOqRO62aHWIctQOguKBYUbp8NQo42FYa7oE/Hdi93zeCmf3v
         /iAGsPporjwAfczyXY7JngpwRaMkHXcFUf3eKtccE6Ij6MNfm0biSoKLx63A+X+LTFNF
         QXnNebG7hR2b4EA1YGNydVu40KbA7pUpw+D6ganEfkStjt9E++/9DpEyQmM5ogspebDB
         SPag==
X-Gm-Message-State: AOJu0YwaNNf2prVwF9/aJMXfXZUxAz3+w/0V31vcYvmxXLFhObWsZyNZ
	Yps14jxgU4WD+tNQu1wLcgRw+cdR4ByhIkIh78vOxNOzpNAryHVBUx3cXY80
X-Google-Smtp-Source: AGHT+IEV4jKhHjdsLz7oyXlyzvVaeE5HSDRVyliZlQOq2R6OaeBib6msQJ2RGsgoRmQBp6Ja5uwnbA==
X-Received: by 2002:a05:6830:1681:b0:6e6:c5c9:dff6 with SMTP id k1-20020a056830168100b006e6c5c9dff6mr465896otr.26.1711556703982;
        Wed, 27 Mar 2024 09:25:03 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o6-20020ae9f506000000b0078a4541720csm3902604qkg.79.2024.03.27.09.25.03
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:25:03 -0700 (PDT)
Message-ID: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
Date: Wed, 27 Mar 2024 09:25:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: ath11k failed to enqueue rx buf: -28
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

This error was brought to my attention in the kernel logs and I'm 
wondering if it is of any concern:

kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28

It seems to happen every few minutes or so. I don't notice any bad 
behavior associated with it per-se, but maybe its an issue of some 
buffer needing to be increased in size? Does this mean a frame is being 
dropped due to no room to receive it?

Hardware we are running is:

[    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
[    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb 
board_id 0xff soc_id 0x400c1211
[    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e 
fw_build_timestamp 2023-12-19 11:11 fw_build_id 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36

Thanks,

James


