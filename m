Return-Path: <linux-wireless+bounces-3505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB8E852701
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCAF286458
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553BEDC;
	Tue, 13 Feb 2024 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2gXxhf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101791CAA9
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788198; cv=none; b=dcjRKx8nbSZKEVVPcyaQZtzxfHtiJiQD8RuFcY+2dCzMiQgXfYuiRq3rYLNacbqReli9yA43mh3wHP2+kBKFWadQBzn1sc6MZnjspnrPI9xSB76/fZVYbnqvj7DYVLJT1RfFrWgLufSjFjrM2q4/HrPEd13AYF66T5cEGtLbWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788198; c=relaxed/simple;
	bh=Eo6vL9p6l1gf8Dl4/p1FCCJAMzu8KLJLATQVPXeh/PM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UvvnYeNfGTfXh3IELSuFSBcGS77A0U29oLbJa43dtGm4rXVDT6YoKMk8vbBE2Z/XrBJUlzIZP7N0A7hqearsEgzXhD+fUDKKnEov9kHVToN7R9jmDANOvt8wbDdUnIYyR1djbEqw3dLeMj+0Pi807L51PHxtvVqAAhgswwqjHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2gXxhf8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2369011a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 17:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707788196; x=1708392996; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2V0Wc3W4rvJpP+bSnssgOfC3uYL4TO71RLKE3oPFv8o=;
        b=j2gXxhf8jrjEZdYfxLplpOBlR3X5OddHrgIRaPShIDQr+WSXPRxtaineiWmg/Zowsz
         1MeM75WxTE1tYAdb8JIp9fWxc/BI7ZI2nfy98YIv58lSaANpLm0RskDcixDrk/7RSp6H
         IDYqkzVdOU6USpg4G1ie9X5cZAEnQEbCDYpT2IeXRK+vVSe7r6DcNQNyax46IqF8mAIB
         TjhY39TSCTVsccWYeU8DS+qYLZ6PtSLqPkDD6HcSZaHHq9lwYtgmpaCPYaCvCiJxUir9
         xKHE7E2sR7niRNSQD0jvvZLWM6YeFgTOOQpgsKsk6PBWajq3rBZgPzK5EiKWsp/8rBjS
         8ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707788196; x=1708392996;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2V0Wc3W4rvJpP+bSnssgOfC3uYL4TO71RLKE3oPFv8o=;
        b=bLmFxH3NhpQG58HevlaTSoe0A/7bX8cMk72kxzybfEhA+EvptLF8+KqMqebklzCiV2
         YwnDJMX6kscQuoxuaB6xNFLCRGwDtHFkT9vSXGhNoU8bEQ10VS7LCG4d/ejhAVA3LzJj
         kkQ4dt9d42qI1iKk0sPgrXN5uLs8jasF0mD+oNhzL9BGTg+yFhWv1Za3Er5FItlRXena
         ZkjTqO16V4EW3jLF+8+vorX+0P0iTvuDw3w36kT0mF+9Me599U5D3VinAJfFoG0Q9I/+
         +m/hLlplJMFyP5Kp414HZn903mDlnmwe5yv6g3L4vnFsQtueVmMRP8wgJlioO9epVCD/
         MVNA==
X-Gm-Message-State: AOJu0YxIBWmJe1nnO6xCSwERZ1H8rgesZloI+PpzpKdT6TdhvNu2kFGQ
	dPeVMURzaaeoH0x1r4o5nxBF9ZZZTZAi/y8ZqkUBm0sA2P8oXXql6QyYznKbrXiURsEiWl6KoWq
	DYskv7snOD5EBLRMMzagw9ulSq7lqLtKso/Q=
X-Google-Smtp-Source: AGHT+IGjKow/ZOrO8uNhKr/kOvSK8TD4yKjytp7B0xGzLXpetMR+KJha3eZ36DzRpHPOWDfkBEij2NqIgbIl4wSYvQA=
X-Received: by 2002:a17:90b:397:b0:295:fb59:5a6d with SMTP id
 ga23-20020a17090b039700b00295fb595a6dmr5046605pjb.22.1707788195821; Mon, 12
 Feb 2024 17:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 12 Feb 2024 19:36:24 -0600
Message-ID: <CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com>
Subject: brcmfmac AP mode
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have been trying to use teh brcmfmac device on my RPi to run in AP
mode to allow device configuration of wifi and such when ethernet is
not available. I am using connman and iwd to manage my internet
connections and have noticed that when the AP is running, the AP will
reset when iwd scans.

I set it up to be an AP so I can configure the network on the RPi via
a web interface. I first set up a as a separate device as an AP for
wlan0:

iw dev wlan0 interface add ap0 type __ap

I then give it a MAC different from the wlan0 so iwd can keep track of
which is which and the ssids will show up on wlan0 when I run 'iwctl
station wlan0 scan'

ip link set dev ap0 address b8:27:eb:00:00:00

I then start an AP with either iwd or hostapd/dnsmasq.

iwctl device ap0 set-property Mode ap
iwctl ap ap0 start-profile testAP

It will start the AP and then I can connect to the Pi from my laptop.
I am using iwd on wlan0 to scan for available SSIDs. Whenever iwd
scans, either manually from cli or automatically, it will reset the AP
and kick everyone off. It does this even when I use hostapd/dnsmasq to
control the AP. When I disable iwd and use wpa_supplicant for
scanning, though, I can set up the AP with hostapd and scan many times
via connmanctl and it will not disconnect.

Why does it kick everyone off when iwd scans? Why is iot more stable
with wpa_supplicant? Is there something I could/should do to make this
more stable? When I try this on an intel card, it is rock steady and I
have not seen a disconnect. I have tried the latest brcmfmac
(cycmfmac) firmware and see the same result.

https://github.com/Infineon/ifx-linux-firmware/tree/master/firmware

I am running RPiOS Bookworm and am fully up to date though it uses an
older firmware
[   11.513277] brcmfmac: F1 signature read @0x18000000=0x1542a9a6
[   11.533628] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430b0-sdio for chip BCM43430/2
[   11.740252] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
01-3b307371

Is there any hope of stability when used like this?

Keith

