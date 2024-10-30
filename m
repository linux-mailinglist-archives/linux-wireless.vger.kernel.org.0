Return-Path: <linux-wireless+bounces-14707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E059B5A35
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 04:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7754D1C21001
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93D14E2E2;
	Wed, 30 Oct 2024 03:12:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F94437;
	Wed, 30 Oct 2024 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257959; cv=none; b=BBiuVboaUz6MSgItZwgx2Cu+Nm7kFzy7+ud9kXw8Iwgv/GYNWaYHQf/8/a4JMbHvCRLze5ur7Squ9HLLm7qDD2TZ90NdlH1r9Ph79hrjnoE4wd71pAWk7/g2FoNk2hYPdA4YPp6lQUKhYGjCRMOQfeUD1MTFc7wNXnxF0/XpvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257959; c=relaxed/simple;
	bh=e9WQXN3eis5JcmriQDZZExOvk6OnQmKBbzFx2L02J7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwd07QAcicgn2O9PRo7I11HVTktfvebmHGRlfNU92ie2HGkLqFe+grGbvg48zt24ctOiEQ/QxELZprUXelo+guwFeaO95zoIKoemrVztCOPAHGRIbpsikaNgj0bS8IB8Y3MkJ4co4bJUMNwJ7ADHTMsFXYMLJrXYswf25viX6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb253c98966c11efa216b1d71e6e1362-20241030
X-CTIC-Tags:
	HR_ERR_NO_COLON, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e03ee94c-8e79-470c-a60e-b01ac150f7f0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:e03ee94c-8e79-470c-a60e-b01ac150f7f0,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:5f646e71f59badc258f87d491058186e,BulkI
	D:241030111228NUS0HV4U,BulkQuantity:0,Recheck:0,SF:38|17|19|64|66|841|102,
	TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: cb253c98966c11efa216b1d71e6e1362-20241030
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1022731029; Wed, 30 Oct 2024 11:12:28 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: 425562414@qq.com,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xiaopeitux@foxmail.com" <xiaopeitux@foxmail.com>,
	"xiongxin@kylinos.cn" <xiongxin@kylinos.cn>
Subject: Re: [PATCH] net: wireless: realtek/rtw89: Add check null return of  kmalloc
Date: Wed, 30 Oct 2024 11:12:22 +0800
Message-Id: <1728e9f5-0d4c-481f-8f85-9e4d74ab4ee5@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4f5eee8cb4024571a9a78af97aecab67@realtek.com>
References: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>  <8734kf2o77.fsf@kernel.org> <4f5eee8cb4024571a9a78af97aecab67@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;  attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiaopei01%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

=0D
=0D
On 2024/10/30 08:35, Ping-Ke Shih wrote:=0D
> Kalle Valo <kvalo@kernel.org> wrote:=0D
>> Pei Xiao <xiaopei01@kylinos.cn> writes:=0D
>>=0D
>>> kmalloc may fail, return might be NULL and will cause=0D
>>> NULL pointer dereference later.=0D
>>>=0D
>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>=0D
>>=0D
>> We use 'wifi: rtw89:' in the title, please check the documentation below=
=0D
>> for more.=0D
>>=0D
> =0D
> A way to known subject prefix is to use git log with the files touched by=
=0D
> this patch:=0D
>     git log --oneline drivers/net/wireless/realtek/rtw89/coex.c=0D
> =0D
> Also subject can point out specific function. Then my opinion is=0D
>    "wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg(=
)"=0D
> =0D
hi Kalle Valo and Ping-Ke Shih,=0D
Thanks,I will modify the commit information and add Fixes.Thanks for help.=
=0D
=0D
Pei Xiao.=0D

