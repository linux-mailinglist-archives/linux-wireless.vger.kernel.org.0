Return-Path: <linux-wireless+bounces-23437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E6AC49E0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4387A9AD5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836D23DEB6;
	Tue, 27 May 2025 08:05:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C501C6FFE;
	Tue, 27 May 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333124; cv=none; b=KFaoyvA8+mCN9h5oqfNjwPvE7G8EnBwejJoBehsIHfk4VHOLXnr+auscWk62uAS3xIudnJIyfH2XAtYv6eEPpQ+sSaXRdtr39F97LJU5+kp3tu6c8/OHZTSERnXWuVjOMbQsVNvV/3GPWbyt4NkLhH3Gs3Y3h9dzmYTO4LRdTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333124; c=relaxed/simple;
	bh=Y28V2JcKpAoRJnsRr5ufq7WzyyMjdtSRBRrr7zvRA70=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KsYaATPxWVE7Xv6z4tFeE8e2uxxvgSo2GiosKqjzWnBi5sW2ujjWjO5PTqoHg36mKJJMfzboB5I2inC8/qSfsZQ/hhTcIRlaD0Ilgmyz9wasnL2g43scWDmNnMdsFdCDZ0FAUXPb3v59LyWaSQ/gmtb19HqMrAPJctPiZ54V55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 51c5a4d23ad111f0b29709d653e92f7d-20250527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0b34eae1-ec01-4f6d-9aad-0f3bcaf8c10e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f33bf93bc8090cddb4fc05533269a36a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 51c5a4d23ad111f0b29709d653e92f7d-20250527
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 444727692; Tue, 27 May 2025 16:05:14 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 0FB2816001F52;
	Tue, 27 May 2025 16:05:14 +0800 (CST)
X-ns-mid: postfix-68357239-3925852549
Received: from [10.42.13.56] (unknown [10.42.13.56])
	by node4.com.cn (NSMail) with ESMTPA id D9BBC16001F49;
	Tue, 27 May 2025 08:05:12 +0000 (UTC)
Message-ID: <4f6e62d1-c850-4469-b549-cc4b47081e3f@kylinos.cn>
Date: Tue, 27 May 2025 16:05:12 +0800
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
ok,thanks!
> Not that I think it even really needs to be there but I guess working
> around a compiler warning could be worth it.
yes!
> johannes

Pei.

Thanks !


