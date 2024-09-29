Return-Path: <linux-wireless+bounces-13281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B0989531
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67D71C20C1E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6C17736;
	Sun, 29 Sep 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqN1S2R7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15491448E2
	for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727610210; cv=none; b=NEpnGW7PwWhXDBcF27KMJ380GFvNGDPsVm2XVD2dmq4c5B5lkmXnYUMTIt1n18YGw8/PO7bI15ywuLaEwe7m0jBH1SQ7kUAvQ31Fv+W4dyRLrJBX6kdB5pCgIn8KxAGRCzy6HTyEmkOkKUi9yvJPA52gNmkPc0H3xOBJ80mvMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727610210; c=relaxed/simple;
	bh=V5sRae3XpPpL0m1jvnlX8E0z8H08aMNkGSw6sHDQiTM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QUiKBVOvRoFAhNqU4SCLv/6dO0SHQuN7pjwP8i03ZlO6RQW1O1IBM0LLy2izJYdxAU+i4oIfDIQZXHv70x6MGZOFIMlBEDA5xmdwYckcTVm5+TrBbzaPfal82SjfkcVJ0lPiQ7Aok1rdFkz3d+wCXXBCkZ6epJ4KOwwpGCqVBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqN1S2R7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso640481066b.1
        for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2024 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727610207; x=1728215007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=624fhbZBZNbMqnc16Sgap7txMDIiSnuHbxfm31s7UV0=;
        b=gqN1S2R7Q4iJTzSV3ymxjDx0DkPMfx2qmbKlvfH/Z1JJpVWnX+XUVHjGEsLxnVpgX+
         xxFmCWmh1RQEB3vUAD8uFNO/5Fs2lk3Evg4c7BPeCVTL85ITPflnmBccTKtkekIkd9L7
         ZuDKJ1ONp5+aFr3xWPgwP1+n1xk/KK25rbIr72cBW0Cm+IfnxAkCtPTg6mIwLubCXZmG
         0fVtFnjbXbcd2RIKGv3Wmbi0mJEEi8VZfacg/8skuTIdVmdkE+ibF08AK512TjKpBCje
         dlZiMHivNweGessxg4ky47efJ3AS3n6ysIFDu/Q6d3H81YzNTNTKXU4lvm7UquDISH25
         fejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727610207; x=1728215007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=624fhbZBZNbMqnc16Sgap7txMDIiSnuHbxfm31s7UV0=;
        b=KOq0pp0c+zYhBaipDKWiVdNMf7NiELkDyjB8L+iyznah9h0TXq1lTqgFZDxg9lZhcb
         UpAU4AdezPdpEv3A0E7WPQgBFKYOuVKXFD9TfgYgEsuy7D8aNxqE6ialO8hzHUWuUibY
         Jp2ibRqLFSUdLKdCMEb/hJR4SHEfJKFbI1li6f52pm1d45JRJMMDRboXOsqvkXUZyRk1
         urKjxqRohGU5TCZFwETq6RAxuRCf9JlL5/MIb6alD2jxC3X46xAwuJSpkpAgDi3tzHs8
         1VQd3PkpSTf4KZ7Lu3pV1awK9PiNmRoSMEvkNab756rNPO/CEdTtLYWv0yGlwipwtK9j
         lDKw==
X-Gm-Message-State: AOJu0YyJzQoQrUDib562QNlrfRYMS5PJkA9wXtIrhq0K+Rg22VEjoo78
	SMidlWP4vaczna/0nP2SrUWw2rM9aunJJXR3eYVk0SPOGC6Uv0f/49JR5w==
X-Google-Smtp-Source: AGHT+IFoU8xbEMsmHbOoaUfvSmC+P31FPz8kpWLUO2fwzAKO+YVMmT0lqJbpCsWycxMe9vx5/0bh7w==
X-Received: by 2002:a17:907:1c20:b0:a8d:2bc7:6331 with SMTP id a640c23a62f3a-a93b1677b10mr1452691166b.27.1727610206786;
        Sun, 29 Sep 2024 04:43:26 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a30dsm365323366b.160.2024.09.29.04.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 04:43:26 -0700 (PDT)
Message-ID: <ca68b936-2416-48e8-851e-45111b62f501@gmail.com>
Date: Sun, 29 Sep 2024 14:43:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: USB devices randomly stop receiving anything
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
Content-Language: en-US
In-Reply-To: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 14:46, Bitterblue Smith wrote:
[...]

> I have the device in this state right now. Is there anything else
> I should look at?
> 

The host controller died when I unplugged another device,
so I can't get any more information from this one.

