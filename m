Return-Path: <linux-wireless+bounces-36973-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FpoXGcaCFmoznAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36973-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:36:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B027D5DF797
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9603034A9E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFE2F8EB6;
	Wed, 27 May 2026 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MDQ+o5rL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C048CFC;
	Wed, 27 May 2026 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860163; cv=none; b=d06hG8K0HR9OtzmowFaKFEMBdFWXHv8xpiIW4r7RwHcnPd28AwP+YX6zerWc1dcX3nvDyT4ty6DDlvamXPbaKNeQLZPGBYQZGMF0nBhQrxU9yR45e/nZHHrSLjKbKXwmo9hFqD8398V94UBFZMYrVr68bVhLVDqJ3BT89YhEpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860163; c=relaxed/simple;
	bh=LeovLlBDFOQntT3OHiWyqofSd8+DXWzcMjiLNYCpiQk=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=WsBZEkFN1enNJy1fyaRjZIZsNqczhwIY9uRKZbaR9KFnqlj/JT2+cfK5MOpEyVpYRPnzJFY6JAbPzq/m2KFliTvRteDMHiSmYWZ/86Pecje0Lth/6K9rwAShWCO5gnlmWKQ6ntSIFkcSWN+wcxSCrzhbXFr8x2E4nhgCJudV3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MDQ+o5rL; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=P/BiXb+f+RdbNY+mkS/FO+sRGrC8T8yS5135DO/Z7kE=;
	b=MDQ+o5rLGPjjxgfsygZLTcJuRBIWE2s2S95pbrHpgnXB/jyHP5tNCtwa4IbwzY
	1hLPdhuGTaCeNIsx0d3ezc5M4NjAGTEvRMJPSvr36bsPtYbV5p7XzJI0XNx5qFsX
	ZNpakpB4WVGfQHd+SIKHqxssICMwkDVQSUzjH19EjjJTQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnT_OLghZqhX4uAA--.38309S2;
	Wed, 27 May 2026 13:35:08 +0800 (CST)
Message-ID: <6A168290.1030507@126.com>
Date: Wed, 27 May 2026 13:35:12 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Sean Wang <sean.wang@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
 shayne.chen@mediatek.com, sean.wang@mediatek.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 xiong.huang@mediatek.com, madhurkumar004@gmail.com, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix resource leak in probe error
 path
References: <20260527034350.527482-1-zenghongling@kylinos.cn> <CAGp9LzruaD57tE5XHHAM8mKoPc-JQSAcaTdgvdSfESJjz-9XnA@mail.gmail.com>
In-Reply-To: <CAGp9LzruaD57tE5XHHAM8mKoPc-JQSAcaTdgvdSfESJjz-9XnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnT_OLghZqhX4uAA--.38309S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4UKrW8Xryruw4UJr4DCFg_yoW5CFWUp3
	yrXa4YkFy5Jr47WanxAa1UZFn0vws5Gr1UGrWYvw13ZryfArn7tF4xK3Z0yryFv39Y9FyF
	qF4jvw13Cas0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Hq7UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoQzjtGoWgowLLQAA3u
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36973-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[126.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B027D5DF797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

   Hi Sean,

   Thanks for the review! You're absolutely right about the incorrect 
Fixes: tag.

   Here's v3 with the correct Fixes tags pointing to the actual commits that
   introduced the resource leaks:

   - ee5bb35d2b83 introduced the pcim_iomap_region() direct return
   - 222606f43b58 introduced the devm_kmemdup() direct return

   Thanks again for catching that.

   Regards,
   Hongling


在 2026年05月27日 12:48, Sean Wang 写道:
> Hi,
>
> On Tue, May 26, 2026 at 10:44 PM Hongling Zeng <zenghongling@kylinos.cn> wrote:
>> When pcim_iomap_region() or devm_kmemdup() fail, the code returns
>> directly without cleaning up previously allocated resources:
>>    - mt76_device allocated by mt76_alloc_device()
>>    - pci irq vectors allocated by pci_alloc_irq_vectors()
>> Fix this by jumping to the existing error cleanup path instead of
>> returning directly.
>>
>> To avoid using an uninitialized variable in the error path, move the
>> dev initialization before the error checks.
>>
>> Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>
> The code change itself looks correct, but commit message Fixes: tag is wrong.
>
> It points to 234738ea3390 ("phy: ti-pipe3: move clk initialization to
> a separate function"), which is unrelated to mt76/mt7921.
>
> The two direct-return leaks appear to come from:
>        - ee5bb35d2b83 ("wifi: mt76: mt7921: Replace deprecated PCI
> function") for the pcim_iomap_region() path.
>        - 222606f43b58 ("wifi: mt76: mt7921: handle MT7902 irq_map quirk
> with mutable copy") for the MT7902 devm_kmemdup() path.
>
>> ---
>>   Change in v1
>>     --fix uninitialized variable warning
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> index 7a790ddf43bb..49a37185f056 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>> @@ -343,11 +343,14 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>>
>>          pci_set_drvdata(pdev, mdev);
>>
>> +       dev = container_of(mdev, struct mt792x_dev, mt76);
>> +
>>          regs =  pcim_iomap_region(pdev, 0, pci_name(pdev));
>> -       if (IS_ERR(regs))
>> -               return PTR_ERR(regs);
>> +       if (IS_ERR(regs)) {
>> +               ret = PTR_ERR(regs);
>> +               goto err_free_dev;
>> +       }
>>
>> -       dev = container_of(mdev, struct mt792x_dev, mt76);
>>          dev->fw_features = features;
>>          dev->hif_ops = &mt7921_pcie_ops;
>>          dev->irq_map = &irq_map;
>> @@ -359,8 +362,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>>                  /* MT7902 needs a mutable copy because wm2_complete_mask differs */
>>                  map = devm_kmemdup(&pdev->dev, &irq_map,
>>                                     sizeof(irq_map), GFP_KERNEL);
>> -               if (!map)
>> -                       return -ENOMEM;
>> +               if (!map) {
>> +                       ret = -ENOMEM;
>> +                       goto err_free_dev;
>> +               }
>>
>>                  map->rx.wm2_complete_mask = 0;
>>                  dev->irq_map = map;
>> --
>> 2.25.1
>>
>>


