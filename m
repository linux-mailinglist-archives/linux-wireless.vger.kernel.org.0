Return-Path: <linux-wireless+bounces-10210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3C92FC1C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5362B2115E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185F15DBAE;
	Fri, 12 Jul 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/dAtYW3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD571E49F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793081; cv=none; b=V6gvx9FJ0Zy/dZSA6Rlk9gq/ujWSQSAU0qoLkhd0X+8SYvr0mkERM+b2skNj3SCL7RZP4/T0UbldAPVfzhtNLrFYP+GGFgYPLEBuID1TSr5MryN7AzbpS6hxNNxso0N8wTBy/5w3OmD1EGM04xr62BTLWlX5Sfs2KjL0J1qII2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793081; c=relaxed/simple;
	bh=/z1kup74z/KAL2K4RpxF1O1KcoX7gWBp24Lh4Sd8GzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fuuQF74L//sLTg87bueZzHuoN9cdcUaS8jzsZJLgDquSjJyOTwKV6RHCQlNbec28ifZc4xj9QGTAzbwbTQZWlIj1DJYcgC6rbMLZ0OuW80wduKxf89OkTBSEAhQStEusOe1xRXfMHcpI8eQ7E0uQzCvgt5Nex8o8xbAndTIcdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P/dAtYW3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d93df6b54dso1148145b6e.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793079; x=1721397879; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLlhxH3+Ji2HEjydrlnkzHXeZt4wCb4sTexTJRz1Ww0=;
        b=P/dAtYW3BTtDX2iUROWiQBystZSmTI0d4I0Be/a7ke1gb4Cxs7taaIgeE2deZHHKzV
         gPW2mOnoC3Rha2olhYVW8qWQq5gObcSGTUF6Mehe2IOswUneoeZoBXIRMRbOaRYYYDuK
         MVJPf+bm/o7kZgSLKmmgAOAc5dchCxRZAglC3Cnknk9MELLaeMSZH0fhii/VGqZudw7H
         ExRwrZkLvfarKWatc57crliH8oTPj0OD7UfIskw6v1KPi76nlUWT7H7mEeoIcFA2pBFC
         HQL473vV37KOohTzN4SWW9fOFqFvLxh1uuEVfuXsHWmvJOmKQzxux4tC8zfu0RvSQ97C
         2Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793079; x=1721397879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLlhxH3+Ji2HEjydrlnkzHXeZt4wCb4sTexTJRz1Ww0=;
        b=iYyNhJzstHc/GGVu7R8yuCBQXnHvkGBCOiGrZ1nu40c0EQd5Wn7nJJxwH/EJIQ9tQA
         cN+vPIknPE5/xmA5V9jOIedUQZTOdqfxOPidFu/fRFSLRnkzhmo7rsj6BG5ADybozws9
         /PcrhLH198PyAlPE254aseExxHRq+QL2rgQsgKZCsPsIx3how12jqY6HY1AtFVHf8FXF
         L+wORs0V+oZZqfQIKGPYqjw5GVrkQrqCTTHjLt/Ltu9T2/jkmWslvQTi/loxiMWq6qJi
         VAhILgBrlIowfx6P78tpGpMfpQVR9VSGNtCkSZFpQT8c6cla36ZnzhspInC6H23lAXj1
         LP8A==
X-Gm-Message-State: AOJu0YwMUPnAKg4XFB2iai7XpJDCumLODoWT8MAV4zS2OCUk9q3OeyS5
	tMQLa6tpnd1DKEHOEY3Z1y7/gJHakedtJfkC7ruyeB52TL83DIOj1meXNqQ30aE4raRfVjlsOlu
	B
X-Google-Smtp-Source: AGHT+IHAyHbgFusA0JqMizXr4hz22Mq7Vto78JMlziySRmWFFZNkw7rMCquD3uQb4mbqip7KCxcsLA==
X-Received: by 2002:a05:6808:19a8:b0:3d6:317b:a95c with SMTP id 5614622812f47-3d93c07512amr12581496b6e.38.1720793077744;
        Fri, 12 Jul 2024 07:04:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3daae4aa5ccsm125803b6e.53.2024.07.12.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:04:37 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:04:34 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: map entire SKB when sending AMSDUs
Message-ID: <97dc657c-f63d-4fd5-a0b5-eb3685c1188d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Benjamin Berg,

Commit 7f5e3038f029 ("wifi: iwlwifi: map entire SKB when sending
AMSDUs") from Jul 3, 2024 (linux-next), leads to the following Smatch
static checker warning:

	drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1879 iwl_pcie_prep_tso()
	warn: error code type promoted to positive: 'sgt->orig_nents'

drivers/net/wireless/intel/iwlwifi/pcie/tx.c
    1855 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
    1856                                    struct iwl_cmd_meta *cmd_meta,
    1857                                    u8 **hdr, unsigned int hdr_room)
    1858 {
    1859         struct sg_table *sgt;
    1860 
    1861         if (WARN_ON_ONCE(skb_has_frag_list(skb)))
    1862                 return NULL;
    1863 
    1864         *hdr = iwl_pcie_get_page_hdr(trans,
    1865                                      hdr_room + __alignof__(struct sg_table) +
    1866                                      sizeof(struct sg_table) +
    1867                                      (skb_shinfo(skb)->nr_frags + 1) *
    1868                                      sizeof(struct scatterlist),
    1869                                      skb);
    1870         if (!*hdr)
    1871                 return NULL;
    1872 
    1873         sgt = (void *)PTR_ALIGN(*hdr + hdr_room, __alignof__(struct sg_table));
    1874         sgt->sgl = (void *)(sgt + 1);
    1875 
    1876         sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
    1877 
    1878         sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, 0, skb->len);
--> 1879         if (WARN_ON_ONCE(sgt->orig_nents <= 0))

skb_to_sgvec() returns negative error codes but sgt->orig_nents is a u32 so
the error handling doesn't work.  Need to either change the type or add a cast.

    1880                 return NULL;
    1881 
    1882         /* And map the entire SKB */
    1883         if (dma_map_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0) < 0)
    1884                 return NULL;
    1885 
    1886         /* Store non-zero (i.e. valid) offset for unmapping */
    1887         cmd_meta->sg_offset = (unsigned long) sgt & ~PAGE_MASK;
    1888 
    1889         return sgt;
    1890 }

regards,
dan carpenter

