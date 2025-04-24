Return-Path: <linux-wireless+bounces-21962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B92FA9A9D5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FD1444196
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A841EEA5D;
	Thu, 24 Apr 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr5TCV04"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DC46B8;
	Thu, 24 Apr 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489821; cv=none; b=r2rzJWthflzlfJFak8LGcWiJ9AZRTaGp20INWLCFl2eAfLkO/nG478+RiTrIaV/eAIQREw2J7xY9m/vk1HI2dv2+8LpY992UPV+4wqgc7CN4vWCMZOlAru792AKe39gRQrltKG7K+eR68lS+v2inizER642o9Y3X4SUDGdgzjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489821; c=relaxed/simple;
	bh=yfXM1WUeNYT3vmj9qVVHXyrTV7rNpEMGeMSekthQuOg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jQ5beB2DH3pAmAGY/efYJzeK9uMNHo1IjnVe19GC3ikoMYdf6C6oi5c7KXzBYygcc7HHT18gJjvN+lpXB3mpk3IO9S8bqigjzwEvXWBFA6umg/fnqDG9RsYuft1fVAaELg9FCaJWtLHLUtWuZjnpmUJVNsVkXmnzvEtili6m+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr5TCV04; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cee550af2so425655e9.1;
        Thu, 24 Apr 2025 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745489818; x=1746094618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFPjM8NK9GyF20CpuZlo+gQtBKK1SMRDaSpIXrmNbvw=;
        b=kr5TCV04SY2ZY3xwQ+OEZTbzqFfLoAW+ZP1GFAJ/0BGJrmBx9KsxZ1DE5RXC2ZK0EK
         p1AVzp9eNELdoLEZ7/pCkPJWOtNMhbavSz+s0xT229umoD+HvjktEPFmeHgiSin640j8
         7jrrdcDo1TSL4fxfKT2OHIxr+/LhxMW4xzeZSsMZQFfIL6EWWk/yzLRt/KKq649b/J4t
         tUYSMXaO5FGgKlJczFODXVChBiVkGOFvK92+Fxc8hSsbniH8WuNDxQPUmouzZvrZsuHZ
         ryssFqksxrdk6ot3Uo29+uqqMmgmBzY/+zMHcNL7M5ehipne1PE4IMOAJ86lIb4Lxun/
         7KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745489818; x=1746094618;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFPjM8NK9GyF20CpuZlo+gQtBKK1SMRDaSpIXrmNbvw=;
        b=mCmwTNvh7dYdoZyqRpNFzO5+BKbJ/4SRCfhF+mxH1yIbyGksFrL0JgTeDv9zz2V2lK
         vt411qAYD4ddj4IASTJ0MO63eSibXRdX6vq7I/mFFwNcUia7y0tfdtRA+wAXulfGpNYV
         +YzefUIBQN8TRvz/7w9iKnW99yWhO6UScS2nCDLeb7urB1n3XYNRzp7YTSgmxmu5bjrH
         L2FQ2Hddf0KDunzLFnj2GXF8PoexSPfLKGMLBeTagrGZptanfhoERw+payF6GT7MNddG
         ZKVWgCj7Yfy+Z2+KRzHvNt2aryprWisSK9KMNL3DwOnvl0Usw854TpPCtndcJfTepR4V
         ofMA==
X-Forwarded-Encrypted: i=1; AJvYcCUvP43FQHnS/lM7G6AkAcBis7XMf8jQDAHqh7KtrX+wLeqYiqq3S5+rnHkybKyUo6OKeF0pskQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDoK05oGUFn1kklnHJjI7Hlj3RO6zhA4dnJH3oYGgLzQtjG2q
	/GvUfBpFMaNVj5kVmNWPUnUCluBx/gqtFkdvj9hUNs790HHCGCpw
X-Gm-Gg: ASbGncv2Oq0Rv5730l9F1wdpb4kekN2HVNpqGB1CvQzkz+JAy2m1mBL7V9aY+josaQ1
	iDJzIsHXeboHVFHXd94GlwPlJhoYVOtps2x7eQvb09LjPxzvHVyz1qCQG0ZX8xsr99xsEcdX/6a
	ckETETMJL0pZQDHQ4emon7+TxvRbcUCSqIVj4YTz8gY8CqdPcObPZEtl5rkaYAlf5Kux2+0no5q
	Xf+pe4mGtQVFoCSngF6XRDJUSF1PkKSCYX6Lde+FXKLdJJvHvY2fUhPgY+UpRdTMOj1TYGzunwK
	+ZMgBccRu/auIJ+vi8eBZcvECjSy29VnP3g36sqpqCbCNPY=
X-Google-Smtp-Source: AGHT+IHL94sgQwqKY15lIUcNNEjM6NiojQ5BvgYuP6XkWKsj9tOrpDMsNcnIJAOjkcwR675PXnz0AA==
X-Received: by 2002:a05:600c:4706:b0:43d:2318:ed7f with SMTP id 5b1f17b1804b1-4409bc057b4mr6833625e9.0.1745489817395;
        Thu, 24 Apr 2025 03:16:57 -0700 (PDT)
Received: from [192.168.36.152] ([82.66.27.2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4408d04802fsm46884505e9.1.2025.04.24.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 03:16:56 -0700 (PDT)
From: "=?UTF-8?Q?Jean-Fran=C3=A7ois_Ingelaere?=" <masterprenium@gmail.com>
X-Google-Original-From: =?UTF-8?Q?Jean-Fran=C3=A7ois_Ingelaere?= <MasterPrenium@gmail.com>
Message-ID: <04dca014-881c-46b4-a084-2001c62b466e@gmail.com>
Date: Thu, 24 Apr 2025 12:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FW: Wireless speed regression issue with >6.12.12/6.13.x +
 firmware update for mediatek MT7925
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
 <Mingyen.Hsieh@mediatek.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CACr2tqu10_mXiXw-Q3VSqYBJhQU1s_m77_uhvjpe0j3H3jhbgA@mail.gmail.com>
 <TYZPR03MB61644B8F34946A73E2C16E27F4DF2@TYZPR03MB6164.apcprd03.prod.outlook.com>
 <5a07aea2090532682c8cd4df3ab1b9026f2e1cd5.camel@mediatek.com>
Content-Language: fr-FR
Disposition-Notification-To: =?UTF-8?Q?Jean-Fran=C3=A7ois_Ingelaere?=
 <MasterPrenium@gmail.com>
In-Reply-To: <5a07aea2090532682c8cd4df3ab1b9026f2e1cd5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello guys,

I've just tested 6.14.3 kernel which seems to include the patched 
driver. Issue is still present, in Wi-FI 6.

Here are some more testings :

6.14.3 + firmware-202412x speed is NOT correct in download but correct 
in upload (20Mbps/750Mbps)
6.14.3 + firmware-202504x speed is NOT correct in download and in upload 
(<10Mbps/<10Mbps) 98% of time
6.14.3 + firmware-202504x speed is more or less correct in download and 
in NOT correct upload (400Mbps/<10Mbps) 2% of time

With older firmware, speed results are inverted as in 6.12.12 kernel (DL 
/ UP), with newer firmware, upload never work correctly.

Please note the speed is mono-thread/mono-stream (ex : iperf -P 1), 
while running multiple simultaneous connections, the DL speed with newer 
firmware seems quite OK. While I'm not having any issue in <=6.12.12 
with mono stream.
Remarks regarding upload speed doesn't change.

Any idea ?

Best regards,


Le 17/03/2025 à 03:12, Mingyen Hsieh (謝明諺) a écrit :
>
> Hi,
>
> Thanks for reporting this issue. We will conduct testing again.
>
> And it is already known that the patch added in 6.12.13 does have some
> issues, but we have also submitted new patches to fix.
>
> Currently, these patches are in the maintainer’s tree. It should soon
> be included in 6.14 and then ported Back to 6.12.x and 6.13.x.
>
> Perhaps you can test the driver from here:
> https://github.com/nbd168/wireless and apply this patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250317011724.3326979-1-mingyen.hsieh@mediatek.com/
>
> Thanks
>
> Best Regards,
> Yen.
>
>
> *********** MEDIATEK Confidentiality Notice ***********
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or
> otherwise exempt from disclosure under applicable laws. It is
> intended to be conveyed only to the designated recipient(s). Any
> use, dissemination, distribution, printing, retaining or copying
> of this e-mail (including its attachments) by unintended recipient(s)
> is strictly prohibited and may be unlawful. If you are not an
> intended recipient of this e-mail, or believe that you have received
> this e-mail in error, please notify the sender immediately
> (by replying to this e-mail), delete any and all copies of this
> e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

