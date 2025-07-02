Return-Path: <linux-wireless+bounces-24768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8587AF5CF0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468D41C44FAD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1942288C89;
	Wed,  2 Jul 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="DeNXlsfH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8327FD6E;
	Wed,  2 Jul 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469965; cv=pass; b=lCWazgcErF6cuPSL4xZ/zULmJ1CkgE/sxIMBIy1GrogVPhUh2BB/NxptYbg5akt7/1VHAA0to5IuPZIwvEhY6kEyeW+5By6o1Ds9X/md/DRlRWDyXYmjtuz1yzLvhX7f7IKTzJCYi6qIR8IwrsWw0w12hhZf1ZD77H4VgRgEuZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469965; c=relaxed/simple;
	bh=YI5xJQzkom4sdxkvBnrOayW443RFDT8jwoEmyUtPD7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqMfAXh8Sdxgm5j4qs+uUMjuFow5Ch05cLUeORbsCSYAPjFMMqITLBu4Uh40cG+LULFoUp0QpwjlSmznenl3Q6tKU02cn1M3yqoMcDWLWiJxsmfvFHRE3jIqxLftKP7LLytw8YU3kUIy6jndYcJM2k6oUK5/ApSAyj7qF47rRCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=DeNXlsfH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751469910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wh4ld+IjPq9rN2v5JrrVbNCJ9Tenxzp/ewU5rqFiunyck4YH3W/tqzh9RZebHG9/ZumIQDhyv5HaQIhnaxA7xPvOmM8lQRQnR189PqUybYczVNFT4AIlTrrAP9D74+vqrH5LwOnwJNo4cPSXgixvX36ChYUJwsrd3oC1lLPCPZg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751469910; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mSSYZlzjDorHVrW9kO4wmXJF7vcClWLjaQL8PerBKvE=; 
	b=dhdQKgAwyG58FQVyICKT4UXpZblCNhIUSpwm3Xg+BFbPESCNAEFUUOcwJGqofWtMAlsyEPky41WQsUzaTyJ0yp4dJdZgTKWKOkVwNVITcLkDVg4C2z/rpf8G7pVD1n5ZpM0kxwOwZFBDOypzGPWuZO4mdOFyVf5WBCWEYDU81uI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751469910;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mSSYZlzjDorHVrW9kO4wmXJF7vcClWLjaQL8PerBKvE=;
	b=DeNXlsfHaMk2Kd1KbaP+z5CgMeLB/0Y79MStxyfuES5HDSFJK/8eDKuQ6yEEGcl8
	z/QOHyIUBVrJunQiap/b+INWBeqtAytqUaKAnv60qL1mZGjRYpXmjO3Dgla5mOfL/GB
	SVkbt+cCJd9w+pA5ueE3JjlaEEEN3y/GCx97BCgo=
Received: by mx.zohomail.com with SMTPS id 1751469909243485.9751973058537;
	Wed, 2 Jul 2025 08:25:09 -0700 (PDT)
Message-ID: <ed010318-8a10-4a8c-b8d4-721bdf631c2b@collabora.com>
Date: Wed, 2 Jul 2025 20:25:03 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <2025070128-chihuahua-slimness-da88@gregkh>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025070128-chihuahua-slimness-da88@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/1/25 3:25 PM, Greg Kroah-Hartman wrote:
> On Mon, Jun 30, 2025 at 12:43:29PM +0500, Muhammad Usama Anjum wrote:
>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>> deallocated and there is high possibility that we'll not be able to get
>> the same memory allocated from dma when there is high memory pressure.
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> 
> No cc: stable?
I'll add it to entire series.

