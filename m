Return-Path: <linux-wireless+bounces-33976-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IJsDPEwxWkP8AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33976-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 14:13:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC15E335C1D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 14:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC093024966
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF742BEFF6;
	Thu, 26 Mar 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dX9TUo+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA562773EE
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530489; cv=none; b=g4FbRZdhnz5EDjPAcpQYbKucaioDPYdAWXQ9Pj9O/sSjFBaD93ZrvONZcNebh3ZDp0jNJjYdHtm8DfOT1f/rlTI9iEc3mXRn9NZwgxXt5PcKz5UZIgsIHuLsYGzOI87yJSgM3nldjVOnNMCW58s34qq5o76gJC21Sv8nQ77EqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530489; c=relaxed/simple;
	bh=Ar6pFA6cG6LoKz6FgL+C3IYDb9ssZhhPm3Mk+YrDRNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dmc5/D/oATDFDJGkQRMfOPK73JQA1LLXddCptZRG6PX3HMkhjsZEtvHP0WW/hwwUK9sLFqTZdYupa/1EBMu7CzzXLYldiK+HQuWLF3ldNiAquMlJXohv78K/AO3p5o50Wrm7uiFb2xMEdaK+2JfUAxOZ+B1LN0FjYr/1vjFK6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dX9TUo+T; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486ff201041so8573385e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774530485; x=1775135285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vL9P/jR/0HIsuH+Bu1d67p3utwY7viGhc92J5P9lo50=;
        b=dX9TUo+TXSkf9e1PaMiB3O2jnSvaGs5/adP1rZZ1G0tGtCuxRz1h6XVF0QdnYhKWhg
         xqjnDjJm8SQj98BzCE5SlTpqgAojH/s7Dcmf8crGgMAzsSc9fDhxEi95ObiLPk8L7jAE
         a2rYc3OgV1Qkkeinkf++cwLAFRgqGDMkakLoMDw7j8foqNErCqE/F/qT1nxDOZ4jVsQ8
         PkfmdADO1ukuG0FCscaHLLqdiL3n+/SxreOPD2yRiZV3f31VqnWRiEMqVtXNTIBnkkIy
         4/O9JNLRtNx95N3B4Itv27uNnoMfelRYmwS+vYF5fjRYrxk45WruOrUgE9DkCbz7PKcO
         /beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530485; x=1775135285;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vL9P/jR/0HIsuH+Bu1d67p3utwY7viGhc92J5P9lo50=;
        b=jIVKeCI3kHDzbsJPYAIxQim+vjR/lN8ijnZ6GzL6n0ivVBgbclrtGdFfVPFTEupgPs
         Z15JlGZ8TGLa0ghICuDiWvidQE5n4GvgS9GThFpS1Vx/4km0jyoh65WH4wMblgn9Gocp
         iZEU0OIQBAP/EtcPLHU4y/T6vMZkeX11n2GEtCkmzlRmqczyjZwkz/xyLkoadIjHjHwt
         Dd4fNhPBOjS8HWBQb2/tfwo91zzlfFJNyCm9/wfFkv6Z5oV+zHvR/sw9qZyFY8y72MgN
         ExVocLtn8VWfQd2+mKcoI7eHohKBwA08OL8yacMpvdYfQNdBErvPHUYX823NHqwqkiyz
         RG4w==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ir9kHI7hLRoJayQcy3NiFTWPEYkeCkNhWslySTo1EwvofQsArkW+ETr9SsVYHYWBd57xczrs6z+S5c+GtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XK4u1qWqKmx6qP+R3+xVg+bLINoogRob210FwWlIkKYX1yIj
	stMW66gvCSddr0csn5zzmKlei7beFHSk8Y3n9f/enePGGfH7QbJnq1Cb9DwZ2qOmEGk=
X-Gm-Gg: ATEYQzxRRwOOe3dJ/vUDZNLCS7+jlHgD1CO1KTEHIaQOsMwWKkIXCOVKmFwXHgoNWNb
	z+gU8paCn+xfgMuLz2vPDRxUR2SGIpyh8sBI2BziE39V40SjpXYX2JxYcSXRTSwfVCIClN7fZsi
	0wFYnQZBkdAytCjKSiRWllMvKpYqkeb5W/1OdbVIQLk1XxmD0YymBBs6SZh67ZzblAHXEZ7XSYd
	vQcRZ6Qkz1qrC9tRlAMWx0FpMzkvzXT3XZKLNZWCI2bn7cLHg1zCFAgAsjubJ5j0MPLDx9QpET4
	8GsIGu1zgwmIE7XANlAGkObZWHTwVVF9tYRMWgoa2eKFzICR4ZUL2cHQ7d5WRsr69SzbVJ1Aj0S
	Pfng5Eqej/DhYy2xLWce1QnVf/EQ4Atx/yHlgz7bzZddJl3n8eVFjrIIairT47ZoQuGmE0fZqF+
	T0nwiVLvsalN9yLDlYWDa8k61rQiyGkJYCpp/lsY2aOed8
X-Received: by 2002:a05:600c:4b89:b0:487:219e:42d with SMTP id 5b1f17b1804b1-487219e05a4mr17195675e9.11.1774530484483;
        Thu, 26 Mar 2026 06:08:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2c8sm7580472f8f.20.2026.03.26.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:08:04 -0700 (PDT)
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
Message-Id: <177453048347.439230.1647215482099213609.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 14:08:03 +0100
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33976-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com,aliel.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC15E335C1D
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

[1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and SDIO pinctrl nodes
      https://git.kernel.org/amlogic/c/fb69fa2cabc68da247bcc0bc99a14dc857b16842
[4/9] arm64: dts: amlogic: t7: Add PWM pinctrl nodes
      https://git.kernel.org/amlogic/c/b1e49f6c1ac15b2c947bdb1d22a82b823de22d27
[6/9] arm64: dts: amlogic: t7: khadas-vim4: Add power regulators
      https://git.kernel.org/amlogic/c/60eff75ac67bbf5445bdbd2842b0109ac591441c

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


