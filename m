Return-Path: <linux-wireless+bounces-14708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08949B5A37
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 04:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AC31C20DAB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41C194C6C;
	Wed, 30 Oct 2024 03:14:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB404437;
	Wed, 30 Oct 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258040; cv=none; b=s5bCkXPdUnY/8wyjZOx/Ojl7Eifc7SwayFr3ILy/F6lltAx74H0aHvTuZHJkMyLbqGUnoqPvyCW3HRnb3SjoralOMaPwYBJUr3Au1NV2u1G2Idw9H+KzPef/zPSBKELYwmHboY1KhkrjIvpU2U2uaC5AMyF8R0zOLddQNIOux0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258040; c=relaxed/simple;
	bh=e9WQXN3eis5JcmriQDZZExOvk6OnQmKBbzFx2L02J7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG8yF/flkUGlNmdiDIKxIGvda1IXigk+UIIhKikMAkPY/ejvogf+7vSBVZN0Rj+W+PDojaAUXzdQdnUv6hKUBqTwE3FkPdzpOAckApjdjJhlegUdvT+XfbuzA73SltnnzSU5IyaMvXQm4Yjndz7Fyj32jpZtgUCZQ0Pfa8wlerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fb5716fc966c11efa216b1d71e6e1362-20241030
X-CTIC-Tags:
	HR_ERR_NO_COLON, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1285e427-c671-46c8-95d5-7ab24506350c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:1285e427-c671-46c8-95d5-7ab24506350c,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:57e0c76bfff6ca60ded9c30cdf170777,BulkI
	D:241030111228NUS0HV4U,BulkQuantity:1,Recheck:0,SF:841|38|17|19|64|66|102,
	TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: fb5716fc966c11efa216b1d71e6e1362-20241030
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2040828064; Wed, 30 Oct 2024 11:13:48 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xiaopeitux@foxmail.com" <xiaopeitux@foxmail.com>,
	"xiongxin@kylinos.cn" <xiongxin@kylinos.cn>
Subject: Re: [PATCH] net: wireless: realtek/rtw89: Add check null return of  kmalloc
Date: Wed, 30 Oct 2024 11:13:43 +0800
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

