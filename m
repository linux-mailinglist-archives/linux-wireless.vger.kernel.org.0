Return-Path: <linux-wireless+bounces-34521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMo0MK0b1mluBAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 11:11:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8793B9A85
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2DB1303DF65
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E93B0ADA;
	Wed,  8 Apr 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1qajidf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1653AE717
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639450; cv=none; b=ipS5Z76wk65/DgDHp9KusDUi0MxcEELX4tgYc3T/XZ2zOsEUWlFLWf9BVqkbifgbPygVEVnbFGaxqU50YwqIpFcWN4Ub6kbplz20HDyYNu4qR9eDwQL3IPL9+gbwTUmAZ0rkLupbfMson3ck72u7euREgR2m33l7P2DCiQD4yVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639450; c=relaxed/simple;
	bh=UKcN9ahvuxPCNeD+PTO7LIE/r0odGE954SbEzEwIjL0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lTqWxvFDPwUblJCnWSsRbzzLehl0GaiJwVrVyKu1rmwhmpM9b0KtxFFzqLoeXVb18B+CJQytkO2Xfbo5LIoQWWHpjOQrx8vDRT1XmQSpSR3gS1LqdKx5OBAD9yo/qOjmg8ggqAGmQJON72ukOIkYznGB5Me8h/ros6YmI8DYASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X1qajidf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfb723793so3863676f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775639447; x=1776244247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO8uch6J2EQbXvmvGcDK9cYBs1vvLxeqc/7RnVBrTR4=;
        b=X1qajidfSOYL/k/AMUZSaEuNQyujfFjCd2Ks+oc8ser4RgC4UK+rnXkrv8UWWHWZY2
         NUlRn0SJq6Kwa8vIN+u9CQ82CZ6xj3IlQD7lzrUhwwTXT07Zv3WZ4x3mbI9gYN/TWrya
         IuoxRJCekyVT4/ZT4tIogn85ayQRsMD9ewKq4yXfuYf4WG1VVSKvxiLLF3kgyhIH/DSF
         D3CpVcr6iI4khfL1yCQTkp6GpcWW3DZ2OsKmHY0b2/BaL71Wj7aD6ADf9oVdGNROfu3u
         bHJwRTaOptBY87OfeKNXAg6Kra66sf1jTUaaffHRVXTR2k3PeEU3NoOP0+GIslVavTDr
         95Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775639447; x=1776244247;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KO8uch6J2EQbXvmvGcDK9cYBs1vvLxeqc/7RnVBrTR4=;
        b=d62yzNe5yYHK0reGt5K1DskL4Dkzwy8e5QXMIFKwQnjXekhycELwnfAH/6/zPh1bae
         naiJhNhhNF5ObGq7zlc/md55t9zQrOXXbM9qA6U6MEeS9+gELKa6Fl3kSF4A4vc1H94Z
         TkuCQ2icHuN8jfztqoZvUdRzxwpBYfQkJEny5rule9s3w/HxEd7ZQIFR9CRrgKmv0Gmo
         wCqyjgDscz7JwIcQnmzO7vtXGtJTx/U69IMZhFSHFpVx2sks9FpzJajhzyvNkrxsk5M/
         f+ecUFQiRk9ldsDM+HT4yMx1jULVh3JtFOV/neXSpU9x6HfQ0TL1cowAF2X+pcinsCbE
         B9tg==
X-Forwarded-Encrypted: i=1; AJvYcCUwomEJQdaPR1vb1chVMQ8vSXWUH0Mu2X+yaIozqMd4r/4AT1D92Q0TFdnUQEtOJbPhJoOf0RAJA/cMyC8P2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyL58uRUxpeyUk35VomwgFH+eYqgk9D3/UPUkeYazakreCvVrt
	pFcpmGeAuEDI2i6oe00bSrPCRGNDy3421saXgTs7Got0pXE0WlJ/pFbXC0BFHnJgJho=
X-Gm-Gg: AeBDieuywNIyNPm0uFzl6Yk2LEjUaG+NG5aWZbAvXijR2ZyAltfKK3FZ6mFCnrxDu1a
	MvEjzOCXtTQsYaHd2B4SehBifvV+DL7ZG2m1l2QxRa8v/JMz6X10VAUwVrVVtUmQ6JvD8ZekkXC
	b8t31C00ryit3Y0ZRsEy4Z09emBsqIA2JgQ38YNojJ325dZY8+/MI+LKm/67RB2mJ8zn9mUtxoB
	VOqjkh9h22MxKDNUhHsi38H+wLIbcRqoa+/a6vv69J3s6UmJugrBkiiI3biwGO+JwPbPJ9uKPYs
	RmVM2rEdwABjLdw1xpCfrc1HhoZB4DRAKUTIeox/zn/G3hAkFSJ9iVlIaH+J7eKjB5PkjZWT257
	WT2HnRL4DEwxGhOB6R3MWVM11cJP5eThg6xRztzf/kmouvM1a2XuEJkb6SSwH+6GWxUfvFDOWAY
	HCPmby5KJPTgzihNqKOT2IS7dPBi5bifiYOHdykPsSsiOe
X-Received: by 2002:a5d:64e4:0:b0:43b:8fa4:194d with SMTP id ffacd0b85a97d-43d292855famr28409560f8f.6.1775639447019;
        Wed, 08 Apr 2026 02:10:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d289asm55901179f8f.19.2026.04.08.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:10:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Nick Xie <nick@khadas.com>
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
Subject: Re: (subset) [PATCH v5 0/9] arm64: dts: amlogic: Add MMC/SD/SDIO
 support for Khadas VIM4 (Amlogic T7)
Message-Id: <177563944623.3409047.5512295931189701100.b4-ty@linaro.org>
Date: Wed, 08 Apr 2026 11:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34521-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com,aliel.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E8793B9A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, 26 Mar 2026 10:59:11 +0100, Ronald Claveau wrote:
> This patch series depends on Jian's SCMI clock patches yet to merge
> https://lore.kernel.org/all/20260313070022.700437-1-jian.hu@amlogic.com/
> 
> This series adds device tree support for the MMC, SD card and SDIO
> interfaces on the Amlogic T7 SoC and the Khadas VIM4 board.
> 
> The first patches add the necessary building blocks in the T7 SoC
> DTSI: pinctrl nodes for pin muxing, PWM controller nodes, and MMC
> controller nodes. The amlogic,t7-mmc and amlogic,t7-pwm compatible
> strings are introduced with fallbacks to existing drivers, avoiding
> the need for new driver code.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v7.1/arm64-dt)

[3/9] arm64: dts: amlogic: t7: Add MMC controller nodes
      https://git.kernel.org/amlogic/c/759613b88fbf051c8a977a5e5b046b28a18ed5c7
[5/9] arm64: dts: amlogic: t7: Add PWM controller nodes
      https://git.kernel.org/amlogic/c/596e3c1bfa7869cf15079e5c6e586575013b2fc3
[7/9] arm64: dts: amlogic: t7: khadas-vim4: Add SDIO power sequence and WiFi clock
      https://git.kernel.org/amlogic/c/647228c014ddbd336a97e74bde81cbb2f7cbd927
[9/9] arm64: dts: amlogic: t7: khadas-vim4: Add MMC nodes
      https://git.kernel.org/amlogic/c/00cca65deacb29947ef32011827ff88fd59dab55

These changes has been applied on the intermediate git tree [1].

The v7.1/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


