Return-Path: <linux-wireless+bounces-2091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A10830522
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E781F24B4C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23D1EA6F;
	Wed, 17 Jan 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8OKgXvP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B501EA6E
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494337; cv=none; b=WOKDWRXvCBw61f3+HwGGz/r9F1aLmyKeQzg6qJsGvZrazaWcu3VDxel16+j0nvijVjShFLyVNAZUV5LVe+PpONOiKpe0QusiZWFtbs3Oh+TJMa67sSsv9MphI6rqnHVlBnzORQt8QIOp8vsyGyEMAPBSML8FSW+mPosYS6H5jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494337; c=relaxed/simple;
	bh=gVt7/Sn2odT1iG7XbXOMPV86sBp35yRM/f0EfvTfyNo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=tYqz/GFFKb8pKQ1Fm3et1E28gskGWnqLJSh5QVSMiR7ZD91fCmaolhTHRMADfHMg6WhkRA4scK6T160SA2vQXkAUZVMUzCAaCDw2K1nZX2CkwusJKOvxkNYne7JxoIGo5KR+O7P0OdKSpD+bF08wpZv+gQABx6z1HWXoISP+OGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8OKgXvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28C4C433F1;
	Wed, 17 Jan 2024 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705494336;
	bh=gVt7/Sn2odT1iG7XbXOMPV86sBp35yRM/f0EfvTfyNo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=g8OKgXvPNplxpaU8bvEEywnpd4mb6pAxdXPNcbVVdQDC/Fyp/dO9puraoQ8B9DJCB
	 ArStu5YLvRaBaX53hKeG3AJfbrw+6TAzO/0Oda9NGaauux2egmqK/TdQF8W5ZJT5gm
	 a0mdBgFLenWVGGSuRYXuBIClAhx6Mhe4iu/mHWVfNfVKXwGqSqqwL/hvVLaz25alqQ
	 caxmdHm5+kLVlT3F4czeaXOEb6SNa9b5ZUdp0xAree0g1ivsUGO3rkWs5SlcEkbbjY
	 Uo9/e/WR/sFHx7NTpF/zMc728Ev+GX+A4OKMYDiGTZ+wIxCnhzV671uH+hIa0S50yF
	 qSaRPSXQupk5A==
From: Kalle Valo <kvalo@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] wifi: ath12k: QCN9274 dualmac bring up
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
Date: Wed, 17 Jan 2024 14:25:33 +0200
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com> (Raj Kumar
	Bhagat's message of "Sat, 6 Jan 2024 01:26:27 +0530")
Message-ID: <87le8o5epu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> QCN9274 Ath12k chipset can support single-mac or dualmac architecture.
> Currently, Ath12k driver supports only the single-mac QCN9274
> architecture.
>
> Hence, add support for dualmac QCN9274 chipset.
>
> Depends-On: wifi: ath12k: add firmware-2.bin support

There's no base-commit so it will be very difficult for me to try to fix
the conflicts. Please ALWAYS use --base, makes it easier for everyone.

I'll mark this as Changes Requested and assume there will be v3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

