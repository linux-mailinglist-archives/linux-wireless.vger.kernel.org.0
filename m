Return-Path: <linux-wireless+bounces-14738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FC9B6570
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 15:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080E61F24586
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD01B85D6;
	Wed, 30 Oct 2024 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iSw7buGO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB44282ED;
	Wed, 30 Oct 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297799; cv=none; b=LdrsQ2/6w0tQOXdINFS+oM7DkbHG5gte2XHgZ3dxjxFIgpj4rQij1chcc9M1vLbrGbBd6E9Ohq6ASrNtWGTOSwwU0WE0RD+1Il1S+qLrG/2dGnG9EzWEuBkhseiDnmuq98ATb4cWeKui1c2vH7MZutKdho91yinVGLv5qZdb9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297799; c=relaxed/simple;
	bh=m0jNg78ICpCSQdGeSw9gnAkbHmEVbPPm5S/VR+TM0ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Htx3qZSMmcvl99zlZi1u+chksqVF8tvpSb8numXPX1TpeVwNIz/38stwUcw6UqgJ+oZs3qh8Kx1JGmB0byMsWfGaO/XR3Gf6Gty6CLwV2LqC7ChXcknRrdC+HWlyWkf2AcrgZgS/2GowVk3Mm8H2O4/VfkV0mBiwAeU07Yio2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iSw7buGO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WkDHZosWokJq6vp6PbMPtO78UYPKzgLZ6M3l76g34iA=; b=iSw7buGOgO5hNHG9DscaCH7E5G
	IkSA6Ko25V4YXAq064e1LYb/6RQvMGosd6hSRsBYQSd8fjuAxEs7ZIHAsjzCYEBOldHHCmcswxVIJ
	CjFC+A7hKTCJjct6LuNS/Ij5J74rz2PZ1q2gPc3X9UY9BQGttWOPujZ8pelTjTJNYKQC3F0CkWnjr
	48uU8+nccQOWKDQiEluZO9Il1I883XT6ooX43kAD6iqLaogGpSu9SR8hn3wo4Gwj06ZEYF5Og4ad2
	WBv/YpgCT5DUfQIAAML+KJIDmT5JjlqPYMroyZFuOCohKeYVyFrOKLWXUbFaYecS1Myzm+A+eNtIp
	fGjpIVAQ==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t69Uv-00H7BU-Kx; Wed, 30 Oct 2024 15:16:33 +0100
Message-ID: <a80c976c-6c93-2f16-bf8e-36ff6ef79393@igalia.com>
Date: Wed, 30 Oct 2024 11:16:27 -0300
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
 <984038be-6cc2-3acc-8ab0-5720a79dbf07@igalia.com>
 <c47081db-4a7a-46df-bb4b-82f8dda94460@gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <c47081db-4a7a-46df-bb4b-82f8dda94460@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 10:17, Bitterblue Smith wrote:
> [...]
> Sure,
> 
> Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Thanks a bunch, V2 just sent:
https://lore.kernel.org/r/20241030141440.1153887-1-gpiccoli@igalia.com/

