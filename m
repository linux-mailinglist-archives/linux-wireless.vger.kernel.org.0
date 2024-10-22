Return-Path: <linux-wireless+bounces-14338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139D69AB516
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6103CB23037
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE641BBBC3;
	Tue, 22 Oct 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SyhXsfpM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C21EB48
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618251; cv=none; b=GXbJes5mo6g2bhr4Cd8TDvCgkTDaRxv1L8312Vx6tA4Ph8fuM0RHceF1uYQEKNFZEoIFYGWb6MDrPJgWaGzib15AnYnOx5R5bo9APuEOsdp1u5Xfa2HTtcDdpgh214vR8ZzVM+KgBSNXqBbZ/vcDgvDpBPj21+0jhXH9T7ofBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618251; c=relaxed/simple;
	bh=8GUnW0klfLk4CvdCGeRjaYnUhFPegexZt+M3RWhjR1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmK+X/JMsdjod1DVO4w3R+Q8N6FmHpTmVP24bF5UdhI9dTlF9OHUK5A3SaDRlKLVywlwEzT1Bl9xJk3hq8NL7oCpkFElr0Qmdi7m4K3j4Rrv04/5dv4BwCGDOF8q3nx2ZTtEFOx2820TVf6uVYFAyaXH7Bkh130JVqFpKmgXRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=SyhXsfpM; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id 3IIot5u0eumtX3IiQtN6KM; Tue, 22 Oct 2024 17:30:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 3IiMtjBovHNNp3IiNtAwld; Tue, 22 Oct 2024 17:30:39 +0000
X-Authority-Analysis: v=2.4 cv=OK8h3zaB c=1 sm=1 tr=0 ts=6717e13f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=mDV3o1hIAAAA:8 a=1M5SEvRStrY57UaG3sYA:9 a=QEXdDO2ut3YA:10 a=SS-iHM-wgvsA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rVIHG0XmA4f4VSAeMysoNLiGdGii26ZP6xLyaTfZXZ0=; b=SyhXsfpMsrRwSnWbESjHwRXAF/
	KZcjBwyvOV4yb56hqbhhAnejgGQ5NLdbLdfJPCxJHP2oJTvmMHdl64yB5UebGwJjJLPTV5gRmuXTf
	OFq2gnQnYmoLGG5B3kvMFTi2BtsqvfgTpeGwzKYtswLcm5Gdr2atCbLw5FZFaWt7XwzoRM/kXjffN
	X1kpHQ7AB+DNAWy9yi4NvlnycyngOJTTyLPy09ZR0Y89FuJHIolLrX3l70AoX/4JpSUwLJHSGNxi+
	HMWBA8vKkjKeNpS1zV3GwNR8i/f/gPhvP6uU30o5YFGrEXIe6JZb8eV6we+y+PuyIKCp8FTmpMg5x
	LVXgNpaw==;
Received: from [201.172.173.7] (port=32812 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t3IiJ-001Gog-1s;
	Tue, 22 Oct 2024 12:30:35 -0500
Message-ID: <ce6cd8e7-cd59-4fcd-89d4-b62765add7a9@embeddedor.com>
Date: Tue, 22 Oct 2024 11:30:32 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5][next] net: dev: Introduce struct sockaddr_legacy
To: David Laight <David.Laight@ACULAB.COM>,
 "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Johannes Berg <johannes@sipsolutions.net>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Kees Cook <kees@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
 <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
 <9e6a2efa17b94522ad2274332f608c38@AcuMS.aculab.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <9e6a2efa17b94522ad2274332f608c38@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t3IiJ-001Gog-1s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.7]:32812
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfChntkvucq+hrsMv5vELKcUWh6vGcB/6+UCi4E1YkaFsbxzCjXNtieW9BdWnw2LcbIe/EvhJ2p438vWkJ4WiEROFS/a/sDHrl8aqQ3qR15uwNNgA7dff
 Cpd84dHlUdQO/41ho+tQx8N5AsLXJ/ki7i59ls5S8q3hCP51/0zCza9jz6PARL8MQEaDaXOItrMu/R0b2k+4Ao7i5lq9H2MKyAkvNp/0/FdYjhfnHndrLfYk



On 22/10/24 06:13, David Laight wrote:
> From: Gustavo A. R. Silva
>> Sent: 16 October 2024 01:27
>>
>> We are currently working on enabling the -Wflex-array-member-not-at-end
>> compiler option. This option has helped us detect several objects of
>> the type `struct sockaddr` that appear in the middle of composite
>> structures like `struct rtentry`, `struct compat_rtentry`, and others:
>>
> ...
>>
>> In order to fix the warnings above, we introduce `struct sockaddr_legacy`.
>> The intention is to use it to replace the type of several struct members
>> in the middle of composite structures, currently of type `struct sockaddr`.
>>
>> These middle struct members are currently causing thousands of warnings
>> because `struct sockaddr` contains a flexible-array member, introduced
>> by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
>> struct sockaddr").
>>
>> The new `struct sockaddr_legacy` doesn't include a flexible-array
>> member, making it suitable for use as the type of middle members
>> in composite structs that don't really require the flexible-array
>> member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
>> warnings.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   include/linux/socket.h | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index d18cc47e89bd..f370ae0e6c82 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -40,6 +40,25 @@ struct sockaddr {
>>   	};
>>   };
>>
>> +/*
>> + * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
>> + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
>> + * array in struct sockaddR") due to the fact that "One of the worst offenders
>> + * of "fake flexible arrays" is struct sockaddr". This means that the original
>> + * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
>> + * flexible-array member was introduced.
>> + *
>> + * This caused several flexible-array-in-the-middle issues:
>> + * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
> 
> I'd bet that the code even indexed the array?
> So it is all worse that just a compiler warning/

I haven't found evidence of that, but this is precisely what we want to prevent
from happening. :)

> 
>> + *
>> + * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
>> + * objects of this type do not appear at the end of composite structures.
>> + */
>> +struct sockaddr_legacy {
>> +	sa_family_t	sa_family;	/* address family, AF_xxx	*/
>> +	char 		sa_data[14];	/* 14 bytes of protocol address	*/
>> +};
>> +
> 
> I'm not sure that is a very good name.
> Reading it you don't know when it is 'legacy' from.

Yep, naming is hard sometimes. This is why I added that long comment
above the struct. :)

However, this is changing and now it looks like this:

diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53d2..2e179706bec4d8 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -35,4 +35,32 @@ struct __kernel_sockaddr_storage {
  #define SOCK_TXREHASH_DISABLED	0
  #define SOCK_TXREHASH_ENABLED	1

+typedef __kernel_sa_family_t    sa_family_t;
+
+/*
+ * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
+ * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
+ * array in struct sockaddr") due to the fact that "One of the worst offenders
+ * of "fake flexible arrays" is struct sockaddr". This means that the original
+ * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
+ * flexible-array member was introduced.
+ *
+ * This caused several flexible-array-in-the-middle issues:
+ * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
+ *
+ * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
+ * objects of this type do not appear at the end of composite structures.
+ */
+struct sockaddr_legacy {
+        sa_family_t     sa_family;      /* address family, AF_xxx       */
+        char            sa_data[14];    /* 14 bytes of protocol address */
+};
+
+#ifdef __KERNEL__
+#	define __kernel_sockaddr_legacy		sockaddr_legacy
+#else
+#	define __kernel_sockaddr_legacy		sockaddr
+#endif
+
+
  #endif /* _UAPI_LINUX_SOCKET_H */

https://lore.kernel.org/linux-hardening/202410160942.000495E@keescook/

--
Gustavo

> It's size is clearly that of the original IPv4 sockaddr.
> (I'm not sure there was ever an earlier one.)
> 
> Perhaps 'strict sockaddr_16' would be better?
> Or, looking at the actual failures, sockaddr_ipv4?
> 
> Alternatively revert b5f0de6df6dce and add a new type that has the char[]
> field??
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

