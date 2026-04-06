Return-Path: <linux-wireless+bounces-34384-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCVPE50w1GmUsAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34384-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 00:15:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F73A7CA7
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E81303D713
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAB39D6C3;
	Mon,  6 Apr 2026 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM9sd4Nb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0F39E17B
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513711; cv=none; b=Pqj5BICKcU10JSYdu+D/WtqJVzZdA1jmEl/8V47zG7cb9kC0uCv/yobBFFE/ZcBnyM1TIUCA40do7ln7Nx4Fgm/tTPVUf1QONysd7Mmf/D/M9+wmUIJy3lvRpeR5TYuppNOaVOABaDRbzpJt41YLN6KuYFHyWlVxrIepYAPtMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513711; c=relaxed/simple;
	bh=UbhrJgjvc7XztvQRMkTAhTcfkSV6zt6Xa+0zVGdUtYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pA15Qm1fADA9ViB8v1MxqpJCF/U0jetd4RrERC9IuzuMlzIET670EeU9j42O+X6fSgMu/bA1hTbW6rTlBJOC7REFgZs3MYpDESU9YvomOuAnjVIs51lA08GCco363uPwlSgB6jCRQNS4WhVMND4RbgPeHn3PtPr0I5Rg14LXfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM9sd4Nb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so27724565e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775513708; x=1776118508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL6Otb7fYv9uJRXVmeEi/4cfCYC6ndzuwvxSK1wlzXQ=;
        b=mM9sd4Nbej4sKhjvU5zueXnyP0JfXiSnenb99wwzSO4jd54olJLwIbzd7ZsY9TlBQx
         D7vFysSnVUtpUVtKyGIZihi3ctE+UnlBhcfMw0MaQVtrTm4kTjSg6ydJFhdQOzPlkbdG
         puwdPVMPo0KDixgWT/ILx0InaGDQHXzuzhtBhQ6cFK2C3PASfY6gWZgn1pw21AQH/Y+A
         6Z6/WW+wLiCs4pN5h8HE2glQxgNhrfW1IIoxV7oFg0UCoKFt9gqpL19yozQMGImATuI5
         bwJ4doVs0J4NW6mNKzkKj9HCZZON0tp1ZIz6F/n2IQIy3lbXBslUaJddSkecfh+rmx0T
         u00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775513708; x=1776118508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CL6Otb7fYv9uJRXVmeEi/4cfCYC6ndzuwvxSK1wlzXQ=;
        b=nP1ZNzRp0BpiaNtVmCH5dVX79ezGz0w30f7RcTOISkpFpafnDD35YIWLSKI5hK9YRg
         e6Hy1OtS4Ya/e4nmJiTJZEYdihkHncxXqFNeFkiqEK7cV5QkzQnFhGOjfiKAXdumSvMU
         wQt7ciBw5ZSk6TJueSWinWAtF2StsL9MQSz0jtgmC/vLoBsnL3f+9w0kfoItqQqVs1Mb
         6WxGbAhtkc3jZSfTgBzktb+ItL2u4tYrkxyDOdMomvB/um8ZqcHaEwkYjwO4MGamllwj
         gycyPTe1SYzjFLUQYMIuvD4ab6yTOKzBYHG6tUhgDC51qnhkgzN2sBbceutR8z/GORiD
         a7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlXaH5UYbZmZ90MDIRXEQB5RocKpl+7tMJPorVFzRZu6zURh8ieJJd4JxNomscvYGlaVPHf0urhybub+x0EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIdCtEj8xL7rKmHXDENcM0OjAjXZh8kNYcCj4e0+zKprGPpAm
	kzRygHg80fMrCiKVLdAjmrkz4BRVTVuwOlNguDIYCf9Bl//cenCPKlmM
X-Gm-Gg: AeBDietaDz3JIbGiQ6crSoKvUaHkyI1qcXC4A4s6dXdbu1RFYfRSU251eOzsv9ImSHs
	0sCKTXrmflG1E/buIiyxMlpgCIQuNIRFTRisKc+JSqlnjbBKzs9dsoMEbZ5k05p3Yey9wEiy7Hw
	4E2uKcrPZ6KQ4meCZN8PJpBy1kuCEVsOYCjMZe+tISqDMkFKF+c3tJ2ZeycHHRjr/de1ZNFIgPE
	u4OuvjqBv/BEZy5IyHNK57BY6gy7CHO/AnSNLCIdG+snuKbgHZAZ8CYjUfyoJTZgzoa3B35nuFi
	aHeW/qIEzlJJ3MH13hZxevEtxJ/VEmoWSfr2Mxte9hhXmZgSx24akFOEceO3HQ+hQ4+Ey+FoC1x
	kiIu+LhC6paZZIfuoEcBR5QnVI9hwSWLU1Nuu2MM9SIEipsVb73+GC5m7Ax+t2KPGC+4iInP6Z8
	mu6YLeBBf2dL2C/a55+tKpT2a0lC7ehZgCiDwjx6Rjjy+huyDrHv9LWzurggs5h9jEUth3p9yGf
	Fkwo1sT+1kl4EgOhk/uyLrS/BeOkpvZ
X-Received: by 2002:a05:600c:3b1e:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488996cd897mr192670285e9.4.1775513707651;
        Mon, 06 Apr 2026 15:15:07 -0700 (PDT)
Received: from dev.fritz.box (p200300de87496f006e2b59fffe4271f6.dip0.t-ipconnect.de. [2003:de:8749:6f00:6e2b:59ff:fe42:71f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a9242d63sm174212345e9.13.2026.04.06.15.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:15:06 -0700 (PDT)
From: Malte Schababerle <m.schababerle@gmail.com>
To: baochen.qiang@oss.qualcomm.com
Cc: ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Malte Schababerle <m.schababerle@gmail.com>
Subject: Re: [PATCH] ath10k: skip quiet mode for WCN3990 to prevent firmware crash
Date: Mon,  6 Apr 2026 22:14:05 +0000
Message-Id: <20260406221405.201848-1-m.schababerle@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <323b5222-a105-4701-8342-9131660fe803@oss.qualcomm.com>
References: <323b5222-a105-4701-8342-9131660fe803@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34384-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschababerle@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A66F73A7CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/2026, Baochen Qiang wrote:
> Malte, the firmware team needs firmware dump to understand this issue,
> would you be able to help collect it?

Sure. Attaching the full dmesg from a reproducible test run (kernel
without the patch, upstream 6.17, postmarketOS on OnePlus 7T / SM8150).

Firmware: WLAN.HL.3.2.0.c2-00006

The crash triggers deterministically on every boot. Key lines:

  [25.122098] PDM: service 'wlan_process' crash:
               'EX:wlan_process:0x1:WLAN RT:0x2076:PC=0xb0008e20'
  [25.283364] ath10k_snoc 18800000.wifi: firmware crashed!

Full crash sequence repeats across subsequent recovery attempts at the
same PC=0xb0008e20 (see attached dmesg.txt).

Note: I'm running an upstream kernel (6.17) on postmarketOS.
CONFIG_QCOM_RAMDUMP and WCSS coredump tooling are not available here.
If the firmware team needs a full Hexagon register dump, please advise
how to collect it in this environment.

Tested-by: Malte Schababerle <m.schababerle@gmail.com>
  on OnePlus 7T (SM8150/WCN3990), kernel 6.17, FW WLAN.HL.3.2.0.c2-00006

