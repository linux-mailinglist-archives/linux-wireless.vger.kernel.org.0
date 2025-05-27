Return-Path: <linux-wireless+bounces-23438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E61AC49E3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27047ACC3E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B22288FB;
	Tue, 27 May 2025 08:06:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626F188006;
	Tue, 27 May 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333195; cv=none; b=ANka/yBPwDh3hIK1ZhPEipMh5j06SQv8YykZE02Vd0jGwYXokmLROpdXUnuZViDyDW6iAsCx0H9dtTxRqnew6gLf08yxL162Zb/tNROolD1h+d/TrEAnB59/YYzatMAARhnh5t2+m8rFB4oPxPDIUf9dYwZYXztJhaUmkv2QxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333195; c=relaxed/simple;
	bh=wzOA6iSPs6TdzvbnAGPufOxY5R/+Op+uWEm/JAcr2MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pew31F6Byh5I/8eJ/twxjDWcIZA181srK+/r7jrLb4KD6OzmK2iHpUn8lo4yQiRHT3IFNz7GCVV57tydO7FpSrXqcdJJt53JKH8wF1D21dlubqqCuEsRefzb/AF9QthcR6mkX6ZeXc9CoCygBD0Ukrc51zac0Nz6VLPVgpI2dw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7aeec8663ad111f0b29709d653e92f7d-20250527
X-CID-CACHE: Type:Local,Time:202505271605+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6f991e43-1ae2-488c-8c3c-8d10bf07218f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f33bf93bc8090cddb4fc05533269a36a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7aeec8663ad111f0b29709d653e92f7d-20250527
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1786078781; Tue, 27 May 2025 16:06:23 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 1BDC916001F52;
	Tue, 27 May 2025 16:06:23 +0800 (CST)
X-ns-mid: postfix-6835727E-8232082558
Received: from [10.42.13.56] (unknown [10.42.13.56])
	by node4.com.cn (NSMail) with ESMTPA id 82B0916001F49;
	Tue, 27 May 2025 08:06:22 +0000 (UTC)
Message-ID: <fadefef6-5e16-4cc3-87d5-33e94ac1ad1a@kylinos.cn>
Date: Tue, 27 May 2025 16:06:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: cfg: Limit cb_size to valid range
To: Johannes Berg <johannes@sipsolutions.net>,
 miriam.rachel.korenblit@intel.com, emmanuel.grumbach@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a603a35a2d05ac9bd44c87efc605d35051d5d12.1747980220.git.xiaopei01@kylinos.cn>
 <af7b544920184403a22f326c3c8f0d560bf1b4d0.camel@sipsolutions.net>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <af7b544920184403a22f326c3c8f0d560bf1b4d0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/5/23 15:59, Johannes Berg =E5=86=99=E9=81=93:
> On Fri, 2025-05-23 at 14:04 +0800, Pei Xiao wrote:
>> =20
>> -	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
>> +	cb_size =3D RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans));
>> +	if (unlikely(cb_size > 12)) {
>> +		WARN_ON(1);
>>
> What's wrong with "if (WARN_ON(...))"?!?

thanks!

V2:

https://lore.kernel.org/lkml/7b373a4426070d50b5afb3269fd116c18ce3aea8.174=
8332709.git.xiaopei01@kylinos.cn/

> Not that I think it even really needs to be there but I guess working
> around a compiler warning could be worth it.
>
> johannes
Pei.Thanks!

