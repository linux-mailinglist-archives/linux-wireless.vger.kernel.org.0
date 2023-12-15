Return-Path: <linux-wireless+bounces-844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68781814F3B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 18:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CE287DAC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460984653D;
	Fri, 15 Dec 2023 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="crtf2yis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8A46528
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id EAr9rhTRShqFdECJHrHsdo; Fri, 15 Dec 2023 17:49:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ECJGro9zfM0U2ECJGrMsb6; Fri, 15 Dec 2023 17:49:15 +0000
X-Authority-Analysis: v=2.4 cv=BuKOfKb5 c=1 sm=1 tr=0 ts=657c919b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=P7lGutExLh3arObF5LoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C0tnBmLizhtV85bV989C1Q4/ieQl62idw3Pu9c+Cx9M=; b=crtf2yisBKNPe9TrXtivlGknCo
	WiKn9uFrv56/hhXNlXfmZMjUyURv+tU5kiJfMn7gYFcFc7PrIA6ud/a3ORBClxFgxjQfZows+bUqp
	/J5t73FuvX4LTNzvLjTBuQaQDW0F2iqJ6uUIpnkbbzQwmZ7rw39BmoPi/isuBO0uUPzt01qVKfpTW
	neWZTSmtucr4UAF7+hBnjhgqNo5BLuTDViHw+jtg6GsdtAHjYrvK5Za/S2DEBDuGa89nKEzqu3pZ3
	kSq/SxXdHo+aC14hNQ5fJBPwcMJgtrphR7ic+ezCO4b8/APQQdiv7nbwNklAGCAAR1PHnNRgEuWKj
	BTgQfK1Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:45694 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rECJF-004Kas-26;
	Fri, 15 Dec 2023 11:49:13 -0600
Message-ID: <6681b643-464d-44d9-b01a-420e543d19d6@embeddedor.com>
Date: Fri, 15 Dec 2023 11:49:07 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][wireless-next/for-next] wifi: mt76: mt7996: Use
 DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings
To: Kalle Valo <kvalo@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org
References: <ZXiU9ayVCslt3qiI@work>
 <170264697580.1759617.6397953788753678096.kvalo@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <170264697580.1759617.6397953788753678096.kvalo@kernel.org>
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
X-Exim-ID: 1rECJF-004Kas-26
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:45694
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPPYn5i7oD2tQeOziQ//hyPtl8y4XoRT49N3DB/4C1D1as/Lx8ZoNGCsV5JlTxNQC9w3pVk13cuR6zQJmAtGaY1M1PcoGw3t67qfwShDrkeIHzQcxp8/
 4Ploqt6QdJd3QDtVrRh1TOYWbZNhS38PuCADuGvTqLg/wVYszWj4+IRfbzqD53bVgJ5+fs+yWBJE3FRMACFtfSahj7FsrP6sX52Tx0n/jPlnL2ozKk6VzSBI



On 12/15/23 07:29, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>> Transform zero-length arrays `rate`, `adm_stat` and `msdu_cnt` into
>> proper flexible-array members in anonymous union in `struct
>> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
>> helper; and fix multiple -Warray-bounds warnings:

[..]

>>
>> This results in no differences in binary output, helps with the ongoing
>> efforts to globally enable -Warray-bounds.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I'll take this directly wireless-next, ok?
> 

Yep, sounds good.

Thanks!
--
Gustavo

