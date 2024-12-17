Return-Path: <linux-wireless+bounces-16501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70479F5744
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245291891E15
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C215A843;
	Tue, 17 Dec 2024 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFe5kZa2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00281148850
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465301; cv=none; b=FKN1+6AFTFVDM7V4O+yFWUFMZGHIdhuKuormCgOrRh+ZIhklIl0HuV+OcRTsh/fHhZ2f2g2itY4Nn++7xwj5Z2C3UiBb3ccUVzTU8KY/G5GrXHIvOH0d/5eA9az3IEtrws5hk90CKBeMOQquuOIUyDjWJ695Im8ocftCRkhZevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465301; c=relaxed/simple;
	bh=P4Wh7WDxvuaJPE+NzdLH/LTdc0U/KBQgaAVuya/DXBs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pVadb8u/PsvYeorlqruMkCKLjquxFjTF6e2wZkQyzzIi22jVvsdOdqQ6RvaK31Oy5WIOEQJ8N7Ptd7a6xwY3PhvPfZceUxTxTo0Zp6q094oLotkOkGT07CraJ9t5I6hG6vTXhIU3NKqaXwMeUp7IXSLan1ghE5UtDl+go5PXXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFe5kZa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBE0C4CED3;
	Tue, 17 Dec 2024 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734465300;
	bh=P4Wh7WDxvuaJPE+NzdLH/LTdc0U/KBQgaAVuya/DXBs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lFe5kZa2KED4DCcGIYJPdNTGa3JlG7adtZ5YtHxg8b8Qq0Or/u0IxjcWiiRhNvocl
	 5C2VcFS+wft6+M8Xq5czNZT4X8jn47rhRXNlJvaBdvopOfWd5BokL6msYTEfRwI3ao
	 uMDw+LsqaFbOIHK6CoVulgVnMzV9FKP7yDVKfot7cMHWT7NDJ34sE0i13Pz3hzzPNw
	 kKQMH1l81Bms+80dKaZJ2WWnsak3Ozk7dpWYwyw3fcFOidIUGIe9xxUOb1q+0iGc4b
	 6uZnEW8lqyJanP0ax2k4Y7+6cSxnuw3P1Yn6Bur/Jyx9+t64wa3Xa7W5HBiIi4lV0g
	 uqd7zD6CbittQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 7/8] wifi: ath12k: Change the Tx monitor SRNG ring ID
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-8-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:54:58 +0200
In-Reply-To: <20241217084511.2981515-8-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:10 +0530")
Message-ID: <87ikrijd9p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> The Tx monitor SRNG ring ID does not align with the ath12k 802.11be
> hardware architecture. Currently, there is no issue since the Tx monitor
> is not enabled. However, in the future, the Tx monitor will be enabled.
> Therefore, change the HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0 SRNG ID and
> assign the correct start ring ID for the ring type HAL_TX_MONITOR_BUF.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

