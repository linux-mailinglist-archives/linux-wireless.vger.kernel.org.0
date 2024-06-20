Return-Path: <linux-wireless+bounces-9308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0616910796
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D941F218DE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859DA1AD9F0;
	Thu, 20 Jun 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6lmXn7Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239E1AD9DE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892541; cv=none; b=cThQU4qfzfW7CreuIai5Ic+g1jdI9xnc9U/sNdaVj/zhPDTngua7juCcADoLMXrqzlbuLrSz1UaKOYJslrzPX/xfXKGwryfTjAzekfj+SMBaGdfH6P/sH26Hc0vOApN7a53m4k52ZKexDYU707syq5T3t5dBbIkHD2+l94IZh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892541; c=relaxed/simple;
	bh=9bJfbKRupOXgKTJN/Kgr1szk1mCSg6BrwEvmo45z+iM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ODbOzzBCHEpIF6RDvWiqXV7TxyEsqfFC1DRBqWWz+JTrYhv9kNGPIJXThngOX5Ke3KetkTO0XCjmeb27LU+mPj72/pRD+fij+Nh9COMa78+sZ+Kk4XJEVA6l/5344FXqquII1sAAe7Jwz2hk3M4Nb66VqR1jOvalHTxu4OIdnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6lmXn7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040D5C32786;
	Thu, 20 Jun 2024 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892540;
	bh=9bJfbKRupOXgKTJN/Kgr1szk1mCSg6BrwEvmo45z+iM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=r6lmXn7YyMWbrxV+GjC510QWKGm33Jsaq0O35EZwfQF0A6tKUI5hO+7CMbQ7Hv/4z
	 2jf4+rgglzHIibOsqbVkNt49P0CXJwnwp/erEDHDuIVk2psvKuw6Bkpm7H4raZoSUi
	 zfgnGE0WXP4eKEzfTMc6yFVSxiq478oSlVzxKISTuIqQIgpFwkOWR4bUych5wgCO1t
	 63Wf0q6j8ICz59kFKquAKFYgS57AYv4M2mf4GXlux2+CYmEBEOZ+qs/OSKzN9eAe/5
	 ert9LhvYlJJi/zeZ+dCKS82Zujcflmgn5m43D/0cA6VOfUKYEzZZf4y0lV2B81Ihss
	 RvpJQf46dttKw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3]wifi: ath12k: Add firmware coredump collection support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
References: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171889253841.918573.15918536206746856053.kvalo@kernel.org>
Date: Thu, 20 Jun 2024 14:08:59 +0000 (UTC)

Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com> wrote:

> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This didn't compile for me, I added this to pci.c:

+#include <linux/vmalloc.h>

Also in the pending branch I made some whitespace in struct ath12k_dump_file_data:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=44ae07628b68375f476895f4fc1e89a570790ac0

Any tips how to test this until we have the debugfs interface to crash the firmware?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240325183414.4016663-1-quic_ssreeela@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


