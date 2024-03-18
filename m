Return-Path: <linux-wireless+bounces-4859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5787EE31
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881B11F24A09
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C454FA8;
	Mon, 18 Mar 2024 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="EQQ2Lj3Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ACE524CE
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780980; cv=none; b=VD9S4vd9+Uqe4EOsegNuf81v93vG2FxWldoylQxqtdm70UemjEPnxtS9MzHSc9KEQodA5dYq6h3qWHNLCOAeHc3yua/E6lUdiRQgtzEY6wwp8usRlDjqbHz8WkmSr45wdxPSHaxS0m6R3oSdwNNxU2yGVN1fiNHrLoy7T+ZXXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780980; c=relaxed/simple;
	bh=a28hIzI5gkB/CSwa0Nfpb+n4Lc04SWKdxGvLqXlkulQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9pCAVdQrwnLqH5rByjLZG5c5ytGt8vPcYO27zOSJ5WOjRj/0GfiN6gnY/oF57HD0LL5ZvJKlsOVC/ArSptuqNZ+txuE+AFZ52J3GUXLv3Jxx5gslLhGUltFZOb2rKO1qpKoZTlW6M5xZS9lOtVgQk/8ThLQ5fBC+zFvIIW2yaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=EQQ2Lj3Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4145ee55ad4so3463275e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1710780974; x=1711385774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ7YAw+8Nuwz+hFL+4q3CaRE/rGOZ4upL7O9xCV6Zc4=;
        b=EQQ2Lj3Z14vYkA+yvN1KKLJEbmWnDSVRHgWOE7lE1ueUn4UxVRF6WhoG6EpkOJKfoK
         11HttEXQCdyBk0YdVcl7qaEP32k8KAKAECFWCpj/hbpg49UsKc3YU0AGuF9k7VBr5jLN
         8uRgFDpPtORWVzotxfiLyWCLlrIv7SGpAeMlu1N1AujO10X9Nu5fjNAWS/hLzBS4e/tF
         bxPZBcnETt59MOb9msxkAGQK40jDcDfNlW+GfQLhpm0yEKPilbnLZxfYM0Vj90u9bbkL
         KnkJN4p0v6ANCaKeioWI3zU52DB1ZLUQJMHaLRZl3lrFuHl+RbTXDZtSQH05xHO3pt6L
         GOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780974; x=1711385774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ7YAw+8Nuwz+hFL+4q3CaRE/rGOZ4upL7O9xCV6Zc4=;
        b=DU+OqlX0A3L6qC1BBuNNT13lG5lHGu+nc6dXBfQxOISLhP96oAVOkhSKd6QJmolI7x
         iyXeiFnxjAsB0lCOIEW6/2PK/bIKNUQubtJCWpZ/i7LbZ+fYregQfQpvI3aPurF96uTy
         n7fnSLiXH6pxGMOTdvdl5kkbg1EUZ6vP3YStJmdiiEBimx5xTEC8/X1JqzZ8UZxWBrsh
         wL107VJYXS/m3fye9unPkYSUtBDHF98eAMdsFGyhkZpiuCPZZIL61eIIFv0xLlPT07Ih
         F0SQtCFsjR3QFBUOIcIn8/JZ/Gtt4n2E6TrBrG/1PJyk0Icz+kwagHQV0evADRxj8boT
         pqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwix5yCLC9r36I4dtjSTyAQ/axySGY4kJaPvbz99drGsZlF1x7g5lZKLvi6fmyn7lcTlsR3VW9gqLNwtahRkcWOicNDIk3X5frjBUDiE4=
X-Gm-Message-State: AOJu0YxLSQDoMoKFBHSFezwmB8+BWE1RUQJ1LxMLc15ECxDsp0RhlaeC
	9zwf2H3uwZ5RyvD5Q/rvZzTpvvRQvOJadlt1mh9jhiG/HFNXLD4gZu0njgYIrRw=
X-Google-Smtp-Source: AGHT+IHsx9r3MSj0l9YzH/OwlwxxKh6WIP0W0sbVtfIzHJxqgm9oVptZiO7SpRL4h0UZNXanQrwqoA==
X-Received: by 2002:a05:600c:4eca:b0:414:1e0:2afa with SMTP id g10-20020a05600c4eca00b0041401e02afamr7215008wmq.3.1710780973625;
        Mon, 18 Mar 2024 09:56:13 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b0033e7de97214sm10194038wrn.40.2024.03.18.09.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 09:56:13 -0700 (PDT)
Message-ID: <f26dfcc6-5fd3-486d-b0f2-80168eb213c7@freebox.fr>
Date: Mon, 18 Mar 2024 17:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k
 <ath10k@lists.infradead.org>, wireless <linux-wireless@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>, Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 16:53, Dmitry Baryshkov wrote:

> Do you have pd-mapper, rmtfs and tqftpserv running? You also need to
> have wlanmdsp.mbn in the same directory as modem.mbn for your platform
> (see how this is handled for sdm845).
> If these points are implemented and you still don't have the wlan,
> please check for tqftpserv messages in syslog.

I have not been able to reach a functional system yet :(

(I'll provide the kernel log at the end.)

These are the processes running in user-space:

# ps aux | grep -v ' \['
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.4  0.2  21640 10752 ?        Ss   17:43   0:03 /sbin/init
root         203  0.1  0.2  34268 11272 ?        Ss   17:43   0:01 /usr/lib/systemd/systemd-journald
root         232  0.1  0.1  24552  5888 ?        Ss   17:43   0:01 /usr/lib/systemd/systemd-udevd
root         291  0.0  0.0   6704  2048 ?        Ss   17:44   0:00 /usr/sbin/cron -f
root         295  0.0  0.0   2204  1152 ?        Ss   17:44   0:00 /usr/bin/qrtr-ns -f 1
root         297  0.0  0.1  16704  7128 ?        Ss   17:44   0:00 /usr/bin/rmtfs -r -P -s
root         298  0.0  0.0   2336  1152 ?        Ss   17:44   0:00 /usr/bin/tqftpserv
root         330  0.0  0.0   4600  1920 ?        Ss   17:44   0:00 /usr/sbin/dropbear -EF -p 22 -W 65536
root         336  0.0  0.0   5252  1664 tty1     Ss+  17:44   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         338  0.0  0.0   5252  1536 tty2     Ss+  17:44   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         339  0.0  0.0   5252  1408 tty3     Ss+  17:44   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         340  0.0  0.0   5252  1664 tty4     Ss+  17:44   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         341  0.0  0.0   5252  1536 tty5     Ss+  17:44   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         342  0.0  0.0   5252  1408 tty6     Ss+  17:44   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         343  0.0  0.0   9012  2816 ttyMSM0  Ss   17:44   0:00 /bin/login -p --
root         365  0.0  0.0   7088  3456 ttyMSM0  S+   17:44   0:00 -bash
root         369  0.0  0.0   4600  2560 ?        Ss   17:44   0:00 /usr/sbin/dropbear -EF -p 22 -W 65536 -2 7
root         370  0.0  0.0   7088  3584 pts/0    Ss   17:44   0:00 -bash


Hmm, I don't see protection-domain-mapper running...

Feb 27 17:44:01 venus pd-mapper[308]: no pd maps available
Feb 27 17:44:01 venus pd-mapper[328]: no pd maps available
Feb 27 17:44:02 venus pd-mapper[345]: no pd maps available
Feb 27 17:44:02 venus pd-mapper[347]: no pd maps available

Is the package supposed to install one or several "pd maps" ?


The system journal contains:

Feb 27 17:43:57 venus systemd-journald[203]: Journal started
Feb 27 17:43:57 venus systemd-journald[203]: Runtime Journal (/run/log/journal/0f2e92c39e6f4f3fa6585b56f928c8ed) is 8.0M, max 73.3M, 65.3M free.
Feb 27 17:43:57 venus systemd-random-seed[211]: Kernel entropy pool is not initialized yet, waiting until it is.
Feb 27 17:43:57 venus systemd-journald[203]: Time spent on flushing to /var/log/journal/0f2e92c39e6f4f3fa6585b56f928c8ed is 19.931ms for 3 entries.
Feb 27 17:43:57 venus systemd-journald[203]: System Journal (/var/log/journal/0f2e92c39e6f4f3fa6585b56f928c8ed) is 8.0M, max 4.0G, 3.9G free.
Feb 27 17:43:58 venus systemd-udevd[232]: Using default interface naming scheme 'v255'.
Feb 27 17:44:01 venus cron[291]: (CRON) INFO (pidfile fd = 3)
Feb 27 17:44:01 venus qrtr-ns[295]: ERROR qrtr-ns: nameserver already running, going dormant: Address already in use
Feb 27 17:44:01 venus pd-mapper[296]: no pd maps available
Feb 27 17:44:01 venus cron[291]: (CRON) INFO (Running @reboot jobs)
Feb 27 17:44:01 venus pd-mapper[308]: no pd maps available
Feb 27 17:44:01 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_1', rejecting
Feb 27 17:44:01 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_2', rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus pd-mapper[328]: no pd maps available
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] WRQ: /readwrite/server_check.txt (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:01 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octetinvalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:01 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:02 venus tqftpserv[298]: )
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:02 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
[...]
Feb 27 17:44:10 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2), reject
Feb 27 17:44:10 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/firmware/image/wlanmdsp.mbn (octet)
Feb 27 17:44:10 venus tqftpserv[298]: [TQFTP] unable to open /readonly/firmware/image/wlanmdsp.mbn (9), reject
Feb 27 17:44:10 venus tqftpserv[298]: [TQFTP] RRQ: /readonly/vendor/firmware/wlanmdsp.mbn (octet)
Feb 27 17:44:10 venus tqftpserv[298]: [TQFTP] unable to open /readonly/vendor/firmware/wlanmdsp.mbn (2)invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:10 venus tqftpserv[298]: invalid path /readonly/vendor/firmware/wlanmdsp.mbn, rejecting
Feb 27 17:44:10 venus tqftpserv[298]: ERROR libqrtr: socket(AF_QIPCRTR): Too many open files
Feb 27 17:44:15 venus login[365]: ROOT LOGIN  on '/dev/ttyMSM0'
Feb 27 17:44:31 venus tqftpserv[298]: ERROR libqrtr: socket(AF_QIPCRTR): Too many open files
Feb 27 17:44:41 venus tqftpserv[298]: ERROR libqrtr: socket(AF_QIPCRTR): Too many open files
Feb 27 17:44:42 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_1', rejecting
Feb 27 17:44:42 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_2', rejecting
Feb 27 17:44:42 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:45:12 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:45:22 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:45:24 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_1', rejecting
Feb 27 17:45:24 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_2', rejecting
Feb 27 17:45:24 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:45:54 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:46:04 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:46:04 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_1', rejecting
Feb 27 17:46:04 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_2', rejecting
Feb 27 17:46:05 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:46:35 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:46:45 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:46:45 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_1', rejecting
Feb 27 17:46:45 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_2', rejecting
Feb 27 17:46:46 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:47:16 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:47:26 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files
Feb 27 17:47:26 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_1', rejecting
Feb 27 17:47:26 venus rmtfs[297]: [RMTFS storage] request for unknown partition '/boot/modem_fsg_oem_2', rejecting
Feb 27 17:47:27 venus tqftpserv[298]: tqftpserv: failed top open /tmp/tqftpserv: Too many open files






Corresponding kernel logs:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51af8014]
[    0.000000] Linux version 6.7.0-10016-g0cea4ace5459 (mgonzalez@venus) (aarch64-none-linux-gnu-gcc (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205, GNU ld (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 2.39.0.20221210) #3 SMP PREEMPT Mon Mar 18 16:59:35 CET 2024
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Freebox Delta
[    0.000000] earlycon: msm_serial_dm0 at MMIO 0x000000000c1b0000 (options '')
[    0.000000] printk: legacy bootconsole [msm_serial_dm0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
[    0.000000] OF: reserved mem: 0x00000000bfffc000..0x00000000bfffffff (16 KiB) nomap non-reusable mpss-metadata
[    0.000000] OF: reserved mem: 0x0000000085800000..0x0000000085dfffff (6144 KiB) nomap non-reusable memory@85800000
[    0.000000] OF: reserved mem: 0x0000000085e00000..0x0000000085efffff (1024 KiB) nomap non-reusable memory@85e00000
[    0.000000] OF: reserved mem: 0x0000000086000000..0x00000000861fffff (2048 KiB) nomap non-reusable smem-mem@86000000
[    0.000000] OF: reserved mem: 0x0000000086200000..0x0000000088efffff (46080 KiB) nomap non-reusable memory@86200000
[    0.000000] OF: reserved mem: 0x0000000088f00000..0x00000000890fffff (2048 KiB) nomap non-reusable memory@88f00000
[    0.000000] OF: reserved mem: 0x000000008ab00000..0x000000008b1fffff (7168 KiB) nomap non-reusable memory@8ab00000
[    0.000000] OF: reserved mem: 0x000000008b200000..0x000000008cbfffff (26624 KiB) nomap non-reusable memory@8b200000
[    0.000000] OF: reserved mem: 0x000000008cc00000..0x0000000093bfffff (114688 KiB) nomap non-reusable memory@8cc00000
[    0.000000] OF: reserved mem: 0x0000000093c00000..0x00000000940fffff (5120 KiB) nomap non-reusable memory@93c00000
[    0.000000] OF: reserved mem: 0x0000000094100000..0x00000000942fffff (2048 KiB) nomap non-reusable memory@94100000
[    0.000000] OF: reserved mem: 0x0000000094300000..0x00000000943fffff (1024 KiB) nomap non-reusable memory@95600000
[    0.000000] OF: reserved mem: 0x0000000094400000..0x00000000944fffff (1024 KiB) nomap non-reusable memory@95700000
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000f5400000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node gpu@f5400000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x00000000f5400000..0x00000000f5401fff (8 KiB) nomap non-reusable gpu@f5400000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x000000017e3fffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17dbf59c0-0x17dbf7fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017e3fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000857fffff]
[    0.000000]   node   0: [mem 0x0000000085800000-0x0000000085efffff]
[    0.000000]   node   0: [mem 0x0000000085f00000-0x0000000085ffffff]
[    0.000000]   node   0: [mem 0x0000000086000000-0x00000000890fffff]
[    0.000000]   node   0: [mem 0x0000000089100000-0x000000008aafffff]
[    0.000000]   node   0: [mem 0x000000008ab00000-0x00000000944fffff]
[    0.000000]   node   0: [mem 0x0000000094500000-0x00000000bfffbfff]
[    0.000000]   node   0: [mem 0x00000000bfffc000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x00000000c0000000-0x00000000f53fffff]
[    0.000000]   node   0: [mem 0x00000000f5400000-0x00000000f5401fff]
[    0.000000]   node   0: [mem 0x00000000f5402000-0x000000017e3fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000017e3fffff]
[    0.000000] On node 0, zone Normal: 7168 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fe000000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] psci: OSI mode supported.
[    0.000000] psci: [Firmware Bug]: failed to set PC mode: -3
[    0.000000] percpu: Embedded 22 pages/cpu s49640 r8192 d32280 u90112
[    0.000000] pcpu-alloc: s49640 r8192 d32280 u90112 alloc=22*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: earlycon=msm_serial_dm,0xc1b0000 clk_ignore_unused ip=dhcp root=/dev/nfs rw debug systemd.log_level=info
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1025136
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem 0x00000000fa000000-0x00000000fe000000] (64MB)
[    0.000000] Memory: 3719276K/4165632K available (17408K kernel code, 3212K rwdata, 24488K rodata, 5632K init, 541K bss, 413588K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 608 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000017b00000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000000] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.010935] Console: colour dummy device 80x25
[    0.018737] printk: legacy console [tty0] enabled
[    0.023246] printk: legacy bootconsole [msm_serial_dm0] disabled
[    0.028082] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=76800)
[    0.028099] pid_max: default: 32768 minimum: 301
[    0.028167] LSM: initializing lsm=capability,integrity
[    0.028256] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.028278] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.029799] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.029860] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.030038] rcu: Hierarchical SRCU implementation.
[    0.030047] rcu: 	Max phase no-delay instances is 1000.
[    0.031289] EFI services will not be available.
[    0.031564] smp: Bringing up secondary CPUs ...
[    0.033830] Detected VIPT I-cache on CPU1
[    0.033894] GICv3: CPU1: found redistributor 1 region 0:0x0000000017b20000
[    0.033967] CPU1: Booted secondary processor 0x0000000001 [0x51af8014]
[    0.036318] Detected VIPT I-cache on CPU2
[    0.036362] GICv3: CPU2: found redistributor 2 region 0:0x0000000017b40000
[    0.036415] CPU2: Booted secondary processor 0x0000000002 [0x51af8014]
[    0.038958] Detected VIPT I-cache on CPU3
[    0.039003] GICv3: CPU3: found redistributor 3 region 0:0x0000000017b60000
[    0.039054] CPU3: Booted secondary processor 0x0000000003 [0x51af8014]
[    0.042127] CPU features: detected: Spectre-v2
[    0.042164] Detected VIPT I-cache on CPU4
[    0.042310] GICv3: CPU4: found redistributor 100 region 0:0x0000000017b80000
[    0.042404] CPU4: Booted secondary processor 0x0000000100 [0x51af8001]
[    0.045680] Detected VIPT I-cache on CPU5
[    0.045833] GICv3: CPU5: found redistributor 101 region 0:0x0000000017ba0000
[    0.045923] CPU5: Booted secondary processor 0x0000000101 [0x51af8001]
[    0.049428] Detected VIPT I-cache on CPU6
[    0.049591] GICv3: CPU6: found redistributor 102 region 0:0x0000000017bc0000
[    0.049682] CPU6: Booted secondary processor 0x0000000102 [0x51af8001]
[    0.053450] Detected VIPT I-cache on CPU7
[    0.053622] GICv3: CPU7: found redistributor 103 region 0:0x0000000017be0000
[    0.053712] CPU7: Booted secondary processor 0x0000000103 [0x51af8001]
[    0.053903] smp: Brought up 1 node, 8 CPUs
[    0.054029] SMP: Total of 8 processors activated.
[    0.054037] CPU: All CPU(s) started at EL1
[    0.054061] CPU features: detected: 32-bit EL0 Support
[    0.054070] CPU features: detected: 32-bit EL1 Support
[    0.054080] CPU features: detected: CRC32 instructions
[    0.054159] alternatives: applying system-wide alternatives
[    0.056828] devtmpfs: initialized
[    0.066961] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.066999] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.067843] pinctrl core: initialized pinctrl subsystem
[    0.068367] DMI not present or invalid.
[    0.069294] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.070111] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.070246] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.070424] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.070460] audit: initializing netlink subsys (disabled)
[    0.070597] audit: type=2000 audit(0.056:1): state=initialized audit_enabled=0 res=1
[    0.070936] thermal_sys: Registered thermal governor 'step_wise'
[    0.070942] thermal_sys: Registered thermal governor 'power_allocator'
[    0.070996] cpuidle: using governor menu
[    0.071116] NET: Registered PF_QIPCRTR protocol family
[    0.071260] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.071471] ASID allocator initialised with 65536 entries
[    0.071879] Serial: AMBA PL011 UART driver
[    0.071932] builtin-fbxserial: Found valid serial infos !
[    0.081977] platform 1da4000.ufshc: Fixed dependency cycle(s) with /soc@0/phy@1da7000
[    0.087287] platform c8c0000.clock-controller: Fixed dependency cycle(s) with /soc@0/display-subsystem@c900000/hdmi-phy@c9a0600
[    0.087544] platform c900000.display-subsystem: Fixed dependency cycle(s) with /soc@0/interconnect@1744000
[    0.087606] platform c900000.display-subsystem: Fixed dependency cycle(s) with /soc@0/clock-controller@c8c0000
[    0.090183] platform hdmi-bridge: Fixed dependency cycle(s) with /hdmi-out/port/endpoint
[    0.090894] Modules: 19888 pages in range for non-PLT usage
[    0.090898] Modules: 511408 pages in range for PLT usage
[    0.091555] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.091572] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.091583] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.091592] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.091601] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.091611] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.091621] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.091630] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.092767] ACPI: Interpreter disabled.
[    0.094364] iommu: Default domain type: Translated
[    0.094375] iommu: DMA domain TLB invalidation policy: strict mode
[    0.094606] SCSI subsystem initialized
[    0.094722] libata version 3.00 loaded.
[    0.094891] usbcore: registered new interface driver usbfs
[    0.094920] usbcore: registered new interface driver hub
[    0.094952] usbcore: registered new device driver usb
[    0.095189] mc: Linux media interface: v0.10
[    0.095239] videodev: Linux video capture interface: v2.00
[    0.095307] pps_core: LinuxPPS API ver. 1 registered
[    0.095317] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.095336] PTP clock support registered
[    0.095368] EDAC MC: Ver: 3.0.0
[    0.095672] scmi_core: SCMI protocol bus registered
[    0.095749] qcom_scm: convention: smc arm 64
[    0.097724] FPGA manager framework
[    0.097806] Advanced Linux Sound Architecture Driver Initialized.
[    0.098383] Bluetooth: Core ver 2.22
[    0.098409] NET: Registered PF_BLUETOOTH protocol family
[    0.098419] Bluetooth: HCI device and connection manager initialized
[    0.098432] Bluetooth: HCI socket layer initialized
[    0.098443] Bluetooth: L2CAP socket layer initialized
[    0.098459] Bluetooth: SCO socket layer initialized
[    0.098795] vgaarb: loaded
[    0.099245] clocksource: Switched to clocksource arch_sys_counter
[    0.099429] VFS: Disk quotas dquot_6.6.0
[    0.099460] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.099612] pnp: PnP ACPI: disabled
[    0.107847] NET: Registered PF_INET protocol family
[    0.107991] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.110159] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.110204] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.110260] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.110431] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.111114] TCP: Hash tables configured (established 32768 bind 32768)
[    0.111218] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.111337] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.111508] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.111881] RPC: Registered named UNIX socket transport module.
[    0.111892] RPC: Registered udp transport module.
[    0.111900] RPC: Registered tcp transport module.
[    0.111906] RPC: Registered tcp-with-tls transport module.
[    0.111914] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.112718] PCI: CLS 0 bytes, default 64
[    0.112829] s3: Bringing 0uV into 1352000-1352000uV
[    0.113015] s4: Bringing 0uV into 1800000-1800000uV
[    0.113143] s5: Bringing 0uV into 1904000-1904000uV
[    0.113272] s7: Bringing 0uV into 900000-900000uV
[    0.113524] l1: Bringing 0uV into 880000-880000uV
[    0.113654] l2: Bringing 0uV into 1200000-1200000uV
[    0.113792] l3: Bringing 0uV into 1000000-1000000uV
[    0.113926] l5: Bringing 0uV into 800000-800000uV
[    0.114056] l6: Bringing 0uV into 1808000-1808000uV
[    0.114206] l7: Bringing 0uV into 1800000-1800000uV
[    0.114335] l8: Bringing 0uV into 1200000-1200000uV
[    0.114468] l9: Bringing 0uV into 1808000-1808000uV
[    0.114619] l10: Bringing 0uV into 1808000-1808000uV
[    0.114760] l11: Bringing 0uV into 1000000-1000000uV
[    0.114897] l12: Bringing 0uV into 1800000-1800000uV
[    0.115041] l13: Bringing 0uV into 1808000-1808000uV
[    0.115188] l14: Bringing 0uV into 1880000-1880000uV
[    0.115350] l15: Bringing 0uV into 1800000-1800000uV
[    0.115499] l16: Bringing 0uV into 2704000-2704000uV
[    0.115642] l17: Bringing 0uV into 1304000-1304000uV
[    0.115781] l18: Bringing 0uV into 2704000-2704000uV
[    0.115939] l19: Bringing 0uV into 3008000-3008000uV
[    0.116083] l20: Bringing 0uV into 2960000-2960000uV
[    0.116249] l21: Bringing 0uV into 2960000-2960000uV
[    0.116398] l22: Bringing 0uV into 2864000-2864000uV
[    0.116547] l23: Bringing 0uV into 3312000-3312000uV
[    0.116707] l24: Bringing 0uV into 3088000-3088000uV
[    0.116855] l25: Bringing 0uV into 3104000-3104000uV
[    0.117006] l26: Bringing 0uV into 1200000-1200000uV
[    0.117165] l28: Bringing 0uV into 3008000-3008000uV
[    0.118145] kvm [1]: HYP mode not available
[    0.119172] Initialise system trusted keyrings
[    0.119420] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    0.119660] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.119925] NFS: Registering the id_resolver key type
[    0.119949] Key type id_resolver registered
[    0.119958] Key type id_legacy registered
[    0.119979] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.119991] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.120141] 9p: Installing v9fs 9p2000 file system support
[    0.218778] Key type asymmetric registered
[    0.218826] Asymmetric key parser 'x509' registered
[    0.218961] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
[    0.219005] io scheduler mq-deadline registered
[    0.219031] io scheduler kyber registered
[    0.233350] EINJ: ACPI disabled.
[    0.254810] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.260412] msm_serial: driver initialized
[    0.262381] arm-smmu 1680000.iommu: probing hardware configuration...
[    0.262426] arm-smmu 1680000.iommu: SMMUv2 with:
[    0.262487] arm-smmu 1680000.iommu: 	stage 1 translation
[    0.262526] arm-smmu 1680000.iommu: 	address translation ops
[    0.262558] arm-smmu 1680000.iommu: 	non-coherent table walk
[    0.262590] arm-smmu 1680000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    0.262628] arm-smmu 1680000.iommu: 	stream matching with 16 register groups
[    0.262690] arm-smmu 1680000.iommu: 	6 context banks (0 stage-2 only)
[    0.263094] arm-smmu 1680000.iommu: 	Supported page sizes: 0x63315000
[    0.263137] arm-smmu 1680000.iommu: 	Stage-1: 36-bit VA -> 36-bit IPA
[    0.263512] arm-smmu 1680000.iommu: 	preserved 0 boot mappings
[    0.265555] arm-smmu 16c0000.iommu: probing hardware configuration...
[    0.265601] arm-smmu 16c0000.iommu: SMMUv2 with:
[    0.265658] arm-smmu 16c0000.iommu: 	stage 1 translation
[    0.265698] arm-smmu 16c0000.iommu: 	address translation ops
[    0.265729] arm-smmu 16c0000.iommu: 	non-coherent table walk
[    0.265759] arm-smmu 16c0000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    0.265796] arm-smmu 16c0000.iommu: 	stream matching with 14 register groups
[    0.265857] arm-smmu 16c0000.iommu: 	10 context banks (0 stage-2 only)
[    0.266199] arm-smmu 16c0000.iommu: 	Supported page sizes: 0x63315000
[    0.266243] arm-smmu 16c0000.iommu: 	Stage-1: 36-bit VA -> 36-bit IPA
[    0.266529] arm-smmu 16c0000.iommu: 	preserved 0 boot mappings
[    0.288283] loop: module loaded
[    0.294030] spmi spmi-0: PMIC arbiter version v3 (0x30000000)
[    0.309304] s1: Bringing 752000uV into 988000-988000uV
[    0.314466] tun: Universal TUN/TAP device driver, 1.6
[    0.320136] ath10k_snoc 18800000.wifi: Adding to iommu group 0
[    0.322321] ath10k_snoc 18800000.wifi: snoc xo-cal-data return -22
[    0.324011] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
[    0.324358] ath10k_snoc 18800000.wifi: qmi msa.paddr: 0x0000000094400000 , msa.vaddr: 0x(____ptrval____)
[    0.324594] ath10k_snoc 18800000.wifi: snoc probe
[    0.325081] usbcore: registered new interface driver rtl8xxxu
[    0.325784] VFIO - User Level meta-driver version: 0.3
[    0.329634] usbcore: registered new interface driver usb-storage
[    0.336508] rtc-pm8xxx 800f000.spmi:pmic@0:rtc@6000: registered as rtc0
[    0.336614] rtc-pm8xxx 800f000.spmi:pmic@0:rtc@6000: setting system clock to 1970-01-01T00:00:10 UTC (10)
[    0.336978] i2c_dev: i2c /dev entries driver
[    0.339118] IR NEC protocol handler initialized
[    0.339150] IR RC5(x/sz) protocol handler initialized
[    0.339175] IR RC6 protocol handler initialized
[    0.343522] input: pm8941_pwrkey as /devices/platform/soc@0/800f000.spmi/spmi-0/0-00/800f000.spmi:pmic@0:pon@800/800f000.spmi:pmic@0:pon@800:pwrkey/input/input0
[    0.361278] Bluetooth: HCI UART driver ver 2.3
[    0.361323] Bluetooth: HCI UART protocol H4 registered
[    0.361355] Bluetooth: HCI UART protocol BCSP registered
[    0.361427] Bluetooth: HCI UART protocol LL registered
[    0.361486] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    0.361695] Bluetooth: HCI UART protocol Broadcom registered
[    0.361752] Bluetooth: HCI UART protocol QCA registered
[    0.361806] Bluetooth: HCI UART protocol Marvell registered
[    0.361879] usbcore: registered new interface driver btusb
[    0.365582] sdhci: Secure Digital Host Controller Interface driver
[    0.365618] sdhci: Copyright(c) Pierre Ossman
[    0.366520] Synopsys Designware Multimedia Card Interface Driver
[    0.368060] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.374502] ledtrig-cpu: registered to indicate activity on CPUs
[    0.376699] hid: raw HID events driver (C) Jiri Kosina
[    0.379404] usbcore: registered new interface driver usbhid
[    0.379585] usbhid: USB HID core driver
[    0.449175] NET: Registered PF_PACKET protocol family
[    0.449806] Bluetooth: RFCOMM TTY layer initialized
[    0.449860] Bluetooth: RFCOMM socket layer initialized
[    0.449908] Bluetooth: RFCOMM ver 1.11
[    0.449952] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    0.449991] Bluetooth: BNEP socket layer initialized
[    0.450017] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    0.450049] Bluetooth: HIDP socket layer initialized
[    0.450219] 9pnet: Installing 9P2000 support
[    0.450390] Key type dns_resolver registered
[    0.474122] registered taskstats version 1
[    0.474498] Loading compiled-in X.509 certificates
[    0.531526] qcom-qusb2-phy c012000.phy: supply vdd not found, using dummy regulator
[    0.532359] qcom-qusb2-phy c012000.phy: Registered Qcom-QUSB2 phy
[    0.535633] qcom-pcie 1c00000.pcie: supply vdda not found, using dummy regulator
[    0.535897] qcom-pcie 1c00000.pcie: supply vddpe-3v3 not found, using dummy regulator
[    0.536147] qcom-pcie 1c00000.pcie: host bridge /soc@0/pcie@1c00000 ranges:
[    0.536253] qcom-pcie 1c00000.pcie:       IO 0x001b200000..0x001b2fffff -> 0x0000000000
[    0.536323] qcom-pcie 1c00000.pcie:      MEM 0x001b300000..0x001bffffff -> 0x001b300000
[    0.584583] msm_serial c171000.serial: msm_serial: detected port #1
[    0.584670] msm_serial c171000.serial: uartclk = 19200000
[    0.585350] c171000.serial: ttyMSM1 at MMIO 0xc171000 (irq = 59, base_baud = 1200000) is a MSM
[    0.585835] serial serial0: tty port ttyMSM1 registered
[    0.587096] msm_serial c1b0000.serial: msm_serial: detected port #0
[    0.587169] msm_serial c1b0000.serial: uartclk = 1843200
[    0.587738] c1b0000.serial: ttyMSM0 at MMIO 0xc1b0000 (irq = 60, base_baud = 115200) is a MSM
[    0.587813] msm_serial: console setup on port #0
[    0.587943] printk: legacy console [ttyMSM0] enabled
[    0.649910] qcom-pcie 1c00000.pcie: iATU: unroll F, 32 ob, 8 ib, align 4K, limit 4G
[    0.654705] arm-smmu 5040000.iommu: probing hardware configuration...
[    0.655406] Bluetooth: hci0: setting up wcn399x
[    0.660410] qcom-pcie 1c00000.pcie: Invalid eDMA IRQs found
[    0.759304] qcom-pcie 1c00000.pcie: PCIe Gen.1 x1 link up
[    0.764221] arm-smmu 5040000.iommu: SMMUv2 with:
[    0.775309] qcom-pcie 1c00000.pcie: PCI host bridge to bus 0000:00
[    0.784943] arm-smmu 5040000.iommu: 	stage 1 translation
[    0.792727] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.800937] arm-smmu 5040000.iommu: 	address translation ops
[    0.800952] arm-smmu 5040000.iommu: 	non-coherent table walk
[    0.800964] arm-smmu 5040000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    0.800977] arm-smmu 5040000.iommu: 	stream matching with 3 register groups
[    0.801012] Bluetooth: hci0: Frame reassembly failed (-84)
[    0.810965] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    0.815178] arm-smmu 5040000.iommu: 	3 context banks (0 stage-2 only)
[    0.822228] pci_bus 0000:00: root bus resource [mem 0x1b300000-0x1bffffff]
[    0.822284] pci 0000:00:00.0: [17cb:0105] type 01 class 0x060400
[    0.827706] arm-smmu 5040000.iommu: 	Supported page sizes: 0x63315000
[    0.830325] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.836290] arm-smmu 5040000.iommu: 	Stage-1: 48-bit VA -> 36-bit IPA
[    0.840132] pci 0000:00:00.0: PME# supported from D0 D3hot
[    0.845689] arm-smmu 5040000.iommu: 	preserved 0 boot mappings
[    0.863885] pci 0000:01:00.0: [1969:1083] type 00 class 0x020000
[    0.869632] arm-smmu cd00000.iommu: probing hardware configuration...
[    0.872814] pci 0000:01:00.0: reg 0x10: [mem 0x1b300000-0x1b33ffff 64bit]
[    0.878086] arm-smmu cd00000.iommu: SMMUv2 with:
[    0.884627] pci 0000:01:00.0: reg 0x18: [io  0x1b200000-0x1b20007f]
[    0.890609] arm-smmu cd00000.iommu: 	stage 1 translation
[    0.898599] pci 0000:01:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    0.903081] arm-smmu cd00000.iommu: 	address translation ops
[    0.909301] pci 0000:01:00.0: quirk_blacklist_vpd+0x0/0x34 took 10452 usecs
[    0.912077] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.915599] arm-smmu cd00000.iommu: 	non-coherent table walk
[    0.936133] pci 0000:00:00.0: BAR 8: assigned [mem 0x1b300000-0x1b3fffff]
[    0.941484] arm-smmu cd00000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    0.946482] pci 0000:00:00.0: BAR 0: assigned [mem 0x1b400000-0x1b400fff]
[    0.946514] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.951229] arm-smmu cd00000.iommu: 	stream matching with 54 register groups
[    0.956090] pci 0000:01:00.0: BAR 0: assigned [mem 0x1b300000-0x1b33ffff 64bit]
[    0.957580] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    0.957587] Bluetooth: hci0: QCA SOC Version  :0x40010214
[    0.957590] Bluetooth: hci0: QCA ROM Version  :0x00000201
[    0.957593] Bluetooth: hci0: QCA Patch Version:0x00000001
[    0.961043] arm-smmu cd00000.iommu: 	17 context banks (0 stage-2 only)
[    0.965834] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x107f]
[    0.970075] arm-smmu cd00000.iommu: 	Supported page sizes: 0x63315000
[    0.974540] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.980086] Bluetooth: hci0: QCA controller version 0x02140201
[    0.980094] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    0.981000] arm-smmu cd00000.iommu: 	Stage-1: 32-bit VA -> 36-bit IPA
[    0.986993] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.993969] arm-smmu cd00000.iommu: 	preserved 0 boot mappings
[    0.997587] pci 0000:00:00.0:   bridge window [mem 0x1b300000-0x1b3fffff]
[    0.998157] atl1c 0000:01:00.0: Adding to iommu group 1
[    1.455435] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    1.464815] atl1c 0000:01:00.0: enabling device (0000 -> 0002)
[    1.532273] Bluetooth: hci0: QCA setup on UART is completed
[    3.013898] spi_qup c175000.spi: IN:block:16, fifo:64, OUT:block:16, fifo:64
[    3.017632] spidev@0 enforce active low on GPIO handle
[    3.024550] spidev@3 enforce active low on GPIO handle
[    3.027057] Bluetooth: hci0: AOSP extensions version v0.96
[    3.034409] Bluetooth: hci0: AOSP quality report is not supported
[    3.040386] spi_qup c1b7000.spi: IN:block:16, fifo:64, OUT:block:16, fifo:64
[    3.063037] Bluetooth: hci0: Frame reassembly failed (-84)
[    3.071896] Bluetooth: hci0: Frame reassembly failed (-84)
[    3.150629] rtl8367c_spi spi1.0: RTL8367C driver loaded, chip id=6367 ver=0040
[    3.232093] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    3.232177] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    3.236679] xhci-hcd xhci-hcd.1.auto: hcc params 0x0230fe65 hci version 0x110 quirks 0x0000000002000010
[    3.244169] xhci-hcd xhci-hcd.1.auto: irq 90, io mem 0x0a800000
[    3.253573] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    3.259336] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    3.264928] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    3.274742] hub 1-0:1.0: USB hub found
[    3.279215] hub 1-0:1.0: 1 port detected
[    3.283091] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.287695] hub 2-0:1.0: USB hub found
[    3.295002] hub 2-0:1.0: 1 port detected
[    3.312877] tusb8042 1-0044: supply vdd not found, using dummy regulator
[    3.313363] tusb8042 1-0044: supply vdd33 not found, using dummy regulator
[    3.321820] tusb8042 1-0044: hub probed successfully, vid:0451 pid:8240
[    3.326033] ld6710_fbx 1-0068: probe
[    3.334032] ld6710_fbx 1-0068: LD6710 chip 00, fw 04
[    3.335838] ld6710_fbx 1-0068: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.352992] ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
[    3.358048] scsi host0: ufshcd
[    3.378944] remoteproc remoteproc0: 4080000.remoteproc is available
[    3.385572] remoteproc remoteproc1: 17300000.remoteproc is available
[    3.385918] remoteproc remoteproc1: powering up 17300000.remoteproc
[    3.393812] remoteproc remoteproc1: Booting fw image adsp.mdt, size 7260
[    3.429385] adreno 5000000.gpu: Adding to iommu group 2
[    3.434150] msm-mdss c900000.display-subsystem: Adding to iommu group 3
[    3.438369] platform c9a0000.hdmi-tx: Fixed dependency cycle(s) with /hdmi-bridge/ports/port@0/endpoint
[    3.440220] platform c9a0000.hdmi-tx: Fixed dependency cycle(s) with /soc@0/display-subsystem@c900000/display-controller@c901000/ports/port@2/endpoint
[    3.440292] scsi 0:0:0:49488: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c150hN
[    3.457755] qcom-venus cc00000.video-codec: Adding to iommu group 4
[    3.463049] scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.492111] scsi 0:0:0:49476: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c144hN
[    3.492274] scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.514052] scsi 0:0:0:49456: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c130hN
[    3.514221] scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.533481] scsi 0:0:0:0: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.541662] scsi 0:0:0:1: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.541683] sd 0:0:0:0: [sda] 7732224 4096-byte logical blocks: (31.7 GB/29.5 GiB)
[    3.549162] sd 0:0:0:0: [sda] 16384-byte physical blocks
[    3.556897] sd 0:0:0:0: [sda] Write Protect is off
[    3.562031] sd 0:0:0:0: [sda] Mode Sense: 00 32 00 10
[    3.567248] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.567290] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    3.571538] sd 0:0:0:0: [sda] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.586496] sd 0:0:0:0: [sda] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.600109] sd 0:0:0:1: [sdb] 2048 4096-byte logical blocks: (8.39 MB/8.00 MiB)
[    3.601876] scsi 0:0:0:2: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.607037]  sda: sda1 sda2 sda3 sda4 sda5 sda7 sda8
[    3.607508] sd 0:0:0:1: [sdb] 16384-byte physical blocks
[    3.607791] sd 0:0:0:1: [sdb] Write Protect is off
[    3.612076] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.620553] sd 0:0:0:2: [sdc] 2048 4096-byte logical blocks: (8.39 MB/8.00 MiB)
[    3.623007] sd 0:0:0:1: [sdb] Mode Sense: 00 32 00 10
[    3.623166] scsi 0:0:0:3: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.627991] sd 0:0:0:2: [sdc] 16384-byte physical blocks
[    3.628155] sd 0:0:0:2: [sdc] Write Protect is off
[    3.633542] sd 0:0:0:1: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.638019] sd 0:0:0:2: [sdc] Mode Sense: 00 32 00 10
[    3.642699] sd 0:0:0:1: [sdb] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.642714] sd 0:0:0:1: [sdb] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.697473] sd 0:0:0:1: [sdb] Attached SCSI disk
[    3.699170] sd 0:0:0:2: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.701222] remoteproc remoteproc1: remote processor 17300000.remoteproc is now up
[    3.703433] sd 0:0:0:3: [sdd] 1024 4096-byte logical blocks: (4.19 MB/4.00 MiB)
[    3.703443] sd 0:0:0:3: [sdd] 16384-byte physical blocks
[    3.704351] sd 0:0:0:3: [sdd] Write Protect is off
[    3.704359] sd 0:0:0:3: [sdd] Mode Sense: 00 32 00 10
[    3.704382] scsi 0:0:0:4: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.705126] sd 0:0:0:3: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.705134] sd 0:0:0:3: [sdd] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.705140] sd 0:0:0:3: [sdd] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.714009] sd 0:0:0:4: [sde] 1024 4096-byte logical blocks: (4.19 MB/4.00 MiB)
[    3.714014] scsi 0:0:0:5: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.715010]  sdd: sdd1 sdd2 sdd3 sdd4 sdd5 sdd6
[    3.720825] sd 0:0:0:2: [sdc] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.721112] sd 0:0:0:3: [sdd] Attached SCSI disk
[    3.721154] sd 0:0:0:5: [sdf] 2048 4096-byte logical blocks: (8.39 MB/8.00 MiB)
[    3.721160] sd 0:0:0:5: [sdf] 16384-byte physical blocks
[    3.721552] sd 0:0:0:5: [sdf] Write Protect is off
[    3.721558] sd 0:0:0:5: [sdf] Mode Sense: 00 32 00 10
[    3.721595] scsi 0:0:0:6: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.722077] sd 0:0:0:5: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.722085] sd 0:0:0:5: [sdf] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.722091] sd 0:0:0:5: [sdf] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.723726] sd 0:0:0:6: [sdg] 18432 4096-byte logical blocks: (75.5 MB/72.0 MiB)
[    3.723733] sd 0:0:0:6: [sdg] 16384-byte physical blocks
[    3.723998] sd 0:0:0:6: [sdg] Write Protect is off
[    3.724003] sd 0:0:0:6: [sdg] Mode Sense: 00 32 00 10
[    3.724354] scsi 0:0:0:7: Direct-Access     SAMSUNG  KLUBG4G1CE-B0B1  0800 PQ: 0 ANSI: 6
[    3.724626] sd 0:0:0:6: [sdg] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.724633] sd 0:0:0:6: [sdg] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.724639] sd 0:0:0:6: [sdg] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.726686]  sdf: sdf1 sdf2 sdf3
[    3.728049] sd 0:0:0:6: [sdg] Attached SCSI disk
[    3.728249] sd 0:0:0:4: [sde] 16384-byte physical blocks
[    3.728619] sd 0:0:0:5: [sdf] Attached SCSI disk
[    3.728813] sd 0:0:0:7: [sdh] 16384 4096-byte logical blocks: (67.1 MB/64.0 MiB)
[    3.728819] sd 0:0:0:7: [sdh] 16384-byte physical blocks
[    3.728971] sd 0:0:0:7: [sdh] Write Protect is off
[    3.728977] sd 0:0:0:7: [sdh] Mode Sense: 00 32 00 10
[    3.729093] sd 0:0:0:7: [sdh] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.729101] sd 0:0:0:7: [sdh] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.729106] sd 0:0:0:7: [sdh] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.730945] sd 0:0:0:7: [sdh] Attached SCSI disk
[    3.735465] sd 0:0:0:2: [sdc] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.743096] sd 0:0:0:2: [sdc] Attached SCSI disk
[    3.745972] sd 0:0:0:4: [sde] Write Protect is off
[    3.768657] hdmi_msm c9a0000.hdmi-tx: supply core-vdda not found, using dummy regulator
[    3.777944] sd 0:0:0:4: [sde] Mode Sense: 00 32 00 10
[    3.778973] sd 0:0:0:4: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.788591] hdmi_msm c9a0000.hdmi-tx: supply core-vcc not found, using dummy regulator
[    3.795615] sd 0:0:0:4: [sde] Preferred minimum I/O size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.809385] msm_dpu c901000.display-controller: bound c9a0000.hdmi-tx (ops msm_hdmi_ops)
[    3.817468] hub 1-1:1.0: USB hub found
[    3.817918] hub 1-1:1.0: 4 ports detected
[    3.818863] sd 0:0:0:4: [sde] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.830064]  sde: sde1 sde2 sde3 sde4 sde5
[    3.833354] adreno 5000000.gpu: supply vdd not found, using dummy regulator
[    3.840405] sd 0:0:0:4: [sde] Attached SCSI disk
[    3.841478] adreno 5000000.gpu: supply vddcx not found, using dummy regulator
[    3.895884] usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
[    3.903813] msm_dpu c901000.display-controller: bound 5000000.gpu (ops a3xx_ops)
[    4.143114] [drm:dpu_kms_hw_init:1057] dpu hardware revision:0x30000000
[    4.265461] [drm] Initialized msm 1.12.0 20130625 for c901000.display-controller on minor 0
[    4.265826] msm_dpu c901000.display-controller: [drm:adreno_request_fw] loaded qcom/a530_pm4.fw from new location
[    4.273179] msm_dpu c901000.display-controller: [drm:adreno_request_fw] loaded qcom/a530_pfp.fw from new location
[    4.283409] msm_dpu c901000.display-controller: [drm:adreno_request_fw] loaded qcom/a540_gpmu.fw2 from new location
[    4.297054] msm_dpu c901000.display-controller: [drm:adreno_request_fw] loaded qcom/a540_zap.mdt from new location
[    4.326314] debugfs: File 'pfp' in directory 'c901000.display-controller' already present!
[    4.326437] debugfs: File 'me' in directory 'c901000.display-controller' already present!
[    4.333595] debugfs: File 'meq' in directory 'c901000.display-controller' already present!
[    4.341817] debugfs: File 'roq' in directory 'c901000.display-controller' already present!
[    4.349971] debugfs: File 'reset' in directory 'c901000.display-controller' already present!
[    4.424861] hdmi_8998_pll_set_clk_rate 148500000 19200000
[    4.425470] hdmi_8998_pll_prepare
[    4.426793] msm_hdmi_hdcp_read_validate_aksv: AKSV QFPROM doesn't have 20 1's, 20 0's
[    4.426808] msm_hdmi_hdcp_read_validate_aksv: QFPROM AKSV chk failed (AKSV=0000000000)
[    4.426822] msm_hdmi_hdcp_auth_prepare: ASKV validation failed
[    4.426829] msm_hdmi_hdcp_auth_work: auth prepare failed -524
[    4.426841] msm_hdmi_hdcp_auth_work: hdcp is not supported
[    4.426901] fb0: Framebuffer is not in virtual address space.
[    4.427007] fb0: Framebuffer is not in virtual address space.
[    4.464193] Console: switching to colour frame buffer device 240x67
[    4.549776] msm_dpu c901000.display-controller: [drm] fb0: msmdrmfb frame buffer device
[    4.559864] input: gpio_keys as /devices/platform/gpio_keys/input/input1
[    4.585452] hub 2-1:1.0: USB hub found
[    4.585989] hub 2-1:1.0: 4 ports detected
[    5.588358] atl1c 0000:01:00.0: atl1c: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[    5.611594] Sending DHCP requests .., OK
[    8.355586] IP-Config: Got DHCP answer from 10.126.6.1, my address is 10.126.6.60
[    8.358520] IP-Config: Complete: [SNIP]
[    8.394201] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.407657] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.410836] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    8.412963] clk: Not disabling unused clocks
[    8.420274] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    8.424237] cfg80211: failed to load regulatory.db
[    8.437397] ALSA device list:
[    8.437808]   No soundcards found.
[    8.474132] VFS: Mounted root (nfs filesystem) on device 0:21.
[    8.479811] Freeing unused kernel memory: 5632K
[    8.507720] Run /sbin/init as init process
[    8.507917]   with arguments:
[    8.510819]     /sbin/init
[    8.513899]   with environment:
[    8.516474]     HOME=/
[    8.519501]     TERM=linux
[    9.121206] systemd[1]: System time before build time, advancing clock.
[   11.924787] systemd-journald[203]: Collecting audit messages is disabled.
[   12.067431] systemd-journald[203]: Received client request to flush runtime journal.
[   12.611332] random: crng init done
[   13.593233] atl1c 0000:01:00.0 enp1s0: renamed from eth0 (while UP)
[   15.276168] remoteproc remoteproc0: powering up 4080000.remoteproc
[   15.280059] remoteproc remoteproc0: Booting fw image mba.mbn, size 234152
[   15.285687] ath10k_snoc 18800000.wifi: received modem starting event
[   15.383271] qcom-q6v5-mss 4080000.remoteproc: MBA booted without debug policy, loading mpss
[   15.727551] ath10k_snoc 18800000.wifi: received modem running event
[   15.735940] remoteproc remoteproc0: remote processor 4080000.remoteproc is now up
[   56.014848] qcom-q6v5-mss 4080000.remoteproc: fatal error received: dog_virtual_root.c:204:DOG_VIR : User-PD grace timer expired with asid = 1, na
[   56.015156] remoteproc remoteproc0: crash detected in 4080000.remoteproc: type fatal error
[   56.027254] remoteproc remoteproc0: handling crash #1 in 4080000.remoteproc
[   56.035329] remoteproc remoteproc0: recovering 4080000.remoteproc
[   56.043849] ath10k_snoc 18800000.wifi: received modem crashed event
[   56.151287] qcom-q6v5-mss 4080000.remoteproc: port failed halt
[   56.153275] ath10k_snoc 18800000.wifi: received modem offline event
[   56.158268] remoteproc remoteproc0: stopped remote processor 4080000.remoteproc
[   56.166158] ath10k_snoc 18800000.wifi: received modem starting event
[   56.275276] qcom-q6v5-mss 4080000.remoteproc: MBA booted without debug policy, loading mpss
[   56.795372] ath10k_snoc 18800000.wifi: received modem running event
[   56.797788] remoteproc remoteproc0: remote processor 4080000.remoteproc is now up
### FOLLOWING 12 LINES ARE REPEATED EVERY ~40 seconds
[   96.987102] qcom-q6v5-mss 4080000.remoteproc: fatal error received: dog_virtual_root.c:204:DOG_VIR : User-PD grace timer expired with asid = 1, na
[   96.987427] remoteproc remoteproc0: crash detected in 4080000.remoteproc: type fatal error
[   96.999457] remoteproc remoteproc0: handling crash #2 in 4080000.remoteproc
[   97.007541] remoteproc remoteproc0: recovering 4080000.remoteproc
[   97.016034] ath10k_snoc 18800000.wifi: received modem crashed event
[   97.122811] qcom-q6v5-mss 4080000.remoteproc: port failed halt
[   97.125928] ath10k_snoc 18800000.wifi: received modem offline event
[   97.132323] remoteproc remoteproc0: stopped remote processor 4080000.remoteproc
[   97.136852] ath10k_snoc 18800000.wifi: received modem starting event
[   97.251330] qcom-q6v5-mss 4080000.remoteproc: MBA booted without debug policy, loading mpss
[   98.125357] ath10k_snoc 18800000.wifi: received modem running event
[   98.127095] remoteproc remoteproc0: remote processor 4080000.remoteproc is now up


