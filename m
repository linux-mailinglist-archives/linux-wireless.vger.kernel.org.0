Return-Path: <linux-wireless+bounces-947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3158817A14
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 19:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A2E1C22C5B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93472208E;
	Mon, 18 Dec 2023 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="RyMWkbHv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8731D130
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id FHoZrgyiE8HteFIiArGrpA; Mon, 18 Dec 2023 18:51:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id FIi9rs8F78vT0FIi9rfwYk; Mon, 18 Dec 2023 18:51:29 +0000
X-Authority-Analysis: v=2.4 cv=ffi+dmcF c=1 sm=1 tr=0 ts=658094b1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10
 a=jTd5SW5Gb-qoyGWwiloA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I2vzKP2T6q76NVZW+vXwKJElJYF/0lYm8wqIlWtRgs4=; b=RyMWkbHvwwOCs8KxhNvgSj/8Wk
	PJGMXyBhPAhc05rCn1yjh5R2GPCyAbk0vzHjB2Bc8xoJvslkZpizv0l/DrP1fS+AHuJD2BTrglSId
	L3g/oL0YNxv+IlPEmlDpRkbHB6/nS7SI9Syev/e4kc2JgHS7ySs04lJs1syFTD9WETRcjXpmb9VYa
	vhf4Kaq3yhKSVlHLCAP41Kq4tg9Odl3VqO8uUg9tgOX4lXrTTuJIbrUtHEsbvCkdcqcB1lVsCpmP9
	SwX92bVmKt5yx9lp1c8obgm5oST9XR2w2UbfXlZ9HyIWlCt740Y0Q3KLnMfovscGiLMHQHBIRp4lt
	7AmFv9DQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:54118 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rFIi8-003cb1-2v;
	Mon, 18 Dec 2023 12:51:28 -0600
Message-ID: <025cebbe-58e5-48c5-9917-04038ef134fc@embeddedor.com>
Date: Mon, 18 Dec 2023 12:51:27 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
 <170292524618.424292.1640750049894446616.kvalo@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <170292524618.424292.1640750049894446616.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rFIi8-003cb1-2v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:54118
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBhm+eDbUcmLZyhn87QUVX6405CzuO0RRqZ5iFK1EQET2JzwHr+/Nnuzs+K+2orBrFsRxQDs/qdaH5blXx67ePgZERFArXG0V3p5pDdphijJNBT9Lzja
 C1Zbo1QeQmLs8y4ILEI3d/yJ8nYWsFFxZ3gzAHgNKvSYuwVqoCOekSjOY46xJ304Fy7FPXUj64XFsRs+xzHLjsM0ceN5TP1A/g+vRHQ0NFI9q5mAfNGdG1rj


> 6 patches applied to ath-next branch of ath.git, thanks.

Awesome! :)

Thanks
--
Gustavo

