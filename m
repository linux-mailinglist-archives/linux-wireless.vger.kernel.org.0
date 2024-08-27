Return-Path: <linux-wireless+bounces-12097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C899617ED
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 21:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D771F2463A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA881AD2;
	Tue, 27 Aug 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ammnqpY1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4F77117
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786732; cv=none; b=WtpHES53ryiYes8sTucA6ro8snXVARa/3xWEQkzUepbJkizZw92MwJAj6rLeo4NStayZL5Zl6yCnFntUpcCz3jwNy594yFO4tZoE2KUf4pc0zGTvHe4Mw+W6X+ffvFrog13Yr2dWXCwEj01qx4y2fDgu/ZerN+h4R4VYNXMbnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786732; c=relaxed/simple;
	bh=mxj3TsiD3sfGe1HxG9X61aMNFlQRwWdk1FPkE3ozNRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r99IMe76hj9HKEXoa/tXJRePXvwyx1xg092Y34oEbztvhz2oM7Vf6iwTD+E/b//rXC7C33pLXyTRAeUO6tki2j6iSXXSJn7Mgzcdde0hCnr/4kb//wC52GX9GGBJwOkBuJHGEDA0de6WZ6sRA6Zh2HQr5oazpv8u2ZHD1lQd4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ammnqpY1; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id izY6stvUtiA19j1onsZHno; Tue, 27 Aug 2024 19:25:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id j1oms5sqeeieBj1omsigFr; Tue, 27 Aug 2024 19:25:29 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=66ce2829
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=7T7KSl7uo7wA:10
 a=cOUt0ba47Qy8L9BmtKEA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8xv0a0awLlFOIkKNP/kzkxKfLITwaLOKFUsw8WiXk2g=; b=ammnqpY1D4Owcnx6/x/0fKQl3z
	7ey4Dk0JjmBBUf3iMqKG1AjhOGV9Q6BR9lu0KFd0LHGk1GCExI8+7flSdIN8PVDazZFlfL47sWmYM
	HskIlwXw3sY/HvI3yro9Ia4jUePAnX6NFROAQ+8ExP4JNM5cLGxDSgZQEvZvn91o7Zb5Hc+h0FLTT
	X59UJpc1rbekPNHi87hUFmTRISxJxIpc74DcH3ODhIbgCihrIhFeN2O0TLRjB2zjFSk1G+xBb6wuW
	yy6JcAUFH488J1PQ92CbQvoo7e6YT/lztzWWYDEDuDjIlM1k4NiQ/9Jldm1ijBi0b6Uwtv6RJhDL3
	L+V6ONQQ==;
Received: from [201.172.173.139] (port=55200 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sj1ok-002mCT-2O;
	Tue, 27 Aug 2024 14:25:26 -0500
Message-ID: <37a70b40-0952-4a87-b583-8915a2206a11@embeddedor.com>
Date: Tue, 27 Aug 2024 13:25:22 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: radiotap: Avoid
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo
 <kvalo@kernel.org>, Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 libertas-dev@lists.infradead.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZrJmjM4izqDqwIrc@cute>
 <6ae3908c182664496784b1f1a86dd5bfd72fbc62.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <6ae3908c182664496784b1f1a86dd5bfd72fbc62.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sj1ok-002mCT-2O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:55200
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB7ODZDbVf1LD9XusyB9nsOJei9okBsrv9YYLk8F8d3WTg3juZmKSh3SNmPP9zbznf9LkO+kCVbs2a26+SmcsnY8gISXuisXPmJXd/W767LL0JqzC5f+
 e9qX+toQvh8i1IAvcYbhixrft4w8GI0ghTh8W7cKQHr42GB/YyeJA1Wy+dGyIaC/ZfksXBLMKKxYZVw/lVoE223XQ08J8gOyOPfFJbRV1RRxc3ndZzovIj4U



On 27/08/24 02:22, Johannes Berg wrote:
> On Tue, 2024-08-06 at 12:08 -0600, Gustavo A. R. Silva wrote:
>>
>> +++ b/include/net/ieee80211_radiotap.h
>> @@ -24,31 +24,36 @@
>>    * struct ieee80211_radiotap_header - base radiotap header
>>    */
>>   struct ieee80211_radiotap_header {
>> -	/**
>> -	 * @it_version: radiotap version, always 0
>> -	 */
>> -	uint8_t it_version;
>> -
>> -	/**
>> -	 * @it_pad: padding (or alignment)
>> -	 */
>> -	uint8_t it_pad;
>> -
>> -	/**
>> -	 * @it_len: overall radiotap header length
>> -	 */
>> -	__le16 it_len;
>> -
>> -	/**
>> -	 * @it_present: (first) present word
>> -	 */
>> -	__le32 it_present;
>> +	/* New members MUST be added within the __struct_group() macro below. */
> 
> There cannot be new members without breaking interop with the radiotap
> spec, that comment isn't really useful ;-)

Ah yes; the comment is not meant to be an invitation to add members to
the struct just for the sake of it. It's there to indicate where they
should be added if needed.

> 
>> +	__struct_group(ieee80211_radiotap_header_hdr, hdr, __packed,
> 
> And also, "header header" sounds odd to me really. The header of the
> header? What's what?
> 
> I think perhaps better to call this ieee80211_radiotap_hdr_fixed or so?

Sounds good to me. :)

Thanks for the feedback!
--
Gustavo


