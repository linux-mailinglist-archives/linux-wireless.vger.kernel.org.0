Return-Path: <linux-wireless+bounces-6371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35248A64D8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 09:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E452F1C21E54
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F013B78B;
	Tue, 16 Apr 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwQANtT0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7939863
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251834; cv=none; b=SppRXaeTZhDICIGV4MNkTJJaNu19ZajZag2YDLhJm0wMgL/sRo7YGOdjn/2RN4BDF/g9daWx6hZ/0CaKwd9NgBOl7T3ggiesbK8nUOk5niJ8RXpUbbiOoHM7SvhQMiCct3T+L8TD5eEZ3JTZn5+j8rtQZJexOoXnP+gBdieUGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251834; c=relaxed/simple;
	bh=pgF5tfPygm4FX7vHgvq0eWcS9uo06XOqLTA2zpWv4Q0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IA0s+cZZIJPwyScGgx8LkZuy8MEto/exeLVzskr4xr9rHak/+ebmoU6VQU5u1OKzEmT0bciNw7IYL5LrGAYpcwb5JPeIYaD4CHHstO3FFIMr622ib9GV8fkSYdmsOweRMvheAItuwJmd7oiU03947Y1iXyGu12hHZkdG7AoEEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwQANtT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5ECC113CE;
	Tue, 16 Apr 2024 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713251834;
	bh=pgF5tfPygm4FX7vHgvq0eWcS9uo06XOqLTA2zpWv4Q0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UwQANtT0V+DX5EMQnuTIkw1Zu69yuO8MASqyjS2TKn/V86BKsiwHQP4MdfeV359+y
	 oGfZMcuvLED8JDBjxfvSykYA9OjgTkqo/MKsSxEQ4MqYfLf4e7EtSThzbfs47UPakF
	 6+1fhtOktxyQfwTt5FaJxmUcQ2vzYifKTyBLpzTnks2NgwVQUUyAC2XSFoz2tRM73q
	 /Q51isVkfJp8fC73dzAuc8Zpv/5IIZWUEodkpjaeTBhUPhsfIemGXa9gkHH4Fhiomv
	 rgexl1W7ubyZMRo+A7J5Ye36oS+h8GeWkcmtOLqCwMasDIr0kW5m5H31jiIoPU69rQ
	 l8ju4flwzco+w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath12k: fix mac id extraction when MSDU
 spillover in
 rx error path
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240404141538.1277258-1-quic_nithp@quicinc.com>
References: <20240404141538.1277258-1-quic_nithp@quicinc.com>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>, Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171325183100.4097708.11184145689430531302.kvalo@kernel.org>
Date: Tue, 16 Apr 2024 07:17:12 +0000 (UTC)

Nithyanantham Paramasivam <quic_nithp@quicinc.com> wrote:

> Currently, in the rx error data path, mac id is extracted from the
> last 64bits of MSDU end description tag for each entry received in
> the WBM error ring. Then, each entry will be updated into the MSDU
> list for further processing. The extracted mac id is valid when a
> single MSDU is not fragmented and received in the WBM error ring.
> 
> In scenarios where the size of a single MSDU received exceeds the
> descriptor buffer size, resulting in fragmented or spillover MSDU
> entries into the WBM error ring. In this case, the extracted mac id
> from each spillover entry is invalid except the last spillover entry
> of the MSDU. This invalid mac id leads to packet rejection.
> 
> To address this issue, check if the MSDU continuation flag is set,
> then extract the valid mac id from the last spillover entry.
> Propagate the valid mac id to all the spillover entries of the single
> MSDU in the temporary MSDU list(scatter_msdu_list). Then, update this
> into the MSDU list (msdu_list) for further processing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f351772c544b wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240404141538.1277258-1-quic_nithp@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


