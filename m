Return-Path: <linux-wireless+bounces-3088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A984891A
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 23:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F366E283C57
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E492134C6;
	Sat,  3 Feb 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS/OKPyt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A5134D9
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706998208; cv=none; b=pGpLpRXERU+07tudIVjFECeFVuuCbAR+RgfGjTuCL3CFFyFpNOq/F3aw1XLRJDJQ24EBIMa4kiHtWNvDhZEr2vunfEOEk5LzFGDJQLpukFfYaEYC/NELkcBOPLtAvPYpzwVaaeCMbJCtlte72+Kpl6GkiG/9kO0fSVbIcSePYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706998208; c=relaxed/simple;
	bh=7emOyW0UQlXcjoe1U4K0aklXPMDzpu+q5sKLpeDisWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ssN7AxmPqXyTGkZqScjYRqKb/dkk5Kc4EwT+tnvSL9dhoHpj9ug9By2BzhvR5eUtxFOlgn6m987aOSD7dQgtlrkisqpbdGZa9scZQsib9++sCT5G9f/eNkNwSbDlU+etTUcyKsJL9heDqS6aBn2Ubq5jKDs4YlzVP9sRT3NWxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS/OKPyt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b18099411so2011482f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 03 Feb 2024 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706998204; x=1707603004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GYO3j/OiNpm5Bjw39Ih/hLrIyxZ2n5YjMJCkJJ45Ys=;
        b=CS/OKPytU6gtMFfKN0r5K/5l2E6t5VfBzJ2bwEiyjLNNCvfasogNk7oLEtF7G6mQYu
         RayGfSUsL3MEootzI4lBFdWKZZ2b4P6D8ekrLafv73zAaNMoGKvE4J0phVHv/5Ouq3Ni
         u/jofQZBmRkpZ1QrYMpwPu7x69sZe7wZ9hYVA+Vt3eURuz9ua7VxDMBNWrns8ILPnFp3
         f1b16xl9pUZDZ0/LEoG7JNqrlzj97OYGovYjQH+L6nS8LbPX+YEfesQUqd4cFRGeFZlr
         7kKIdPaCaWldkcYrRMrJYnsDL80sh6x6DEPFnGnNAzItj8YilF5r5MIdDZGOFmodorY3
         OrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706998204; x=1707603004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GYO3j/OiNpm5Bjw39Ih/hLrIyxZ2n5YjMJCkJJ45Ys=;
        b=ibVbP5iRmkI6zqGEfdXn/T2uH9fD8LSE7XvfdLT+MH+zl1d5JWq7WRRhrAROLyUEpY
         Yg3TYG+ObkZvW+9sSph237sCCs9wBOTPPROET4b1S5uvXOWmfk+dqVd9RCTicZG+ij+G
         MFKqpHqb0LO5/U9t5lE9LACqrO88ppllcvRqG0YRzZCovIt8p//KihueiBZANm1YZ/Pk
         lROOnodQ0Svo1DQ0bBxHdBPuMP744YR7HxBHwzmD39TdEVZnW5ySrhbO6qkR+9lq8xLZ
         0DexhyVOUGtT3oETefdLDdsTtBBy5cxVZLhS+9d9W2l0uqcqTe+A/MituMHsOgn/4Jpb
         2ETA==
X-Gm-Message-State: AOJu0YxS9dYrnfEkgd/rL0aEWJ7ETTKxVZmLkxCJUOtXR7r2TVlkbYCo
	cT5OSdDPR07VfG9SRpTaTwJpyyzt2erKLBtbqgNMrlsJLgFNjZNMqSY9hW6h
X-Google-Smtp-Source: AGHT+IFRFHKS5s3F7GwAbcJbHkhUNIBtw41GUQUA6Gca7npewErNg0c81K8YZrtaOzCXBJA7ctk25A==
X-Received: by 2002:adf:a4d3:0:b0:33b:183f:b194 with SMTP id h19-20020adfa4d3000000b0033b183fb194mr3921663wrb.38.1706998204387;
        Sat, 03 Feb 2024 14:10:04 -0800 (PST)
Received: from nixos.localnet (alagny-155-1-32-83.w83-200.abo.wanadoo.fr. [83.200.85.83])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c1d9500b0040faf410320sm4058637wms.20.2024.02.03.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 14:10:04 -0800 (PST)
From: chris <inkbottle007@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: gregory.greenman@intel.com
Subject:
 Persistent `iwlwifi` Queue Stuck and `rcu_preempt` Detected Stalls on AX210
Date: Sat, 03 Feb 2024 22:10:03 +0000
Message-ID: <2494913.iZASKD2KPV@nixos>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dear Linux Wireless Community and Gregory Greenman,

I=E2=80=99m writing to bring to your attention a persistent issue affecting=
 Intel AX210=20
Wi-Fi adapter users. Myself and others across different Linux distributions=
,=20
including NixOS and Fedora, have encountered regular system crashes=20
characterized by `iwlwifi` queue stuck log entries, followed by `rcu_preemp=
t=20
detected stalls`.=20

=46rom discussions on kernel bug trackers and with other users facing the s=
ame=20
problem, it seems this issue might be related to the Wi-Fi adapter halting =
the=20
PCIe bus, leading to a system-wide freeze necessitating a hard restart.

I haven't observed any specific circumstances leading to the crash which oc=
curs=20
irregularly. On Fedora Adam seems to have observed it is the downloading of=
=20
large files that is causing it.

Below a brief summary of my system setup and error logs:

```
$ hostnamectl=20
 Static hostname: nixos
       Icon name: computer-desktop
         Chassis: desktop =F0=9F=96=A5
Operating System: NixOS 24.05 (Uakari)           =20
          Kernel: Linux 6.7.1
    Architecture: x86-64
 Hardware Vendor: ASUS
  Hardware Model: ROG STRIX X670E-E GAMING WIFI
=46irmware Version: 1807
   Firmware Date: Thu 2023-12-14
```

```
$ journalctl -b 0 | grep "firmware version"
Jan 30 06:49:29 nixos kernel: iwlwifi 0000:08:00.0: loaded firmware version=
=20
86.fb5c9aeb.0 ty-a0-gf-a0-86.ucode op_mode iwlmvm
```

```
$ journalctl -b -1
=2E..
Jan 26 03:24:55 nixos kernel: iwlwifi 0000:08:00.0: Queue 4 is stuck 39108=
=20
39109
Jan 26 03:25:00 nixos kernel: sched: RT throttling activated
Jan 26 03:25:11 nixos bluetoothd[1059]: profiles/audio/avdtp.c:cancel_reque=
st()=20
Suspend: Connection timed out (110)
Jan 26 03:25:16 nixos kernel: rcu: INFO: rcu_preempt detected stalls on CPU=
s/
tasks:
Jan 26 03:25:16 nixos kernel: rcu:         0-....: (8 GPs behind) idle=3Dd6=
bc/
1/0x4000000000000002 softirq=3D3077933/3077934 fqs=3D5080
Jan 26 03:25:16 nixos kernel: rcu:         (detected by 3, t=3D21002 jiffie=
s,=20
g=3D14745593, q=3D886 ncpus=3D12)
```

Here error log from Adam experiencing same system crash:

```
$ egrep -i 'queue.*is stuck|rcu_preempt' fedora_journalctl_20240116
Jan 15 10:31:58 fedora kernel: iwlwifi 0000:0a:00.0: Queue 4 is stuck 12684=
=20
12704
Jan 15 10:32:50 fedora kernel: rcu: INFO: rcu_preempt detected stalls on CP=
Us/
tasks:
```
=46or additional information and undertaken troubleshooting steps:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217990[1]
https://community.intel.com/t5/Wireless/AX210-System-Crash-after-iwlwifi-Qu=
eue-Stuck-Error-Issue/m-p/1562147[2]
https://bugzilla.redhat.com/show_bug.cgi?id=3D2262044[3]

Any guidance, insights, or suggestions for troubleshooting this issue furth=
er=20
would be greatly appreciated.=20

Thank you for your time and dedication to the Linux wireless ecosystem.

Sincerely, =20
Chris=20

=2D-------
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217990
[2] https://community.intel.com/t5/Wireless/AX210-System-Crash-after-iwlwif=
i-Queue-Stuck-Error-Issue/m-p/1562147
[3] https://bugzilla.redhat.com/show_bug.cgi?id=3D2262044




