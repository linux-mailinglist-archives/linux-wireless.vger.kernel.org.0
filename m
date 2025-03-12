Return-Path: <linux-wireless+bounces-20224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D9A5D8DE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E12176FB1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38323816C;
	Wed, 12 Mar 2025 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ERTwtiOC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE623816E;
	Wed, 12 Mar 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770601; cv=none; b=AK/7QnIkxEynZ4tDTjn8tphVD32ssD5sN3DsL5vfFXAtqYNh6e2BX9bhU24uMBoElXs4CF7NRD2NKSUBfnVoRNwAxeo3pCLQv+rsEQ1x0aaV9NXyXUoPVUjV8pk0TJhJngE84+frPo0OxZ+F4wlFAgjDlahTUe8v1pOjYfTrf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770601; c=relaxed/simple;
	bh=9ryUk7DVvq9+6Ap5R4BRHp3am0vLJ/J6X98bl9RNmL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTVdXuWScSmK+PFq8H4WPDrVXxwDrIAi2c07hs3u+Ta/3TFElnJwTWwnHskJx27oRcPhJAHlrircyERa9l9fuRezCm8FyjfI3orTMi1+g4pOz2eMmQqO07oDquot8RZGQGLgusBqtp6o17AMXYX1/pdheZoiWpuUySGQvk3VQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ERTwtiOC; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pHuCru4QHXqB2mgYvDq44oAwbOQyDAtraRq+g+1pboI=; b=ERTwtiOCIj3j9CarcXXRXrdwuP
	EpNIw145j2Xe+T2gXM5n0PMpASp9n12VZF6X7wZBRwaERBwYvVbVsR9AylP1Aex+H35rLaz2abJu6
	O7ri+i6hJ6mSNxxm9XPtGzCwxYKM34GM8SKyaMoKXH03heHl8VdwDcQWSot+mI5p0CNA=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tsI60-00GAxl-2Z;
	Wed, 12 Mar 2025 10:09:48 +0100
Message-ID: <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>
Date: Wed, 12 Mar 2025 10:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
To: Ping-Ke Shih <pkshih@realtek.com>, Shengyu Qu <wiagn233@outlook.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.03.25 02:41, Ping-Ke Shih wrote:
> Shengyu Qu <wiagn233@outlook.com> wrote:
>> 
>> Hi Shih,
>> 
>> Can you also give this patch a review? Seems I also need to convert to
>> reverse Xmas tree order for this patch, will do it in next version.
> 
> Yes. Please do it.
> 
>> 
>> Best regards,
>> Shengyu
>> 
>> 在 2025/2/22 19:38, Shengyu Qu 写道:
>> > The token id in RxDMAD may be incorrect when it is not the last frame
>> > due to WED HW bug. Lookup correct token id by physical address in sdp0.
>> >
>> > Downstream patch link:
>> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/737340322ab22b138fd200e02
>> 0d61ffdbe3e36a9/autobuild/autobuild_5.4_mac80211_release/mt7988_wifi7_mac80211_mlo/package/kernel/mt76
>> /patches/0062-mtk-wifi-mt76-mt7915-wed-find-rx-token-by-physical-a.patch
>> >
>> > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
>> > Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
>> > ---
>> >   drivers/net/wireless/mediatek/mt76/dma.c | 25 +++++++++++++++++++++++-
>> >   1 file changed, 24 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
>> > index 844af16ee551..5bf63014263c 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/dma.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/dma.c
>> > @@ -444,9 +444,32 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
>> >   	mt76_dma_should_drop_buf(drop, ctrl, buf1, desc_info);
>> >
>> >   	if (mt76_queue_is_wed_rx(q)) {
>> > +		u32 id, find = 0;
>> >   		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
>> > -		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
>> > +		struct mt76_txwi_cache *t;
>> > +
>> > +		if (*more) {
> 
> Because of scope, should define 'find' (or 'found'?) as bool here.
> 
>> > +			spin_lock_bh(&dev->rx_token_lock);
>> > +
>> > +			idr_for_each_entry(&dev->rx_token, t, id) {
> 
> idr_find() can only get a pointer associated with the ID. Not sure if it can
> have a reverse way -- get ID from pointer. With sequential search in data path,
> cost is higher.
> 
> Maybe you can consider to build association between argument 'idx' and
> pointer/token by another patch.
> 
> But logic is okay to me.

Adding to that, it matters how frequently the token ID is incorrect. If 
the token ID is correct most of the time, then it's worth optimizing for 
that as the default case. In that case you should avoid the extra idr 
scan if the pointer for the provided token id already matches.

- Felix

