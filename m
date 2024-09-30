Return-Path: <linux-wireless+bounces-13338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4B98AEBF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EE11F23AAA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937717BB38;
	Mon, 30 Sep 2024 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjnN24l1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D31A2547
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729777; cv=none; b=dccCAKgJPk43LtTiVu1LC7Q/z3kJL0xwWlX6CpQb5WZ67rRTON/uvo89S2Yhz8cWD/Yp8y5m6oQadzUfJ92QnqIYJ/tJoFFAfetOqhelBirAKGvdItBsyZn95Dan/tMZ3GLQxny6f816YlOAnGvXpMM0L1f57TSgUZJBWnjboBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729777; c=relaxed/simple;
	bh=+ZbOB6PU2gGki+6Nx02UdhkmNQvTyVlBCvONwafgdE0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a1/koB+yxaCQMm0Ac0knqAyx6lmbbxEnW1vy1JmOoBzysiyci39EDkVQEuqqp27YQzB63OaZmrt7NUXqHJEWa3QYb/Hu7kfu5+nszkGjgvG2W1PILQOSPAXarbVsOfxaMa7SuTz5Jz03i0Yj8dldHWfVqIF8BfEFjW4aYbSjYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjnN24l1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso2354818f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727729774; x=1728334574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RLsaO8If/Uzi1PJiBJZweLXUXSjRPUiSecApRUIpTKg=;
        b=EjnN24l1m15aXrC+CEPAGtbXSnYeLQph0e78qR//NNPux2gLB2emS0unwDOSGtzJko
         w3CiFkye/dnpUPikdAwTHUf9NIlmhTsyd6yX26VDoXrCVXsAgotBGdmefCBFUVDeBq0h
         D9VnISXulSPixHkdJMqxtoZ183h+3TQPoTqgG5AB+SlrNqdo/4ZI73jUDcK3jYS87Pr1
         2rDqWnQLw8NltCUZxHZQhpIrhhbwxrms0kJRRO4zPY45yMGnfE7/YunsdW+f0UaV/TlQ
         xzSpN1c0f+LS9W/ZSbvHUZef95U3+AaMJgKf10W8ROWsRTbkCgLpsW13cL3PhDltuexk
         sGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729774; x=1728334574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLsaO8If/Uzi1PJiBJZweLXUXSjRPUiSecApRUIpTKg=;
        b=Yyk453JDxmljrXHdbod76CYfFuINOt3dOS54VSegrv6NKTbFSvjvKeLCmEPVlwlmx2
         SJAGYVKEp4ZU9rs7HmnfKtCYZQCwBV+00sJG5GTYGQmBH6Am2MeRcmCpvmvDs9ecCsIh
         EdELJca/YIDWfmVFckxh5efsqFdIl8wchi+HBAv2rL7dOBOd+XOW1IH1yNw01WGPhZjL
         e/jf/X0y9eu+4nKGX3AJYFeieCjMCVyYF5y0rxae6xS83JNdBblk/JVlFjPSaSkEY6RQ
         27SxOnW4AMQ3o9VauvunzWv5bkE8cDLdJudv15lWUL8HJamw0jSmLZicHk5DiCU4l1J7
         bUKw==
X-Gm-Message-State: AOJu0Yy/UG2q1BCm7sUiU6cm6s58jl4BiCRCOlRTyAfBajCt3FhnOOWJ
	bci6LyYdzxpBMAZVMV2Pvqbh1vdNriznUWBwJykUdHCg2soO5qGj1pADaA==
X-Google-Smtp-Source: AGHT+IHnvGxpTyLquMc2qENG/CHUtqu6BwgRtYwtFpHJmRloHzkPdI4NBWhc8ugDrF1nCyIPvXGxsQ==
X-Received: by 2002:adf:efc9:0:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37cd5b10563mr7324867f8f.59.1727729773795;
        Mon, 30 Sep 2024 13:56:13 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730fbbsm10266744f8f.77.2024.09.30.13.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:56:12 -0700 (PDT)
Message-ID: <baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>
Date: Mon, 30 Sep 2024 23:56:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
Content-Language: en-US
In-Reply-To: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 14:46, Bitterblue Smith wrote:
> Hi,
> 
> I have this problem with RTL8811CU, RTL8723DU, RTL8811AU, RTL8812AU.
> I assume all USB devices are affected. If I have qBittorrent running,
> the wifi stops working after a few hours:
> 
> Sep 24 00:48:21 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:21 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:23 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:23 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:25 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:25 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:27 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:27 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:29 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:29 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:31 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:31 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:33 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:33 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:35 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:35 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:37 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:37 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:39 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:39 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:41 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:41 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Added BSSID ... into ignore list, ignoring for 10 seconds
> Sep 24 00:48:42 ideapad2 NetworkManager[433]: <info>  [1727128122.0377] device (wlp3s0f3u2i2): supplicant interface state: completed -> disconnected
> Sep 24 00:48:45 ideapad2 NetworkManager[433]: <info>  [1727128125.6030] device (wlp3s0f3u2i2): supplicant interface state: disconnected -> scanning
> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Removed BSSID ... from ignore list (clear)
> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: SME: Trying to authenticate with ... (SSID='...' freq=2472 MHz)
> Sep 24 00:48:50 ideapad2 kernel: wlp3s0f3u2i2: authenticate with ... (local address=,,,)
> Sep 24 00:48:51 ideapad2 NetworkManager[433]: <info>  [1727128131.2488] device (wlp3s0f3u2i2): supplicant interface state: scanning -> authenticating
> Sep 24 00:48:51 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 1/3)
> Sep 24 00:48:51 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:52 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 2/3)
> Sep 24 00:48:52 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:53 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 3/3)
> Sep 24 00:48:53 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
> Sep 24 00:48:54 ideapad2 kernel: wlp3s0f3u2i2: authentication with ... timed out
> 
> After this all scans return nothing. The chip is still alive,
> though. The LED blinks during the scans (it's hardware-controlled)
> and another device in monitor mode can see the probe requests.
> 
> I confirmed that even C2H stop coming. I used aireplay-ng to send
> some authentication or association frames (can't remember) which
> require TX ACK report. I saw "failed to get tx report from firmware"
> and no C2H.
> 
> While qBittorrent is needed to trigger this bug, simply downloading
> a random Linux iso did not do the job. "Other" torrents did. It's
> unclear why. Maybe it's uploading that triggers the bug.
> 
> I left iperf3 running all day and nothing happened. Only qBittorrent
> can break it.
> 
> RTL8822CE doesn't have this problem. I can use qBittorrent with it
> just fine.
> 
> I mounted debugfs and dumped the MAC registers during a scan using
> this command:
> 
> for i in {00..20}; do sleep 0.5; cat /sys/kernel/debug/ieee80211/phy2/rtw88/mac_{0..7} > dead-$i.txt; done
> 
> I thought maybe some RX URBs failed silently and rtw88 stopped
> sending them to the device (== stopped requesting data from it),
> but that's not the case. [1]
> 
> I have the device in this state right now. Is there anything else
> I should look at?
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/realtek/rtw88/usb.c?h=v6.10.11&id=25eaef533bf3ccc6fee5067aac16f41f280e343e#n641

I still don't know why qBittorrent is required to trigger this bug,
but I found the problem.

alloc_skb fails (silently) therefore the RX URB is not submitted
ever again. There are only 4 RX URBs.

static void rtw_usb_rx_resubmit(struct rtw_usb *rtwusb, struct rx_usb_ctrl_block *rxcb)
{
	struct rtw_dev *rtwdev = rtwusb->rtwdev;
	int error;

	rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
	if (!rxcb->rx_skb)
		return;

	usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->pipe_in),
			  rxcb->rx_skb->data, RTW_USB_MAX_RECVBUF_SZ,
			  rtw_usb_read_port_complete, rxcb);

	error = usb_submit_urb(rxcb->rx_urb, GFP_ATOMIC);

I added an error message there:

	rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
	if (!rxcb->rx_skb) {
		rtw_err(rtwdev, "failed to allocate rx_skb\n");
		return;
	}

Now I get these before it stops receiving:

Sep 30 22:34:38 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to allocate rx_skb
Sep 30 22:35:03 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to allocate rx_skb
Sep 30 22:35:03 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to allocate rx_skb
Sep 30 22:35:03 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to allocate rx_skb
Sep 30 22:35:05 ideapad2 wpa_supplicant[1287]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS                                                                                        Sep 30 22:35:05 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware                                                                              
Sep 30 22:35:07 ideapad2 wpa_supplicant[1287]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS                                                                                        
Sep 30 22:35:07 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware                                                                                 
Sep 30 22:35:08 ideapad2 wpa_supplicant[1287]: wlp3s0f3u2i2: CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1                                  

What to do about it?

