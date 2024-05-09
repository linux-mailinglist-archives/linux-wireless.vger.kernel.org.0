Return-Path: <linux-wireless+bounces-7393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84C8C106E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B89A1F23F34
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9FF15279B;
	Thu,  9 May 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfzGkExN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4B14A62A
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261596; cv=none; b=EZySKcrLUzEyu0WrQZUebyKRxqeMcuae2MJzVfcNlZ5ais+MMf5ldG6jqCqTr9Zj6yWz13lJn6QfMHnEcVOxtN7F9wFYTTPSOlCYJQs1lIAcSIHnKGYiL/c+uMPmcf62a5/SndD+xzIIc9193epk1O8P4K5T+C4wGQDlxPW+0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261596; c=relaxed/simple;
	bh=yW4/8AJULUNNk+ruSXFX821aWYkFjPWrJpItbCfXUzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4zdLaeFhJbjMcYsZ0+Ow1zXDq4MlU0+cqOvdyNRc4ZkZpszLjjlkWhyfyhdjtJxvA/UdL1aatyglyxLND88Vk0CYbkX7RZ/IMR/W7+xI5lFObU32PyG/pb6K82IvX74AhiFwvqqjgirg7om3SAW9WH965NqJ5dARnAqBiTDHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfzGkExN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso217276166b.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2024 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715261593; x=1715866393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzazCux0S+tRRPtkB85kvGu4bpBvnpgsVg9tAd8QnZQ=;
        b=HfzGkExNv3D7tS6WA4rYICAt6nUv6UUAjFzvEK8Knf62dd0yqyiLO9UIUENFYYrJrB
         Nuc1w0N9zyy5DtTy53g9Y9pyegxqHerUg7bCPhC8Ls+37HwCRXVmYwbFgBGMGT3CQ2cp
         M/U39l06ciZWBi/r0TwELbLDGQYEHiK8yxUrOAnQGby2VjoLALnn2ITk9t8JqolK1t3U
         zRKLf6gL1bMWFEycAdjv86Bl4KcWQzlnyogB9103aIjDbfSVoX+HFYHbWRlFegPU/b1H
         LfgdIphEeL4rOTYiVLDGz3SDefw3h9kyFUW4+eKyBuF+wgqg6iwckX4YK5PBPrYC4X5P
         jkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261593; x=1715866393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzazCux0S+tRRPtkB85kvGu4bpBvnpgsVg9tAd8QnZQ=;
        b=pGZFAPkpFUfJOYTfexdZNWV6UxXdcfrRiYV4B1uBP+xS8BrKD2+1n/KxF3GVt8F0Sx
         zlj0Yu3NjETkrG97VPWhxKtDk1pDAB4SrW+ziNuEYEDwcgipFq+9EHxxqeaGtLxZHq2v
         EVOEeyAtUfKvvnZKPPNvAPHQ0y6TlG97o7smC6tV7ecNeXCt6hltcyPZcT2N7lKPuP1e
         8QmphxlER63MS31jFoIxwuYite6FIzKcKonUhIiDXZoI30yqdKmmrvft8rVG+sKiZZE+
         Pszhiy19AUoLq8XxxWec3jOwAukSJYs38uiNyi3TMNu+WnZSpf/TynKNW6kb3CXeILbR
         vAqg==
X-Gm-Message-State: AOJu0YzxdMH2yG6oyufetEbmKNpyFzHCpq6jo223a5shkCRzSM4Vq+N4
	tTfr94nExKMfO7W+JWzF0F4uJ6hy07npmljSvujMClehT9PWmPz6g5x/SpucKaN0GFeqcqy/JQD
	E
X-Google-Smtp-Source: AGHT+IFENIkDZGg8UsXbzWDnpe3oEn3lTZc2Jp+9esjUznuy21c4U2I3S0uEvTjuANW5/8fpb+VbYQ==
X-Received: by 2002:a17:906:ad6:b0:a58:ea85:9114 with SMTP id a640c23a62f3a-a59fb9d959fmr379910066b.50.1715261593295;
        Thu, 09 May 2024 06:33:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm74962066b.31.2024.05.09.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:33:13 -0700 (PDT)
Date: Thu, 9 May 2024 16:33:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: alexis.lothore@bootlin.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: [bug report] wifi: wilc1000: convert list management to RCU
Message-ID: <eab04ab6-752a-41ac-9fcb-0e4e14687de1@moroto.mountain>
References: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>

A related warning is:

drivers/net/wireless/microchip/wilc1000/wlan.c:237
wilc_wlan_txq_filter_dup_tcp_ack() warn: sleeping in atomic context

drivers/net/wireless/microchip/wilc1000/wlan.c
   726          rcu_read_lock();
                ^^^^^^^^^^^^^^^
Disables preemption.

   727          wilc_for_each_vif(wilc, vif)
   728                  wilc_wlan_txq_filter_dup_tcp_ack(vif->ndev);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sleeps.

   729          rcu_read_unlock();

regards,
dan carpenter


