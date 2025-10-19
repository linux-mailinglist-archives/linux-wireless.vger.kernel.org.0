Return-Path: <linux-wireless+bounces-28081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C66BEE3AB
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 13:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88AA189AAED
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560CA29E113;
	Sun, 19 Oct 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F6TV2LrW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247F29D288
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760872787; cv=none; b=SU0CtwgQI0H2SA79W5H5V4993Bjy4wDGaaWUeNmpRo4rxcdQLeBpGuDvnAoIjf0VlY6+3rQavzsNfZohV3qWXPnCG3nzZE7576HKAaRXYqjuVlzlsU9D4/VdLh3umKxDb8ZA1hirAHHMnNM3IM7rOZ05VDPT6VFRRh286Ss6pj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760872787; c=relaxed/simple;
	bh=tEkQp2sIfkQfzEDx03lu2c624oUqElD/6WOKBOub6o8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=T2fVafz+yvWHXHYA6ICDMtpjEpc1du1ne+SPbdgiWe42DqQJeE7u9wGx63HLbT5vwpf6B593NPrYYuy/B+eOS/TA5Fjb5GAGZlTKmJmZJxVu5kGprNzIAFH6j1zszSXGI+Ra0qa0SNQsxVO+qFu4LUbrT/CQJNQyGO06xjVSRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F6TV2LrW; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-940d27610b8so23342839f.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 04:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760872785; x=1761477585;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TsB+tDEbHrQirUzM2BvJAhO/Udv9gdfHtlGbbHKvJc=;
        b=Au+/G/Dp9qMtyiUerk81ZeHzVlknK4jSY1PhcugLd2PaFZc6sWl9ZryZn9ESAR/bTf
         j+5q5GFHoON1WOeyRIJGNMISw4TOX9O1RNKg/pAhN/x7QcC54Vz+5BbU11vSsnKXKNxF
         p6qfDwwMcWdbCdo0Hof4Vl8/1Bi9SWjfPaZ28pnJB2+4gtNu/FCwlInISgtFuUGre98X
         SCra+qfeqU/McibZr+BnRC+ly5TBT10KSMTQFckK5bcujF2ZDn5mJ/2l6ESLvHsdOgUb
         92CRL4QMyHwe7BJ8qDzP+SmaAIr8stll2f69K5u+jkLfWS447nwKJxSAZT8mbhGZEDIX
         Xy0w==
X-Gm-Message-State: AOJu0YxeMABsh69cL4I079ia04pG9eQygdqTnFn+OI418ZjtxMvIgznP
	e2u5KPNnUALtlyOy5RCINkMOfvxzeW/lm+06pK/ssZDSCIyUj/LMs7HTywxyd5U8mdpq21hAxkH
	3l28UE9cbbiIpChjLfU1GlY835wJUC/rDuHJ/nTF5/WNg8YykIB/wyOxBA91lYBBFBYxkPn0dW0
	qVwZp8lvgsIZOd1jOAKVofOutsC6Nk5Nxlax1aMEXqnI9wIJ86raaZ9Sl1f+WptDeMbJutTrTpH
	7EOVPXBmeyMxVBSgDAsJySEz7Y9OWI=
X-Gm-Gg: ASbGnct2pSkXKBhWd9o17TK4+rJerTPu6PAblNo3uW7EAuritEJ4Q3uRkKKRw+VAuFq
	EX5ATSutLCPrrUlh/M5w4jp0TqIdQsiZJhJ7ydIRbetnIfbjBckGl0T2dpgqeTVa7rkdfvnl0k+
	VUOlciwLeCR+iOSA5teXkxPmaGOGxvWY3yDZc4Rl6DzQftiYX0bYcSs4sZL+U+RQ0zxR+Tc4V6W
	XRSbNW4WNA6JClNsFc8oNEuXUUPOgsBWpCQNKxm6d//18CWQEPgB9xonFFUhFjulo+eLBgkV0QN
	QJXtYG9OzNiZCE3frV6rCd+GGESXeAuZAKC6XJkRlE90yCkiSrygHtlTBb7Idt8rlB6XcuZ898t
	xmRFDbzXf3/9JFsGlCJ9JCe1QHltHVgbGWFSQjlOaySqZdN1nA/+Tzw2dB8guuDGQDSVfso/WJd
	/vzRY9/ImPBUB+jjSHEKtlwUKqdLM0GXabVvw=
X-Google-Smtp-Source: AGHT+IEV4uE+5dI4VJt1jPUHq4tVlPhsrJhH4rKgJB7XGhuNV/nAoFdtZ9dv6X1X8nXTRHE4bwm+A0WjzccK
X-Received: by 2002:a92:c245:0:b0:429:4c65:e8f7 with SMTP id e9e14a558f8ab-430c52d775cmr130712215ab.24.1760872784831;
        Sun, 19 Oct 2025 04:19:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-430d07b3dd4sm6051615ab.25.2025.10.19.04.19.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Oct 2025 04:19:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b5cbb3629f2so433878866b.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760872781; x=1761477581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TsB+tDEbHrQirUzM2BvJAhO/Udv9gdfHtlGbbHKvJc=;
        b=F6TV2LrW2DNTfCoj/USCiMh5r6ppJtJyHRkKCiGiycYQZzi7QQXc1pOFpT5PsQBrbk
         Tsi/HfwSzhUB+cVcY58/twcDBAcuQD5kmQR5ODyKUPzZQn3+yRrg2tUammRNhIdelhsw
         t0MbIcpgc9QNPzh0oQIkEt+ujHWeEP2XLvBCM=
X-Received: by 2002:a17:906:c14c:b0:b62:ac4e:c14f with SMTP id a640c23a62f3a-b6475012dd8mr1084722166b.54.1760872781372;
        Sun, 19 Oct 2025 04:19:41 -0700 (PDT)
X-Received: by 2002:a17:906:c14c:b0:b62:ac4e:c14f with SMTP id a640c23a62f3a-b6475012dd8mr1084720466b.54.1760872780874;
        Sun, 19 Oct 2025 04:19:40 -0700 (PDT)
Received: from [192.168.178.31] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391523sm479130766b.18.2025.10.19.04.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 04:19:40 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Berkem Dincman <berkem.dincman@gmail.com>
CC: "linux-wireless" <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Sun, 19 Oct 2025 13:19:40 +0200
Message-ID: <199fc3250e0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAC3nzgJM6azT8T4StreR874h5sUarLH62mgHvRZndV_XEOBEgQ@mail.gmail.com>
References: <CAC3nzgJ9uX3rREGQGbLA+oJMzDh0Bc-Fs5sP1sM_4DGScgq=3w@mail.gmail.com>
 <977b67ef-ef6f-4ae4-99db-eeb921a17e3f@broadcom.com>
 <CAC3nzgJM6azT8T4StreR874h5sUarLH62mgHvRZndV_XEOBEgQ@mail.gmail.com>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: New test release reload driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 19 oktober 2025 01:45:47 schreef Berkem Dincman <berkem.dincman@gmail.com>:

> This is dmesg the last lines after reloading the driver module

Better to respond inline and avoid top posting.

>
> 18 Eki 2025 Cmt 21:46 tarihinde Arend van Spriel <
> arend.vanspriel@broadcom.com> şunu yazdı:
>
>> On 10/18/2025 5:38 PM, Berkem Dincman wrote:
>>> I have PostmarketOS on Pinebook Pro v25.06 it has an 6.6.34 kernel
>>> originally I have custom kernels 6.16.7 6.17-rc7 also booting and wifi
>>> working 6.18-rc1 sends alot error messages to the screen but works fine
>>> if the driver (brcmfmac) is reloaded
>>
>> Thanks for the feedback. I would be happy to look into the 6.18-rc1
>> issue, but you are giving me much to work with. Any kernel logs that
>> show the error messages would be a start.

So the error messages indicate communication with the firmware on the wifi 
device is broken.

[ 20.068465] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[ 20.069067] ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec failed (-110)

But the firmware started ok because I see before the failures start to occur:

[ 16.137950] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Apr 
15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID 01-996384e2

Things seem to go south when Bluetooth is starting:

[ 17.273314] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0382
[ 17.287981] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 17.288011] Bluetooth: BNEP filters: protocol multicast
[ 17.288032] Bluetooth: BNEP socket layer initialized
[ 17.319081] Bluetooth: MGMT ver 1.23
[ 20.068465] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

As Bluetooth resides on the same chip as wifi I find that suspicious. I 
would like to know what happens when you disable Bluetooth. Can you test that?

Regards,
Arend

>> Also please put the mailing lists in Cc: so other people seeing the same
>> issue can chime in.
>>
>> Regards,
>> Arend




