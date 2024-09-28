Return-Path: <linux-wireless+bounces-13269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32099988EBD
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E4C2823C1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCD15B987;
	Sat, 28 Sep 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG7FpMYc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AA2AF15
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514970; cv=none; b=Rf8Z+iDQOSfeAqwrhtKhn63ybAyrIRWL176eVUr8CX4IbGu32c/fT+Qy3PntOCkrPKWa1tYbuYYrzibwRwCdd68O7RuUXLJ/dfi69y/YlbjG7zxclrypAUiSAp23O9Ka23AGlM8oMrnCkEob8KoDW5hRf7YSY9uuUi1ECFeJKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514970; c=relaxed/simple;
	bh=nSS8/Mp4RwqYI3+lY1xNHCPSdP62FLumSgms12QSo3g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IVKoHrGq7ZaY/XX/ISQcBiGJnkZx/6VZcEE2+bd4zv4yVv1RE/7Ga1Slgv6oeQ5AUHhhLXHKkB1WmDlYsK1TP2P1jYWiB3MXNVYIiuoNtiMc1KnVDkNkDMhORNsK29ryKf5WsIaq1FA4zVf30sDK0pclTGNZ9sDzl9Q40pUO5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG7FpMYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4281C4CEC3;
	Sat, 28 Sep 2024 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514969;
	bh=nSS8/Mp4RwqYI3+lY1xNHCPSdP62FLumSgms12QSo3g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=vG7FpMYcfh44DGZMLQuobAViD7RYHLjUf4X+h/1E4yG5GNROTbdJwfOlZPc+BSJml
	 hRMRT8fiTMwoe+K8m4fG5GlJVtLh3/r/r6iChOMkL4HVEbSwtFp52jKicctVeTP075
	 k9G3hqhxpSYARdzKEWQiB148cRzmJ1P9DgCIMu0Lmj7+/NgVJ6l2/Cg37eE3T9xXpA
	 4wPJ1oVmhZoXFKwkZsTolPBTLYEPmBKyXBAqNZk0pXlCOxtUVw51QkrfI5iTBYTQkB
	 sK6nAYXyeEjTCJYxgJHWD7Ne6ujNwHSy8wmoRK2zG7TAHbidEXH/dyBXHgEanJr7VX
	 EzbUgp5Om5+DA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: enable fw_wmi_diag_event hw param for
 WCN6750
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240828103043.2413-1-quic_bpothuno@quicinc.com>
References: <20240828103043.2413-1-quic_bpothuno@quicinc.com>
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Balaji Pothunoori
	<quic_bpothuno@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751496718.2249584.7164352924972001237.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:16:08 +0000 (UTC)

Balaji Pothunoori <quic_bpothuno@quicinc.com> wrote:

> WCN6750 firmware sends the log messages via WMI_DIAG_EVENTID only
> when the host driver enables the same via QMI_WLANFW_WLAN_INI_REQ_V01
> QMI message. This is further controlled via fw_wmi_diag_event.
> Hence set this flag to true for the firmware to send the logs.
> These logs are further collected in the user space through
> the trace infrastructure.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00233-QCAMSLSWPLZ-1
> 
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c9c6a4f1be1f wifi: ath11k: enable fw_wmi_diag_event hw param for WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240828103043.2413-1-quic_bpothuno@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


