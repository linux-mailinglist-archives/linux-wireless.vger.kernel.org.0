Return-Path: <linux-wireless+bounces-940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F18179DD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 19:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E071F22E9F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1C1DDF8;
	Mon, 18 Dec 2023 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnydp11d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7381DDC9
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 18:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307CAC433C8;
	Mon, 18 Dec 2023 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702924883;
	bh=Q0rKyM6bQtFZ/G0js32MCf68XYvA8jE5KFmtUJe/xas=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Jnydp11dtOs2iKoLVn8aoV0VNlCiaZNrW11WVLnQ/Kcuvr8jSWU3zrWqxtaCToW5h
	 lViSeK31qjxc7UjEwrRAl/hFPJqJpocLMPhwOvKuUCPwdf9EaDhSpYRkweeDudC2Hv
	 pJAo4n0FkiRWC42427Kgup+aQ16xPOV0sbsk8mcffeijqMy2BN628/e+ajwL+NmGMG
	 PyPQISQqFTORLc+grfr/6KGbMW5fMcDXVnoxHmi+rkwv/36TR7TKo9A/+rncQ8wUpQ
	 4gRsRuH/hbhg+E/R59VoiM37HOuLny5siJAcB8ks7iPypmkikcfQzfcEQY6OZ5NbAy
	 1auckMDRTgKNA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: fix NULL pointer dereference in
 ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231208043433.271449-1-hdthky0@gmail.com>
References: <20231208043433.271449-1-hdthky0@gmail.com>
To: Xingyuan Mo <hdthky0@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS
 DRIVER),
 linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
 Xingyuan Mo <hdthky0@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170292488043.424292.16691603667971169981.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 18:41:22 +0000 (UTC)

Xingyuan Mo <hdthky0@gmail.com> wrote:

> We should check whether the WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT tlv is
> present before accessing it, otherwise a null pointer deference error will
> occur.
> 
> Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
> Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ad25ee36f001 wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231208043433.271449-1-hdthky0@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


