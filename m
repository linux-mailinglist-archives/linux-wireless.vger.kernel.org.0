Return-Path: <linux-wireless+bounces-11872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF57495D801
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 22:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA911C20F16
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43441C8225;
	Fri, 23 Aug 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oQYjD4Pu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE61C7B97
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446050; cv=none; b=rligIdGQKMPj8oh7XNpr6XY9bPJMXcKyte2MQgN1LklWXL2YqM7RpB1OgCV0oupYQVyqXhFaZB2CntEm9LesYvRfD3PcntnrLXukQRQc2oUGQuRnyGQlFc+ILzudjS/aG3bRIByXTx5juRcgJXm3Edp+da1Jt1C/Cej3Sr0igdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446050; c=relaxed/simple;
	bh=3dO5cWmRYtFM2zR4e9haQvfRfS5uN/lrzX+WW0Z1Sqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHB+uVKVVTFt12TYM7mdbW0cTfah/KswqCOnoV5eFsOtCGhs8HHJu02vGg8XBnQbeLIZ1pno1He2hDFSKtDuXW1cD4P5BjGW0wT7U30Qj30b9EduvBkRZwRSTCKODd0Aj1OMgBeyHogG1bY3MAXUpp4kb6nYojnhD7s5J9dbZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oQYjD4Pu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 06D3D88915;
	Fri, 23 Aug 2024 22:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724446047;
	bh=UqFMfwvJhTvpB83TxHsUc7SlHBnT2kq12zdqHH46qZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oQYjD4PuWTnYYFNXC9I3GZptjgn9lT23KWkQKvfgpoRANIxeDPKP6RiqJ5GgmpVGc
	 4yIfpK5Dtg7axcbCkq6v2/vROXNP+ikv/NEFQ3c6+KcRrWI8YMn3T7KBMmRZk1iJcL
	 FkKRAnrG4hurvQjg0EvFKc7Qq1CvmbYl5DDI/K7z+NDDNPI6aTRLuSTI6/6OMwnqnr
	 Ol/NiyIkYrUEt3Wam1esl+5PvLs/ahQP5MMfsoP4PO7B0xnzLb8mdZFfsPgxTOkPmn
	 qmZLIUuTKOtI9s71Gj3VDszlnJEitAOhfV2lmRHdqWyfy/tWUe3aZHvVN+DbqZ667D
	 FRJ5Zcyo1vV/g==
Message-ID: <8c283462-44cf-4316-9f11-ee9c0b9abce2@denx.de>
Date: Fri, 23 Aug 2024 22:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Do not operate uninitialized hardware
 during suspend/resume
To: Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc: alexis.lothore@bootlin.com, claudiu.beznea@tuxon.dev, kvalo@kernel.org
References: <20240821183639.163187-1-marex@denx.de>
 <05ada8d8-d5b5-4b9b-88dd-bdbd9aea65ce@microchip.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <05ada8d8-d5b5-4b9b-88dd-bdbd9aea65ce@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/23/24 7:16 PM, Ajay.Kathat@microchip.com wrote:
> Hi Marek,

Hi,

> On 8/21/24 11:36, Marek Vasut wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> In case the hardware is not initialized, do not operate it during
>> suspend/resume cycle, the hardware is already off so there is no
>> reason to access it.
>>
>> In fact, wilc_sdio_enable_interrupt() in the resume callback does
>> interfere with the same call when initializing the hardware after
>> resume and makes such initialization after resume fail. Fix this
>> by not operating uninitialized hardware during suspend/resume.
> 
> Is this behavior observed then power-save is enabled when interface is not up.

This is observed when the system with WILC3000 boots (wilc3000 is not 
if-up'd or anything) and is suspended and resumed, as simple as that.

