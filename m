Return-Path: <linux-wireless+bounces-1476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7AF823E62
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D81C20E2F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89122030A;
	Thu,  4 Jan 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsvSHTRu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960120312
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f0462ee645so769867b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jan 2024 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704359569; x=1704964369; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q6zy9fgKcFtlSto6sNYmWO9c6tE+E4PhEvJJmzXqdus=;
        b=bsvSHTRuDlEYnnX6mHMEFtex5gJrG76+cYFjPHE83T7aDwq8LzZXUP1b4MFPbeXBFd
         yZnFvsJl/NGKWdLqs5Y/p/nXjQ7mcWSkgHx/X9MJn5KPXTUiSkT8fg45LVVHyzOHmNVk
         Nt0nAomPyWyWLs3609uM5l/o7QMvvc2lLNPQ2TN35s6cyikHpuUI0DbreNBRX8APuj4m
         8Ra7cYW9U0yFU0nuF9CRBrT0bjP+g8mHx/dMGWotxjqR0WnUyXeNp0AMABp3IliQfVUf
         erXiYmczu+yCFM3WhHlQIrGVcX1WJnR9Yo6cRCEi5z7YSxMM6DPCRq2IYdLWzU1WT9/P
         L3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359569; x=1704964369;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6zy9fgKcFtlSto6sNYmWO9c6tE+E4PhEvJJmzXqdus=;
        b=gpl0Ia//NIimoHDm4NmNMMQioaA7Ri3iGWj7EVmhVsnRpJCzhi8lbpCpf7UG32usF0
         Z4/ir084Z02Q5ly5eLu8ooq/KJBkszG/NEH7Phnow9nmadIO4PzhE1HxILUm6VKaQKaG
         0dYJk3tnP6P4+39reswCxGoibRUZyTEvu56ghavOZifroyRDWa+UdKPXGs0sN/t8UplQ
         GuE05nAOby+WFNC2CaQehodQLidE79QvRtmnOuM5vY6DKJJfYAY3o2sv/3A7MQwtHTsd
         0rne6Ks9+J82Ynhxyh9VlUeBVreHCi3BiBwSWx5cRBme6Lgx7zSFQC29qruEgWZp3vkq
         6XIg==
X-Gm-Message-State: AOJu0Yz6I1xVmihkCnXIwsixtp0ADWI93Jg6GdGZF54p5hI5zGi8qSJY
	wcuO96Ga9Tt4WyYMxIl6V5P6CUVqZvFQcpAwBxQ4LOivYdM=
X-Google-Smtp-Source: AGHT+IHu3z9GImaZuA/4OBj8tIDrNXXvaIavnGB4r1v5t8qSupFQ1yOB9vXzhVMVv2DeMqUdrhqGgqHFxfeQUT/aJoQ=
X-Received: by 2002:a25:d656:0:b0:dbd:5ad0:8a34 with SMTP id
 n83-20020a25d656000000b00dbd5ad08a34mr328185ybg.5.1704359569418; Thu, 04 Jan
 2024 01:12:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicola Mingotti <nico020978@gmail.com>
Date: Thu, 4 Jan 2024 10:12:38 +0100
Message-ID: <CAL7TOjnP72fV4en6i3hsd3qgsjas+a9O2rgp2CuCdKMLOh+VEg@mail.gmail.com>
Subject: RTL8822bu as AP rejects Tapo devices
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, i wish to signal what seems to me a bug.

I set up a few Linux boxes as AP in our office using Brostrend AC1200
dongles (chipset RTL8822BU).

Using the external module RTL882xbu suggested by Brostrend it all
works but there is one issue, i can't put more than one dongle for
each Linux box. I contacted Brostrend and I was told to wait for the
driver to be in the Linux kernel.

I saw that now RTL8822bu is in the kernel 6.5.0-5 which for me is
accessible without risk of wasting the AP configuration upgrading the
OS from Debian Stable to Debian Testing. I upgraded.

In the AP which runs now Debian Testing it is true i can plug in two
Brostrend dongles. It works as AP 2.4Ghz, in the sense that i can
connect to it with my Samsung phone. BUT, here comes the problem, NO
ONE of the >10 Tapo devices (2 cameras C225 and several plugs P110)
want to connects to the AP with the driver provided by the kernel.

I installed the RTL882xbu module in the same Debian Testing AP and now
all the Tapo devices do connect.

bye
n.m.

