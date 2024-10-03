Return-Path: <linux-wireless+bounces-13483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B00098F710
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 21:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10ED1F210C8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C01A76CF;
	Thu,  3 Oct 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="22piGBiL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5801A727F
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984104; cv=none; b=p/KAiLukLE4wtnNyP2hSOtUH1s5kFKussE6fbJlZ7kigROcJouqvZL6gU4r3jOnDVwMn0B4BaqdtqOp7RwN0Wg483V5mhw4PeYaU3my7FRUYjLCpKmQNHdcFEWIYz0rXCM8LUX6baIyxgiNFHXjBj0rw6sWxICvqylEueG8QI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984104; c=relaxed/simple;
	bh=LLh9ThTIiMVhX/neewuArCL0jkBk9VogBqgvAJOvTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q2UyRswawqgAV/KKgP3yv90vmfHtyu16kE9Gkq1L9NM8chNmdaaq6wxYbtMynWqRBljdeP2RiOTSDempW9RemT6qDUJOim6aKAQ2fe4010PbCfFSjHljhQMMpW0y5vI2rnrhh/RgJ3djMASL62ce7HEpSxxyUYne+fV5cKNzZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=22piGBiL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso13371425e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727984098; x=1728588898; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLh9ThTIiMVhX/neewuArCL0jkBk9VogBqgvAJOvTm0=;
        b=22piGBiLRMrORSy2p8IoyaBzeLIzt13BNohvuGrbiyd291pxhkPDGjgnb/UuWo+YED
         AJc7UAUAEYggoYJVe160cQLbs1gxF0rzW7MsKFHOQ2ROU/1r8Hu4fC9G9urVchhGovpg
         BLfFyRhmktbSjI6X03GfVow2Xt8wDJfv1tTHdEHXb/Pe8nI62fbqTMSxIJ+sqiYTP0lf
         CBvbWjIpjEJLyzvror67WgaWtUsmLe8woLi6fmbV+GUt0PCfphL/Aau58XHf9fTnpbUO
         ypfgIZzcBXW+7STKPpjNFIVsvdWIQ+ZoIW2AuK0RtZVEdQvU9iinTKlsVyxsqnV4EUgE
         sphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984098; x=1728588898;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLh9ThTIiMVhX/neewuArCL0jkBk9VogBqgvAJOvTm0=;
        b=r5Gz3H4u2uCSj1uqQUVDvlMZ/OznvU6QzKuzt9aF1PWq1Jl8xcIk53WdwN5wEcDAR7
         KPmcKD6QDxMhMheqRHeKVcNl/V2mICc+QoxPsQhRZAitrIsT0Z8Ppt7VrM98PPcsfRQ/
         7mBH3YuLamPsWfQl+kiFTdcsY0/u8fmmgRRSGiawTJx2JhLV6nCTvAR/iHXz6s3f04uf
         wnu9SWvhJtQheDunor+lEgRL9yvqYH32w6Wn9dEIBRjWMN/+xYFa80tYj9Le76bVJRiu
         tIEnmHMXcSmn7RnuUk/XYgYOEzULRuH6j4Ad0rQLU2lMjxp2PF2lblyAx8B5co//OtJU
         90Hg==
X-Gm-Message-State: AOJu0Yy3ozk8CFxQWecedDsfoFWtID8Xo2bTcpo3w6Q8VTT0swhFjh2O
	++MrZ202Lcc984QKyrZ2HHy4xlTn9Rng7xqSscNxYjduNFgF1rMA8uSBg+CMuH9uzQ/HlW022h5
	W
X-Google-Smtp-Source: AGHT+IH1HtS9Jw3nAhSN/+wZ02Xwcq8CBSqtMYrzSydEbeDRb8zvfo0ekwV9Sw5BTYxcWZGJVJpvXA==
X-Received: by 2002:a05:600c:3b02:b0:42f:8287:c24d with SMTP id 5b1f17b1804b1-42f85aba0b1mr1095575e9.21.1727984097924;
        Thu, 03 Oct 2024 12:34:57 -0700 (PDT)
Received: from yamato (93-45-8-132.ip100.fastwebnet.it. [93.45.8.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802b2734sm22383555e9.42.2024.10.03.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:34:56 -0700 (PDT)
Date: Thu, 3 Oct 2024 21:34:48 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: Mediatek 7902
Message-ID: <kd5m2zkpnp2hanv2ksre43wegtjxhkffhgkmec2v6pa6inpydj@ciempu4tylgp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

as far as i can see, there is no driver still.
Is there any work in progress for this driver ?

Thanks a lot,
Regards,
Angelo

