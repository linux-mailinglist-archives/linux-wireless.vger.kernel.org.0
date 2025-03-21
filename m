Return-Path: <linux-wireless+bounces-20668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C603A6BD00
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D82D189BCF3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36715530C;
	Fri, 21 Mar 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtuBaVk5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED48F6B
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567607; cv=none; b=bgKmqy54skFMDtCILZMdTju5BECT3iJTxYSHdGcw8Smkv7kXwo3/HEQx3lVBWfMsyUjc/nRCT+dZA4hTbUmzSP+KVCDMEqZsZahq3REnjGttz92lMRdjRV00Np4ZPrBztLU/0HFT9jWgPjB/aT59ZNMrw2iJUhaUwZbCJ4T7dZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567607; c=relaxed/simple;
	bh=UzuMyhJ9TUUzDWVFFoVxDSg/s6WUbD6J822qNIvZb8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnqhSTr1E3e21ZgSpf5+X8Okkhnwb92Al8KXLWsO2d4MbSMi5D1z5FZy6W2+yhCI6cTkdRkSY0Uzge3FIulNWJKRWhCo/1GTzrxca+R3npWuNStG1omdo7TxOzve5Zb8Pr8U0l0z5EMRhLKkBK4NoIGtbWbwSegxBLswmC2JP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KtuBaVk5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-399737f4fa4so1284099f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567604; x=1743172404; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCM/0pxY2Et0ZhXNOx5M/rBqqFuiIGPsmpAIcE+cA+0=;
        b=KtuBaVk5GkAf42594HV56NpOewRTtZsrI3veLgwcBzIcLDjxVsimUJhwTuEI4fxN84
         iiUzyC3Heuot2Q/urc+sPMJdZ8Btpo/7Aogmsg+z98rWXGFetkYvDQ6c350nxCgo5Cyu
         rSQFzCutjrBfYiUz+QQewcmR5ljVBUYGrs5d61dTNYGdaLxyYi4eO/90cBT6GflLu9jy
         1BBPe+wmvv6/VxWxj5cYIlji4rCxfkx2uomM8b6/R6jfQNQpmUTGH3NnqMlvbVzNeHRu
         ZRBftu//3ROT4T+jJln5TJIfg6WZEHvPbMdXqaI+45mJY/NQN54tEfweODkjr9sJaquK
         qg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567604; x=1743172404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCM/0pxY2Et0ZhXNOx5M/rBqqFuiIGPsmpAIcE+cA+0=;
        b=rIAYdnCQjJOdyHPXx+qqiZ6JJngEdEXYuo/ijzRDxzqN8MBLnNYu7PagJ7ye0OykkO
         W4yuJe0dWgFLFkX+t9M4f5qh5LHwctuMU6h46rx/jgHYtzD7xf8uzlXFxl4FFKjIPmQN
         GmKn0Jkt9fG0CjrxPDKAjCU5WendTSe9cmfF2IDBQ3DXtymoRdcSMo2ip7nu4QPA9oHr
         A2EFseOyqTJdTNyowmM3vFqGg9P/2xp6ZDcB10mpoEDsoZy4bdKRj4b402qqE3pq/zvY
         qwO3TEXlDfzsqxq4mqYfpIT+oldOEvi5VXY8U/XUbjfiDlEJAkzY/QHCxjGgHTufLZYG
         hRgg==
X-Gm-Message-State: AOJu0Yw0OCviDNfqLSMpDfci5s2pSI5749wqVdOo4w8EwFSnLliCf0kJ
	nhrUTM617zeeSBeGR/sjfJbbz4a53J9KUyidxK4291meAowT3sFq+PmedirWcYLdx+acb88pbBI
	o
X-Gm-Gg: ASbGncsG2KJDO2tZpRFGz3zyHZWqwFOwQ0YEnhYucWdcOEZEMwZLE4nLz6UI/dNY2PX
	szTK1CX86T/3kWmU97KhpLJG1WFfh/sD1KDa5I2v+L9lf65WroP3zoYDwSocRoWe8FRYY3QmC0g
	zxYx9THoDBS9f2W08Km/F2oCkIeM4o2Nsit7xeCSxXWI8CnzwClLhEEjHKhL0n+Sb0qRpAzueeE
	fUbo9gW8Euc/IarZDb6aq0TqbT8b28WiIs9LX5EC5gBc24zwi4QAnZSa7vpN2r1EDkOydpdbYR7
	voSYyrUY+v43Kba8/OkqmB8efq7WNtb28A0fRzZ0lG93RD/Tew==
X-Google-Smtp-Source: AGHT+IGWV/p7m8S7xqGZKFR3zF2W6QjG0ha40UpvzvNsYp/rwN5LamAAHEDfsFE/TVOy2+owapxVnQ==
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-3997f902e3dmr3289351f8f.12.1742567604149;
        Fri, 21 Mar 2025 07:33:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9efd61sm2542776f8f.91.2025.03.21.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:33:23 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:33:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: scan: set vif offchannel link for
 scanning/roc
Message-ID: <2f5c3a3c-89d9-407a-b163-4b5cc81da319@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Felix Fietkau,

This is a semi-automatic email about new static checker warnings.

Commit 3ba20af886d1 ("wifi: mt76: scan: set vif offchannel link for
scanning/roc") from Mar 11, 2025, leads to the following Smatch
complaint:

    drivers/net/wireless/mediatek/mt76/channel.c:307 mt76_put_vif_phy_link()
    warn: variable dereferenced before IS_ERR check 'mlink' (see line 305)

drivers/net/wireless/mediatek/mt76/channel.c
   304		struct mt76_dev *dev = phy->dev;
   305		struct mt76_vif_data *mvif = mlink->mvif;
                                             ^^^^^^^^^^^
The patch adds a dereference

   306	
   307		if (IS_ERR_OR_NULL(mlink) || !mlink->offchannel)
                                   ^^^^^
Checked too late.

   308			return;
   309	

regards,
dan carpenter

