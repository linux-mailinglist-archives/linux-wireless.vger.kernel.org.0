Return-Path: <linux-wireless+bounces-31809-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA3yLnPdjmlSFgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31809-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 09:14:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD7133DC8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77092304C944
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7931A7E2;
	Fri, 13 Feb 2026 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QEYwK3J5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2003a-snip4-6.eps.apple.com [57.103.86.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A831A04D
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970464; cv=none; b=c3AdE8u0CD3sH5DqBZKgYzyKpezJMS8WG5z2Pk5bcoSMaYdneLHn1D3T73rF9+P/2nzGWe6rk19d2PvhT04vnlII8Jm7eQbRZO674eSKbYGmLXHts8mT2S3mEmAoj/TyxH+R1NSD0Q72wl3DAc+SAz5o0EQ7lrnppg/CPwq2R8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970464; c=relaxed/simple;
	bh=q4QAQxr2YWQJgXYt4grNRQPazEg6ovYZJgqFRgCAeaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZAO/vIOanlmM4g8/JpQQBcNGOK2AP2i6Sa+HnnZDlWHirMGzz9mG+fYWj4zflKNTB9Xkq0kakGjgeHeS0XqtVUSLgPYiSR1qWJzycI7brWAHgiiVKYApqxyTELP4E/aqx8lIEzA2wgsW9Z4sljleAmTIaSrceqQ759FvCXtn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QEYwK3J5; arc=none smtp.client-ip=57.103.86.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id 65165180012D;
	Fri, 13 Feb 2026 08:14:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1770970462; x=1773562462; bh=/LARnnhltrteE7RVnXpHilkzn9b2mV9ms4DAA0dwm+8=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=QEYwK3J5+PG38E4fjjtKC+RNUqYX5ZeleS6kXmyErFJGEaH4PiEuGgzOiUOJ1ayj5ghkydoV8xmFdWRojN2XBnLhystSFAQX6vLx1t9KCZ691xyc8RQ/kIBSJq7PYGlt6AorMbBEBbVZk83V6j9B3K8UXSWE2QhU8ppdT1M+T0RPlLZuHfi6Ka5PTivtNtpSa7kGdd8+91LSm2+r1LSx1+oYZDbT0dBizUEik/zCWECcDmp8G3GwqE0jBPVmGssSPdwEm1CFFVT8UGe4+40YW2t52ytUq4xQFpmaPtYeOgDxmR81aW9simzQsPasnCvWjOdLros3u7kRvQ5hbz3XaA==
Received: from [172.31.0.10] (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id CF6431800123;
	Fri, 13 Feb 2026 08:14:17 +0000 (UTC)
Message-ID: <a3fd0a27-f09f-4950-919d-1b4ba2dcb16a@icloud.com>
Date: Fri, 13 Feb 2026 00:14:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: mac80211: question about 20/40 coex support
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aY7NLLnOCXS8L31z@FUE-ALEWI-WINX>
Content-Language: en-US
From: Alex Gavin <a_gavin@icloud.com>
In-Reply-To: <aY7NLLnOCXS8L31z@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Wa4BqkhX c=1 sm=1 tr=0 ts=698edd5c
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=h3XwevFeXowA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yaAG3qJ-AAAA:8
 a=6rwCHf0nDpkkAYE5YVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oLVlbjkABFOu4cUI0CGI:22
X-Proofpoint-GUID: 6WDhNxZN4f4I1Y1VFphFPh7Go3ci71r7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2MiBTYWx0ZWRfX9LWM30AhQxD4
 D438PyYCSUVETTbJc/1IA9OL3G5EUmmQta8Y3rEfTuptipRLk78v0TlJm8FEzGBjbEonZyr87db
 yAKFOogphhv2KWlXkCY8FFit1FRXY8hp9lDHwKsXbU6ORroTj4kw1ezgWhx9ZuDsZ8lhWvhZpxe
 FbBqG7XHggReTUe5jFdD35oEDp2Yo9mxnEAuuQSd0qO6v5Ds/sTQPLG4Cz9h5AjvMlME5f1RHiB
 7whr88vltfrbX9H2gl5ObGBqwLkMcFopC8bOk+92Q/mEibtB1N/IR6yniBiaI9zKuF3JB2j+QC9
 igQivAy4iTm6jYD3qpR8uUkABVnq2e8kFfHQ+gcxSfc2XFrgAGSIh8qDohmb8w=
X-Proofpoint-ORIG-GUID: 6WDhNxZN4f4I1Y1VFphFPh7Go3ci71r7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130062
X-JNJ: AAAAAAABR7WIg29Pej7EAwnex22rwjpQBrfY8PLWPIMwOi2b1VgGBO1VXL0qtLFD54SQP5+sCOVWACloYZ18WYlH3uqO1A3V37XmGF3S1KRglc8FSFKY6BG02x1FA9pT8B7TsKqMp4EqRPPoTcN+n8iKvmlTAHQittcySz10c4PhrTqRTfEa7nkFxRlLHNeGm71JNiyKyd4w9LACM/NvEF6UznyMx7m02Cx+OapeGXbOp2fsO+UIN3t9fGtDrBzndgXkahgWYQAnOEA388eIHhjfPAl72cdGJWhpLRnzix8qO89jVNiXifNw8h1KfhACbZ2LjWHS/4CUFHIXSlRQ4rM5tVaALW7fyxyoKgLkLQK6CKQW3KDWwMcO/5ZU0lL5XLovnhD0CDoKvHxj9GVsqz5/trGZUFJk08Av1B85r37Pm6WIjgQV3tJb1wXEcylukLwLZOH7XG8+uG39SJo1rZWm+1bKOUfER8j13UVWTgmJILxXWlvClsFsBq5Yz+Q+IgFOCo76QNqzFThTVxVtij7hukhAXDmWBhGHT9AAZS8DtsZ/PlOypI4xkbzAB3NaiV91kKnjNjXpIqk7FB6vlV7EcyUmLpuQU/yqBSpKowH0FtsyAqlJxb+F1JDuLV1RVhGdP0xjTGhL6mPEsDNCu0ZZZ/+h0UHKmQL6zgesaLFZBBX79NrFQNnrXbGv4CF28BELZ9IoRAEFoUhPOZancOol7rtNdY9ZdJisrI0i
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31809-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a_gavin@icloud.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]
X-Rspamd-Queue-Id: 21DD7133DC8
X-Rspamd-Action: no action

On 2/12/26 23:05, Alexander Wilhelm wrote:
> 
> Hello wireless devs,
> 
> I am analyzing a wireless management frame taken from the beacon of an
> access point, and in this frame the `20/40 Coexistence Management Support`
> bit is set to 0, indicating that the feature is not supported. See frame
> below:
> 
>     Frame 2: 217 bytes on wire (1736 bits), 217 bytes captured (1736 bits)
>     Radiotap Header v0, Length 26
>     802.11 radio information
>     IEEE 802.11 Beacon frame, Flags: ........
>     IEEE 802.11 Wireless Management
>         Fixed parameters (12 bytes)
>         Tagged parameters (155 bytes)
>             Tag: SSID parameter set: "SSID"
>             Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
>             Tag: DS Parameter set: Current Channel: 6
>             Tag: Traffic Indication Map (TIM): DTIM 0 of 2 bitmap
>             Tag: Country Information: Country Code DE, Environment All
>             Tag: ERP Information
>             Tag: QBSS Load Element 802.11e CCA Version
>             Tag: Supported Operating Classes
>             Tag: HT Capabilities (802.11n D1.10)
>             Tag: HT Information (802.11n D1.10)
>             Tag: Extended Capabilities (10 octets)
>                 Tag Number: Extended Capabilities (127)
>                 Tag length: 10
>                 Extended Capabilities: 0x04 (octet 1)
>                     .... ...0 = 20/40 BSS Coexistence Management Support: Not supported
>                     .... ..0. = General Link (GLK): 0x0
>                     .... .1.. = Extended Channel Switching: Supported
>                     .... 0... = GLK-GCR: 0x0
>                     ...0 .... = PSMP Capability: Not supported
>                     ..0. .... = Reserved: 0x0
>                     .0.. .... = S-PSMP Support: Not supported
>                     0... .... = Event: Not supported
>                 Extended Capabilities: 0x00 (octet 2)
>                 Extended Capabilities: 0x00 (octet 3)
>                 Extended Capabilities: 0x02 (octet 4)
>                 Extended Capabilities: 0x00 (octet 5)
>                 Extended Capabilities: 0x00 (octet 6)
>                 Extended Capabilities: 0x01 (octet 7)
>                 Extended Capabilities: 0x0040 (octets 8 & 9)
>                 Extended Capabilities: 0x40 (octet 10)
>             Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
> 
> I reviewed several driver implementations, and none of them seem to
> advertise this capability. I also could not find any definition for this
> bit in `include/linux/ieee80211.h`, unlike many other capability bits that
> are defined (e.g. `WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING` or
> `WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT`). From what I can see, none of the
> `mac80211`‑based drivers appear to support this feature, is that correct?
> 
> Additionally, I want to confirm whether my understanding of the feature is
> accurate: the 20/40 Coexistence mechanism implements the “good neighbor”
> policy, meaning that an AP using a 40 MHz channel in the 2.4 GHz band must
> fall back to 20 MHz when it detects an overlapping BSS (OBSS). Is that
> right?
> 
> Any clarification would be greatly appreciated.
> 
> 
> Best regards
> Alexander Wilhelm
> 

From my understanding, this is implemented in userspace (i.e. hostapd), at least in upstream code.

In hostapd, the '20/40 BSS Coexistence Management Support' bit you reference is set in the
'hostapd_ext_capab_byte()' function in 'src/ap/ieee802_11_shared.c' when 'obss_interval' is set in
the AP config file.

For more information on the 'obss_interval' config item see the following from the hostapd config
reference here [1]:

# If set non-zero, require stations to perform scans of overlapping
# channels to test for stations which would be affected by 40 MHz traffic.
# This parameter sets the interval in seconds between these scans. Setting this
# to non-zero allows 2.4 GHz band AP to move dynamically to a 40 MHz channel if
# no co-existence issues with neighboring devices are found.
#obss_interval=0


The following sections from the 802.11 standard may be helpful to understand this topic in more
depth, although I'm sure there's information online that may be easier to digest:

- 9.4.2.58 20/40 BSS Coexistence element
- 9.4.2.54.2 HT Capability Information field
- 11.15.12 Switching between 40 MHz and 20 MHz

From 11.15.12:

TE-B: On any of the channels of the channel set defined in Clause 18, reception of a 20/40 BSS
Coexistence Management, Beacon, Probe Request, or Probe Response frame that contains a value of 1 in
a Forty MHz Intolerant field and that has the Address 1 field equal to the receiving STA’s address
or to a group address, with no further addressing qualifications.


Best,

Alex


[1] https://git.w1.fi/cgit/hostap/plain/hostapd/hostapd.conf



