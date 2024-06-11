Return-Path: <linux-wireless+bounces-8807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797F9043C8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7941C20299
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27485171D8;
	Tue, 11 Jun 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzO3vHSu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341214A96
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130998; cv=none; b=C4kX7Rf6QZP2GxArczMaGrtzfYQ2XT9mhWUgJotBR4xGkBy6FnIGO7XD9pgkovW2N+kjgWjAs9Z9UnedldaIignXoUW/B6Y9AxKH1gdCcpzac6ZpQS9IaMx3BDlNjAwfTy+xnhkgQjosgNdfbId5VzTubZUbXw6Ku33Zrd61Z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130998; c=relaxed/simple;
	bh=RCKxxHD3IKIUcqSpL8ezjJy6dgyDehoOCjJuNNVeRZA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RQbiZv99APaqXUCBBNHaVdv59Vi+U2o+6JjHCJkT9XFxdMSNrEsGLmvtQ7R6yMZ1viu8+MTBevL+JRCejN9tzpQV84QAi1UOCI8sCzuyZQWGnONGKN5My0ln/Yq4ykXP/t9vNPb9Qi0DtEQIgS78wX/FlnrggFQObwv+U33bAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzO3vHSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926A4C2BD10;
	Tue, 11 Jun 2024 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130997;
	bh=RCKxxHD3IKIUcqSpL8ezjJy6dgyDehoOCjJuNNVeRZA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PzO3vHSuynXbKjS4nGxQHGJgeRL+FWGRAKMUbpJ9fvw31wWJSmLLr6tx5kj+jIl+r
	 auN4LQObvcL145JY598vE/dGycou8m5cFz1+oUhfMmZXIPuFYre4Bomiu8p+T8P+Ez
	 0yLyH8LSI7Cp9WA788L7l+DUXACGtxNOSw7NYkRwxSzSBDnoQlFwyI4pj/WFaM95PA
	 BxXIk1iC/ohLUuE+SmsfpNSl9FzIUeS2n9NcQ/jWiQAm8PN8ea2fUyzqyIqmqdGDE1
	 58DfJIFX3FQ/wM1i0IG7DHg+enuEaQXBMKgwqZFvjIbycTgxNdZpRNLhKO2bat+X3t
	 slZKVOffEwhtw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix ACPI warning when resume
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240531024000.9291-1-quic_bqiang@quicinc.com>
References: <20240531024000.9291-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813099453.3564613.760110557004474171.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:36:36 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently ACPI notification handler is installed when driver loads and only
> gets removed when driver unloads. During resume after firmware is reloaded,
> ath12k tries to install it by default. Since it is installed already, ACPI
> subsystem rejects it and returns an error:
> 
> [   83.094206] ath12k_pci 0000:03:00.0: failed to install DSM notify callback: 7
> 
> Fix it by removing that handler when going to suspend. This also avoid any
> possible ACPI call to firmware before firmware is reloaded/reinitialized.
> 
> Note ab->acpi also needs to be cleared in ath12k_acpi_stop() such that we
> are in a clean state when ACPI structures are reinitialized in
> ath12k_acpi_start().
> 
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 576771c9fa21 ("wifi: ath12k: ACPI TAS support")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8b2a12749b08 wifi: ath12k: fix ACPI warning when resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240531024000.9291-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


