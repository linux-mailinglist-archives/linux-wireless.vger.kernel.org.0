Return-Path: <linux-wireless+bounces-10483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8EF93B184
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF71F285A7E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07661158D75;
	Wed, 24 Jul 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcaPWlBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A6158D6F
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827385; cv=none; b=NDfuKLWT9gwT5ZHC2+LCRAlUBIEZyQjhjmmSFnal5OTPs7S58LYRMr7C3WRejrWeBzl9fxFJgpB95oPLKjdjc72lVHAgnapmU00AXAyi2IgkU5UEXd+doZbXFjabSlRC4bc5Wczle4r+IHg9+fJiANLua4af+/gV5afnO1SnEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827385; c=relaxed/simple;
	bh=Kj/wKUM7e23DAVZAStjdK5/fuQPzs3EloAOkITnKKEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=geraPpmLgoG9KeLEA/7adRYgG9AgAkofXcSCwMYVBAuVjRiIjGJdofiY/5dJP+diGXpl1foAAp/p/8GDCvt0HkloVE+Cpc3hS0fJ63AnG37cAYbqqPAf1+qXbSfoIvPsrMMjc9QFRT5HvEl1SyzWJC/56yJ9ITlmIFsjhWkBQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcaPWlBA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367940c57ddso3649256f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721827382; x=1722432182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj/wKUM7e23DAVZAStjdK5/fuQPzs3EloAOkITnKKEs=;
        b=XcaPWlBAJMVcqukdwzdPlkDY/mAT19RaGb7DhWku6aAy2P5kId1mdW+iZgCJze+oAR
         nqRTSwzeN7GXKQOsubUB3cPn+Ut8Zk1BDhDlyQp5L4wzYu/hOW/WXE6NA2CO1z0zxS1W
         HPborvyXxoedd7z42wbBtkdiddRbDb6/00QnFLeZZuCBG7qBfB/t2IRheVnQvZTSgGWB
         bGGpMp1fTvZZsj/hNwEr6rpI6rcOLAMNbiWUjbRNa4MsTFJ7e1WEoL+C/KUKox4Pd60w
         ElhuCMb8ptdzjvWL0TYoBTWc0NjImwMY0X8Ad8C78LkHk0Yw7Ka+Q6XnmPPdgafn2YqC
         GbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827382; x=1722432182;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj/wKUM7e23DAVZAStjdK5/fuQPzs3EloAOkITnKKEs=;
        b=JRoOvh7XGgpMMwDPol4imPoU3SBYYzhvCIm0z1pceoYGIzzhWT/klengzoz0WqYVOg
         SBNCTkgRJPAiN/KM47LPM94Xfu2zC0CnPAQTJ/zYzzXnmQZO0NDAs39JjvC4FZiJsabx
         nkFyspIH5aOzTiM3tPaGc3cbL1dOWlUrzth6sNbLgomSU8mGIWhbnNxF7CcbhZy2FN0R
         cpjDJz7AAmxTfYUyX0ZcXE99LFVEq8xB3fpUxGgHMLx/XhyE1531zWJEGdADzeKORU46
         db5LC/WuEmGU78c8o9KVSoCg3/fzW0xzyqkjVPNPJbo8Q8mP/Ov7qJAVgmIpUQD80zHh
         5Frw==
X-Gm-Message-State: AOJu0YxyvFUi9wm8tkvOn8E7507WRuud1vSdSIKxKaikk5zS/THTS1ex
	IyifKu5ihcy7eYyWFe2nIFkSv4d3KoPzp0aIz99xgErYnfMCQz6jx4jzvmCr
X-Google-Smtp-Source: AGHT+IH7PgRZmH2ZFGrqlKg1Ugzc8B6YjFZHZou3SHfSOFIsRGbPR4Ok5Xcn9YAP8Y0Sgny28+ZsUg==
X-Received: by 2002:a5d:4b82:0:b0:368:6561:daba with SMTP id ffacd0b85a97d-369bae25141mr8200959f8f.31.1721827382253;
        Wed, 24 Jul 2024 06:23:02 -0700 (PDT)
Received: from [192.168.0.188] (asfd-05-b2-v4wan-170068-cust1033.vm14.cable.virginm.net. [80.192.20.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878811899sm14289703f8f.116.2024.07.24.06.23.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 06:23:01 -0700 (PDT)
Message-ID: <7c728fdc-6984-49b7-9361-cc1008616e15@gmail.com>
Date: Wed, 24 Jul 2024 14:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi ring buffer log spam on kernel 6.10
From: Adam Macdonald <adampoke111@gmail.com>
To: linux-wireless@vger.kernel.org
References: <d115c07d-4e3e-4e9d-9704-f0cbe159b986@gmail.com>
Content-Language: en-GB
In-Reply-To: <d115c07d-4e3e-4e9d-9704-f0cbe159b986@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As an update, this appears to be exactly related to https://bugzilla.kernel.org/show_bug.cgi?id=201761

In comment 75 Rafael Wysocki links another thread on the mailing list in which there is a supposedly working patch.
Hopefully this can be accepted mainline soon after testing.

Adam

On 24/07/2024 12:15, Adam Macdonald wrote:
> Greetings,
>
> I have just upgraded to the Linux kernel 6.10 on Arch Linux last night and am having issues with the thermal driver (iwlwifi) for my Intel AX210 (8086:2725) being unable to read out one of the thermal zones (the only thermal zone?).
>
> The following log message is repeated about 3-4 times a second in the kernel ring buffer log.
>
> [...]
> thermal thermal_zone3: failed to read out thermal zone (-61)
> [...]
>
> The offending driver:
> $ cat /sys/class/thermal/thermal_zone3/type
> iwlwifi_1
>
> I am currently running 6.10.0-arch1-2, but was previously running 6.9.10-arch1 without this log spam occurring.
> It is important to note, however, that on 6.9.10 it would previously fail to read out the thermal zone _once_, but not continue to retry forever & fill the log:
>
> Jul 23 14:26:09 milky kernel: thermal thermal_zone3: failed to read out thermal zone (-61)
>
> Thank you for taking the time to read this email
> Cheers,
> Adam
>

