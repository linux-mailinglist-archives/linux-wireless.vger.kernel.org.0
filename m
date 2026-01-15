Return-Path: <linux-wireless+bounces-30842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03582D2317D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 09:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2CE302AE24
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDCEED8;
	Thu, 15 Jan 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="aCHZXmKo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02B2877D4
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465228; cv=pass; b=cx2xLVHpyggjTnB99enTji5PI1TVDv3wjeT+kjrfKOGz4g4TcwlGDPesKcqC3CLSZCZrrgxlPdIprlEU88sWd6y7Cm5nIH4yHSfXReLLpEM02/D+RIHbBS7uq0cq1WEam/Iw0uOcFN6gLNIKT0S+C9sY17WL7oSOu30D/X7eswY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465228; c=relaxed/simple;
	bh=Kgip1bKFrTPG9c2JsFgljQmYZi6HcbppxU5CdVuIuZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HHSovSghDunA0riGVppnk8eDzrq4nIjnVD2kzVWYPXqtw1jJ+aPJZ1DjRyphu1+5ts5X/7AEK7zzFRomkjTHkcYhEknNqgQi4V5XUi+g2NKwQJuGW/Oro3KIfyXtKQSCQh/Dl3ub+EztqiBCgF9ifAydrepBhxS7Kt8X9t7xMA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=aCHZXmKo; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1768465220; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W61ILOhWMba/+q7dc66NIlC7XyYlPy5j08DIO+XRgpHRjZq6meacGdQZUtSW4E3mjhWinDUgkN6L3eXAEfA4Tcq8Rzldy47rXnYk6goJh5I6+YvMpjUEt0bbPFwKfFYXvsyvPEFkzMY0kL5MDR+gDztD99sLaemQxbmMzFXfu0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768465220; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Kgip1bKFrTPG9c2JsFgljQmYZi6HcbppxU5CdVuIuZo=; 
	b=cwJhIPq1CT53lHkxJ12MLtfHzYJPPzrrcRMm83/CE586+RGMNxBFe+tkDruY1uQQyPQzsGUfxiG/xuWfRKct9saczc3Cl2VksCJERMsQ39TG0j0NRPKupxfVLOjG5p7eYNSpnlYHYfKzjPw+Xf7LzwBcqnT1b8DX6cu/006o+lQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768465220;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:References:In-Reply-To:Reply-To;
	bh=Kgip1bKFrTPG9c2JsFgljQmYZi6HcbppxU5CdVuIuZo=;
	b=aCHZXmKosSKPg1eh1SZr717U6SBxMF93DPnMNn/7WJl9iH0jqT0fCghw5qKL9caa
	eonL5R4yQ4woBb3Iz+8zZ9JLGmWB6XRdeJBQS9qhL52gk/8QoHgT3N7Urvo2cjynItS
	yPODfQ/7E86MJws/t3MsCGXnqK34gobKxH18KNDc=
Received: by mx.zohomail.com with SMTPS id 1768465217051452.0691473771633;
	Thu, 15 Jan 2026 00:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jan 2026 16:20:12 +0800
Message-Id: <DFP0LJ1BX1US.2KD2FIIVAKD3S@xv97.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath: fix comment typo in monitor mode handling
From: "Chien Wong" <m@xv97.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Chien Wong"
 <m@xv97.com>, "'ath11k@lists.infradead.org'" <ath11k@lists.infradead.org>
References: <20251030143041.12027-1-m@xv97.com>
 <a47cfe9f-01eb-4cdd-ac97-421f3c8a3451@oss.qualcomm.com>
In-Reply-To: <a47cfe9f-01eb-4cdd-ac97-421f3c8a3451@oss.qualcomm.com>
X-ZohoMailClient: External

On Thu Jan 15, 2026 at 12:34 AM CST, Jeff Johnson wrote:
> On 10/30/2025 7:30 AM, Chien Wong wrote:
>
> Subject should have use "ath11k:"
> I'll fix this in my pending branch
>
> And I've removed the ath12k list and added the ath11k list
>
>> Correct a typo in the monitor mode comment where "it make" was mistakenl=
y
>> used instead of "it doesn't make". The comment explains that the brief
>> period where monitor mode appears enabled before being removed is harmle=
ss
>> in practice.
>> Also, use more common phrase "in practice" instead of "in practise".
>>=20
>> Fixes: 3f6e6c3291ed ("ath11k: disable monitor mode on QCA6390")
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices"=
)
>
> And I'll drop the Fixes tags since there is no code change and hence no n=
eed
> to backport this change to stable kernels.
>

As a newbie in kernel development, I now understand the use of Fixes tag.
Thank you.

Regards,
Chien Wong

