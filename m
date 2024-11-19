Return-Path: <linux-wireless+bounces-15516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D599D2F5C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 21:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F77DB23464
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C651D2B30;
	Tue, 19 Nov 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="aaqr4Sju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9B16A956
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047375; cv=none; b=TFtCfcPEn/rscPdJryPe8qCr/4DDJQ5mAL3JCq2V/owzRqh8FXwlSpmrpPxvTgzyJUPQuVggC2dSXqOS6zp+YVJ9/0iVcAWjsxLTih0rcgUi96lkjGIaAoVEZIgEwMajnaX3gh1M+30p+mnmJzoxQEat6mVHDhwswnqV1ulTnNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047375; c=relaxed/simple;
	bh=3Cbep4/jPphKomPPOlqRGVE/VNikNv4j8Vy/HmySlm4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Kb1oLYKcGak0jqd9NwBD9mAlV+vdDRamTdoGUcefxr+h0mrWOk83JX5InBo9YYQG8nYeDP9JCLbAJMSyrGfF8JD3+rh6MoxyRqPMNrzJVna8rY5VLj5W8DHY41Q+G71Ee5dXZI3yiREGVGosm0+DlXES4r6rtszS6lqaxnsYBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=aaqr4Sju; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso3157416276.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1732047371; x=1732652171; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KgWpOKHATV4YeR+Un0eRHbRg2ztCrtw2oUnFHzweI6Y=;
        b=aaqr4SjuvtynEu83ijOsnOPkJyvu0tfeqO9uBOIbjOfPYw+xq+Nxtz90SJZJfGk7fL
         dglSuWNPARrJhkKtDsIquXOCvJ13GCC4NDOVN6FvxyPcRNsNlkXilhR6aFZCKvwfiWJd
         iHxiCOwAcckT7EzUDxNjHXXsolJVne5pzySNY8cm3nFlw0tbyUqYgZTOphK0LCB4r/CP
         nq0j63mQyRL4yABItMdaEA/U+uju1v0HiAGuEYZksI47uLk/sIXIopB1Jfq+HRjbDV3Y
         vc5qD5rNiWB+lm6YKUWp6sOyOy1Dobj2bmgBrWmbpxIyTEO1885M60sTa8kwAyjPoyCE
         xOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047371; x=1732652171;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgWpOKHATV4YeR+Un0eRHbRg2ztCrtw2oUnFHzweI6Y=;
        b=gE3ijgGmwop7VF400Lw+T/4K/eNUROvqh2RXNFjxpsHC7Ejy8PTJRlFApytE9ANPS0
         TrA0P2PzpgSJEqeXx2m4kR8Koz/SHvkmDnAIBJBjnTY9Own3fd6WiI4Hf3Dm7eZbpJsY
         Y5HLcanPOefvY6w7a/TXQ9NnmcLl3aYa8m/9p0zmEMId9uN8RIrJzUSylmQcOKcqvLBb
         N6mlF+dqfDR3EbZaosA24ZuNiT1HDMyrusRsGIGqPopy8IthGbEvWsBOMhFzOx3uzAJ/
         2EBFCokw0FZqzKcdEGuAjP1bd2ERME9ZOg9RA4X5+Gbl7GHCaoUNbq0oTnbrU/46cFvL
         UUlg==
X-Forwarded-Encrypted: i=1; AJvYcCU2h8iPX7j2RMGwIcXWydP5aT9H121zToHPTrob+mT8wS2pyju0ncM8RPsDJqH5hLzTYwRYwfxUl2krD2XZoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmbYaILjAbD37TtlzzEf72+hTg+bugzX7OxdV22v/zgkB/AVZ
	I4NBLsCalvrQ337VzlHnZzNon3uH2CDLAgVgfkw/ZoyEDmMwfx1QTLdFFnYN6l8WannraVauFSF
	9CvUroATvz0ugMAe71doGdBVBpN6qtlKsV+gdfPrhdLTPDmdHJ0A=
X-Google-Smtp-Source: AGHT+IFIGoS5c0Sgz4TtH9ip/vT18yheZrm4GNWm5kgq7Tyare9DQG7i5JIN9B5P7dc9QHZDKavFxMYENugU59McLDw=
X-Received: by 2002:a05:690c:9a8c:b0:6ee:5cf9:f893 with SMTP id
 00721157ae682-6eebd0e61b4mr3481347b3.2.1732047371675; Tue, 19 Nov 2024
 12:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 19 Nov 2024 12:16:00 -0800
Message-ID: <CAJ+vNU0dCV7-2gFDPTiOjAV-HCeHZ3H1DjGdqYKo+MGadfrSbA@mail.gmail.com>
Subject: ath11k swiotlb buffer is full
To: ath11k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Greetings,

I've got an ath11k card that is failing to init on an IMX8MM system
with 4GB of DRAM:
[    7.551582] ath11k_pci 0000:01:00.0: BAR 0 [mem
0x18000000-0x181fffff 64bit]: assigned
[    7.551713] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    7.552401] ath11k_pci 0000:01:00.0: MSI vectors: 16
[    7.552440] ath11k_pci 0000:01:00.0: qcn9074 hw1.0
[    7.887186] mhi mhi0: Loaded FW: ath11k/QCN9074/hw1.0/amss.bin,
sha256: 5ee1b7b204541b5f99984f21d694ececaec08fbce1b520ffe6fe740b02a4afd7
[    8.435964] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[    8.435991] ath11k_pci 0000:01:00.0: fw_version 0x270206d0
fw_build_timestamp 2022-08-04 12:48 fw_build_id
WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
[    8.441700] ath11k_pci 0000:01:00.0: Loaded FW:
ath11k/QCN9074/hw1.0/board-2.bin, sha256:
dbf0ca14aa1229eccd48f26f1026901b9718b143bd30b51b8ea67c84ba6207f1
[    9.753764] ath11k_pci 0000:01:00.0: Loaded FW:
ath11k/QCN9074/hw1.0/m3.bin, sha256:
b6d957f335073a15a8de809398e1506f0200a08747eaf7189c843cf519ffc1de
[    9.789791] ath11k_pci 0000:01:00.0: swiotlb buffer is full (sz:
1048583 bytes), total 32768 (slots), used 2528 (slots)
[    9.789853] ath11k_pci 0000:01:00.0: failed to set up tcl_comp ring (0) :-12
[    9.790238] ath11k_pci 0000:01:00.0: failed to init DP: -12
root@noble-venice:~# cat /proc/cmdline
console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
root=PARTUUID=5cdde84f-01 rootwait net.ifnames=0 cma=196M

The IMX8MM's DRAM base is at 1GB so anything above 3GB hits the 32bit
address boundary. If I pass in a mem=3096M the device registers just
fine.

I found this to be the case with modern kernels however I found
differing behavior with older kernels:
- 6.6 and 6.1 the device registers with 4GB DRAM but crashes on client connect
- 5.15 devices registers with 4GB DRAM and appears to work just fine

Could anyone explain what is going on here? Obviously there have been
changes at some point to start using swiotlb which I believe was all
about avoiding 32bit DMA limitations but I'm not clear how I should be
configuring this for IMX8MM with 4GB DRAM. Maybe my kernel IOMMU
configuration is incorrect somehow?

I'm also unclear why there was no apparent problem with older kernels
such as 5.15.

Best Regards,

Tim

