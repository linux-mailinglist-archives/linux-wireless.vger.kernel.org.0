Return-Path: <linux-wireless+bounces-17567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E9A12A45
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 18:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D3E188B428
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68F61A00EC;
	Wed, 15 Jan 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FihV3LTN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33916DEDF
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963726; cv=none; b=r1x1EAajOWCGQY/m+vj1JWPrg0nPvnMLkQmGlJnyLy0bYeMhuxRXNjcNBY0XsE9r/lQeD8bHJejQf27k0+WIrHFDN5zOpLEyPyOsyPmzvEMbxREK68x4HbIC3t+HOgxZwq0CaVzVgICpgO4ca7vrxgwwwzCC9fJdBkOabOnr48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963726; c=relaxed/simple;
	bh=jq+YJHu59Gmy/7GFunRU/FthoBLQJAzv6M39Nxk2gSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sysgR/y2qpcickmVZTay/Dl8WfYb/irz+tSJV/A9US2dp1WwiJ/B80+7K5fIZ5/DmjXdjsBF7pxO1uJLYr476aey8aag75SDWEcq5sxRXGwfOXtVpSnpKRfs3lGdxsHGN+jM/paTMSKz0JH/pZIpfW97xN5nqunriGtIbNxwx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FihV3LTN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43626213fffso7423685e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736963723; x=1737568523; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlDDNcKDaZcW8uRMpLsonrE48doB0/bvIA2RZCJ2Hho=;
        b=FihV3LTNoC5hYn0FPOCpQH3NdcgjlYZcdM3Tm4ZBwX56ZyjRze19WKqpQA7kh02qEv
         xM9QVVFen8Y9ScpJJzUoP7yxeTgNsYR91FLcemEcZWT1NXXCi4IweoFYAqFnKzJwqoxh
         OPMOkddlmMxjAOifnwNLI2vMVNqQYgnDbQD60zweOjgnBgkUCtznRW/theQqj6OwSXgw
         HGm3s4EmZmdocAY3eryJ0Dg3+3rUNjWNRDnvSo6DeEXR3LHpid+nLbuy/JycIGzaQzUc
         owmpj4OFf7UzruYb4j+u9OPTryp4PiWVuTmlKKEASKTrNHa+4CF9Dh/TJIK7j42pizeI
         4FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963723; x=1737568523;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlDDNcKDaZcW8uRMpLsonrE48doB0/bvIA2RZCJ2Hho=;
        b=NoJxi3AAQan2o6elMwmcHO7CZ1qRgmE5b83OWVOli3UK6RqFrdU32alZBKr36PXmEu
         45hyv5Zp0VAD8I88FpBS6tdJWG96g+w/6cQBCCzixIwF6GPxDdyGqaardsAtj1TLJqTm
         2pTpAzBdgDsmoiIL1mSOSC5+vF4iJACdR9XJOFIyPG58YChzHjXNs6rO5jdTQIsdRP+Z
         nKzwqpv0WY35XVsKy0H4sJrkE4EhTOcpEsuVKSeiCacqYAJDv1UIVLx5Ln5LT4DV73T6
         Y6qa56kkwTPPgyfMP1XCKT7T3Mizayw9RnvYjCgCa8tv0yynsXAEVIDpzSqnIgRgPlCL
         jg5w==
X-Gm-Message-State: AOJu0YzHPeFOtX6pfYPDfMZ6dAfgF8IAwUKuKSurXai/ZvIjHh1ShfYp
	+Hjc68EMx1CGqXJ07EWAVtMGAvet6pdhOyka0oLeh/uDmlQKPTlwxrCndg==
X-Gm-Gg: ASbGncuJ6xJrZ1/6+rg5B5hsMRL8vUzNGt5Xnc+guZgs3HL9rr766gK5eV2oRBk6jzw
	7ublRI5SbX2eMYDraqGoi8mIWCTRb1fo1LCgDHU+mC/kRFWi61OqxbpVhQ9sxIH98abrWTuuvWX
	CV8cQwzwXIqktRk4v8uZAuWoN3QLHqKXb9hpWATomsmFuzeDoiVaULWImS28bvThFOaRJyUvaOd
	snv2sY1GdWSjHGu7XWrSBrmtIB7akfDGiNyEEGCV/OwwLsw5baGBFr0CAegd5TTa3iClEPbKTg=
X-Google-Smtp-Source: AGHT+IFI1l0q2TyjPbJiKFhDTGKHt3GarGprcZBwc1uYTtn4KG2IKwwePxh9rc58ZBicbtX9Hz3KHw==
X-Received: by 2002:a7b:ce86:0:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-437c6af2037mr32040895e9.6.1736963722866;
        Wed, 15 Jan 2025 09:55:22 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74abb27sm30829685e9.9.2025.01.15.09.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jan 2025 18:55:21 +0100
Message-Id: <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/7] wifi: ath12k: Add monitor interface support on
 QCN9274
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
In-Reply-To: <20250107021017.3857555-1-quic_periyasa@quicinc.com>

On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
> Currently, monitor interface not supported. Therefore, add the missed TLV
> tags parsing in the monitor parser, configure the monitor vdev state
> identifier with HTT filter setup.
>
> Depends-On:
> 	[PATCH v3 0/3] wifi: ath12k: Refactor monitor Rx handler
> 	https://lore.kernel.org/all/20241224143613.164921-1-quic_periyasa@quicin=
c.com/
>
> 	[PATCH v2 00/14] wifi: ath12k: Enable monitor ring for updating station =
dump in QCN9274
> 	https://lore.kernel.org/all/20241223060132.3506372-1-quic_ppranees@quici=
nc.com/
>
> 	[PATCH v2 00/10] wifi: ath12k: Add peer extended Rx statistics debugfs s=
upport
> 	https://lore.kernel.org/all/20241224161442.263729-1-quic_periyasa@quicin=
c.com/
>
> Hari Chandrakanthan (1):
>   wifi: ath12k: fix link valid field initialization in the monitor Rx
>
> Karthikeyan Periyasamy (1):
>   wifi: ath12k: Replace band define G with GHZ where appropriate
>
> P Praneesh (5):
>   wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
>   wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
>   wifi: ath12k: change the status update in the monitor Rx
>   wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
>   wifi: ath12k: add monitor interface support on QCN9274
>
[...]

Hello,

There might be something wrong with this series.

I applied it on top of ath-pending-202501150104 + the "ath12k: Add peer ext=
ended
Rx statistics debugfs support" and now 'iw dev wlan0 station dump' shows me
that the RSSI value seems to not be updated anymore after I stop a monitor
interface on the same phy.

Steps to reproduce:
iw phy phy0 interface add mon0 type monitor
ip link set mon0 up
# then just for 1 sec but it might not be usefull at all
tcpdump -nepi mon0
ip link set mon0 down
watch -n1 iw dev wlan0 station dump
# 'signal' seems to not be updating anymore, maybe some other fields too ?

Don't know if this is from this series or something else broken before, but=
 as
we could not add a monitor interface before, I could not see it.

There still is a possibility that I messed something up while applying it s=
o I
would greatly appreciate if you could check it.

This is on split-phy QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILIC=
ONZ-1

Thanks

