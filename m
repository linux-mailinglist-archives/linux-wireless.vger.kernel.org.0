Return-Path: <linux-wireless+bounces-16499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F349F5734
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F126616348D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC909192D69;
	Tue, 17 Dec 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcrN1qvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8D148850
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465215; cv=none; b=n28YKCNDxcit1O+qshGfj3VetufTY26w6lcQ3LUm+Vfr/3GsyXX4C7MgQSRjHYY9wPIs8r9vSbe+BbZ3G0h1DuedvJyJFrZ4RKrqt3r22G24ZdxLrkwVTUmX+v37y4DB0cPvHohFTPiIgud991u+FPnhtCb8aYzXH56CDBLY3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465215; c=relaxed/simple;
	bh=pj+yxV8FV5mtqrf87VgeRSFczeCBpTFhHO6uGHQ6948=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o/WcKWAFxY+XOOBRl4wFyZGYW6OHQKJMJ0J3pN7AQ5+YEhaIKItw7BFYvP/QgZ5V05kZ4SsEiy0LqC5CjKNuZLF8Lk9agH7YPSyc9MApNAKOQM5CYj2Ebh/WoZQNt2ovj4glQLarbdCsiI+rWS26E3KizPnk2x1CMQNmfFZsmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcrN1qvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921F4C4CED3;
	Tue, 17 Dec 2024 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734465215;
	bh=pj+yxV8FV5mtqrf87VgeRSFczeCBpTFhHO6uGHQ6948=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lcrN1qvw/3o10wYH0pYwHPzj4Zx6SOg0XuNBv+2t6EI/nImPaTq5xmqmBzfF+n3ys
	 JYo1b9c5XKN2rjdEsKaz8xqZWVc6uHAUyKLb5nnsF3CbB7sPl4toYSC37YPjgEmv69
	 VmHzU27UGt1jYpzfOjUgPh63Rx9c3HDNPQv6bK5HhUEcICpP/XDESzfRX4szKnybOe
	 e7jrevrCd4SH9VM7P4EVkiXlLPXOoHGmk9HRY9z9Sdt6sg59mf9hEA3Ok08ONMF+QO
	 xgcStRM3ESRgZ2Od1g4StNnvcE2pQ/lvJ/9ggwXmpRPXKaknmHI1tLCPVOut/pocZs
	 qGl4BrXMWg8Ow==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 5/8] wifi: ath12k: fix incorrect TID updation in DP
 monitor status path
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-6-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:53:32 +0200
In-Reply-To: <20241217084511.2981515-6-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:08 +0530")
Message-ID: <87r066jdc3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, an incorrect TID value gets populated in the monitor status Rx
> path due to an incorrect bitmap value given to the ffs() built-in helper
> function. Therefore, avoid the decrement and directly provide the TID
> bitmap to the ffs() built-in helper function for the correct TID update
> in the monitor status Rx path.
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

