Return-Path: <linux-wireless+bounces-26041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C58B14CC2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 13:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D885B18A3523
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D3287253;
	Tue, 29 Jul 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furda-net.20230601.gappssmtp.com header.i=@furda-net.20230601.gappssmtp.com header.b="OjqiW7O3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBA227EA8
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787442; cv=none; b=LY1oZlP0EyJ+8hFoX5jWJW+8m4KhcAtMPKAT5kY2rFTdM9F5L9nL2eZaMxzRVeyb2osz8mVcAXJTa+rCyDobJ4DGNv0dY1IlN6VPMMk+PxrNmAVNcD6u17GlhdllTx2OFhttON6yftJXAOKsQ5GA4Gwbos1DldEMtY7z0InWG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787442; c=relaxed/simple;
	bh=lRW9zSS+IEbWQ+G0gZwnUQSfnDa7BrSESTANPPz9bGM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=miDLn+LgOV070v1lrUcIqIfNGJOJ4ocEIuQM/lYBBeJXg+Xq23820dj/O3JlABHzmhngRdUSVEFlaUUDwkOvEKHp15i/OBBoic3+qryY3V6zfsUWm7F5QKU0l1s2IxODmiV0ThI3gksT8n3CwP1sLTmS40Nkyp7Tw9zs6yUEtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=furda.net; spf=none smtp.mailfrom=furda.net; dkim=pass (2048-bit key) header.d=furda-net.20230601.gappssmtp.com header.i=@furda-net.20230601.gappssmtp.com header.b=OjqiW7O3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=furda.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furda.net
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so347858a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furda-net.20230601.gappssmtp.com; s=20230601; t=1753787436; x=1754392236; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSWs3EKrdL5W6aMeNG74XNPULxdRP+nF7qkRdKKtCKs=;
        b=OjqiW7O3IWuN+VbBU+WcSpNMUsOd+/uEaxekg9Vb50y137alusENCVhcaOCmsKIXHm
         MZqLfgoR889SAuXts/cvl8VKWLPKlIECfplt0TuM3KV9rAzkHSgMkVJH2/U254rPGd2G
         Hf8TKi1c+TuaUiXtJJE4+cxI9RkkZsqLe+wPN8vFqjuioLndEJEkyuT72SQ2cHjMZ1gI
         JvDXeCGmdBSJA2tGA3hhVdhJD8w8iAqF9E+O+/rKH4yNnBoqRzC50Iz/dNgRW0YZo/cv
         87FkrJ0VpMWfheZ2xF4VOg5cXjtDB46tt/h2UbTDbsW+pcyi4O8qn7PVHS3qfY0DNOSO
         fYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787436; x=1754392236;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSWs3EKrdL5W6aMeNG74XNPULxdRP+nF7qkRdKKtCKs=;
        b=kgYdH6QauLA38s3JiUM+6ZsZMMwQOJGxML/fdNvwYrPuShmfLNaXGJnMvWsfpfVWPe
         JiXjVsis+l3eLkm9Q/F6sfxPgc7iQL5EHXsITxK61kS8xBuK6EiopMOrEC86xwWFEOPr
         Hwfrz9kYTImj7SFMJJ258D8by7PMZGKeYt+lcAuqTH+4AzCnDimKDNgIDPf/Bmt3LVG9
         Or0pO4Ao77QSai/LziLUNhEhUgCI7b4dTeQPx2afz2UbwJmOcEmeWUhgUrt7y31n7GPS
         50C0nWXL8D57SMcQ82N1rkNgpNjJQ94AKplvRdixYPZuIPa1szk+GNWkVwe6/5cg1P9z
         /EvQ==
X-Gm-Message-State: AOJu0Yzoc/Pa+L8FEr9+0GZisKOSL5FL4CbON9Hlm1X8o1DD0rOB1C6/
	UmhbzfTSHgKplHpyCrCzIdpkIYnEkoNHx2pSoqh2lgCk/Oc5Ap6jb9DcgPpxU2Qr0aZF2v8NFWf
	2/8hzPPMJ
X-Gm-Gg: ASbGncue9xnSGRevcgED9Na2NIE8aiMSkUUOVWT0CZ35QvZtgY3GYgpX4u57/2PBzkF
	td/JMBjtc1RC9nJ0tKuiA/8G8PX1620adt9mwjoCrEiGsgt9w4rmIA1cvGCJJ+U23E4EAole+Qf
	IKJ1OpIKoel3Xa1PJyKs6OyPF8fdFAsVrMkn/DDiWjOlkTGgxpvLu0m/bVsCn6Lsj8BlxSFbs46
	8ft0pRFhIZtnrUyH0kI1bw/lbCuH9w/yLkNf0LmjsQHugcM+igF0rh792Ju/iK1QeQuHy80z6CD
	u57mdkC3nLiHEjL80LlqNloJ2QooRuOZge+CUDueUE1Y9qXkrPocTikLvWi28rErWp/ZkCW+khE
	2ldJ4fy+5NjNbfz9UroDu618DFW3mXZwu
X-Google-Smtp-Source: AGHT+IGyyaJ3CQ1T+zqCWd9CMisJGOJC6MgYbS6XlLMcshRACnClzmwL/2mdV1P61yEmiO0U1LrMhg==
X-Received: by 2002:a17:907:6094:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-af619aff33bmr1711107166b.41.1753787436206;
        Tue, 29 Jul 2025 04:10:36 -0700 (PDT)
Received: from [10.227.68.20] ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589ff78sm574453166b.47.2025.07.29.04.10.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 04:10:35 -0700 (PDT)
Message-ID: <bf61ef7c-1254-4eba-99f8-631c00da7e77@furda.net>
Date: Tue, 29 Jul 2025 13:10:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-wireless@vger.kernel.org
From: Richard Furda <richard@furda.net>
Subject: =?UTF-8?Q?MT7921U_USB_WiFi_instability_on_OpenWRT_=28mt76_driver=29?=
 =?UTF-8?Q?_=E2=80=93_deauth_after_=7E24h=2C_phy2-sta0_netdevice_lockup?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm encountering a reproducible stability issue with the*MediaTek 
MT7921U USB WiFi adapter*under*OpenWRT*(tested with both 23.05.5 and 
24.10.2 builds), using the upstream*mt76*driver.

https://forum.openwrt.org/t/beryl-ax-mt7921u-usb-phy-sta0-wedged-after-24hrs


      Problem Summary:

After ~24 hours of continuous use in client mode (|phy2-sta0|,|wlan2|), 
the adapter:

  *

    disconnects from the AP with a*deauthentication*

  *

    triggers a kernel log:

    |unregister_netdevice: waiting for phy2-sta0 to become free. Usage
    count = 1 |

  *

    does not recover without a full reboot

  *

    continues to be visible via|iw|or|ip|commands, but cannot rejoin
    networks or reset


      System Details:

  *

    *Hardware*: MT7921U USB WiFi adapter (based on MediaTek chipset)

  *

    *Driver*:|mt76-usb|from mainline (OpenWRT kernel 5.15 and 6.1 tested)

  *

    *Platform*: OpenWRT x86_64 and ARM routers

  *

    *Mode*: STA (client) mode only, acting as WAN uplink

  *

    *Interface*:|phy2-sta0|


      Logs:

Example|iw dev phy2-sta0 link|and|station dump|show healthy connection 
before failure, followed by:

  *

    sudden drop in traffic

  *

    deauth

  *

    log spam with netdevice not freeing

(Full dmesg trace and debug logs available on request)


      Attempts to resolve:

  *

    Disabled power saving and powersave quirks

  *

    Reloading|mt76|modules: not sufficient to recover

  *

    Trying OpenWRT snapshots with newer kernel and latest firmware

  * Problem is seen with 2.4GHz or 5GHz

  * OIR of the module did not help

  * The USB stick is not HW broken as I am not able to reproduce the
    issue in my home-network with the same settings for days



      Request:

Could you please help investigate or point to what additional logs or 
patches I could test?


Let me know if I can assist with logs, traces, or testing patches.


Thanks,

Richard


