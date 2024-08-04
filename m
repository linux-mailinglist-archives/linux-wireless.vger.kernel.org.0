Return-Path: <linux-wireless+bounces-10884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FA946C2E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 07:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8731F21790
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 05:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE788BEF;
	Sun,  4 Aug 2024 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fBYXf47t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5FA79FD
	for <linux-wireless@vger.kernel.org>; Sun,  4 Aug 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722748531; cv=none; b=Ivtrpzw/egw943fgB+zD82Nb6VZd7WIMusxManMwChrE3QOmgt9O331BjZK2g09XFM6WGJV9aOMq9sZiwXmiHJXbgZQWxtg6XHP6m9PJdP7IYo1jF5FRiU8x/wPwAeq4ShXobDdbIUUTkPOM+mDwFWj4RwSSEf8dJKJPfE4cIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722748531; c=relaxed/simple;
	bh=hC94lJtk6TXXcWzwvKA6sgtgiBt9hLLyMvUa+xoW4ks=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F96vlCCoePuViD9KCqaokb3qOJnicYtjswiKS7/X+TXMcCrYlVCHX67Z00CtyWGnj+CvaAS9dmKA3ebVFt7prfPd0R7bkYgJjmg1TGr8x1r+vlDi1xY16P3wMf/HEqCxYK97T9+Vsnwj7xVRbk1bQqloomgyEbY7r8POkeNZfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fBYXf47t; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so10593227a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 03 Aug 2024 22:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722748528; x=1723353328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfRRcniaBVMwO5ZH+xc0aRIPkDBM+y8KvVhsHnScZT8=;
        b=fBYXf47tGu7BavOXI0hpqRURhswbvNgiqXi3vW6LYL6lzJ74eyxD8GLGXXaooelCJW
         o1WRrj+Bepc4eSsTgvPQLSKxMBG3+2So4Al9pqV6UPODM69YgyWDzjaUUrzYKvshT1kR
         XDrJr+hyraGDnp16g6NUybqVv97Om7TGctSbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722748528; x=1723353328;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfRRcniaBVMwO5ZH+xc0aRIPkDBM+y8KvVhsHnScZT8=;
        b=svRGsR9TG4rrpvm4zes323Ru3AsJnSI/WOeP7ulKdlcqk/UnfvT6p5DOXr6Lu+WMlF
         4nnhsrfaB2MB1z06mGG8kyF5imqUEpRTCWaNYXyIg5ZZPjsGGJ5vnQKRriX0FKSzRFK/
         eeeN4WReGCSWWdhMUOgazkF8UG79qIc8rmqD8Dc8OBIa66p2Zb0PRMOU5e3vfIPOJu5y
         Fv/eWQZJXr74V3VGxqhfWOfkgBlB4xUQpY74q4J9UB83HA2YI+ns7C3Edi2MDHmOOHqE
         bytFqju6PVBKIJQ3i0T9Bbt3rmMkR4cPIHAQuJgSGTNN6GG0hvqYFq5uXKGSIB9BRzm2
         NIEw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvfetJ7B6z/1K/JbiXGjzs6uwn6Q1GJW4wa2xJcqAu4gXrU1wK685knCcJGVQB7EzxPQxjkTiosI8YhKpNGLKtxe5XMkNNojSTMoOpr8=
X-Gm-Message-State: AOJu0Yzrv5MRkbLcGQAeWb8FlB9q/S+ePvbsSN8qZ6D4yD36s7aFreOl
	1JA/eBZgBSlaQiEmK3Eb/tF38Ht34v39hjjX6WHVok6+7lDCXKW14foI4GSXvg==
X-Google-Smtp-Source: AGHT+IGRATyaylaBzEG3ZZ7Q/CU5ff7wZmkBUSPsjwNUhxOc6yzMFhwG4JmIpQNT4OFEDxjCVH6e4g==
X-Received: by 2002:a50:e602:0:b0:5a1:f74d:2d58 with SMTP id 4fb4d7f45d1cf-5b7f541365cmr5444803a12.24.1722748528160;
        Sat, 03 Aug 2024 22:15:28 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5baff14989fsm521960a12.55.2024.08.03.22.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2024 22:15:27 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <gargaditya08@live.com>, <devnull+j.jannau.net@kernel.org>
CC: <asahi@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>, <j@jannau.net>, <kvalo@kernel.org>, <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <marcan@marcan.st>, <stable@vger.kernel.org>
Date: Sun, 04 Aug 2024 07:15:27 +0200
Message-ID: <1911bd06198.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 4, 2024 5:11:00 AM Aditya Garg <gargaditya08@live.com> wrote:

> Hi
>
> wpa_supplicant 2.11 broke Wi-Fi on T2 Macs as well, but this patch doesn't 
> seem to be fixing Wi-Fi. Instead, it's breaking it even on older 2.10 
> wpa_supplicant. Tested by a user on bcm4364b2 wifi chip with a WPA2-PSK 
> [AES] network. dmesg output:
>
> However dmesg outputs more info

Not seeing much info in this output which indicate an issue.

> [    5.852978] usbcore: registered new interface driver brcmfmac
> [    5.853114] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
> [    5.992212] brcmfmac: brcmf_fw_alloc_request: using 
> brcm/brcmfmac4364b2-pcie for chip BCM4364/3
> [    5.993923] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN-u-7.5-X0.bin failed with error -2
> [    5.993968] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN-u-7.5.bin failed with error -2
> [    5.994004] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN-u.bin failed with error -2
> [    5.994041] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN.bin failed with error -2
> [    5.994076] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-X0.bin failed with error -2
> [    6.162830] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
> [    6.796637] brcmfmac: brcmf_c_process_txcap_blob: TxCap blob found, loading
> [    6.798396] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4364/3 wl0: 
> Jul 10 2023 12:30:19 version 9.30.503.0.32.5.92 FWID 01-88a8883

This message means the firmware download was completed successfully.

> [    6.885876] brcmfmac 0000:01:00.0 wlp1s0: renamed from wlan0
> [    8.195243] ieee80211 phy0: brcmf_p2p_set_firmware: failed to update 
> device address ret -52
> [    8.196584] ieee80211 phy0: brcmf_p2p_create_p2pdev: set p2p_disc error
> [    8.196588] ieee80211 phy0: brcmf_cfg80211_add_iface: add iface 
> p2p-dev-wlp1s0 type 10 failed: err=-52

The creation of P2P device fails, but this only disables P2P aka 
WiFi-Direct. A full kernel log would be helpful. Even better to build the 
driver with CONFIG_BRCMDBG and load the driver with modparam 
'debug=0x9416'. That will show a lot more driver logging which may provide 
more clues.

Regards,
Arend




