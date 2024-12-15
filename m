Return-Path: <linux-wireless+bounces-16399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F59F2515
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C700F1607E0
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A819048D;
	Sun, 15 Dec 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hpf0ZGEE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD41758B
	for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284017; cv=none; b=OV7JAobu+dos7hC5fqb+AScKYcn62KpDlZHPsGzNLWZ9i+zExBNU8r85lvlyFLnFgjT3PKGgSmSNI6ROkCHHl22+g9eOBtesv5+2MGPIsfbOZurUajX/ZU/oUBCLFDTMCsqpRhKLrR2JYVA5F7QPXoiiY294qiAjtzlGfEUmr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284017; c=relaxed/simple;
	bh=FS5b3ZtEtrlrdhN68XfcJL8gjYnve3wZU2ads3mas0k=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ubg9ig+LSt7W1PeLgqARQQNEvaDcsu9zLcFcJMTnKZIRj70RN/LSDELr7ldXBXaP5+pbJSaH4f0lUyuVtJR6XJ0NvASwXGWO8OBDnjRvDgmCKJlUxjcnFqH7DJ5/a9up3c6ipP2MFKCTovj4l0m5Y2vWDoAm9ZO9L8RXP4haM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hpf0ZGEE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso6235182a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734284014; x=1734888814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS5b3ZtEtrlrdhN68XfcJL8gjYnve3wZU2ads3mas0k=;
        b=hpf0ZGEEknYPtUfJ3dN4itFj/MOMFszmuRW8ODMOpiSIiFtbv2IpUrceeceFHS2FY4
         K703pHHvRIttD1KgtNeNfu1Y2+ngEa/5txG0ODwTt7Y2N4Q6m/PuClrfEMfb3FMzAIeP
         X/Lw+hCFZ2UH5GYfGHPgpmBavMNv+LYiBpKwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734284014; x=1734888814;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FS5b3ZtEtrlrdhN68XfcJL8gjYnve3wZU2ads3mas0k=;
        b=pqoyo6h0uZPn823oNuPQzRhNV7sJO/LdkVWCzVXtaT4iAvbsRgLaHyS5mRz4EF0QpX
         wgaSx930cWQov6kAn+S7y3jeByO0GL+VWPrQiktfjRVJ8642mo7dogXms45nXyENHnnU
         PrvMS7kdv2O/6AwLfCNTARDAADsUHuDuLSh8nVpMgoPB3WQ2PsINOoM8bfGKGJ8JgznD
         aYgMpy2WYlyrvZEYO1LoQndBMsWU4ur7mqDxoexSD1sbm/oSFnJxTf+v/irwd82FZvCb
         RsWXkrXQ8DzFPNWWKXVeRI+TZr+7LJTCCvPVouXVL1sRa48kGYXy199g8PjpryJQ9LqY
         I9rw==
X-Forwarded-Encrypted: i=1; AJvYcCWPXj6A6WHs65roCEIIEHivpDEHdB8C9GtiZf4pXEb7YBgYUiKz1WwHVDuRBQ8UHEE5r6HWnqz6CtDhnElpSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3X2I83dvbguXx53qiSy+K7ShwS11j8goQDXWSvaUzwg3OLkVI
	zQJxvJU0ChVWjfabqgLavsDPZ1b0dK9LQufwkOD4RDAcpAWnrKEpRrsewNGyFA==
X-Gm-Gg: ASbGncsUOGZbPHcRgsQMLOEFzTfmQlxVOVaJLSWig2jOjfYVqLjcK7WulzbVUOBG7rI
	rOj5bB/dfWQuH5CCSN8xj40Z1q/SjqBvjH7a1i11JOTgQCPdphFhOeC4i79jnP7Udx1tGhU9bt4
	DgkuCZa0fbaXRahY/5OWtgABq6QAm+d8gilfBgGxzTtq9DVs8gPRzfTpShBNPUEfllC/ouj5eh7
	LjwIiqa/h9nov9jylQ1mRt8VUB6IPshpGT9lTPFfWZm3u/D1sKY7N9okesSZJubfzagdxjoV0KO
	3+s8rDVu/eBVK1UnlQM=
X-Google-Smtp-Source: AGHT+IGuds3i4q+BA3H4MOun/bl8g8YBnInjucpDSfM1WD+kqqFaeBZkuXp09jXqFKZpbUgwzJfqzQ==
X-Received: by 2002:a05:6402:3908:b0:5d3:fcca:cab1 with SMTP id 4fb4d7f45d1cf-5d632b619e7mr10761085a12.15.1734284013701;
        Sun, 15 Dec 2024 09:33:33 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5114sm2309179a12.5.2024.12.15.09.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:33:33 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: <brcm80211@lists.linux.dev>, <linux-wireless@vger.kernel.org>, Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Date: Sun, 15 Dec 2024 18:33:30 +0100
Message-ID: <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com>
 <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
 <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com>
 <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
User-Agent: AquaMail/1.54.0 (build: 105400535)
Subject: Re: brcmfmac SAE/WPA3 negotiation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:

> On Sun, Dec 15, 2024 at 6:12 AM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On 12/14/2024 2:34 PM, KeithG wrote:
>>> Arend,
>>>
>>> I looked through the info where I got the latest firmware:
>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
>>> and did not find anything, but I really do not know what I am looking for.
>>
>> I think I had a bit more luck and maybe found the needle. I sent out
>> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
>>
>> Regards,
>> Arend
> Arend,
>
> Can you send me a link to that patch? I want to try it.

Hmm. I explicitly sent it to you, but here is a link to patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/

You can apply it on top of the other 3 patches.

Regards,
Arend



