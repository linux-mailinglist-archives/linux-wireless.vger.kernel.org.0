Return-Path: <linux-wireless+bounces-3895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94E85F17B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909932827E1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA21426C;
	Thu, 22 Feb 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPHFRM6X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8DFBF4
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583107; cv=none; b=TWhYw17yY4ditC9ZG4oQGXWWwWxH2KCMjX7SOUAn/TdiF8BhBMrw+ZW8HBA5RADHIrFU1+VHg4qGRiOLwaAXLQQ2SVUSLvj41stBKHhfSI2s3XebH0Sx+nIDD/CqV75iJMp/psgpyh2JRBI/m7gWB/GqhObY0RRNaQaT8uCgnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583107; c=relaxed/simple;
	bh=nXjyzMN1tP+ikBL5uHXkysnaM6WKpy+upxv9MW+lzzI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ho52lD3PAMEJuwSM6LE6Mb852+MneW3eiWl5Tre1L07SUWrGq6dTladeFuv3ZGaYLTCCBFAnlTHpSIi2wgyvyGoIsb+L5Y98fJlHusLWyvYX8sNYy6yv9BKaf7b59yYjw2Uf4ShW+FZ2WrAgF2Hcte7FqeF0h7sHCn28ph/V6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPHFRM6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568C5C433F1;
	Thu, 22 Feb 2024 06:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708583107;
	bh=nXjyzMN1tP+ikBL5uHXkysnaM6WKpy+upxv9MW+lzzI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OPHFRM6XuX2WzXP0EU13Q/3GQkjQudbcBNzXsK7fhEtTySzlxXp/TI0jDms+wBezN
	 ERRHj/CL6tXobxBudBUYg3KOb4gVNP9NSh1xgx71ivRwh3Wa2Y2PYrce8A0+TSR8X+
	 iLhTIpbl0YYHG5QlCI7Pnm9CfbyP75/rRAEEyRH4TQpBQNN3/SpyiL+A8C3bnoRAiH
	 4UQZv2Oyj+VoLRAQo3H9XulrcnbgFZqZVRAUXndkR9fOk9NgFSKbxt/8MkT92rkNrb
	 1toBHUUhURGtjn8cs04cr/UdTlKDbtxm8jpbWBLQpVeTHXiym8qthXFo9CcEJg+6pd
	 mzgLOCFygAkIA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: ath11k: thermal: don't try to register
 multiple times
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
	<20240221024725.10057-6-quic_bqiang@quicinc.com>
	<df08dfd4-189c-407b-8a2e-6fd2bbf3b22f@quicinc.com>
	<5828b835-6b4d-4245-991a-7f6b54ee8b51@quicinc.com>
Date: Thu, 22 Feb 2024 08:25:04 +0200
In-Reply-To: <5828b835-6b4d-4245-991a-7f6b54ee8b51@quicinc.com> (Baochen
	Qiang's message of "Thu, 22 Feb 2024 10:34:16 +0800")
Message-ID: <871q95audb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 2/22/2024 1:15 AM, Jeff Johnson wrote:
>> On 2/20/2024 6:47 PM, Baochen Qiang wrote:
>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>
>>> Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
>>> ends up calling ath11k_thermal_register(). So we try to register thermal
>>> devices multiple times. And when we power off the firmware during
>>> suspend/hibernation (implemented in the next patch) we get a warning in resume:
>>>
>>> hwmon hwmon4: PM: parent phy0 should not be sleeping
>>>
>>> Workaround this similarly like ath11k_mac_register() does by testing
>>> ATH11K_FLAG_REGISTERED.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> you need to add your own S-O-B
> Oh, sorry for missing that.
>
> Hi Kalle, I see you have put this series in pending branch. I am
> wondering if I need to send a v2 to add my S-O-B tag, or you have any
> other plan?

I can add it in the pending branch if you send it to me as a reply to
this mail. s-o-b is like a signature so I won't add it on my own.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

