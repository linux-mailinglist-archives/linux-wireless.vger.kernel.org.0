Return-Path: <linux-wireless+bounces-20717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197FA6D101
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7AF16B7C3
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F4376F1;
	Sun, 23 Mar 2025 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Dke5Xn3y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E03595D
	for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742760776; cv=pass; b=SWnrQXmAR3K32L4EokfbU/dLBJzvk08kVYJ+aj8I9uw3WsK0Hq/Y/Iy1lJAQKqGD/rTMGfPzbaT+7IcgVS34GIdB8w0UVRv/dAoDJxHrmzeTk/nY0lSL4UvE21VeWPEXDn+aDoMRrpXIY/BMgybkzvPJifjZDOaew/J2gqGI2kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742760776; c=relaxed/simple;
	bh=Xk/SWxoEAlQwcQRBUsT/OTxoa6JOj4uOFYybheT3Hz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdSw46yTIoiZXBT5RRDBy7VVLOaig6o1bbwbh0m41PYcWx1pB8ArHL8JyVoAbwkU47z/DjfxvRZNOG5yJ7eDmQsPtqqT3Po376iMJ+rGcgYw0xj5mfP8vFQtA5GNdaGh0wfEzdTmv4FaYhmdXmDeuUSxNgMrqk9dxQzjaJzkhuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Dke5Xn3y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742760765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AM1DN9WbGR93tp8Nt4Em/P4TSnXZE5tC61utHpEvDWs0BSaYTkDG89667KSmHt1bVkCs3WJ3oyefuthr5gHSbEO/Z6dtHv/4aeI1ALw+Dqp0Zrfc/f7Dabn/hDKAqbdrfxa2Yma1BmUkunS3df0OW2iAYbSGAfeF1TDSXvqa5y0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742760765; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t7Cs40h1I32QA6hah5heYVE4/zI7hWbUU2YmAjNIFo8=; 
	b=ITz1lzJzEIj9uQnksnZoKa0F6xJA4wEf1qT5gMB+mHxLrAjAC+HJwgZcHi3mHDILuYv3YPE/IaICvry8hcE1wu9MOy1rn6cyn9VZ8wa7kkReTTdbwxio9VFkiIVuZIfMhoQv0XJdX1hgFakc5uTUNO23AAgIjRZoBd3vYm2iRYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742760765;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=t7Cs40h1I32QA6hah5heYVE4/zI7hWbUU2YmAjNIFo8=;
	b=Dke5Xn3yagnMDoMgp2SbUANxyZLruYV1kMxWyv7n6OJNYxrVp0nhU1MtBoVNj4sV
	v8JeQsiMhWbhIl1Nk+0VTisDu1ET8IwOssWw5OzEez9696bRGWom7OeCZyFIYcC5qH+
	AkNZPFjVhYl1ezwdbk+6qUB7R6f+1QPC21shXtF4=
Received: by mx.zohomail.com with SMTPS id 17427607646843.6235385042233474;
	Sun, 23 Mar 2025 13:12:44 -0700 (PDT)
Message-ID: <d71241e5-fa21-4aa6-936d-a7a97a8a07b5@collabora.com>
Date: Mon, 24 Mar 2025 01:12:39 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/5] wifi: ath11k: bring hibernation support back
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250320023003.65028-1-quic_bqiang@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250320023003.65028-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/20/25 7:29 AM, Baochen Qiang wrote:
> To handle the Lenovo unexpected wakeup issue [1], previously we revert
> commit 166a490f59ac ("wifi: ath11k: support hibernation"). However we
> need to bring it back, of course with additional changes such that Lenovo
> machines would not break.
> 
> As those machines work well in Non-WoWLAN suspend mode, the thought here
> is that we do WoWLAN suspend on Lenovo machines while do non-WoWLAN
> suspend (which is done in the reverted commit) on other machines. This
> requires us to identify Lenovo machines from others. For that purpose,
> read machine info from DMI interface, match it against all known affected
> machines. If there is a match, choose WoWLAN suspend mode, else choose
> non-WoWLAN mode.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
I've tested the series and it works. Feel free to add my tag to the
series. Let me know any more help with testing is required.

Tested-on: QCNFA765
WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> Baochen Qiang (5):
>   wifi: ath11k: determine PM policy based on machine model
>   wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
>   wifi: ath11k: refactor ath11k_core_suspend/_resume()
>   wifi: ath11k: support non-WoWLAN mode suspend as well
>   Reapply "wifi: ath11k: restore country code during resume"
> 
>  drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
>  drivers/net/wireless/ath/ath11k/core.c | 245 +++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/core.h |  11 ++
>  drivers/net/wireless/ath/ath11k/hif.h  |  14 +-
>  drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
>  drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
>  drivers/net/wireless/ath/ath11k/pci.c  |  44 ++++-
>  drivers/net/wireless/ath/ath11k/qmi.c  |   4 +-
>  8 files changed, 301 insertions(+), 40 deletions(-)
> 
> 
> base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4


-- 
Regards,
Usama

