Return-Path: <linux-wireless+bounces-1630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DF8285F7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 13:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527B11C2152B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19E381B4;
	Tue,  9 Jan 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrUzDHwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FD374FE
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 12:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6686C433F1;
	Tue,  9 Jan 2024 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802913;
	bh=32dtlFEDmpYlPSuhrYgC24OmzGy3LLUIz4NejUJYmfo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NrUzDHwNdGpM4+2mtFd7OoYZMOpVmswXM3nJlpln4amDyPBMzL1CYBiowbCOh5PFh
	 mRycWGNDMDQg60sNtoXYtWdScxvr4PptUKIQhvRiBYpyWd23591hVbEOQSAhzBD1Yp
	 UAm+Rx45D6aFmt1xXY2tDtPYhfFQ5kflgoNHAc/9/8i9KfIbCTcE12BHRGKfK9g6md
	 9PfUJGl6ZGg3qKrsLP2/6wJZh4Lj0Pj06d9cQO0/a39XByNDqQhmsS6M1EjzEdwrDH
	 2sZvaUWfMEpvu5bJS3j2nSHN9X0x7IO0fPWOlbnY5kCoWNCunLUn12htoL5vx0aJ+0
	 pPCi2dp5b37TA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] wifi: ath11k: add support for QCA2066
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
Date: Tue, 09 Jan 2024 14:21:50 +0200
In-Reply-To: <20240109021336.4143-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Tue, 9 Jan 2024 10:13:34 +0800")
Message-ID: <87frz6ely9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> QCA2066 is a PCI based DBS device. It is very similar to WCN6855
> overall: they share the same PCI device ID, the same major and
> minor version numbers, the same register address, and same HAL
> descriptors etc. The most significant difference is that QCA2066
> supports 3-antenna configuration while WCN6855 doesn't. To
> differentiate them, subversion numbers are used. Currently four
> numbers are used by QCA2066: 0x1019A0E1, 0x1019B0E1, 0x1019C0E1
> and 0x1019D0E1.
>
> In order to read subversion register, pci.ops needs to be ready
> at that time, this change is done in the first patch.
>
> The second patch enables support for QCA2066.
>
> v2:
>  - Rebased on ToT.

And the firmware is now available here:

https://github.com/kvalo/ath11k-firmware/tree/master/QCA2066/hw2.1

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

