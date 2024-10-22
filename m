Return-Path: <linux-wireless+bounces-14294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C79A9B70
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04F91F230E5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C76132120;
	Tue, 22 Oct 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRqN0HUQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A636124
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583270; cv=none; b=IwHoaDJQNw/CtjB/ZO/h3t2t0VmvfyDOcMQXKna89uSa04jw0EWeC+ER2OXs9TPGrQrsNu87GZzYictfzasEs+mZSh2F/ji+XsAtq2B9n44qhTPBqUmwokvOFBLWgB/ibWN6LlGiOVsw1dkUOLMixGa/FV32hR7Dg90Z6RdaP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583270; c=relaxed/simple;
	bh=vwZg68piq+RdXI+ln/yjAtHFs9GxcvyPWjuI7Z35WMg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=blLIvsL5Dl3mCvbyC9mB/pg6fBL1O40TAef048+kauWLTKK+OUwFAaaotH+E5FvfkxCLGjiAxq5Uyjbc4iD4DDRvK0D9OR+hSD5WXTTrjwT5Xjwg03UHErvklbUSgXbOsTDwARCbt84rfwVVHH0nOv/nzBfuNsoOHPRpdfobFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRqN0HUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89618C4CEC3;
	Tue, 22 Oct 2024 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583269;
	bh=vwZg68piq+RdXI+ln/yjAtHFs9GxcvyPWjuI7Z35WMg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HRqN0HUQ1y3vLl+a029aCvPbsTEHrsWAai8jOhMqObEDJTfw/WjEwmvo7gejz7mb8
	 P9z7ZXyQzUkRTtLLLrSyD0Dpjef0nt1qiAdWSA0IODw60+dbOEx9l+bCWHYgMOawAu
	 w7FAMA/x0+IkaJGnEM/blkkaAxLSxUplzrw2RuJEwkNI+agqTU3qHFHMIcZZsfx51P
	 A5Z2xefr1fSC3ObS3Wr43NI7hMee07MP68YG4xjD8SmnHMHHjgK5XdSxPGRgf3yGq3
	 fJC1F7jzmBJRKCSURWHZXXQSRmHRO/FBduUqwqYi3VNddo5FdPEaZm4adOHtVuByOC
	 Gj+IyBeAeX56A==
From: Kalle Valo <kvalo@kernel.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: =?utf-8?Q?N=C3=ADcolas?= F. R. A. Prado <nfraprado@collabora.com>,
  Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,  Felix Fietkau <nbd@nbd.name>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: do not increase mcu skb refcount if retry
 is not supported
References: <20240917110942.22077-1-nbd@nbd.name>
	<1d673f56-0bd8-4a55-8805-4e30c38cc36f@collabora.com>
Date: Tue, 22 Oct 2024 10:47:46 +0300
In-Reply-To: <1d673f56-0bd8-4a55-8805-4e30c38cc36f@collabora.com> (Muhammad
	Usama Anjum's message of "Tue, 22 Oct 2024 11:48:43 +0500")
Message-ID: <87h694o9y5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Muhammad Usama Anjum <Usama.Anjum@collabora.com> writes:

> On 9/17/24 4:09 PM, Felix Fietkau wrote:
>
>> If mcu_skb_prepare_msg is not implemented, incrementing skb refcount doe=
s not
>> work for mcu message retry. In some cases (e.g. on SDIO), shared skbs ca=
n trigger
>> a BUG_ON, crashing the system.
>> Fix this by only incrementing refcount if retry is actually supported.
>>=20
>> Fixes: 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages")
>> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> #Kern=
elCI
>> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mcu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wire=
less/mediatek/mt76/mcu.c
>> index 98da82b74094..3353012e8542 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mcu.c
>> @@ -84,13 +84,16 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *d=
ev, struct sk_buff *skb,
>>  	mutex_lock(&dev->mcu.mutex);
>>=20=20
>>  	if (dev->mcu_ops->mcu_skb_prepare_msg) {
>> +		orig_skb =3D skb;
>>  		ret =3D dev->mcu_ops->mcu_skb_prepare_msg(dev, skb, cmd, &seq);
>>  		if (ret < 0)
>>  			goto out;
>>  	}
>>=20=20
>>  retry:
>> -	orig_skb =3D skb_get(skb);
>> +	/* orig skb might be needed for retry, mcu_skb_send_msg consumes it */
>> +	if (orig_skb)
>> +		skb_get(orig_skb);
>>  	ret =3D dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
>>  	if (ret < 0)
>>  		goto out;
>> @@ -105,7 +108,7 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *d=
ev, struct sk_buff *skb,
>>  	do {
>>  		skb =3D mt76_mcu_get_response(dev, expires);
>>  		if (!skb && !test_bit(MT76_MCU_RESET, &dev->phy.state) &&
>> -		    retry++ < dev->mcu_ops->max_retry) {
>> +		    orig_skb && retry++ < dev->mcu_ops->max_retry) {
>>  			dev_err(dev->dev, "Retry message %08x (seq %d)\n",
>>  				cmd, seq);
>>  			skb =3D orig_skb;
> This patch is in next from 5 weeks. As 3688c18b65ae ("wifi: mt76: mt7915:=
 retry mcu messages") is
> already in the mainline, why this fix hasn't been included in mainline? I=
 thought fixes are included
> as soon as possible in mainline RCs. Am I missing something?=20
>
> Are we planning to include this fix in next release instead of current on=
e?

The commit is now in wireless tree:

34b695481084 wifi: mt76: do not increase mcu skb refcount if retry is not s=
upported

With good luck it will be in v6.12-rc5 but no guarantees.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

