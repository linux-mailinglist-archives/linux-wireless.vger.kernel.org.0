Return-Path: <linux-wireless+bounces-8789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB3903B20
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31621C24174
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B0817F37D;
	Tue, 11 Jun 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzRT4DcN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB017E917;
	Tue, 11 Jun 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106395; cv=none; b=jvevskr3INqM6k6jccSf7bi9cU3s1WMJ5kAfLIf7/b98HXR6/gk8zi4KQLs0g7z5kLsU02IlzMTbhk7YWK8AkdtmzLCHx3CRL5qiQTFypkp9m4ej7jdaoHZVXZHKWCUmRnaEAEkmS6ZHk7Glzh0Xs0i7YoCrU+maBtu1+ICimQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106395; c=relaxed/simple;
	bh=AINinorpPKyxWmfo82lnRkRi9te8sFDsBLq3LrFlYxs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cF/ZnYS5AFo0lrqWS92L2U5nS1tyFY6ecIbomJGR9xBqHMNSBgYAaWdeq8RsBPYwCqwmG5zlesOD1Hyxx3X92zM2H7rOFIjEkzCEI161uS8oR2FiY8fUcLUAoKqwPUDXQKulKL9IopQWjPKuTY9SKpBRqVZYF8TJuUhPda6rReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzRT4DcN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f60a17e3e7so4898115ad.1;
        Tue, 11 Jun 2024 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718106393; x=1718711193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5+FNsgFTzouaSii0B2x8nVgKa1T/D7rNb0Lvm5+9HA=;
        b=hzRT4DcNNVzgW3yYdaBbyK+2kLrhDg7xEpPmcNhjzQ6e4oaPyhqyJkvsB502JgXkgO
         jwL7kKZEo7W5nWxD43PZIGUPWmVRNAfwQ9TNYukxeGkT17Jyn/hekVJ3lZwnFqpjP0PS
         G/+CX7hVtPQl5wpfvjpz6SPb+jFiVCpbBh2vNjIJsvZSMHprq5+iDzvzYKzoNV9fgi20
         cpYmwCrt2XefZsoUKe/ubL56i5R4K8PduC8rhO0oB3G1HpPB5Pe/h+GzgO6gtAJ9I022
         XOn0rvjls5H4RQaJZHkHHEZBdy0OEaU25H7noAcmNQ4NvRPsHhaSjEY5QegAZ95POD6X
         Hepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106393; x=1718711193;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5+FNsgFTzouaSii0B2x8nVgKa1T/D7rNb0Lvm5+9HA=;
        b=sY6QnZn9TIeXXyYTLZFvuMf2CCcupt9jqO0wajMDaOyzO7AQJ1erSB2073KjtAaQQJ
         Ns32pg9mz3UMtBWqGnxjZxLsyFgmcr7fS/aJE42SdtqrIoGwac35emYry2O3knqYcckU
         EE91oqCjmfIKrOMbbNlBKesDA/tNZrLrVMAlVlyZ8ANST4bBC8ERqDeI/srAdBXD+G7+
         Rt8n+xrQ5sbgf3DPeHBGOTV06grvnGOXOSFcmm3H+ezEdtW97tI+Qa+IxnsNqWmw5Uh+
         neuzB3ksxNkhg5zLDuOQC7z+1y6r24hkBWeIoum+tJ2mMIIp+sXzg3sLO6Zp+BZJzboM
         XO5A==
X-Forwarded-Encrypted: i=1; AJvYcCWHJdwKDrC7d65bQU0NN5U4tgclLxcML24RGtY/nZlQoWgwX0c3gokUwcHmbfT988bVpkMF45nqkD+crlfucX/2MCqb8iCrM8emuVn8Qel3B3EIIhMknnQCIQFPgOl89PA0f1qVJ68gVkZ/qt8=
X-Gm-Message-State: AOJu0YzV515j5qljYvUv+J3QLQ9h6MysPURUfcrKdUyGdPX27B4Po3c0
	V3UriPLeT7FBKLaFdRwS3RcxabdyPnCpDMBx/OaD2UZSPTPAy3awFejg5wHeM5sBM/vdSg5vu9J
	m6IkNnBEzcRsR3tw/uulmrxQY0811KFEMB58=
X-Google-Smtp-Source: AGHT+IG4eXRgpJ8C7f3o6MsPUI8tsMGcL7PTbaVxi0noEQCHuFzMJNY7rIVvw6l6mGjycuMGAC/vt8a3Qe25+etqouA=
X-Received: by 2002:a17:903:2349:b0:1f7:12c9:9426 with SMTP id
 d9443c01a7336-1f712c9974fmr58237965ad.3.1718106392986; Tue, 11 Jun 2024
 04:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Jun 2024 08:46:21 -0300
Message-ID: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
Subject: iwlwifi: Regression after migrating to 6.6.32
To: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	johannes.berg@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

After upgrading from kernel 5.10.y to 6.6.32 on an i.MX8MM IoT Gateway board,
I started seeing the following storm of iwlwifi warnings (these warnings
keep coming in a loop):

[    6.995391] ------------[ cut here ]------------
[    7.373564] WARNING: CPU: 3 PID: 136 at
/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:269
iwl_pcie_rxmq_restock+0x158/0x178 [iwlwifi]
[    7.385677] Modules linked in: iwlmvm(+) mac80211 libarc4
openvswitch nsh nf_conncount nf_nat iwlwifi edt_ft5x06 cfg80211 rfkill
fuse nfnetlink ipv6
[    7.399053] CPU: 3 PID: 136 Comm: irq/209-iwlwifi Tainted: G
W          6.6.32-stable-standard-00001-ga9f741529938 #1
[    7.410285] Hardware name: CompuLab i.MX8MM IoT Gateway (DT)
[    7.415951] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.422921] pc : iwl_pcie_rxmq_restock+0x158/0x178 [iwlwifi]
[    7.428648] lr : iwl_pcie_rxmq_restock+0x40/0x178 [iwlwifi]
[    7.434285] sp : ffff800081f6bd30
[    7.437605] x29: ffff800081f6bd30 x28: 0000000000000000 x27: 0000000000000000
[    7.444761] x26: 0000000000000000 x25: ffff0000c0c0ae70 x24: ffffffffffffe844
[    7.451913] x23: ffff0000c0c0b62c x22: 0000000000000001 x21: ffff0000c0c08080
[    7.459066] x20: ffff0000c0c0c078 x19: ffff0000c0c0c000 x18: 0000000000000000
[    7.466220] x17: 000000040044ffff x16: 00500072b5503510 x15: ffff0000ff7a22c0
[    7.473374] x14: 0000000000000000 x13: 000001308d5fa082 x12: 00000000000001da
[    7.480525] x11: 0000000000000000 x10: 0000000000000a30 x9 : ffff800081f6bd10
[    7.487677] x8 : ffff0000c02b4590 x7 : dead000000000122 x6 : dead000000000100
[    7.494829] x5 : ffff0000c0c09e70 x4 : ffff0000c4ed4290 x3 : ffff0000c4ed42a8
[    7.501981] x2 : 00000000fb645800 x1 : ffff0000c4ed42b8 x0 : 0000000000000fff
[    7.509134] Call trace:
[    7.511585]  iwl_pcie_rxmq_restock+0x158/0x178 [iwlwifi]
[    7.516965]  iwl_pcie_irq_msix_handler+0x38c/0x444 [iwlwifi]
[    7.522690]  irq_thread_fn+0x2c/0xa8
[    7.526281]  irq_thread+0x160/0x248
[    7.529782]  kthread+0x110/0x114
[    7.533021]  ret_from_fork+0x10/0x20
[    7.536607] ---[ end trace 0000000000000000 ]---
[    7.541357] ------------[ cut here ]------------

Does anyone have any suggestions on how to fix this for 6.6.y?

Thanks,

Fabio Estevam

