Return-Path: <linux-wireless+bounces-7592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7E8C42E6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10702280DED
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7415380F;
	Mon, 13 May 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD/teDXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06A1E497;
	Mon, 13 May 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609555; cv=none; b=ZP6jyDRCXw9IX3a3mDXLGkEHP9gw16q85LHjVKynZ1NOZKBg8RXcDoTNOqvXs8eDbKKt9DsK3f+wbDRHuHAFE+NpNcZ6tww4q5SWnb7vuS5r2PJB+MbL2dmy5y7sUQbh/gxOfvhN1RAmvF+baToBjW0w+tvDPS23gmSh34gFQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609555; c=relaxed/simple;
	bh=cfVkEuuf1nm+2kNAircxmCV5OVM0lYdc8fwZJMocSJw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Cfus86E/4sRGVPB8EUKWJDjM1ZrWS9TAHPbLKfWbZIikazUKJFJqEiLuneKwtegO+4B/CjtYQvl2D5FRlaOcRcabcz5HPYQtTYGlWayRlpHazZL39MtuMS2+MZkBkRBaNhStIPdX2y36avSicXeLswP83HXH+eR1eVUXJvLJneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD/teDXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F4C32782;
	Mon, 13 May 2024 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609554;
	bh=cfVkEuuf1nm+2kNAircxmCV5OVM0lYdc8fwZJMocSJw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fD/teDXbT0HGcM7y9LjRgxQ5GQ2qDLPuOfKqqrGThMjiDPVKzLgiP3X0wbLDSQdxs
	 9oM1dd8FDmvO7fVpOHIzYtXVBkusb2DSkBiSWxBSXvVznbHXkYCgGJtFUJxCGq54tq
	 ctEX3zIqiUKQuSyLdqnOWq+c5mD88YODZ2x/EG4YDXMLCFgtvfKA100coopPNjo8Rm
	 EdMufQe5hHDNZvBUBX22S1RxJcuF3knWWLOFxVM6fuhiv18AozQG03reW+O4da8Yjm
	 6RGecGnBmPu3hmeiZLViIhfdgjZ9c3gsQkle9RGjPU5bS4nTaio5VvFwpPxyuFdiCA
	 hUO8r4FSMdJ8g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: initialize 'ret' in
 ath12k_qmi_load_file_target_mem()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240504-qmi_load_file_target_mem-v1-1-069fc44c45eb@quicinc.com>
References: <20240504-qmi_load_file_target_mem-v1-1-069fc44c45eb@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <ath11k@lists.infradead.org>, Jeff Johnson
	<quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171560955084.1690511.16227061715514007364.kvalo@kernel.org>
Date: Mon, 13 May 2024 14:12:32 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> smatch flagged the following issue:
> 
> drivers/net/wireless/ath/ath12k/qmi.c:2619 ath12k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.
> 
> The reality is that 'ret' is initialized in every path through
> ath12k_qmi_load_file_target_mem() except one, the case where the input
> 'len' is 0, and hence the "while (remaining)" loop is never entered.
> But to make sure this case is also handled, add an initializer to the
> declaration of 'ret'.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

bb0b0a6b96e6 wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
199f149e97dc wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240504-qmi_load_file_target_mem-v1-1-069fc44c45eb@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


