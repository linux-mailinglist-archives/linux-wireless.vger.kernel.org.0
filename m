Return-Path: <linux-wireless+bounces-12925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C797B417
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 20:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F67B1F23082
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0C185956;
	Tue, 17 Sep 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="K+/LpjXw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B613BAFA
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726597314; cv=none; b=Y4kEzSr8Rk+C2MZ3rzfnEZ2Q3mWCsLt9erjGa4XE9IZgIhJu1RziLQ8HB3dkpgOp/FrB5yGqdmZJVawHIqn1P0AJlkFtJRGV6zF5pMyBEcgv8vE4qXZ8cgvpe9vS7FErUPhZtcfpVCjDhloFmnmqeTMXxZJ9Jf0Ggqd0EVVKMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726597314; c=relaxed/simple;
	bh=F/5Uk9BmhUmJeZmONjtDhwhpEWYM+T/oEN+3bs6YFPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6/NqENk8niBVM2+ZDe3qEGYZVONaRAu+vtiHke7yki0BkVVtMDaoMuXVaTxYGJGo159FGsRFMCHi5kcokpuU2PeCZHtvfSx31cUN0mJegEJfPMcr7nQ4K0xseXHKxfkj5rMDiibmBM0iNJTuZNU5pt2EX/MBDHMXJrKF/TUN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=K+/LpjXw; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id qYA5sbyC8g2lzqcpesKVd0; Tue, 17 Sep 2024 18:21:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id qcpcsnYFPLprVqcpdsKAP4; Tue, 17 Sep 2024 18:21:45 +0000
X-Authority-Analysis: v=2.4 cv=JP09sdKb c=1 sm=1 tr=0 ts=66e9c8b9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=McKQfLOCXuPBttKt2ZEA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ef0Hg5MrRNH1tr9n1lG3ogKlKwcjx39jbO/ZsfsDFfc=; b=K+/LpjXwujNIDopPIB3afOgVN4
	yu20Tiv+i55+wj1ViBwPVKqXqmOOqJ1AlQZLrVE8XBedPhuSTdjpY+/hfo4jeTSvsNkZpgnWdEJ+u
	GOTwkP+j0GUqCXGwBliFDAo3sFt4QI3PwCCzY63wi3atlqrW0niWg6wqz8MQrfG19Vz3VJ51QXf+3
	sDu3HNl5e9B74o4qj33mpbpGkJWS8lEePTfSFrEUJJh4Yu+zD6fgupP5TWX4hrJ9smyIb4inBqNK4
	72o4++Y77d5haau87oqk3StJ1MTF4COjxOBri1E4n0VjYVJhsRQZIKizbgRPHPhHRA715fZNhhEt8
	tsfrq2sw==;
Received: from [185.44.53.103] (port=57240 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sqcpb-002rYi-2v;
	Tue, 17 Sep 2024 13:21:44 -0500
Message-ID: <4e926821-de7c-4618-be73-e95965bef3b5@embeddedor.com>
Date: Tue, 17 Sep 2024 20:21:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mwifiex: Fix memcpy() field-spanning write warning
 in mwifiex_config_scan()
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: David Lin <yu-hao.lin@nxp.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Sascha Hauer <s.hauer@pengutronix.de>, Kees Cook <kees@kernel.org>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Johannes Berg <johannes.berg@intel.com>
References: <20240917150938.843879-1-alpernebiyasak@gmail.com>
 <1b2af606-ade7-4550-b1ba-a78202b257e5@quicinc.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <1b2af606-ade7-4550-b1ba-a78202b257e5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sqcpb-002rYi-2v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:57240
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJD2l4xKO7wkH/xLwZ9kxkKhx/G3RqYjYe9aejrrkWnuMj4uKx2W5I1r222OXHtBEHoLCBeO3JInCWL0Amue8DFpVzQqlNL9Y1fuQiRNPKf6MlqcS1NL
 1YMp+udse+F0mVOSowfbjEfozDcU+wjuangNtThCpytOAo2VzcjUGh3zxpJCRO5Jlv22gasaOqPOW8o2gxyzeurUT449bt9bIwFzxVM4IG4eVhX9zRFX2vdb



On 17/09/24 20:10, Jeff Johnson wrote:
> On 9/17/2024 8:08 AM, Alper Nebi Yasak wrote:
>> Replace one-element array with a flexible-array member in `struct
>> mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
>> on a MT8173 Chromebook (mt8173-elm-hana):
>>
>> [  356.775250] ------------[ cut here ]------------
>> [  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
>> [  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]
>>
>> The "(size 6)" above is exactly the length of the SSID of the network
>> this device was connected to. The source of the warning looks like:
>>
>>      ssid_len = user_scan_in->ssid_list[i].ssid_len;
>>      [...]
>>      memcpy(wildcard_ssid_tlv->ssid,
>>             user_scan_in->ssid_list[i].ssid, ssid_len);
>>
>> Also adjust a #define that uses sizeof() on this struct to keep the
>> value same as before.
>>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> ---
>> I found these relevant patches that modify other such arrays, where the
>> second one removes a -1 from some sizeof() calculation:
>>
>> https://lore.kernel.org/lkml/Y9xkECG3uTZ6T1dN@work/T/#u
>> https://lore.kernel.org/lkml/ZsZa5xRcsLq9D+RX@elsanto/T/#u
>>
>> So I think we need the +1 to keep things same. But it appears to work
>> fine without it, so I'm not sure. Maybe it should've had a -1 before
>> that I would remove with this?
> 
> I think the original code was incorrect and was allocating too much memory.
> I do not think WILDCARD_SSID_TLV_MAX_SIZE requires modification.

If this is case, I think the changelog text should include the following
'Fixes' tag (and the `__counted_by` annotation added in a separate patch):

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")

Thanks
--
Gustavo

> 
>>
>>   drivers/net/wireless/marvell/mwifiex/fw.h   | 2 +-
>>   drivers/net/wireless/marvell/mwifiex/scan.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
>> index d03129d5d24e..4a96281792cc 100644
>> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
>> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
>> @@ -875,7 +875,7 @@ struct mwifiex_ietypes_chanstats {
>>   struct mwifiex_ie_types_wildcard_ssid_params {
>>   	struct mwifiex_ie_types_header header;
>>   	u8 max_ssid_length;
>> -	u8 ssid[1];
>> +	u8 ssid[];
>>   } __packed;
>>   
>>   #define TSF_DATA_SIZE            8
>> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
>> index cab889af4c4a..50af78ee935b 100644
>> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
>> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
>> @@ -32,7 +32,7 @@
>>   #define WILDCARD_SSID_TLV_MAX_SIZE  \
>>   	(MWIFIEX_MAX_SSID_LIST_LENGTH *					\
>>   		(sizeof(struct mwifiex_ie_types_wildcard_ssid_params)	\
>> -			+ IEEE80211_MAX_SSID_LEN))
>> +			+ IEEE80211_MAX_SSID_LEN + 1))
>>   
>>   /* Maximum memory needed for a mwifiex_scan_cmd_config with all TLVs at max */
>>   #define MAX_SCAN_CFG_ALLOC (sizeof(struct mwifiex_scan_cmd_config)        \
>>
>> base-commit: 4f3e012d4cfd1d9bf837870c961f462ca9f23ebe
> 

