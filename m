Return-Path: <linux-wireless+bounces-15698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED89D8F4B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 00:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC2816A5F2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 23:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176ED194A44;
	Mon, 25 Nov 2024 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrY1CGbc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2518FDA5
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578513; cv=none; b=LKH6oUJAkNyRarDvfldNIwX1WMGxei1cWigG0qGDLn5RB0oFx3d9W6lvrfySlfc8IL6HYx0gl96NFe1C/vzglBV9P4ml5K8WD2oncosuppKU1VKoy+LpU47mKegv7FzrFw76a5kx5wEt5JM9uFBCCxNAYlgc9mEKJNTirFelLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578513; c=relaxed/simple;
	bh=EC6ndjM+ODykaE8GCl2tAMP5cCknIhNHnVWA7jqjuAY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SD0BXXTFk5P/DDUBXLLwZQPDBZA7Rb2CR0uAQlkNeQMXFpE/s6GgG/mbjqClQO75nqc5Pq2ugKDBJ0n7ujVkYviJ1eivL1JM1I8BitP/iiv/3mVjkP+OZ+CQN0/CJeXav9psVhseXKJKquuy/qklZ941Eqde3hFi/42YnUfLG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrY1CGbc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa54adcb894so223798666b.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732578509; x=1733183309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jto+WF2AlCP1G+odmHIEbVUa1bUJYYf+h2T8MIXdroU=;
        b=UrY1CGbc/r14zEqIa1sto6RPQSlsXp23tFXOUSJFX6g3hy9NijKURQ0E3uJm549Znb
         k67U4j8QxhosYrtYLfkvb+BxJdP3AyPvDwPj4s1zA1yeoCdwSZNxnpK9FG97hv+NqgOe
         faQhXoyAjscAThKuv6Tv303U8L7Oph+WHj2kD7OaVJdPk40Fa9/HjkIEeI/B1uFZAuaX
         YVd+XKNmEvn/Ka54lt6B1eyZc0TWTG7R1QQl0w0mmHgSjqv/LBAOAw2enscpXWg3GF38
         Bo7W4uDB8QRlpDmye+7fR481/gUYn0GtqBBJJHr2GPj6jRQe6s9kCgk9WyPGLpWY/R/m
         ZZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732578509; x=1733183309;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jto+WF2AlCP1G+odmHIEbVUa1bUJYYf+h2T8MIXdroU=;
        b=UkdqEytopbJOEQuoyccHjQBRc57abM18I4NC/IE+eYKc4jFfmHtlvg8JmLk7CPXSU5
         j1bj4jHw5ZlhZFTcEfsXMQr4dOrehlDxp3rwjvsBOszBvXdrHz27Y9N3uGV4PdMprvzv
         QB8bSBHAHbdE27hmsCiHpoIndSrCpp+kPb2c58nO/gXcBfiZc9LGtX6GaR2ylxKzI0Re
         V9p3XIZ9psZrQ/Usd/P0X9CKRBepVDbkC+XIv6XWR/8f4ROVBeyaZaaw8yjnCBEkXeZg
         /otOjJvyRj97fIv3TsdE/k0ebhp/KKQtURFl81edERs5dAgZR/jYZVTdHZw7F5gbQZEP
         v9kg==
X-Forwarded-Encrypted: i=1; AJvYcCXgvoSwGearquxztKBH5AxOqlICUWgG9pgslHH6f+h/D12I46mTEhk4VqvmVUwH8cF663v5FHpCdi/E7FotXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IiXDDz6060/7vEENC+PHeecOaFXUkbvo12A5vl0Q2Re1dcS/
	MVUFcpjrTWTrSJoducjGsL7GzfjJgVjvdq/NNAx4ZS5z5VU/+01J
X-Gm-Gg: ASbGncvtHIU1GiKlMrce83AGNMQHLXWrz/pKYxdwtmOhQQ1R/7CDOgORHTmLNP5mA/B
	hD6/0rUy/oxhRIgtTHvU5NDQJNFFoZmMPwHtFWdP4ULSQ5lKr6DM5TRG1DBsNFNUvdMX5CYa0mn
	ZzGehZoNVfIW9tJ4RrSfARCIt1jpypmv5XwwEesWmIXajkVxLoXQ8+2GHksqEyIglsO1YBrXm6J
	SbZwLbDNx3xQQkllDhcErLOSJ0PtBt+ptr+ugcssWRxih5SOiSBB/LD
X-Google-Smtp-Source: AGHT+IGhjuHtoZkF/e/CItMjCFLlLoH/PeLR/aq7ct2wStawIFIMei+5YYz/7TCoP3v4+1HDcacd1g==
X-Received: by 2002:a17:907:cb27:b0:aa4:f520:41b6 with SMTP id a640c23a62f3a-aa5099eb73bmr1095814266b.30.1732578508828;
        Mon, 25 Nov 2024 15:48:28 -0800 (PST)
Received: from [192.168.0.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28cedcsm523583066b.11.2024.11.25.15.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 15:48:26 -0800 (PST)
Message-ID: <133b8a9d-55e2-4483-ab2d-9ed06ef5ed96@gmail.com>
Date: Tue, 26 Nov 2024 01:48:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: usb: Copy instead of cloning the RX skb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
 <e9f32f00c63945bfb97dff12d081478e@realtek.com>
Content-Language: en-US
In-Reply-To: <e9f32f00c63945bfb97dff12d081478e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/2024 11:16, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> "iperf3 -c 192.168.0.1 -R --udp -b 0" shows about 40% of datagrams
>> are lost. Many torrents don't download faster than 3 MiB/s, probably
>> because the Bittorrent protocol uses UDP. This is somehow related to
>> the use of skb_clone() in the RX path.
> 
> Using skb_clone() can improve throughput is weird to me too. Do you check
> top with 100% cpu usage?
> 

I checked the CPU usage now and the results are interesting. In short,
patch 1/2 slightly raises the CPU usage, and patch 2/2 lowers it a lot.

I used this command: "top -b -d 20 -n 2" while running iperf3 in
reverse mode. During every test the RX speed was approximately 490 Mbps.
I tested with RTL8812AU. I used the numbers from the second "frame"
printed by each top command. I added up all the processes that had CPU
usage of at least 0.1%. I removed processes that I think are irrelevant
(kwin_wayland, konsole, weechat, plasmashell).

Before patch 1/2:

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  21192 asdf      20   0   17988   3468   2828 S  26.6   0.0   0:05.90 iperf3
     34 root      20   0       0      0      0 S   8.7   0.0   1:06.89 ksoftirqd/1
     17 root      20   0       0      0      0 S   4.7   0.0   0:44.58 ksoftirqd/0
     40 root      20   0       0      0      0 S   3.9   0.0   0:25.15 ksoftirqd/3
     28 root      20   0       0      0      0 R   3.7   0.0   0:31.46 ksoftirqd/2
  20964 root      20   0       0      0      0 R   3.5   0.0   0:01.21 kworker/u16:1-rtw88_usb: tx wq
  20716 root      20   0       0      0      0 I   3.4   0.0   0:02.74 kworker/u16:3-flush-259:0
  11253 root      20   0       0      0      0 I   2.9   0.0   0:43.42 kworker/u16:4-events_unbound
  20572 root       0 -20       0      0      0 I   2.7   0.0   0:03.05 kworker/u17:0-rtw_tx_wq
  21194 root       0 -20       0      0      0 I   2.7   0.0   0:00.59 kworker/u17:1-rtw_tx_wq
                                                  62.8

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  21798 asdf      20   0   17988   3408   2768 S  33.7   0.0   0:08.41 iperf3
     34 root      20   0       0      0      0 S   7.5   0.0   1:21.17 ksoftirqd/1
     17 root      20   0       0      0      0 S   5.8   0.0   0:54.08 ksoftirqd/0
     28 root      20   0       0      0      0 S   5.7   0.0   0:38.42 ksoftirqd/2
     40 root      20   0       0      0      0 S   5.5   0.0   0:29.69 ksoftirqd/3
  21261 root      20   0       0      0      0 I   3.0   0.0   0:02.32 kworker/u16:0-rtw88_usb: tx wq
  21237 root       0 -20       0      0      0 I   2.6   0.0   0:00.71 kworker/u17:4-rtw_tx_wq
  20716 root      20   0       0      0      0 I   2.4   0.0   0:05.97 kworker/u16:3-rtw88_usb: rx wq
  20964 root      20   0       0      0      0 I   2.4   0.0   0:04.65 kworker/u16:1-rtw88_usb: rx wq
  21244 root       0 -20       0      0      0 I   0.7   0.0   0:00.24 kworker/u17:12-rtw_tx_wq
                                                  69.3

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  21853 asdf      20   0   17988   3700   2932 S  34.3   0.0   0:08.38 iperf3
     17 root      20   0       0      0      0 S   7.0   0.0   0:55.93 ksoftirqd/0
     34 root      20   0       0      0      0 S   6.8   0.0   1:22.92 ksoftirqd/1
     40 root      20   0       0      0      0 S   5.4   0.0   0:31.05 ksoftirqd/3
     28 root      20   0       0      0      0 S   4.9   0.0   0:39.62 ksoftirqd/2
  21261 root      20   0       0      0      0 I   3.1   0.0   0:03.22 kworker/u16:0-rtw88_usb: rx wq
  21833 root       0 -20       0      0      0 I   2.4   0.0   0:00.67 kworker/u17:0-rtw_tx_wq
  20427 root      20   0       0      0      0 I   2.2   0.0   0:12.37 kworker/u16:2-events_unbound
  21834 root       0 -20       0      0      0 I   1.1   0.0   0:00.30 kworker/u17:2-rtw_tx_wq
                                                  67.2

With patch 1/2:

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  22222 asdf      20   0   17988   3804   3036 S  29.4   0.0   0:08.38 iperf3
     34 root      20   0       0      0      0 R  10.3   0.0   1:26.13 ksoftirqd/1
     28 root      20   0       0      0      0 R   7.9   0.0   0:42.00 ksoftirqd/2
  20964 root      20   0       0      0      0 I   5.8   0.0   0:06.66 kworker/u16:1-rtw88_usb: rx wq
     17 root      20   0       0      0      0 S   5.0   0.0   0:57.49 ksoftirqd/0
  21261 root      20   0       0      0      0 I   4.2   0.0   0:04.55 kworker/u16:0-rtw88_usb: tx wq
     40 root      20   0       0      0      0 S   4.1   0.0   0:32.39 ksoftirqd/3
  20716 root      20   0       0      0      0 I   2.8   0.0   0:08.07 kworker/u16:3-rtw88_usb: tx wq
  21237 root       0 -20       0      0      0 I   2.5   0.0   0:01.32 kworker/u17:4-rtw_tx_wq
  21834 root       0 -20       0      0      0 I   1.0   0.0   0:00.61 kworker/u17:2-rtw_tx_wq
  21225 root      20   0       0      0      0 I   0.1   0.0   0:00.33 kworker/2:2-events
                                                  73.1

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  22265 asdf      20   0   17988   3596   2828 S  30.5   0.0   0:08.17 iperf3
     34 root      20   0       0      0      0 S  10.5   0.0   1:28.96 ksoftirqd/1
     28 root      20   0       0      0      0 S   9.1   0.0   0:44.54 ksoftirqd/2
  20427 root      20   0       0      0      0 I   5.9   0.0   0:13.72 kworker/u16:2-rtw88_usb: rx wq
  20716 root      20   0       0      0      0 I   5.7   0.0   0:09.78 kworker/u16:3-rtw88_usb: tx wq
     17 root      20   0       0      0      0 S   3.9   0.0   0:58.72 ksoftirqd/0
     40 root      20   0       0      0      0 S   3.5   0.0   0:33.53 ksoftirqd/3
  21833 root       0 -20       0      0      0 I   3.2   0.0   0:01.76 kworker/u17:0-rtw_tx_wq
  20964 root      20   0       0      0      0 I   1.1   0.0   0:07.34 kworker/u16:1-flush-259:0
  21834 root       0 -20       0      0      0 I   0.4   0.0   0:00.92 kworker/u17:2-rtw_tx_wq
                                                  73.8

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  22303 asdf      20   0   17988   3808   3040 S  31.3   0.0   0:08.58 iperf3
     28 root      20   0       0      0      0 R  10.0   0.0   0:47.50 ksoftirqd/2
     34 root      20   0       0      0      0 S   9.9   0.0   1:31.69 ksoftirqd/1
  20716 root      20   0       0      0      0 I   5.2   0.0   0:11.26 kworker/u16:3-rtw88_usb: rx wq
     17 root      20   0       0      0      0 S   4.0   0.0   0:59.98 ksoftirqd/0
  20427 root      20   0       0      0      0 I   4.0   0.0   0:15.06 kworker/u16:2-rtw88_usb: tx wq
  20964 root      20   0       0      0      0 I   3.8   0.0   0:08.73 kworker/u16:1-rtw88_usb: tx wq
     40 root      20   0       0      0      0 S   2.7   0.0   0:34.49 ksoftirqd/3
  21833 root       0 -20       0      0      0 I   1.9   0.0   0:02.47 kworker/u17:0-rtw_tx_wq
  21834 root       0 -20       0      0      0 I   1.8   0.0   0:01.49 kworker/u17:2-rtw_tx_wq
                                                  74.6


With patches 1/2 and 2/2:

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  23151 asdf      20   0   17988   3656   2888 S  28.9   0.0   0:08.86 iperf3
  22400 root       0 -20       0      0      0 I   2.7   0.0   0:00.86 kworker/u17:6-rtw_tx_wq
  21261 root      20   0       0      0      0 I   2.3   0.0   0:06.47 kworker/u16:0-rtw88_usb: tx wq
  22401 root       0 -20       0      0      0 I   1.3   0.0   0:00.41 kworker/u17:7-rtw_tx_wq
  20427 root      20   0       0      0      0 I   1.2   0.0   0:16.02 kworker/u16:2-rtw88_usb: tx wq
     34 root      20   0       0      0      0 S   0.5   0.0   1:32.23 ksoftirqd/1
  20964 root      20   0       0      0      0 I   0.4   0.0   0:09.30 kworker/u16:1-rtw88_usb: tx wq
  22498 root      20   0       0      0      0 I   0.1   0.0   0:00.07 kworker/1:1-events
                                                  37.4

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  23213 asdf      20   0   17988   3360   2720 S  30.7   0.0   0:08.69 iperf3
  23169 root       0 -20       0      0      0 I   3.3   0.0   0:00.93 kworker/u17:1-rtw_tx_wq
  21261 root      20   0       0      0      0 I   1.5   0.0   0:07.17 kworker/u16:0-rtw88_usb: tx wq
  23219 root      20   0       0      0      0 I   1.0   0.0   0:00.21 kworker/u16:3-rtw88_usb: tx wq
     34 root      20   0       0      0      0 S   0.6   0.0   1:32.59 ksoftirqd/1
  20964 root      20   0       0      0      0 I   0.6   0.0   0:09.46 kworker/u16:1-rtw88_usb: tx wq
  23189 root       0 -20       0      0      0 I   0.6   0.0   0:00.26 kworker/u17:9-rtw_tx_wq
  20427 root      20   0       0      0      0 I   0.5   0.0   0:16.48 kworker/u16:2-rtw88_usb: tx wq
  22283 root      20   0       0      0      0 I   0.1   0.0   0:00.03 kworker/1:0-events
                                                  38.9

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  23266 asdf      20   0   17988   3608   2968 S  27.5   0.0   0:07.55 iperf3
  21833 root       0 -20       0      0      0 R   2.7   0.0   0:03.09 kworker/u17:0+rtw_tx_wq
  20964 root      20   0       0      0      0 I   1.6   0.0   0:10.03 kworker/u16:1-events_unbound
  23272 root      20   0       0      0      0 I   1.5   0.0   0:00.31 kworker/u16:4-rtw88_usb: tx wq
  22401 root       0 -20       0      0      0 I   1.1   0.0   0:00.97 kworker/u17:7-rtw_tx_wq
     34 root      20   0       0      0      0 S   0.5   0.0   1:32.83 ksoftirqd/1
  20427 root      20   0       0      0      0 I   0.5   0.0   0:16.78 kworker/u16:2-rtw88_usb: tx wq
  23228 root      20   0       0      0      0 I   0.1   0.0   0:00.08 kworker/1:2-events
                                                  35.5


>>
>> Don't use skb_clone(). Instead allocate a new skb for each 802.11 frame
>> received and copy the data from the big (32768 byte) skb.
>>
>> With this patch, "iperf3 -c 192.168.0.1 -R --udp -b 0" shows only 1-2%
>> of datagrams are lost, and torrents can reach download speeds of 36
>> MiB/s.
>>
>> Tested with RTL8812AU and RTL8822CU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 52 ++++++++++++++----------
>>  1 file changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 93ac4837e1b5..727569d4ef4b 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/mutex.h>
>>  #include "main.h"
>>  #include "debug.h"
>> +#include "mac.h"
>>  #include "reg.h"
>>  #include "tx.h"
>>  #include "rx.h"
>> @@ -546,49 +547,58 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>  {
>>         struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
>>         struct rtw_dev *rtwdev = rtwusb->rtwdev;
>> -       const struct rtw_chip_info *chip = rtwdev->chip;
>> -       u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>>         struct ieee80211_rx_status rx_status;
>> -       u32 pkt_offset, next_pkt, urb_len;
>>         struct rtw_rx_pkt_stat pkt_stat;
>> -       struct sk_buff *next_skb;
>> +       struct sk_buff *rx_skb;
>>         struct sk_buff *skb;
>> +       u32 pkt_desc_sz = rtwdev->chip->rx_pkt_desc_sz;
>> +       u32 max_skb_len = pkt_desc_sz + PHY_STATUS_SIZE * 8 +
>> +                         IEEE80211_MAX_MPDU_LEN_VHT_11454;
>> +       u32 pkt_offset, next_pkt, skb_len;
>>         u8 *rx_desc;
>>         int limit;
>>
>>         for (limit = 0; limit < 200; limit++) {
>> -               skb = skb_dequeue(&rtwusb->rx_queue);
>> -               if (!skb)
>> +               rx_skb = skb_dequeue(&rtwusb->rx_queue);
>> +               if (!rx_skb)
>>                         break;
>>
>>                 if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
>>                         dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
>> -                       dev_kfree_skb_any(skb);
>> +                       dev_kfree_skb_any(rx_skb);
>>                         continue;
>>                 }
>>
>> -               urb_len = skb->len;
>> +               rx_desc = rx_skb->data;
>>
>>                 do {
>> -                       rx_desc = skb->data;
>>                         rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat,
>>                                              &rx_status);
>>                         pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
>>                                      pkt_stat.shift;
>>
>> -                       next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
>> +                       skb_len = pkt_stat.pkt_len + pkt_offset;
>> +                       if (skb_len > max_skb_len) {
> 
> This seems a new rule introduced by this patch. Do you really encounter this
> case? Maybe this is the cause of slow download throughput?
> 

No, I never saw this case. It just seemed like a good idea to check the
size passed to alloc_skb. Maybe it's not needed?

>> +                               rtw_dbg(rtwdev, RTW_DBG_USB,
>> +                                       "skipping too big packet: %u\n",
>> +                                       skb_len);
>> +                               goto skip_packet;
>> +                       }
>>
>> -                       if (urb_len >= next_pkt + pkt_desc_sz)
>> -                               next_skb = skb_clone(skb, GFP_KERNEL);
>> -                       else
>> -                               next_skb = NULL;
>> +                       skb = alloc_skb(skb_len, GFP_KERNEL);
>> +                       if (!skb) {
>> +                               rtw_dbg(rtwdev, RTW_DBG_USB,
>> +                                       "failed to allocate RX skb of size %u\n",
>> +                                       skb_len);
>> +                               goto skip_packet;
>> +                       }
>> +
>> +                       skb_put_data(skb, rx_desc, skb_len);
>>
>>                         if (pkt_stat.is_c2h) {
>> -                               skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
>>                                 rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
>>                         } else {
>>                                 skb_pull(skb, pkt_offset);
>> -                               skb_trim(skb, pkt_stat.pkt_len);
>>                                 rtw_update_rx_freq_for_invalid(rtwdev, skb,
>>                                                                &rx_status,
>>                                                                &pkt_stat);
>> @@ -597,12 +607,12 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>                                 ieee80211_rx_irqsafe(rtwdev->hw, skb);
>>                         }
>>
>> -                       skb = next_skb;
>> -                       if (skb)
>> -                               skb_pull(skb, next_pkt);
>> +skip_packet:
>> +                       next_pkt = round_up(skb_len, 8);
>> +                       rx_desc += next_pkt;
>> +               } while (rx_desc + pkt_desc_sz < rx_skb->data + rx_skb->len);
>>
>> -                       urb_len -= next_pkt;
>> -               } while (skb);
>> +               dev_kfree_skb_any(rx_skb);
>>         }
>>  }
>>
>> --
>> 2.47.0
> 


