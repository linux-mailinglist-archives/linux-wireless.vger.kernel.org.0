Return-Path: <linux-wireless+bounces-23828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7717AAD0FE4
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 23:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C6D188F165
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232341C5485;
	Sat,  7 Jun 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCTaAjND"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80132F3E
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749331305; cv=none; b=Pu4axUbdgc83kvbJvxS6/mU4EDlVU8CrbPUvrcsBqQKTJYO6RytZF0krcj2h5LFcbrkyW9oGzmSGqOJpl8S6eN5xPq5v4O4S5YH4B3+Q+Z3R1AftnehzpTK8i8n4BQhhUUl3VeW72x+WNvifr3K/h+1vyI8kCquD1tG4EioXv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749331305; c=relaxed/simple;
	bh=foH3eEVtEhuJIFr9wS5kNY4QizyrlpiSOQTb0NuL8uM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UyXsyK2u1m9K0JLSYU76cnT0q/zA7a299Zm0yfC3jwb7Yu7PZiqjnT/gdZvEIfWlL/Smp/AtkeDrz2ylsqNWqQtr2K77XnuB4waLOkg3avqnO5yiqbg8DnWxfUxyRmgvFgR6mzjCAJ28a+M4CgjznGVwxzYU9ZnmwvCJAEOsq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCTaAjND; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso2304542a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749331303; x=1749936103; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j9HB+D9ZkqbMOsDA7+7EU066PAzJUjJsXungctE1b6U=;
        b=fCTaAjND45aMGZuJ+BKKS7e4PQAGf/tO/IV4Fa/UorLOmyzXDx/GFelEvCqhu9AE+t
         oTXX40NMqQ0NlmX3mD3O7NwPcgnFWTa1Jym3GZovmFvyQeRcOqpbTTG6kRYcwlnGPLWF
         rcddsJ0/Ky+EYJZRoyilb71rVIwcTNaOrDttyiRnJkQNyS0AasUbsNeZzZ/AcM9yOc6g
         JRNdNdXBUEPy94kerg09Zz4LvXOAhntgt2c7isp8OVRc4htSBOF7eVMh2LGREO1yFijh
         +lo7N5pWeuCv7/weEwHkOxwFVU6ijJ5w0Go6zN6E9mMKHc8tsjnLiwt6zXns/mBgIb7T
         5QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749331303; x=1749936103;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9HB+D9ZkqbMOsDA7+7EU066PAzJUjJsXungctE1b6U=;
        b=dZ8qa2wBJ2Jnr6H6GDy158CaptJzDchEtxNt0MO5Ssp268lP0Ue3AVVzbiCML24SXv
         UOYCucKqK86cnayQWB73jw12DZbC1fezC748qzCR8Wes7ViAgv5MdFXSc2Z/0NVz+rv0
         /xDIE+TRLR1+9qt9K2DvW85k3NTVg2hTlkppy2LW1i1+ODygLvaJxoEF5hDg8IHgTAFZ
         f5604N2HKB8l2BNAkeZhyfZBYzLQOw8GtCVdPz3ASd+Q4/4BN3892DjH9cXFzlPzGRKF
         L7rM+BdoiCmF0WvVGQT2SjvZMOq/J9WrM5Xhh1A5ej9bnQBb2S/45NxoqoD+11811ggF
         7aPw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7BkNR4nsUy1+2HxtPGApBX57yRDJRC3m0V1x4FOncrYm5CjFLD4SB6gySfD2VxlsLWd8Ig+pOXeBaTgmWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+004G3a1hnawU1Nir6NZcvRtgugvvYH69ZujjyoPcBr6eoZaU
	7zEj14032x4QYWFTp88a76jLGI7xmyHSODjgN+E7KeLZ4A1HuGogdWet+lXdyB/EJxX3tFEMEWT
	pqTth16uE1fn72dOkFxw+ArMqWr3EOaAlouyJ
X-Gm-Gg: ASbGncvlhnGbzPH5AiDesGM8PNkKnjn1RHu7MzyVG3SW4dQ7VmKkgnwnlGUvWx59jeM
	vg+XiXI2/6oRaCDp0x6lppqjCj8iQF+SF0PT6VKuw7cJNEYLY+e90ma7vhcf4WwDdq49xGLF1Ya
	MgEtJLwJhROL4WQ1tnvz4r0Le5wHE/lmzMAqi4GD2DjHrwUXqtJkKVDPZv5tmFQ75nqsF5C9JZ4
	7v6fQ==
X-Google-Smtp-Source: AGHT+IFuQl73xNY9slYNz+GbrSw7N+TfJdOfCxFt6u1zp+/OH8Tjp3UTPpugjv83mWm3RUF9C29svlFOFdrvMaIUEH8=
X-Received: by 2002:a17:90b:4d8c:b0:311:b0d3:865 with SMTP id
 98e67ed59e1d1-3134707752emr9888072a91.32.1749331302821; Sat, 07 Jun 2025
 14:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Ionu=C8=9B_Nicula?= <nicula.iccc@gmail.com>
Date: Sun, 8 Jun 2025 00:21:31 +0300
X-Gm-Features: AX0GCFtoEEdLY48C4s7J9aeJqSxXhPq7VoryutogQ3WBsLYI9GKQSR0rVGMNSf8
Message-ID: <CAHQvu9-jM+=t6VHM6XsK2nwjMv-xN=V4GTAV+Op7c=P737TWNQ@mail.gmail.com>
Subject: problem: low wifi download/upload speed on AMD RZ717
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

I have some network issues on my new Framework 13 laptop [1] which is
running an AMD AI 300 series CPU and the AMD RZ717 network card (which
uses the mt7925e driver). In case it's relevant, I'm using a Mikrotik
hAP ac2 router, running RouterOS 6.49.18.

I've tried some different Linux versions and these are my observations:

1. From Linux 6.14.2 to 6.14.3 there seems to be a regression with
   regards to download speed, but an improvement with regards to upload
   speed. On 6.14.2 I'm getting 250Mbps download and 50Mbps upload. On
   6.14.3 I'm getting 16Mbps download and 250Mbps upload.
2. On the other versions that I've tried, namely 6.14.6, 6.14.9, 6.14.10
   and 6.15.1, the results are the same as on 6.14.3 -- low download
   speed and good upload speed.

Note: the expected result is 200-300Mbps for both download and upload,
which is what I get when I use USB tethering with my phone (connected to
the same wireless network).

On the versions that come after 6.14.2, the WiFi is basically unusable.
But on 6.14.2, like I said, the upload speed is low.

Some people [2] have reported that the RZ717 WiFi issues have improved
around 6.14.7, but clearly this is not the case for my setup. So this
issue might be router-dependent.

If you need other information that would be useful for
investigating/solving this issue, let me know.

[1] https://frame.work/ro/en/laptop13
[2] https://community.frame.work/t/amd-ryzen-ai-300-not-fully-supported-by-linux-yet/70046

