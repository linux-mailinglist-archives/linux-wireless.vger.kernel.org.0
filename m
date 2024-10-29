Return-Path: <linux-wireless+bounces-14687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD39B5179
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679E9282775
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300781DCB2D;
	Tue, 29 Oct 2024 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZW7g7A7f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA51DC05F;
	Tue, 29 Oct 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224738; cv=none; b=q43z774V08GX8FbQwn1J118r7S3pw6aVZ3kr2bmVzuLGH+Y1jJ0ruUPZI0Pa4hQL8wv7BCtIt/9nrqSsfSintS2I+fOq4i3JAs7lmv8N30M/d4h7L+7y5JRRK/BX6ccq6RTWY+phiHD5XcGHMiXG89fODfGB9V6HgVZdnpFA9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224738; c=relaxed/simple;
	bh=s/u8pPWMC3pbZzSIZknK0FhGVvT9Ea35bWwGGdoY6I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJtkP55v4kvP5q9ZkdkD9aEZz9FzMVBiBc2qSt9ns8yeK6BXN083aYXo3obHapr65avIpoPM3Kk7f1KdG1iZpWohLqwWFjHcgg5JUearKJ1OopVpl1MkL4tvTldeBq8pZ0z932e5/dqYs6XmP0NTIPHt67OxD9CdUF3Ut3wVIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZW7g7A7f; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WEPme5oYRYRSsuylMXdLZT71KCEZcWHqld3pfio5ORs=; b=ZW7g7A7fhcAdPHrNRRm6x4lcEJ
	N1AC4hg3eHNot9HXU82AS3Yuatqq6o6cx0yp53DrICalsmuTcBViNz3nw1ZBOiianeQkAv9hNGymx
	QFx3P0s43A0l43j9XOcQBgzuqUhYEwfevBIvez64FynE0HNFFoRcS6dSld/ryKiHRCMqFEomBSAai
	zR913skQZ8cXU64awnT2RB3we332Lr2MaXlZDERtauY9s3JN/3jRr4NXZg8WHRHtvNG4pUxijE7zh
	NPRfdjTYMBPz63l6uuLkYBH9Kr95IRtBIdhx/bxDGrIEEDoHcBD+pNYJAIJYrWHBWy+/i+LpQjUzr
	RaQIMRlA==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5qUP-00GjvG-Qd; Tue, 29 Oct 2024 18:58:46 +0100
Message-ID: <984038be-6cc2-3acc-8ab0-5720a79dbf07@igalia.com>
Date: Tue, 29 Oct 2024 14:58:40 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
Content-Language: en-US
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
 <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
 <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
 <14c3164c-0e1e-4d9d-89d9-28d3240861c6@gmail.com>
 <d6e01e56-51e7-cbb2-024a-c7db86dc70fb@igalia.com>
 <baf6d88e-e753-4aaf-a340-991373d77fa8@gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <baf6d88e-e753-4aaf-a340-991373d77fa8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 13:55, Bitterblue Smith wrote:
> [...]
> 
> I tested your patch. Both my devices can still read the efuse.
> 

This is super great, thank you! Would you like to have a Tested-by on
that? If so, just send the name / email of your preference and I can add
it to the V2. I'll implement the PCI guard and re-submit, thanks again!

Cheers,


Guilherme

