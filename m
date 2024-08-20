Return-Path: <linux-wireless+bounces-11652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57EB95818A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B612821D6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870718A933;
	Tue, 20 Aug 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NPQTC7v7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B3418A928
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144368; cv=none; b=kY4LqO320uR4NE9HQkiQ9dOjYEcTcCiGQPxFtEbVpDXTL/qz762TpwWugSdAf8eGN1VsOzAAKV5r3VDxgaVo16DVdIgQaoZUDg9gIPNeueB/jPxCkIKttHn6qTxvRJQq6M4ISrkgDI9V/Ef3LIZt/Yl+z80zk2yyocGEgL18nqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144368; c=relaxed/simple;
	bh=RjeixHYVLHHf45eXa/OFpm6POVOyDrf2UJ/lLn54E4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzTKleQOET4KZd8gvB0pfETW4qp5KLyI7j1kWro3LSpcXIqSD8Xrg8wZgxn5z/WTpl0dQXSkw58xfkX3w6SzEnseGzcjwrvjpRuVgIkKkHI5rR1kwwiPRNvG/xQAGEG7yKu902rMo5JRu4AqiinME7qwz2gy6cD5MKBlNc86z/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NPQTC7v7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99567c3c-1f45-4a3f-a739-b35f014127b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724144363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=deFt1RItMiAcKZnzOmo0EZwe3WAWajcCcK+fbFD3Z4w=;
	b=NPQTC7v7xZvvAsgOKfBRVGfrY+h0BK8SRZUG3Qqyg/Mrrs2RiEHEsGIX2hjmqzSvvnDyEp
	GFHqYOprrhxyNSc2kgWnJrZn3KdBf2GZp2vlxNjfd/Xw+F/eVOTjGZ7a0HrzhotWNronHD
	/veoxk0i37Ea3CVWE/u9h9Oj+JHVJVc=
Date: Tue, 20 Aug 2024 09:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net/wireless] Question about `cfg80211_conn_scan` func: misuse
 of __counted_by
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <CAPbMC760=5UeaU2wwNZkBMi2ZMVhr2GQgG+VkM8Z7zNbt-FtTA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAPbMC760=5UeaU2wwNZkBMi2ZMVhr2GQgG+VkM8Z7zNbt-FtTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/08/2024 20:19, Haoyu Li wrote:
> Dear Linux Developers for NETWORKING and CFG80211/NL80211,
> 
> We are curious about the use of `struct cfg80211_scan_request *request`
> in function `cfg80211_conn_scan`.
> The definition of `struct cfg80211_scan_request` is at
> https://elixir.bootlin.com/linux/v6.10.6/source/include/net/cfg80211.h#L2675.
> ```
> struct cfg80211_scan_request {
> struct cfg80211_ssid *ssids;
> int n_ssids;
> u32 n_channels;
> const u8 *ie;
> size_t ie_len;
> u16 duration;
> bool duration_mandatory;
> u32 flags;
> 
> u32 rates[NUM_NL80211_BANDS];
> 
> struct wireless_dev *wdev;
> 
> u8 mac_addr[ETH_ALEN] __aligned(2);
> u8 mac_addr_mask[ETH_ALEN] __aligned(2);
> u8 bssid[ETH_ALEN] __aligned(2);
> 
> /* internal */
> struct wiphy *wiphy;
> unsigned long scan_start;
> struct cfg80211_scan_info info;
> bool notified;
> bool no_cck;
> bool scan_6ghz;
> u32 n_6ghz_params;
> struct cfg80211_scan_6ghz_params *scan_6ghz_params;
> s8 tsf_report_link_id;
> 
> /* keep last */
> struct ieee80211_channel *channels[] __counted_by(n_channels);
> };
> ```
> 
> Our question is: The `channels` member of `struct
> cfg80211_scan_request` is annotated
> with "__counted_by", which means the array size is indicated by
> `n_channels`. Only if we set `n_channels` before accessing
> `channels[i]`, the flexible
> member `hws` can be properly bounds-checked at run-time when enabling
> CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE. Or there will be a
> warning from each array access that is prior to the initialization
> because the number of elements is zero.
> 
> In function `cfg80211_conn_scan` at
> https://elixir.bootlin.com/linux/v6.10.6/source/net/wireless/sme.c#L117,
> we think it's needed to relocate `request->n_channels = n_channels` before
> accessing `request->channels[...]`.
> 
> Here is a fix example of a similar situation :
> https://lore.kernel.org/stable/20240613113225.898955993@linuxfoundation.org/.
> 
> Please kindly correct us if we missed any key information. Looking
> forward to your response!

You are quite right that the case when (wdev->conn->params.channel !=
NULL) should initialize n_channels to 1 first.

The other question is if it's legal to take address beyond the end of
array. I'm talking about
request->ssids = (void *)&request->channels[n_channels];
But you can easily check it yourself with pretty simple program.



> Best,
> Haoyu Li


