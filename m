Return-Path: <linux-wireless+bounces-13313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1FC989C40
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002C7B21192
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD017E473;
	Mon, 30 Sep 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FppoJLcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657E17CA1B
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683790; cv=none; b=cdRpC3KAw3rbDHKolN5f4cjWlCFjKDh+MpMdLhXf8rXJ8wwPI0fh7J5VUCkJXm9Y5i9UxgpuzvLghxSl7edGhC6tsBpsj45dcdUB2sID45QqlrZs1ZaJgiYaHmKgVP+1FEcurT3hbRi6lsSQwr8oE7BJvTlcjnJsvB7g7PWpPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683790; c=relaxed/simple;
	bh=Xx414iMLuxALXKs+wO5vcFTmabes1w6H5Py+TNbMyPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ9Vd96RjmotMqvvimNO9Y8zyHmUpGmKGtB3l3SN7eIkw/fQNWE/aUVca+DBFbdeAq5Yv/utWUI10ZB2Ev3hgh0XgbD2g6TMwv5PCY0sPuGqTHCr6gdlya3AqgCYKnjz/33vZbrAYWh00n9XCUirVw8S/g2l7CGb5djkzi7RUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FppoJLcG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b0b2528d8so44438785ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 01:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727683788; x=1728288588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx414iMLuxALXKs+wO5vcFTmabes1w6H5Py+TNbMyPA=;
        b=FppoJLcGOoI00AZ8pk9Ew/JK7dacaHMNbFXsnQuvxKaTWAS4DWz6DYUvNIajVaMwkT
         BwuQZ72IQytY6qRdTdi7DkcUAKE00W2hO3p9egE6Nro5PVyblOOngJpJEYgDH45549ne
         FpqUzX3K08jJsk5rCS+BYKSujmu0Q8R2aANZjHQip3L+M3QzflD7YbogkinBLZwIiAo4
         7KygE21g69FoDG4l2C6CANX0u4jMyu+A4pKRM1SXDWJXjgZJPjR2TOklOhnrImObQf+/
         UBKKkiFPxagJJC/IFUIExb2wel5xY7CvRmaBH2+d0LxJ2hJf8qsTl3oS7ED70GQNCiF2
         Ql/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727683788; x=1728288588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xx414iMLuxALXKs+wO5vcFTmabes1w6H5Py+TNbMyPA=;
        b=QuBxAW2zBSAaDWVwQNwpHRm0a46w9FebSW3pxKu8EKdtkjohkgAjhwmVk2XIirR9er
         qVtMWwJFQl7bHrthVhmeGJs2yYZpR+GeV2pdsJCC050lKc0vkw2XGSQyQ4BEdSQcQPgC
         V5Bvf9OHwMuQFwLs4ZhQl/7n8XVTWQHZZyfBRDSo+LS6mTAJvPjq4//SwjX/TjAqdIiz
         yw3yGs6tVy5Yc/PHJL74sim61aSf9fwpt3KW/eAieukhG4fpMZZI6YZIeqkIQZf5KUSz
         oKlePMHR2FumqFgU1SWiUMVwoi770QisKy6lja8Th5VgQLyJv0GLJimb3PD4vYinasQ5
         3NbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3UolzduSC6hRcyf8UstyAkIlqYh4SRu9g1qeaZgfUOcBJ8Do1uULaXbIyfRG+6j8ULaJdhbmfqi8L0DpGqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXKgyPzaeOrPEyPbPKIvkWf6/VozyBBw2t8Um4U+4cew8Ufvy
	HDX08cE+9YpdXftSHz2JEmZqmna4DuYFrRF9A/EKw7jg38C3IZldiUCW0rcuiS85oJgEuYycXAD
	Fyn2rvQIQO/ZNKH0VF8qYheXNeL2RuPl/TPnKRA==
X-Google-Smtp-Source: AGHT+IHL79vWrV1UbQW2i+UC3FcnuUEn4RoHxDXgrgsEhFXFX4vbKat3GD+mMJkdcENWj5dVp6Y7ppyyQzgjgk1yEE8=
X-Received: by 2002:a17:902:ce91:b0:20b:6d8c:461 with SMTP id
 d9443c01a7336-20b6d8c0791mr75062715ad.5.1727683788157; Mon, 30 Sep 2024
 01:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com> <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com> <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
 <934d601f-be43-4e04-b126-dc86890a4bfa@huawei.com> <CAC_iWjL7m4ZL2W2OZM5F22dLvZhxU6fyCXV_xjyGf+W7UP43EQ@mail.gmail.com>
 <ac2eec69-8f44-4adb-8182-02c78625851d@huawei.com>
In-Reply-To: <ac2eec69-8f44-4adb-8182-02c78625851d@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Sep 2024 11:09:11 +0300
Message-ID: <CAC_iWj+Shb6buVf+wZaWe-NZ+UVxmW9DYqsTiL27U+V_Ko_65w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 05:44, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/28 15:34, Ilias Apalodimas wrote:
>
> ...
>
> >
> > Yes, that wasn't very clear indeed, apologies for any confusion. I was
> > trying to ask on a linked list that only lives in struct page_pool.
> > But I now realize this was a bad idea since the lookup would be way
> > slower.
> >
> >> If I understand question correctly, the single/doubly linked list
> >> is more costly than array as the page_pool case as my understanding.
> >>
> >> For single linked list, it doesn't allow deleting a specific entry but
> >> only support deleting the first entry and all the entries. It does support
> >> lockless operation using llist, but have limitation as below:
> >> https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/llist.h#L13
> >>
> >> For doubly linked list, it needs two pointer to support deleting a specific
> >> entry and it does not support lockless operation.
> >
> > I didn't look at the patch too carefully at first. Looking a bit
> > closer now, the array is indeed better, since the lookup is faster.
> > You just need the stored index in struct page to find the page we need
> > to unmap. Do you remember if we can reduce the atomic pp_ref_count to
> > 32bits? If so we can reuse that space for the index. Looking at it
>
> For 64 bits system, yes, we can reuse that.
> But for 32 bits system, we may have only 16 bits for each of them, and it
> seems that there is no atomic operation for variable that is less than 32
> bits.
>
> > requires a bit more work in netmem, but that's mostly swapping all the
> > atomic64 calls to atomic ones.
> >
> >>
> >> For pool->items, as the alloc side is protected by NAPI context, and the
> >> free side use item->pp_idx to ensure there is only one producer for each
> >> item, which means for each item in pool->items, there is only one consumer
> >> and one producer, which seems much like the case when the page is not
> >> recyclable in __page_pool_put_page, we don't need a lock protection when
> >> calling page_pool_return_page(), the 'struct page' is also one consumer
> >> and one producer as the pool->items[item->pp_idx] does:
> >> https://elixir.bootlin.com/linux/v6.7-rc8/source/net/core/page_pool.c#L645
> >>
> >> We only need a lock protection when page_pool_destroy() is called to
> >> check if there is inflight page to be unmapped as a consumer, and the
> >> __page_pool_put_page() may also called to unmapped the inflight page as
> >> another consumer,
> >
> > Thanks for the explanation. On the locking side, page_pool_destroy is
> > called once from the driver and then it's either the workqueue for
> > inflight packets or an SKB that got freed and tried to recycle right?
> > But do we still need to do all the unmapping etc from the delayed
> > work? Since the new function will unmap all packets in
> > page_pool_destroy, we can just skip unmapping when the delayed work
> > runs
>
> Yes, the pool->dma_map is clear in page_pool_item_uninit() after it does
> the unmapping for all inflight pages with the protection of pool->destroy_lock,
> so that the unmapping is skipped in page_pool_return_page() when those inflight
> pages are returned back to page_pool.

Ah yes, the entire destruction path is protected which seems correct.
Instead of that WARN_ONCE in page_pool_item_uninit() can we instead
check the number of inflight packets vs what we just unmapped? IOW
check 'mask' against what page_pool_inflight() gives you and warn if
those aren't equal.


Thanks
/Ilias
>
> >

