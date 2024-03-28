Return-Path: <linux-wireless+bounces-5270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822EF88BAE1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 08:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6989B216FD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 07:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A612880F;
	Tue, 26 Mar 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtnPsoa9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180461862F;
	Tue, 26 Mar 2024 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436476; cv=none; b=Nb5ep6Nullr8ANHuoXlnC+rGzgmJUl+6wNuoUXSRYu0+cdR1kZQP4iFAIBRKfUxuRI4vhZTHAyfiq/2oBM7/Li2fiJd+InKOvWQZDJ9uHkHgPc4oUuFewfsL4hSzMmOnBGFMIca1MQ99xHJ6uggc0mX2qemNn4uj71cmyFIKmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436476; c=relaxed/simple;
	bh=oLtmTcha0du6evy+UwkpZVCoII3VOZPljy+nm6nXV9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdJ63vyUOBadaRMnfziLPO87+a1ttr6qpId0pL9KRBwQHJ6Ylwo6h88NEp1Oa8jVWTO5wPb2xVmbHSDDk4kWiRkYQpMO8TUT8A9kBOLul11YeCa4tbfcAiENC8iejy5WhqgAba7iNSdm71WpZhWCHmnuyZdYH7hTZBS8USRPE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtnPsoa9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4644bde1d4so670530466b.3;
        Tue, 26 Mar 2024 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711436470; x=1712041270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDKb2M9m2N/T/ojZvD9vpqOH7ck2s7a6r40cUfN081o=;
        b=LtnPsoa9YmS9UA7J3cOAKueQ24uS1O16IVymynJE9YukWkL2oKBMgSB7P2zXFSsUFy
         /tYL9dsvtG6VWJKKh0E14nXe8jCqiQxawKQsuzcFUW4gdpQZWtNFQXSsZpXtsUACSllD
         1KeFCupv9GwsuQG5IbYHaEgC2JPhtZriJGYZSgKlrnpt+o9xNbCFGEvuybJ/fQuDHI3+
         GNO0BsPi0ssGqMQPpNzxW2JFMze6/ik8DUyHtahPH+rsdhA4VJN8uMsGzQnitkiWTE9F
         MSVYY8wbWrkb7DcKs3aepLrOScfZsEFCJBk+vjnsGeVYbGn0RmUYZ8J7YF8XJbxLAyP1
         Xcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711436470; x=1712041270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDKb2M9m2N/T/ojZvD9vpqOH7ck2s7a6r40cUfN081o=;
        b=BUhmT/y2ILFq0Wqeb0V1cXbWxnG0665AatAK8wJUVROVwrCAj9DJ+0iUuZ4QL2RStn
         QuqzPgGDWBq9jbmmI0jozVAnIAZA9lXNx/n3AzsDVlbo9FIgs503riKoHg5x11Ppcsj/
         2TFigo8U6ucUNbUTyCtrh3zT8IIJ10+rFQ9vhBcJnuRxXtivuggSiEij+piWBb3zYWhk
         T3uv9UfY2epH98AbAr4DrY0TyRo4Znnwj8B1EUc1gpGYW5OfXoJ8EHp3lCYiCMt8JAkN
         /Gnifdjn0xkCgf8QWN/i0p1uU86iuHVykiYzcSEztuGSUWRb+A1nuj2hhFm8yuHhSMZ9
         SxDw==
X-Forwarded-Encrypted: i=1; AJvYcCVmSBxtgGaHn8ArCqAz7pCvWfJORsYCbIDqoXT3AUYMRl4oIVICPXx19gTFF77CdGScV1nuJQXDQ+aMoFfdvSy30XjQeQDlCAMLPcauDB2Vp2aus1Ofxte88beyg7gxk0Y/a6qaDEDFB6UQeOo=
X-Gm-Message-State: AOJu0Ywb+o6QgHDe+vMhv8WrBdRWQvzmA5ZUN8JpMBuQ3oyYm6wq1v9H
	rsbW3yfHElZ8g8/DGe2H+KRtzEGxLf66G+P3AzX8E6RI62MpOlUG
X-Google-Smtp-Source: AGHT+IGS7If5ZXcQkgLuE49sfA9z218WCOq2iJGFO/MWSofFJ+6rGOBhl6p4HD5hJSj51PdqEOlRTQ==
X-Received: by 2002:a17:906:f1ca:b0:a4d:8f17:44db with SMTP id gx10-20020a170906f1ca00b00a4d8f1744dbmr1667693ejb.31.1711436469707;
        Tue, 26 Mar 2024 00:01:09 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id c21-20020a170906155500b00a46baba1a0asm3892431ejd.100.2024.03.26.00.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:01:09 -0700 (PDT)
Message-ID: <8b89de10-10a9-477f-9096-f78e769c1e1f@gmail.com>
Date: Tue, 26 Mar 2024 08:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7603: add debugfs attr for disabling frames
 buffering
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 openwrt-devel@lists.openwrt.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240325223319.30125-1-zajec5@gmail.com>
 <4c6319eb-79d3-46ba-a334-c74ea13461ea@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <4c6319eb-79d3-46ba-a334-c74ea13461ea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.03.2024 00:11, Rafał Miłecki wrote:
> I'll provide some iperf logs from my ThinkPad with 8086:3166 Intel
> Wireless-AC 3165 working as 2 GHz client of MT7603EN on Netgear R6220.

I run seven 1-hour iperf sessions overnight using ThinkPad + Xiaomi
Mi Router 4C (MT7628AN Wi-Fi SoC) with buffering DISABLED.

Session 1 (1 hour) with 51.7 Mbps avg:
All GOOD

Session 2 (1 hour) with 40.5 Mbps avg:
* 2 seconds traffic stall (STA diconnected with 34=DISASSOC_LOW_ACK)
* 718 seconds traffic stall (nothing in STA logs)

Session 3 (1 hour) with 51.6 Mbps avg:
* 5 seconds traffic stall (STA diconnected with 34=DISASSOC_LOW_ACK)

Session 4 (1 hour) with 51.8 Mbps avg:
All GOOD

Session 5 (1 hour) with 51.8 Mbps avg:
All GOOD

Session 6 (1 hour) with 51.8 Mbps avg:
All GOOD

Session 7 (1 hour) with 51.1 Mbps avg:
All GOOD

I find MT7628AN without frames buffering pretty usable.



Now, with frames buffering enabled, things look quite worse. There are
multiple traffic stalls and often TCP session dies. See below.

pon, 25 mar 2024, 23:23:51 CET
------------------------------------------------------------
Client connecting to 192.168.27.1, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.181 port 58838 connected with 192.168.27.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3]  1.0- 2.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3]  2.0- 3.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3]  3.0- 4.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3]  4.0- 5.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3]  5.0- 6.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  6.0- 7.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3]  7.0- 8.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  8.0- 9.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3]  9.0-10.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 10.0-11.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 11.0-12.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 12.0-13.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 13.0-14.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 14.0-15.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 15.0-16.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 16.0-17.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 17.0-18.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 18.0-19.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 19.0-20.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 20.0-21.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 21.0-22.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 22.0-23.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 23.0-24.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 24.0-25.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 25.0-26.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 26.0-27.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 27.0-28.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 28.0-29.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 29.0-30.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 30.0-31.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 31.0-32.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 32.0-33.0 sec  3.50 MBytes  29.4 Mbits/sec
[  3] 33.0-34.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 34.0-35.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 35.0-36.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 36.0-37.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 37.0-38.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 38.0-39.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 39.0-40.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 40.0-41.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 41.0-42.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 42.0-43.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 43.0-44.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 44.0-45.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 45.0-46.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 46.0-47.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 47.0-48.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 48.0-49.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 49.0-50.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 50.0-51.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 51.0-52.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 52.0-53.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 53.0-54.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 54.0-55.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 55.0-56.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 56.0-57.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 57.0-58.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 58.0-59.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 59.0-60.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 60.0-61.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 61.0-62.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 62.0-63.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 63.0-64.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 64.0-65.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 65.0-66.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 66.0-67.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 67.0-68.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 68.0-69.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 69.0-70.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 70.0-71.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 71.0-72.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 72.0-73.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 73.0-74.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 74.0-75.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 75.0-76.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 76.0-77.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 77.0-78.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 78.0-79.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 79.0-80.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 80.0-81.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 81.0-82.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 82.0-83.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 83.0-84.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 84.0-85.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 85.0-86.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 86.0-87.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 87.0-88.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 88.0-89.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 89.0-90.0 sec  7.88 MBytes  66.1 Mbits/sec
[  3] 90.0-91.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 91.0-92.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 92.0-93.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 93.0-94.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 94.0-95.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 95.0-96.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 96.0-97.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 97.0-98.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 98.0-99.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 99.0-100.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 100.0-101.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 101.0-102.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 102.0-103.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 103.0-104.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 104.0-105.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 105.0-106.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 106.0-107.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 107.0-108.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 108.0-109.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 109.0-110.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 110.0-111.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 111.0-112.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 112.0-113.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 113.0-114.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 114.0-115.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 115.0-116.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 116.0-117.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 117.0-118.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 118.0-119.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 119.0-120.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 120.0-121.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 121.0-122.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 122.0-123.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 123.0-124.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 124.0-125.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 125.0-126.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 126.0-127.0 sec  2.50 MBytes  21.0 Mbits/sec
[  3] 127.0-128.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 128.0-129.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 129.0-130.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 130.0-131.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 131.0-132.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 132.0-133.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 133.0-134.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 134.0-135.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 135.0-136.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 136.0-137.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 137.0-138.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 138.0-139.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 139.0-140.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 140.0-141.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 141.0-142.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 142.0-143.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 143.0-144.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 144.0-145.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 145.0-146.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 146.0-147.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 147.0-148.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 148.0-149.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 149.0-150.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 150.0-151.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 151.0-152.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 152.0-153.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 153.0-154.0 sec  7.62 MBytes  64.0 Mbits/sec
[  3] 154.0-155.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 155.0-156.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 156.0-157.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 157.0-158.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 158.0-159.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 159.0-160.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 160.0-161.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 161.0-162.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 162.0-163.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 163.0-164.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 164.0-165.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 165.0-166.0 sec  7.75 MBytes  65.0 Mbits/sec
[  3] 166.0-167.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 167.0-168.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 168.0-169.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 169.0-170.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 170.0-171.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 171.0-172.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 172.0-173.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 173.0-174.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 174.0-175.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 175.0-176.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 176.0-177.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 177.0-178.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 178.0-179.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 179.0-180.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 180.0-181.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 181.0-182.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 182.0-183.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 183.0-184.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 184.0-185.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 185.0-186.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 186.0-187.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 187.0-188.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 188.0-189.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 189.0-190.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 190.0-191.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 191.0-192.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 192.0-193.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 193.0-194.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 194.0-195.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 195.0-196.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 196.0-197.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 197.0-198.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 198.0-199.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 199.0-200.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 200.0-201.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 201.0-202.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 202.0-203.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 203.0-204.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 204.0-205.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 205.0-206.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 206.0-207.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 207.0-208.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 208.0-209.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 209.0-210.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 210.0-211.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 211.0-212.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 212.0-213.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 213.0-214.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 214.0-215.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 215.0-216.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 216.0-217.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 217.0-218.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 218.0-219.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 219.0-220.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 220.0-221.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 221.0-222.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 222.0-223.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 223.0-224.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 224.0-225.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 225.0-226.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 226.0-227.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 227.0-228.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 228.0-229.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 229.0-230.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 230.0-231.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 231.0-232.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 232.0-233.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 233.0-234.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 234.0-235.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 235.0-236.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 236.0-237.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 237.0-238.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 238.0-239.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 239.0-240.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 240.0-241.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 241.0-242.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 242.0-243.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 243.0-244.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 244.0-245.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 245.0-246.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 246.0-247.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 247.0-248.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 248.0-249.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 249.0-250.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 250.0-251.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 251.0-252.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 252.0-253.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 253.0-254.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 254.0-255.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 255.0-256.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 256.0-257.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3] 257.0-258.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 258.0-259.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 259.0-260.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 260.0-261.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 261.0-262.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 262.0-263.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 263.0-264.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 264.0-265.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 265.0-266.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 266.0-267.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 267.0-268.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 268.0-269.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 269.0-270.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 270.0-271.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 271.0-272.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 272.0-273.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 273.0-274.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 274.0-275.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 275.0-276.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 276.0-277.0 sec  4.12 MBytes  34.6 Mbits/sec
[  3] 277.0-278.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 278.0-279.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 279.0-280.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 280.0-281.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 281.0-282.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 282.0-283.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 283.0-284.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 284.0-285.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 285.0-286.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 286.0-287.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 287.0-288.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 288.0-289.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 289.0-290.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 290.0-291.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 291.0-292.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 292.0-293.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 293.0-294.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 294.0-295.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 295.0-296.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 296.0-297.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 297.0-298.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 298.0-299.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3] 299.0-300.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 300.0-301.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 301.0-302.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 302.0-303.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 303.0-304.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 304.0-305.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 305.0-306.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 306.0-307.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 307.0-308.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 308.0-309.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 309.0-310.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 310.0-311.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 311.0-312.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 312.0-313.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 313.0-314.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 314.0-315.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 315.0-316.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 316.0-317.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 317.0-318.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 318.0-319.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 319.0-320.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 320.0-321.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 321.0-322.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 322.0-323.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 323.0-324.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 324.0-325.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 325.0-326.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 326.0-327.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 327.0-328.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 328.0-329.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 329.0-330.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 330.0-331.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 331.0-332.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 332.0-333.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 333.0-334.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 334.0-335.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 335.0-336.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 336.0-337.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 337.0-338.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 338.0-339.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 339.0-340.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3] 340.0-341.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 341.0-342.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 342.0-343.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 343.0-344.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 344.0-345.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 345.0-346.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 346.0-347.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 347.0-348.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 348.0-349.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 349.0-350.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 350.0-351.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 351.0-352.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 352.0-353.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 353.0-354.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 354.0-355.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 355.0-356.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 356.0-357.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 357.0-358.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 358.0-359.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 359.0-360.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 360.0-361.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 361.0-362.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 362.0-363.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 363.0-364.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 364.0-365.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 365.0-366.0 sec  1.38 MBytes  11.5 Mbits/sec
[  3] 366.0-367.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 367.0-368.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 368.0-369.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 369.0-370.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 370.0-371.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 371.0-372.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 372.0-373.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 373.0-374.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 374.0-375.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 375.0-376.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 376.0-377.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 377.0-378.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 378.0-379.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 379.0-380.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 380.0-381.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 381.0-382.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 382.0-383.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 383.0-384.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 384.0-385.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 385.0-386.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 386.0-387.0 sec  4.12 MBytes  34.6 Mbits/sec
[  3] 387.0-388.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 388.0-389.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 389.0-390.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 390.0-391.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 391.0-392.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 392.0-393.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 393.0-394.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 394.0-395.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 395.0-396.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 396.0-397.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 397.0-398.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 398.0-399.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 399.0-400.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 400.0-401.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 401.0-402.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 402.0-403.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 403.0-404.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 404.0-405.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 405.0-406.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 406.0-407.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3] 407.0-408.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 408.0-409.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 409.0-410.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 410.0-411.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 411.0-412.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 412.0-413.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 413.0-414.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 414.0-415.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 415.0-416.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 416.0-417.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 417.0-418.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 418.0-419.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 419.0-420.0 sec  2.50 MBytes  21.0 Mbits/sec
[  3] 420.0-421.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 421.0-422.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 422.0-423.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 423.0-424.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 424.0-425.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 425.0-426.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 426.0-427.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 427.0-428.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 428.0-429.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 429.0-430.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 430.0-431.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 431.0-432.0 sec  1.88 MBytes  15.7 Mbits/sec
^C^C^C[  3] 432.0-433.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3] 433.0-434.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 434.0-435.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 435.0-436.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 436.0-437.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 437.0-438.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 438.0-439.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 439.0-440.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 440.0-441.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 441.0-442.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 442.0-443.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 443.0-444.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 444.0-445.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 445.0-446.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 446.0-447.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 447.0-448.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 448.0-449.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 449.0-450.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 450.0-451.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 451.0-452.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 452.0-453.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 453.0-454.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 454.0-455.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 455.0-456.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 456.0-457.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 457.0-458.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 458.0-459.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 459.0-460.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 460.0-461.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 461.0-462.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 462.0-463.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 463.0-464.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 464.0-465.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 465.0-466.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 466.0-467.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 467.0-468.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 468.0-469.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 469.0-470.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 470.0-471.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 471.0-472.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 472.0-473.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 473.0-474.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 474.0-475.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 475.0-476.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 476.0-477.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 477.0-478.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 478.0-479.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 479.0-480.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 480.0-481.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 481.0-482.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 482.0-483.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 483.0-484.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 484.0-485.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 485.0-486.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 486.0-487.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 487.0-488.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 488.0-489.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  0.0-489.0 sec  1.94 GBytes  34.2 Mbits/sec



pon, 25 mar 2024, 23:32:13 CET
------------------------------------------------------------
Client connecting to 192.168.27.1, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.181 port 35878 connected with 192.168.27.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  8.38 MBytes  70.3 Mbits/sec
[  3]  1.0- 2.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3]  2.0- 3.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3]  3.0- 4.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3]  4.0- 5.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  5.0- 6.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3]  6.0- 7.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3]  7.0- 8.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3]  8.0- 9.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3]  9.0-10.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 10.0-11.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 11.0-12.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 12.0-13.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 13.0-14.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 14.0-15.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 15.0-16.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 16.0-17.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 17.0-18.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 18.0-19.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 19.0-20.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 20.0-21.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 21.0-22.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 22.0-23.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 23.0-24.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 24.0-25.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 25.0-26.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 26.0-27.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 27.0-28.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 28.0-29.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 29.0-30.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 30.0-31.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 31.0-32.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 32.0-33.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 33.0-34.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 34.0-35.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 35.0-36.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 36.0-37.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 37.0-38.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 38.0-39.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 39.0-40.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 40.0-41.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 41.0-42.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 42.0-43.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 43.0-44.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 44.0-45.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 45.0-46.0 sec  1.38 MBytes  11.5 Mbits/sec
[  3] 46.0-47.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 47.0-48.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 48.0-49.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 49.0-50.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 50.0-51.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 51.0-52.0 sec  1.38 MBytes  11.5 Mbits/sec
[  3] 52.0-53.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 53.0-54.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 54.0-55.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 55.0-56.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 56.0-57.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 57.0-58.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 58.0-59.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 59.0-60.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 60.0-61.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 61.0-62.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3] 62.0-63.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 63.0-64.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 64.0-65.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 65.0-66.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 66.0-67.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 67.0-68.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 68.0-69.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 69.0-70.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 70.0-71.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 71.0-72.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 72.0-73.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 73.0-74.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 74.0-75.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 75.0-76.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 76.0-77.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 77.0-78.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 78.0-79.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 79.0-80.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 80.0-81.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 81.0-82.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 82.0-83.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 83.0-84.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 84.0-85.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 85.0-86.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 86.0-87.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 87.0-88.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 88.0-89.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 89.0-90.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 90.0-91.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 91.0-92.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 92.0-93.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 93.0-94.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 94.0-95.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 95.0-96.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 96.0-97.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 97.0-98.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 98.0-99.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 99.0-100.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 100.0-101.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 101.0-102.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 102.0-103.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 103.0-104.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 104.0-105.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 105.0-106.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 106.0-107.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 107.0-108.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 108.0-109.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 109.0-110.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 110.0-111.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 111.0-112.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 112.0-113.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 113.0-114.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 114.0-115.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 115.0-116.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 116.0-117.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 117.0-118.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 118.0-119.0 sec  2.50 MBytes  21.0 Mbits/sec
[  3] 119.0-120.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3] 120.0-121.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 121.0-122.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 122.0-123.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 123.0-124.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 124.0-125.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 125.0-126.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3] 126.0-127.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 127.0-128.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 128.0-129.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 129.0-130.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 130.0-131.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 131.0-132.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 132.0-133.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 133.0-134.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 134.0-135.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 135.0-136.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 136.0-137.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 137.0-138.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 138.0-139.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 139.0-140.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 140.0-141.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 141.0-142.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 142.0-143.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 143.0-144.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 144.0-145.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 145.0-146.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 146.0-147.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 147.0-148.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 148.0-149.0 sec  3.25 MBytes  27.3 Mbits/sec
^C^C^C[  3] 149.0-150.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 150.0-151.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 151.0-152.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 152.0-153.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 153.0-154.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 154.0-155.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 155.0-156.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 156.0-157.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 157.0-158.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 158.0-159.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 159.0-160.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 160.0-161.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 161.0-162.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 162.0-163.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 163.0-164.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 164.0-165.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 165.0-166.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 166.0-167.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 167.0-168.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 168.0-169.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 169.0-170.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 170.0-171.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 171.0-172.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 172.0-173.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 173.0-174.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 174.0-175.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 175.0-176.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 176.0-177.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 177.0-178.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 178.0-179.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 179.0-180.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 180.0-181.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 181.0-182.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 182.0-183.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 183.0-184.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 184.0-185.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 185.0-186.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 186.0-187.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 187.0-188.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 188.0-189.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 189.0-190.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 190.0-191.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 191.0-192.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 192.0-193.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 193.0-194.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 194.0-195.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 195.0-196.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 196.0-197.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 197.0-198.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  0.0-198.1 sec   712 MBytes  30.2 Mbits/sec



pon, 25 mar 2024, 23:35:43 CET
------------------------------------------------------------
Client connecting to 192.168.27.1, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.181 port 42114 connected with 192.168.27.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  8.38 MBytes  70.3 Mbits/sec
[  3]  1.0- 2.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3]  2.0- 3.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  3.0- 4.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  4.0- 5.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3]  5.0- 6.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  6.0- 7.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3]  7.0- 8.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3]  8.0- 9.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  9.0-10.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 10.0-11.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 11.0-12.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 12.0-13.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 13.0-14.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 14.0-15.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 15.0-16.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 16.0-17.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 17.0-18.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 18.0-19.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 19.0-20.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 20.0-21.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 21.0-22.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 22.0-23.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 23.0-24.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 24.0-25.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 25.0-26.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 26.0-27.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 27.0-28.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 28.0-29.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 29.0-30.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 30.0-31.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 31.0-32.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 32.0-33.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 33.0-34.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 34.0-35.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 35.0-36.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 36.0-37.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 37.0-38.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 38.0-39.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 39.0-40.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 40.0-41.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 41.0-42.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 42.0-43.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 43.0-44.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 44.0-45.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 45.0-46.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 46.0-47.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 47.0-48.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 48.0-49.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 49.0-50.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 50.0-51.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 51.0-52.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 52.0-53.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 53.0-54.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 54.0-55.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 55.0-56.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 56.0-57.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 57.0-58.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 58.0-59.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 59.0-60.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 60.0-61.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 61.0-62.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 62.0-63.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 63.0-64.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 64.0-65.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 65.0-66.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 66.0-67.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 67.0-68.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 68.0-69.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 69.0-70.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 70.0-71.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 71.0-72.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 72.0-73.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 73.0-74.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 74.0-75.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 75.0-76.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 76.0-77.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 77.0-78.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 78.0-79.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 79.0-80.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 80.0-81.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 81.0-82.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 82.0-83.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 83.0-84.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 84.0-85.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 85.0-86.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 86.0-87.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 87.0-88.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 88.0-89.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 89.0-90.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 90.0-91.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 91.0-92.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 92.0-93.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 93.0-94.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 94.0-95.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 95.0-96.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 96.0-97.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 97.0-98.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 98.0-99.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 99.0-100.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 100.0-101.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 101.0-102.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 102.0-103.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 103.0-104.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 104.0-105.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 105.0-106.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 106.0-107.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 107.0-108.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 108.0-109.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 109.0-110.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 110.0-111.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 111.0-112.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 112.0-113.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 113.0-114.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 114.0-115.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 115.0-116.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 116.0-117.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 117.0-118.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 118.0-119.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 119.0-120.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 120.0-121.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 121.0-122.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 122.0-123.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 123.0-124.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 124.0-125.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 125.0-126.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 126.0-127.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 127.0-128.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 128.0-129.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 129.0-130.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 130.0-131.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 131.0-132.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 132.0-133.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 133.0-134.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 134.0-135.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 135.0-136.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 136.0-137.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 137.0-138.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 138.0-139.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 139.0-140.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 140.0-141.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 141.0-142.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 142.0-143.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 143.0-144.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 144.0-145.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 145.0-146.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 146.0-147.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 147.0-148.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 148.0-149.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 149.0-150.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 150.0-151.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 151.0-152.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 152.0-153.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 153.0-154.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 154.0-155.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 155.0-156.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 156.0-157.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 157.0-158.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 158.0-159.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 159.0-160.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 160.0-161.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 161.0-162.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 162.0-163.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 163.0-164.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 164.0-165.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 165.0-166.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 166.0-167.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 167.0-168.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 168.0-169.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 169.0-170.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 170.0-171.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 171.0-172.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 172.0-173.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 173.0-174.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 174.0-175.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 175.0-176.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 176.0-177.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 177.0-178.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 178.0-179.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 179.0-180.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 180.0-181.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 181.0-182.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 182.0-183.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 183.0-184.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 184.0-185.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 185.0-186.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 186.0-187.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 187.0-188.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 188.0-189.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 189.0-190.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 190.0-191.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 191.0-192.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 192.0-193.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 193.0-194.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 194.0-195.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 195.0-196.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 196.0-197.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 197.0-198.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 198.0-199.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 199.0-200.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 200.0-201.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 201.0-202.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 202.0-203.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 203.0-204.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 204.0-205.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 205.0-206.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 206.0-207.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3] 207.0-208.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 208.0-209.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 209.0-210.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 210.0-211.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 211.0-212.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 212.0-213.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 213.0-214.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 214.0-215.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 215.0-216.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 216.0-217.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 217.0-218.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 218.0-219.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 219.0-220.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 220.0-221.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 221.0-222.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 222.0-223.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 223.0-224.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 224.0-225.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 225.0-226.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 226.0-227.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 227.0-228.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 228.0-229.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 229.0-230.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 230.0-231.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 231.0-232.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 232.0-233.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 233.0-234.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 234.0-235.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 235.0-236.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 236.0-237.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 237.0-238.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 238.0-239.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 239.0-240.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 240.0-241.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 241.0-242.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 242.0-243.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 243.0-244.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 244.0-245.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 245.0-246.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 246.0-247.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 247.0-248.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 248.0-249.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 249.0-250.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 250.0-251.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 251.0-252.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 252.0-253.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 253.0-254.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 254.0-255.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 255.0-256.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 256.0-257.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 257.0-258.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 258.0-259.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 259.0-260.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 260.0-261.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 261.0-262.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 262.0-263.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 263.0-264.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 264.0-265.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 265.0-266.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 266.0-267.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 267.0-268.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 268.0-269.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 269.0-270.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 270.0-271.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 271.0-272.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 272.0-273.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 273.0-274.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 274.0-275.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 275.0-276.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 276.0-277.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 277.0-278.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 278.0-279.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 279.0-280.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 280.0-281.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 281.0-282.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 282.0-283.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 283.0-284.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 284.0-285.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 285.0-286.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 286.0-287.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 287.0-288.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 288.0-289.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 289.0-290.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 290.0-291.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 291.0-292.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 292.0-293.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 293.0-294.0 sec  5.00 MBytes  41.9 Mbits/sec
[  3] 294.0-295.0 sec  4.88 MBytes  40.9 Mbits/sec
[  3] 295.0-296.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 296.0-297.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 297.0-298.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 298.0-299.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 299.0-300.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 300.0-301.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 301.0-302.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 302.0-303.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 303.0-304.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 304.0-305.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 305.0-306.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 306.0-307.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 307.0-308.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 308.0-309.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 309.0-310.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 310.0-311.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 311.0-312.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 312.0-313.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 313.0-314.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 314.0-315.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 315.0-316.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 316.0-317.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 317.0-318.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 318.0-319.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 319.0-320.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 320.0-321.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 321.0-322.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 322.0-323.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 323.0-324.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 324.0-325.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 325.0-326.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 326.0-327.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 327.0-328.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 328.0-329.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 329.0-330.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 330.0-331.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 331.0-332.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 332.0-333.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 333.0-334.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 334.0-335.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 335.0-336.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 336.0-337.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 337.0-338.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 338.0-339.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 339.0-340.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 340.0-341.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 341.0-342.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 342.0-343.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 343.0-344.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 344.0-345.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 345.0-346.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 346.0-347.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 347.0-348.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 348.0-349.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 349.0-350.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 350.0-351.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 351.0-352.0 sec  7.00 MBytes  58.7 Mbits/sec
[  3] 352.0-353.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 353.0-354.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 354.0-355.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 355.0-356.0 sec  3.50 MBytes  29.4 Mbits/sec
[  3] 356.0-357.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 357.0-358.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 358.0-359.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 359.0-360.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 360.0-361.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 361.0-362.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 362.0-363.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 363.0-364.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 364.0-365.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 365.0-366.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 366.0-367.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 367.0-368.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 368.0-369.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 369.0-370.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 370.0-371.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 371.0-372.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 372.0-373.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 373.0-374.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 374.0-375.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 375.0-376.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 376.0-377.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 377.0-378.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 378.0-379.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 379.0-380.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 380.0-381.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 381.0-382.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 382.0-383.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 383.0-384.0 sec  7.50 MBytes  62.9 Mbits/sec
[  3] 384.0-385.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 385.0-386.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 386.0-387.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 387.0-388.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 388.0-389.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 389.0-390.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 390.0-391.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 391.0-392.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 392.0-393.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 393.0-394.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 394.0-395.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 395.0-396.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 396.0-397.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 397.0-398.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 398.0-399.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 399.0-400.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 400.0-401.0 sec  6.62 MBytes  55.6 Mbits/sec
[  3] 401.0-402.0 sec  6.00 MBytes  50.3 Mbits/sec
[  3] 402.0-403.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 403.0-404.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 404.0-405.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 405.0-406.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 406.0-407.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 407.0-408.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 408.0-409.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 409.0-410.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 410.0-411.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 411.0-412.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 412.0-413.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 413.0-414.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 414.0-415.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 415.0-416.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 416.0-417.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 417.0-418.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 418.0-419.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 419.0-420.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 420.0-421.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 421.0-422.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 422.0-423.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 423.0-424.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 424.0-425.0 sec  6.25 MBytes  52.4 Mbits/sec
[  3] 425.0-426.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 426.0-427.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 427.0-428.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 428.0-429.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 429.0-430.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 430.0-431.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 431.0-432.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 432.0-433.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 433.0-434.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 434.0-435.0 sec  1.88 MBytes  15.7 Mbits/sec
[  3] 435.0-436.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 436.0-437.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 437.0-438.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 438.0-439.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 439.0-440.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 440.0-441.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 441.0-442.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 442.0-443.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 443.0-444.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 444.0-445.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 445.0-446.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 446.0-447.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 447.0-448.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 448.0-449.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 449.0-450.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 450.0-451.0 sec  7.12 MBytes  59.8 Mbits/sec
[  3] 451.0-452.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 452.0-453.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 453.0-454.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 454.0-455.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 455.0-456.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 456.0-457.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 457.0-458.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3] 458.0-459.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 459.0-460.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 460.0-461.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 461.0-462.0 sec  7.38 MBytes  61.9 Mbits/sec
[  3] 462.0-463.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 463.0-464.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 464.0-465.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3] 465.0-466.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 466.0-467.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 467.0-468.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 468.0-469.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 469.0-470.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 470.0-471.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 471.0-472.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 472.0-473.0 sec  2.12 MBytes  17.8 Mbits/sec
[  3] 473.0-474.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 474.0-475.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 475.0-476.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 476.0-477.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 477.0-478.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 478.0-479.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 479.0-480.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 480.0-481.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 481.0-482.0 sec  2.75 MBytes  23.1 Mbits/sec
[  3] 482.0-483.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 483.0-484.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 484.0-485.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 485.0-486.0 sec  4.62 MBytes  38.8 Mbits/sec
[  3] 486.0-487.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 487.0-488.0 sec  2.62 MBytes  22.0 Mbits/sec
[  3] 488.0-489.0 sec  1.75 MBytes  14.7 Mbits/sec
^C^C^C[  3] 489.0-490.0 sec  3.50 MBytes  29.4 Mbits/sec
[  3] 490.0-491.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 491.0-492.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 492.0-493.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 493.0-494.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 494.0-495.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 495.0-496.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 496.0-497.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 497.0-498.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 498.0-499.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 499.0-500.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 500.0-501.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 501.0-502.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 502.0-503.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 503.0-504.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 504.0-505.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 505.0-506.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 506.0-507.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 507.0-508.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 508.0-509.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 509.0-510.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 510.0-511.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 511.0-512.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 512.0-513.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 513.0-514.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 514.0-515.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 515.0-516.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 516.0-517.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 517.0-518.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 518.0-519.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 519.0-520.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 520.0-521.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 521.0-522.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 522.0-523.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 523.0-524.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 524.0-525.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 525.0-526.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 526.0-527.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 527.0-528.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 528.0-529.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 529.0-530.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 530.0-531.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 531.0-532.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 532.0-533.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 533.0-534.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 534.0-535.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 535.0-536.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 536.0-537.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 537.0-538.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 538.0-539.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 539.0-540.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 540.0-541.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 541.0-542.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 542.0-543.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 543.0-544.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 544.0-545.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 545.0-546.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 546.0-547.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 547.0-548.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 548.0-549.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 549.0-550.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 550.0-551.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 551.0-552.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 552.0-553.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 553.0-554.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 554.0-555.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 555.0-556.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 556.0-557.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 557.0-558.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 558.0-559.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 559.0-560.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 560.0-561.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 561.0-562.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 562.0-563.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 563.0-564.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 564.0-565.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 565.0-566.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 566.0-567.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 567.0-568.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 568.0-569.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 569.0-570.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 570.0-571.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 571.0-572.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 572.0-573.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 573.0-574.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 574.0-575.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 575.0-576.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 576.0-577.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 577.0-578.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 578.0-579.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 579.0-580.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 580.0-581.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 581.0-582.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 582.0-583.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 583.0-584.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 584.0-585.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 585.0-586.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 586.0-587.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 587.0-588.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 588.0-589.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 589.0-590.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 590.0-591.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 591.0-592.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 592.0-593.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 593.0-594.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 594.0-595.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 595.0-596.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 596.0-597.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 597.0-598.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 598.0-599.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 599.0-600.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 600.0-601.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 601.0-602.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 602.0-603.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 603.0-604.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 604.0-605.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 605.0-606.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 606.0-607.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 607.0-608.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 608.0-609.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 609.0-610.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 610.0-611.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 611.0-612.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 612.0-613.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 613.0-614.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 614.0-615.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 615.0-616.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 616.0-617.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 617.0-618.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 618.0-619.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 619.0-620.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 620.0-621.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 621.0-622.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 622.0-623.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 623.0-624.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 624.0-625.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 625.0-626.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 626.0-627.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 627.0-628.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 628.0-629.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 629.0-630.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 630.0-631.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 631.0-632.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 632.0-633.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 633.0-634.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 634.0-635.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 635.0-636.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  0.0-636.7 sec  2.33 GBytes  31.4 Mbits/sec


