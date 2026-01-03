Return-Path: <linux-wireless+bounces-30313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4CCF03BB
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46253031CE3
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9826A1C4;
	Sat,  3 Jan 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ACO9Ks"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF81B4F2C;
	Sat,  3 Jan 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767462713; cv=none; b=WWcV+TM/AVx+tjJf6jnJlH14mw5D+n9VXPXjFYgjyrb78NpQzFcXbpU5MzMN4MJHaz7nCj7pcH64UxP7yUQDdg5VYbc18h06y10b3ZiBahp58kwfLBgFiTef2C6UhlTADcvv7c9GW3FHWpvh5eGqjbXxNjQwTZUGC3/DGFu7vuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767462713; c=relaxed/simple;
	bh=/5CTIoZ+dEyqw60A6EXzdsbPpn/68FO19Wzg2NxH9QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPWSyC4qXmeZLvhiz/1SXAMbwolBvzCF6d0zpXTmKKzbU2KpPsdbHErAoX64BaxK54jmem6/nDeaE+E9VwGQ/nd1rg7IYcL2yhqXkzb5YzFgmSi3FiujMDnjcxl9BYnqXLLNfy9pJAYDSA3MfIcXOaOMvD4OWa5tLmD5xIQf/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/ACO9Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A750C19422;
	Sat,  3 Jan 2026 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767462712;
	bh=/5CTIoZ+dEyqw60A6EXzdsbPpn/68FO19Wzg2NxH9QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/ACO9KsbmBhvRBFKM2gAplnSXeVw77IpN5C4+0c4/rm1kIrneRsxJU7sXqm2tdWE
	 jKL1yFKJgEBviUA0jDQmyQXS/k8A3wHvzStWW2TOSIGyY/i66U0dDVwmh83cULHdi8
	 qY7cePy6Nq32UZoDFK4KoudShCxA1VEIG5sLKImkff26nSN+w6G9iL16QTain5HkBo
	 rSjNumFRAN5FKdVmS4BiTMNxx/0b4dkG15G3Yx5/V5wY4LPhngsBSRWTJondAKBgaE
	 k3GYVOwBcxplRiBCXUgRwSC14J9cX6ky/TixfexnZGJ4bNT93ISmHKV6asZcNr7TG5
	 yECp6jGTK63wQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ath12k@lists.infradead.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Dale Whinham <daleyo@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/4] Microsoft Surface Pro 11 support
Date: Sat,  3 Jan 2026 11:51:43 -0600
Message-ID: <176746270364.2648843.15525156382034430633.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
References: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Dec 2025 16:26:28 +0100, Jérôme de Bretagne wrote:
> This series brings support for the Qualcomm-based Microsoft Surface
> Pro 11 covering both the OLED and LCD variants.
> 
> 

Applied, thanks!

[2/4] firmware: qcom: scm: allow QSEECOM on Surface Pro 11
      commit: 380f8a4c734b029100dea5bc9e2f8982f72da6b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

